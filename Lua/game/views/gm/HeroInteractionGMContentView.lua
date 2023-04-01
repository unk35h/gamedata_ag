slot0 = class("HeroInteractionGMContentView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroInteractionGMContentUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.OnEnter(slot0)
	if slot0.inited == false then
		slot0:Init()
	end
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.inited = true
end

function slot0.InitUI(slot0)
	slot0.idleTimer_ = slot0.params_.idleTimer
	slot0.skinId_ = slot0.params_.skinId

	if SkinCfg[slot0.skinId_] == nil then
		print("SkinCfg[self.skinId_] == nil")
	end

	slot0.animator_ = slot0.params_.animator
	slot0.typeName_ = slot0.params_.typeName

	if #string.split(slot0.typeName_, "_") == 1 then
		slot0.actionType_ = slot1[1]
		slot0.voiceType_ = slot0.actionType_ .. "_talk"
		slot0.voiceDelayType_ = slot0.actionType_ .. "_delay"
	else
		slot0.actionType_ = slot1[1]
		slot0.voiceType_ = slot0.typeName_
		slot0.voiceDelayType_ = slot1[1] .. "_delay"
	end

	slot0.actionNameList = {}
	slot0.actionList_ = {}
	slot0.voiceList_ = {}
	slot0.voiceDelayList_ = {}
	slot0.interactionCfg_ = HeroInteractionCfg[SkinCfg[slot0.skinId_].hero]

	if slot0.interactionCfg_ and slot0.interactionCfg_[slot0.typeName_] ~= nil then
		slot0.actionNameList = slot0.interactionCfg_[slot0.typeName_]
	end

	if slot0.interactionCfg_ and slot0.interactionCfg_[slot0.voiceType_] ~= nil then
		slot0.voiceList_ = slot0.interactionCfg_[slot0.voiceType_]
	end

	if slot0.interactionCfg_ and slot0.interactionCfg_[slot0.actionType_] ~= nil then
		slot0.actionList_ = slot0.interactionCfg_[slot0.actionType_]
	end

	if slot0.interactionCfg_ and slot0.interactionCfg_[slot0.voiceDelayType_] ~= nil then
		slot0.voiceDelayList_ = slot0.interactionCfg_[slot0.voiceDelayType_]
	end

	if slot0.backgroundBtn_ == nil then
		slot0.backgroundBtn_ = slot0:FindCom("Button", "background")
	end

	if slot0.btn_prefab == nil then
		slot0.btn_prefab = slot0:FindGo("HeroInteractionBut_prefab")
	end

	if slot0.panel_go == nil then
		slot0.panel_go = slot0:FindTrs("panel")
	end

	slot0.btn_list = {}
	slot0.btnGo_list = {}

	slot0:GenBtn()
end

function slot0.GenBtn(slot0)
	if slot0.actionNameList ~= nil and #slot0.actionNameList > 0 then
		for slot4, slot5 in ipairs(slot0.actionNameList) do
			if Object.Instantiate(slot0.btn_prefab, slot0.panel_go):GetComponentInChildren(typeof(Text)) ~= nil then
				slot7.text = slot5
			else
				print("btn_text为空")
			end

			if slot6:GetComponent(typeof(Button)) == nil then
				print("button_:按钮为空")
			end

			table.insert(slot0.btn_list, slot8)
			table.insert(slot0.btnGo_list, slot6)
		end
	end
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in ipairs(slot0.btn_list) do
		slot0:AddBtnListener(slot5, nil, function ()
			uv0:DelayToPlayInteractionAnimation(uv1, 0)
		end)
	end

	slot0:AddBtnListener(slot0.backgroundBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.DelayToPlayInteractionAnimation(slot0, slot1, slot2)
	if slot0.playingInteraction_ then
		return
	end

	if slot2 == nil then
		slot2 = 1
	end

	if slot0.interactionTimer_ then
		slot0.interactionTimer_:Stop()

		slot0.interactionTimer_ = nil
	end

	slot0:PlayInteractionAnimation(slot1)
end

function slot0.PlayInteractionAnimation(slot0, slot1)
	if slot0.interactionTimer_ then
		slot0.interactionTimer_:Stop()

		slot0.interactionTimer_ = nil
	end

	slot0:PlaySpecialAnimation(#slot0.actionList_ > 0 and slot0.actionList_[slot1] or nil, slot0.voiceList_[slot1], slot0.voiceDelayList_[slot1])
end

function slot0.PlaySpecialAnimation(slot0, slot1, slot2, slot3)
	if slot0.playingInteraction_ then
		return
	end

	if slot0.idleTimer_ then
		slot0.idleTimer_:Reset()
	end

	if slot0.animator_ and slot1 ~= nil then
		LuaForUtil.EnableEyeController(slot0.animator_.transform, false)
		manager.resourcePool:ResetBlendShapes(slot0.animator_.transform)
		AnimatorTools.PlayAnimationWithCallback(slot0.animator_, slot1, handler(slot0, slot0.OnPlaySpecialCallback))

		slot0.playingInteraction_ = true
	else
		slot0.playingInteraction_ = false
	end

	slot4 = SkinCfg[slot0.skinId_].hero
	slot5 = string.split(slot2, "_")

	print(string.format("播放%d的动作为%s，声音为%s， 延迟为 %d 毫秒", slot0.skinId_, slot1 ~= nil and tostring(slot1) or "无", slot2 ~= nil and tostring(slot2) or "无", slot3 ~= nil and slot3 or 0))

	if slot0.animator_ then
		trans = slot0.animator_.transform
	end

	if slot3 > 0 then
		if slot0.talkDelayTimer_ then
			slot0.talkDelayTimer_:Stop()

			slot0.talkDelayTimer_ = nil
		end

		slot0.talkDelayTimer_ = Timer.New(function ()
			HeroTools.PlayTalk(uv0[1], uv0[2], nil, trans)
		end, slot3 / 1000)

		slot0.talkDelayTimer_:Start()
	else
		HeroTools.PlayTalk(slot5[1], slot5[2], nil, trans)
	end
end

function slot0.OnPlaySpecialCallback(slot0)
	slot0.playingInteraction_ = false

	if slot0.animator_ then
		LuaForUtil.EnableEyeController(slot0.animator_.transform, true)
		manager.resourcePool:ResetBlendShapes(slot0.animator_.transform)
		AnimatorTools.CrossFade(slot0.animator_, "action1_1")
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.btnGo_list) do
		Object.Destroy(slot5)
	end

	slot0.btn_list = nil
	slot0.btnGo_list = nil
	slot0.inited = false
	slot0.playingInteraction_ = false

	HeroTools.StopTalk()

	if slot0.talkDelayTimer_ then
		slot0.talkDelayTimer_:Stop()

		slot0.talkDelayTimer_ = nil
	end

	if slot0.interactionTimer_ then
		slot0.interactionTimer_:Stop()

		slot0.interactionTimer_ = nil
	end

	AnimatorTools.Stop()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
