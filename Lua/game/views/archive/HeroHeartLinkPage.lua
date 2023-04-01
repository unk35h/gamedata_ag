slot0 = class("HeroHeartLinkPage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.itemList_ = {}
	slot0.dataList_ = {}
	slot0.heartLinkVoice_ = {
		HeroVoiceCfg.get_id_list_by_file.trust1[1],
		HeroVoiceCfg.get_id_list_by_file.trust2[1],
		HeroVoiceCfg.get_id_list_by_file.trust3[1],
		HeroVoiceCfg.get_id_list_by_file.trust4[1],
		HeroVoiceCfg.get_id_list_by_file.trust5[1]
	}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "conName")
end

function slot0.AddUIListener(slot0)
end

function slot0.UpdateData(slot0)
	slot0.dataList_ = {}
	slot1 = 1
	slot2 = HeroRecordCfg[slot0.archiveID_]

	for slot6 = 1, 100 do
		if not slot2["heart_chain" .. slot6] or slot2["heart_chain" .. slot6] == "" then
			break
		end

		slot8, slot9, slot10 = IsConditionAchieved(GameSetting.heart_chain_unlock_condition.value[slot6], {
			heroId = slot0.archiveID_
		})
		slot0.dataList_[slot1] = {
			isUnlock = slot8,
			current = slot9,
			all = slot10,
			id = slot6,
			index = slot1
		}
		slot1 = slot1 + 1
	end

	table.sort(slot0.dataList_, function (slot0, slot1)
		if slot0.isUnlock ~= slot1.isUnlock then
			return slot0.isUnlock
		end

		return slot0.id < slot1.id
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.archiveID_ = slot1
	slot0.heroID_ = slot2

	if not table.indexof(GameDisplayCfg.heart_chain_missing.value, slot2) then
		slot0:UpdateData()

		slot4 = 1

		for slot8, slot9 in ipairs(slot0.dataList_) do
			if not slot0.itemList_[slot8] then
				slot0.itemList_[slot8] = HeartLinkItem.New(slot0.itemGo_)
			end

			slot0.itemList_[slot8]:RegisterRefresh(handler(slot0, slot0.UpdateLayout))
			slot0.itemList_[slot8]:RefreshUI(slot0.archiveID_, slot9)

			slot4 = slot4 + 1
		end

		for slot8 = slot4, #slot0.itemList_ do
			slot0.itemList_[slot8]:Hide()
		end

		slot0.controller_:SetSelectedState("true")
	else
		slot0.controller_:SetSelectedState("false")
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
end

function slot0.OnExit(slot0)
	for slot4 = 1, #slot0.itemList_ do
		slot0.itemList_[slot4]:OnExit()
	end
end

function slot0.UpdateLayout(slot0, slot1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
	slot0:PlayVoice(slot1)
end

function slot0.PlayVoice(slot0, slot1)
	if slot0.heartLinkVoice_[slot1] == nil then
		return
	end

	SDKTools.SendMessageToSDK("hero_sound", {
		hero_id = slot0.heroID_,
		sound_id = slot2
	})
	slot0.interruptFunc_()

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

	slot0.textinfoText_.text = HeroVoiceDescCfg[slot0.heroID_][slot2]
end

function slot0.StopVoice(slot0)
	if slot0.delayPlayTimer_ then
		slot0.delayPlayTimer_:Stop()

		slot0.delayPlayTimer_ = nil
	end

	manager.audio:StopVoiceImmediate()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RegisterInterruptVoice(slot0, slot1)
	slot0.interruptFunc_ = slot1
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
