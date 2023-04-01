slot0 = class("ActivityRaceMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIDownUI/ActivityRace/ActivityRaceMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.switchItemList_ = {}
	slot2 = nil

	for slot6 = 1, slot0.switchPanelTrans_.childCount do
		slot0.switchItemList_[slot6] = ActivityRaceSwitchItem.New(slot0.switchPanelTrans_:GetChild(slot6 - 1).gameObject)
	end
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		slot1 = {}
		slot5 = ActivityShopCfg[uv0.activityID_].activity_theme

		for slot5, slot6 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[slot5]) do
			table.insert(slot1, ActivityShopCfg[slot6].shop_id)
		end

		slot2, slot3 = ShopTools.IsShopOpen(slot0.shop_id)

		if slot2 then
			JumpTools.GoToSystem("/shop", {
				shopId = slot0.shop_id,
				showShops = slot1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif slot3 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif slot3 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("activityRaceRewardPanel", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.rankBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ActivityRaceAction.QueryRankList(uv0.rankID_, function ()
			uv0:Go("/activityRaceRank", {
				activityID = uv0.rankID_
			})
		end)
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_RACE_DESCRIPE")

	slot0.activityID_ = slot0.params_.activityID
	slot0.rankID_ = slot0.params_.rankID
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:RegisterRedPoint()
	slot0:RefreshUI()
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in ipairs(slot0.switchItemList_) do
		slot5:OnExit()
	end

	slot0:UnRegisterRedPoint()
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.switchItemList_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.subActivityList_ = ActivityCfg[slot0.activityID_].sub_activity_list

	for slot4, slot5 in ipairs(slot0.switchItemList_) do
		slot5:SetData(slot0.activityID_, slot0.subActivityList_[slot4])
	end

	slot0:RefreshDesc()

	slot0.scoreText_.text = ActivityRaceData:GetTotalScore(slot0.activityID_) or 0
end

function slot0.RefreshDesc(slot0)
	slot0.descText_.text = GetTips("ACTIVITY_RACE_CONTENT")
end

function slot0.AddTimer(slot0)
	slot0.remainTimeText_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		for slot3, slot4 in ipairs(uv0.switchItemList_) do
			slot4:RefreshLock()
		end

		uv0.remainTimeText_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RegisterRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.rewardBtnTrans_, string.format("%s_%s_reward", RedPointConst.ACTIVITY_RACE, slot0.activityID_))
end

function slot0.UnRegisterRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.rewardBtnTrans_, string.format("%s_%s_reward", RedPointConst.ACTIVITY_RACE, slot0.activityID_))
end

return slot0
