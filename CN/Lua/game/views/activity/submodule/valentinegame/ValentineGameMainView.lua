slot0 = class("ValentineGameMainView", ReduxView)

function slot0.UIName(slot0)
	return ValentineGameTools.GetMainUIName(slot0.params_.activityId)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if ActivityData:GetActivityData(uv0.activityID_):IsActivitying() then
			JumpTools.OpenPageByJump("valentineGameReward", {
				activityId = uv0.params_.activityId
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
	slot0:AddBtnListener(slot0.testBtn_, nil, function ()
		if ActivityData:GetActivityData(uv0.activityID_):IsActivitying() then
			JumpTools.OpenPageByJump("/valentineGameTest", {
				activityId = uv0.params_.activityId
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:BindUIRedPoint()
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.RefreshData(slot0)
	slot0.activityID_ = slot0.params_.activityId
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
end

function slot0.RefreshUI(slot0)
	slot0:RefreshTime()
end

function slot0.RefreshTime(slot0)
	slot1 = nil

	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0.startTime_ then
		slot0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.startTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot2 < slot0.stopTime_ then
		slot0.timeTxt_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.stopTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end

			uv1.timeTxt_.text = manager.time:GetLostTimeStr(uv1.stopTime_)
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.BindUIRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, RedPointConst.VALENTINE_GAME_REWARD .. "_" .. slot0.params_.activityId)
	manager.redPoint:bindUIandKey(slot0.testBtn_.transform, RedPointConst.VALENTINE_GAME_OPEN .. "_" .. slot0.params_.activityId)
end

function slot0.UnBindUIRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, RedPointConst.VALENTINE_GAME_REWARD .. "_" .. slot0.params_.activityId)
	manager.redPoint:unbindUIandKey(slot0.testBtn_.transform, RedPointConst.VALENTINE_GAME_OPEN .. "_" .. slot0.params_.activityId)
end

function slot0.OnTop(slot0)
	if ValentineGameTools.GetGameHelpKey(slot0.params_.activityId) ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(slot1)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0:UnBindUIRedPoint()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
