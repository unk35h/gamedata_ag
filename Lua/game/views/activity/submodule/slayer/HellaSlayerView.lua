slot0 = class("HellaSlayerView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/HellaUI/Slayer/HellaSlayerUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, HellaSlayerItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_talentBtn, nil, function ()
		if TalentTreeTools.GetActivityIdByTheme(ActivityTools.GetActivityTheme(uv0.slayer_activity_id)) then
			JumpTools.OpenPageByJump("/talentTree", {
				activityId = slot1
			})
		end
	end)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		JumpTools.OpenPageByJump("hellaSlayerReward", {
			slayer_activity_id = uv0.slayer_activity_id
		})
	end)
	slot0:AddBtnListener(slot0.m_bgBtn, nil, function ()
		if uv0:IsOpenSectionInfo() then
			uv0:SetSelectIndex(0)
			JumpTools.Back()
		end
	end)

	slot1 = slot0.m_scrollEvent

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if uv0:IsOpenSectionInfo() then
			uv0:SetSelectIndex(0)
			JumpTools.Back()
		end
	end))
end

function slot0.OnTop(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	slot1 = manager.windowBar

	slot1:SetGameHelpKey("ACTIVITY_HELLA_SLAYER_DESCRIPE")

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		if uv0:IsOpenSectionInfo() then
			uv0:SetSelectIndex(0)
		end

		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.slayer_activity_id = slot0.params_.slayer_activity_id or 0
	slot0.regionList = ActivityCfg[slot0.slayer_activity_id] and slot1.sub_activity_list or {}

	slot0.list:StartScroll(#slot0.regionList)
	slot0:SetSelectIndex(0)
	SlayerAction.SetSlayerRead(slot0.slayer_activity_id)
	manager.redPoint:bindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, slot0.slayer_activity_id))
	slot0:RefrenTime()

	slot0.timer = Timer.New(function ()
		uv0:OnTimerEvent()
	end, 1, -1)

	slot0.timer:Start()
end

function slot0.OnExit(slot0)
	slot0:RemoveTween()

	slot0.selectIndex = 0

	manager.redPoint:unbindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, slot0.slayer_activity_id))
	manager.windowBar:HideBar()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

function slot0.OnTimerEvent(slot0)
	slot0:RefrenTime()

	for slot5, slot6 in ipairs(slot0.list:GetItemList()) do
		slot6:RefreshTime()
	end
end

function slot0.RefrenTime(slot0)
	if ActivityData:GetActivityData(slot0.slayer_activity_id) and slot1:IsActivitying() then
		slot0.m_timeLab.text = manager.time:GetLostTimeStr(slot1.stopTime)
	else
		slot0.m_timeLab.text = GetTips("TIME_OVER")
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.regionList[slot1]
	slot4 = false

	if slot1 == #slot0.regionList then
		slot4 = true
	end

	slot2:SetData(slot1, slot0.slayer_activity_id, slot3, slot4)
	slot2:SetSelectedIndex(slot0.selectIndex)
	slot2:RegistCallBack(handler(slot0, slot0.SetSelectIndex))
end

function slot0.SetSelectIndex(slot0, slot1)
	if slot1 == slot0.selectIndex then
		return
	end

	if slot1 ~= 0 and not ActivityData:GetActivityIsOpen(slot0.regionList[slot1]) then
		slot4 = manager.time:GetServerTime()

		if ActivityData:GetActivityData(slot2) and slot4 < slot3.startTime then
			ShowTips(string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(slot3.startTime)))
		else
			ShowTips("TIME_OVER")
		end

		return
	end

	slot0.selectIndex = slot1

	if slot0.list:GetItemList()[slot0.selectIndex] then
		slot0.m_scrollCom.horizontal = false

		slot0:RemoveTween()

		slot6 = LeanTween.value(slot0.m_scrollContent, slot0.m_scrollContent.transform.localPosition.x, -slot3.transform_.localPosition.x + slot0.m_scrollViewTrans.rect.width / 2 - slot3.transform_.rect.width / 2, 0.2)
		slot0.tween_ = slot6:setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.m_scrollContent.transform.localPosition = Vector3(slot0, 0, 0)
		end))
	else
		slot0.m_scrollCom.horizontal = true
	end

	for slot7, slot8 in pairs(slot2) do
		slot8:SetSelectedIndex(slot0.selectIndex)
	end

	if slot0.selectIndex ~= 0 and slot0.regionList[slot0.selectIndex] then
		slot4 = slot0.regionList[slot0.selectIndex]

		slot0:Go("slayerSctionInfo", {
			sectionType = BattleConst.STAGE_TYPE_NEW.SLAYER,
			section = ActivitySlayerCfg[slot4].stage_id,
			region_activity_id = slot4,
			slayer_activity_id = slot0.slayer_activity_id
		})
	end
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil)
		LeanTween.cancel(slot0.m_scrollContent)

		slot0.tween_ = nil
	end
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("slayerSctionInfo")
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
