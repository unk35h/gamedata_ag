slot0 = class("SummerStorySebedItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.chapterID_ = slot2
	slot0.activityID_ = slot3

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.OnEnter(slot0)
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.unLockState_ = ActivityTools.IsUnlockActivity(slot0.activityID_)

	manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.ACTIVITY_STORY_STAGE .. slot0.activityID_)
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.redPoint:unbindUIandKey(slot0.transform_, RedPointConst.ACTIVITY_STORY_STAGE .. slot0.activityID_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.activityData_.stopTime < manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		if slot1 < slot0.startTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot0.startTime)))

			return
		end

		if ActivityData:GetActivityIsOpen(uv0.activityID_) == false then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(manager.time:GetServerTime() + 1)))

			return
		end

		if not uv0.unLockState_ then
			ShowTips("ACTIVITY_FINISH_ALL_SUMMER_STORY")

			return
		end

		ActivityStoryAction.UpdateRedPoint(uv0.activityID_, 0)
		uv0:Go("/summerStageSeabed", {
			theme = ActivityConst.THEME.SUMMER,
			chapterID = uv0.chapterID_
		})
	end)
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	if slot0.activityData_.stopTime < manager.time:GetServerTime() then
		slot0.controller_:SetSelectedState("on")

		return
	end

	if slot2 < slot1.startTime then
		slot0.controller_:SetSelectedState("off")

		slot0.timeText_.text = manager.time:GetLostTimeStr(slot1.startTime)
		slot0.timer_ = Timer.New(function ()
			uv0 = manager.time:GetServerTime()

			if uv1.startTime <= uv0 then
				uv2.controller_:SetSelectedState("on")
				uv2:StopTimer()

				return
			end

			uv2.timeText_.text = manager.time:GetLostTimeStr(uv1.startTime)
		end, 1, -1)

		slot0.timer_:Start()

		return
	end

	slot0.controller_:SetSelectedState("on")
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
