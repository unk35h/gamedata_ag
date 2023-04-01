slot0 = class("HeroArchiveVoicePage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.itemList_ = {}
	slot0.isPlayingIndex_ = 0
	slot0.timer_ = nil

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.itemlistGo_, HeroVoiceItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot1, slot0.heroID_, slot0.itemList_[slot1])

	if slot1 == slot0.isPlayingIndex_ then
		slot2:StartPlay()
	end

	slot2:AddUIListener(function (slot0, slot1)
		PlayerAction.CheckHeroVoice(uv0.heroID_, function ()
			if uv0.isPlayingIndex_ == uv1 then
				uv0:StopVoice()
			else
				uv0:PlayVoice(uv1, uv2)
			end
		end)
	end)
end

function slot0.AddUIListener(slot0)
end

function slot0.UpdateData(slot0)
	slot1 = 1
	slot0.itemList_ = {}

	for slot5, slot6 in ipairs(HeroVoiceCfg.all) do
		slot7 = HeroTools:IsUnlockVoice(slot0.heroID_, slot6)

		if HeroVoiceDescCfg[slot0.heroID_][slot6] ~= nil and slot8 ~= "" then
			slot0.itemList_[slot1] = {
				id = slot6,
				isUnlock = slot7
			}
			slot1 = slot1 + 1
		end
	end

	table.sort(slot0.itemList_, function (slot0, slot1)
		if (slot0.isUnlock or slot1.isUnlock) and slot0.isUnlock ~= slot1.isUnlock then
			return slot0.isUnlock
		end

		return slot0.id < slot1.id
	end)
end

function slot0.RefreshUI(slot0, slot1)
	if slot0.timer_ ~= nil then
		slot0:StopVoice()
	end

	slot0.heroID_ = slot1

	SetActive(slot0.dialogueGo_, false)

	if HeroTools.GetHeroIsUnlock(slot0.heroID_) then
		slot0.controller_:SetSelectedState("unLock")
		slot0:UpdateData()
		slot0.scrollHelper_:StartScroll(#slot0.itemList_)
	else
		slot0.controller_:SetSelectedState("lock")
	end
end

function slot0.OnExit(slot0)
	if slot0.delayPlayTimer_ then
		slot0.delayPlayTimer_:Stop()

		slot0.delayPlayTimer_ = nil
	end

	if slot0.timer_ then
		manager.audio:StopVoiceImmediate()
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.PlayVoice(slot0, slot1, slot2)
	SDKTools.SendMessageToSDK("hero_sound", {
		hero_id = slot0.heroID_,
		sound_id = slot2
	})
	slot0.interruptFunc_()

	slot0.textinfoText_.text = HeroVoiceDescCfg[slot0.heroID_][slot2]
	slot0.dialogueContentTrans_.localPosition = Vector3(0, 0, 0)

	SetActive(slot0.dialogueGo_, true)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.dialogueContentTrans_)

	if slot0.delayPlayTimer_ then
		slot0.delayPlayTimer_:Stop()

		slot0.delayPlayTimer_ = nil
	end

	slot0.delayPlayTimer_ = Timer.New(function ()
		if manager.audio:IsStoppedOfVoice() then
			uv0.delayPlayTimer_:Stop()

			uv0.delayPlayTimer_ = nil

			HeroTools.PlayVoice(uv0.heroID_, HeroVoiceCfg[uv1].file, HeroVoiceCfg[uv1].type)

			uv0.timer_ = TimeTools.StartAfterSeconds(math.max(HeroTools.GetTalkLength(uv0.heroID_, HeroVoiceCfg[uv1].file, HeroVoiceCfg[uv1].type), 0.017) / 1000, function ()
				uv0:StopVoice()
			end, {})
		end
	end, 0.033, -1)

	slot0.delayPlayTimer_:Start()

	slot0.isPlayingIndex_ = slot1

	if slot0.scrollHelper_:GetItemByIndex(slot1) then
		slot3:StartPlay()
	end
end

function slot0.StopVoice(slot0)
	SetActive(slot0.dialogueGo_, false)

	if slot0.delayPlayTimer_ then
		slot0.delayPlayTimer_:Stop()

		slot0.delayPlayTimer_ = nil
	end

	if slot0.timer_ then
		manager.audio:StopVoiceImmediate()
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	if slot0.isPlayingIndex_ ~= 0 then
		if slot0.scrollHelper_:GetItemByIndex(slot0.isPlayingIndex_) then
			slot1:StopPlay()
		end

		slot0.isPlayingIndex_ = 0
	end
end

function slot0.RegisterInterruptVoice(slot0, slot1)
	slot0.interruptFunc_ = slot1
end

function slot0.Dispose(slot0)
	slot0.timer_ = nil

	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
