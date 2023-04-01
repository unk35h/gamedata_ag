slot0 = class("SkadiLittleGameView", ReduxView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummerSkadiGameUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.buttonBtn_, nil, function ()
		JumpTools.OpenPageByJump("skadiGameReward")
	end)
end

function slot0.InitBtns(slot0)
	if not slot0.itemView_ then
		slot0.itemView_ = {}
		slot4 = slot0.activityID_

		for slot4, slot5 in ipairs(ActivityCfg[slot4].sub_activity_list) do
			slot0.itemView_[slot5] = SkadiLittleGameItem.New(slot0[string.format("item%dGo_", slot4)], slot5, slot0.activityID_)
		end
	end
end

function slot0.OnTop(slot0)
	if ActivityTools.GetGameHelpKey(slot0.activityID_) ~= "" then
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

function slot0.OnEnter(slot0)
	slot0.activityID_ = ActivityConst.SIKADI_GAME

	slot0:InitBtns()

	for slot4, slot5 in pairs(slot0.itemView_) do
		slot5:OnEnter()
	end

	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime
	slot0.detailText_.text = GetTips("ACTIVITY__CROSSWAVE_CONTENT")

	slot0:AddTimer()
	manager.redPoint:setTip(RedPointConst.SKADI_LITTLE_GAME_LEVEL, 0)
	manager.redPoint:bindUIandKey(slot0.buttonBtn_.transform, RedPointConst.SKADI_LITTLE_GAME_REWARD)
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.itemView_) do
		slot5:OnExit()
	end

	manager.redPoint:unbindUIandKey(slot0.buttonBtn_.transform, RedPointConst.SKADI_LITTLE_GAME_REWARD)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.itemView_) do
		slot5:Dispose()
	end

	slot0.itemView_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.remainText_.text = GetTips("TIME_OVER")

		return
	end

	slot0.remainText_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.remainText_.text = GetTips("TIME_OVER")

			return
		end

		uv0.remainText_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 0.5, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
