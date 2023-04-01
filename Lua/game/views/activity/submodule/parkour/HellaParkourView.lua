slot0 = class("HellaParkourView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/HellaUI/Parkour/HellaParkourUI"
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
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		if ActivityData:GetActivityIsOpen(uv0.parkour_activity_id) then
			JumpTools.OpenPageByJump("hellaParkourReward", {
				parkour_activity_id = uv0.parkour_activity_id
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
	slot0:AddBtnListener(slot0.m_entrustBtn, nil, function ()
		if ActivityData:GetActivityIsOpen(uv0.parkour_activity_id) then
			JumpTools.OpenPageByJump("/hellaParkourEntrust", {
				parkour_activity_id = uv0.parkour_activity_id
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
	slot0:AddBtnListener(slot0.m_loseBtn, nil, function ()
		if ActivityData:GetActivityIsOpen(uv0.parkour_activity_id) then
			JumpTools.OpenPageByJump("/hellaParkourLose", {
				parkour_activity_id = uv0.parkour_activity_id
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_HELLA_PARKOUR_DESCRIPE")
end

function slot0.OnEnter(slot0)
	slot0.parkour_activity_id = slot0.params_.parkour_activity_id or 61101
	slot0.timer = Timer.New(function ()
		uv0:RefreshTime()
	end, 1, -1)

	slot0.timer:Start()
	manager.redPoint:bindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_REWARD, slot0.parkour_activity_id))
	manager.redPoint:bindUIandKey(slot0.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_ALL, slot0.parkour_activity_id))
	manager.redPoint:bindUIandKey(slot0.m_loseBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_COLLECT, slot0.parkour_activity_id))
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	manager.redPoint:unbindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_REWARD, slot0.parkour_activity_id))
	manager.redPoint:unbindUIandKey(slot0.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_ALL, slot0.parkour_activity_id))
	manager.redPoint:unbindUIandKey(slot0.m_loseBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_COLLECT, slot0.parkour_activity_id))
end

function slot0.RefreshTime(slot0)
	if ActivityData:GetActivityData(slot0.parkour_activity_id) and slot1:IsActivitying() then
		slot0.m_timer.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr(slot1.stopTime)
	else
		slot0.m_timer.text = GetTips("TIME_OUT")
	end
end

return slot0
