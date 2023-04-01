slot0 = class("RiddleMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/Riddle/RiddleMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.itemList_ = {}
	slot0.riddleUpdateHandler_ = handler(slot0, slot0.RefreshRiddle)
end

function slot0.OnEnter(slot0)
	slot5 = INFO_BAR

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		slot5
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SPRING_FESTIVAL_RIDDLE_DESCRIPE")

	for slot5, slot6 in ipairs(ActivitySpringFestivalRiddleCfg.get_id_list_by_activity_id[slot0:GetActivityID()]) do
		if slot0.itemList_[slot5] == nil then
			slot0.itemList_[slot5] = SpringFestivalRiddleMainItem.New(slot0[string.format("riddleGo%s_", slot5)], slot1, slot6)
		end
	end

	for slot5, slot6 in ipairs(slot0.itemList_) do
		slot6:OnEnter()
	end

	slot0:AddTimer()
	slot0:AddRefreshTimer()
	SpringFestivalRiddleAction.HideRedPoint(slot1)
	manager.notify:RegistListener(SPRING_FESTIVAL_RIDDLE_UPDATE, slot0.riddleUpdateHandler_)
	manager.notify:RegistListener(SPRING_FESTIVAL_RIDDLE_ANSWER_ERROR, slot0.riddleUpdateHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(SPRING_FESTIVAL_RIDDLE_UPDATE, slot0.riddleUpdateHandler_)

	slot4 = SPRING_FESTIVAL_RIDDLE_ANSWER_ERROR
	slot5 = slot0.riddleUpdateHandler_

	manager.notify:RemoveListener(slot4, slot5)
	manager.windowBar:HideBar()

	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:OnExit()
	end

	slot0:StopTimer()
	slot0:StopRefreshTimer()

	slot0.lightState_ = nil
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.riddleUpdateHandler_ = nil

	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = {}
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("springFestivalRiddleReward", {
			activityID = uv0:GetActivityID()
		})
	end)
end

function slot0.GetActivityID(slot0)
	return ActivityConst.SPRING_FESTIVAL_RIDDLE
end

function slot0.RefreshItemList(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.itemList_) do
		slot6:RefreshState(slot1)
	end
end

function slot0.RefreshRiddle(slot0)
	slot0:AddRefreshTimer()
end

function slot0.CheckLightRiddle(slot0)
	if ActivityData:GetActivityData(slot0:GetActivityID()).stopTime <= manager.time:GetServerTime() then
		slot0.lightState_ = false

		slot0:RefreshItemList(slot0.lightState_)
		slot0:StopRefreshTimer()

		return
	end

	if manager.time:GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0) < SpringFestivalRiddleData:GetLastAnswerTime(slot1) + GameSetting.activity_spring_festival_riddle_punish_time.value[1] * 60 then
		slot6 = slot8
	end

	slot9 = nil

	if slot0.lightState_ ~= ((not SpringFestivalRiddleData:CanAnswer(slot1) or (slot6 <= slot4 or slot8 - slot5 > 86400) and true or false) and false) then
		slot0.lightState_ = slot9

		slot0:RefreshItemList(slot0.lightState_)
	end
end

function slot0.AddRefreshTimer(slot0)
	slot0:StopRefreshTimer()
	slot0:CheckLightRiddle()

	slot0.refreshTimer_ = Timer.New(function ()
		uv0:CheckLightRiddle()
	end, 1, -1)

	slot0.refreshTimer_:Start()
end

function slot0.StopRefreshTimer(slot0)
	if slot0.refreshTimer_ then
		slot0.refreshTimer_:Stop()

		slot0.refreshTimer_ = nil
	end
end

function slot0.AddTimer(slot0)
	slot0.stopTime_ = ActivityData:GetActivityData(slot0:GetActivityID()).stopTime

	slot0:StopTimer()

	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.timeText_.text = GetTips("TIME_OVER")

		return
	end

	slot0.timeText_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.timeText_.text = GetTips("TIME_OVER")

			return
		end

		uv0.timeText_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
