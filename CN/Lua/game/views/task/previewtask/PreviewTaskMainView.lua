slot0 = class("PreviewTaskMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Task/AdvanceTaskUIPop"
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.scrollView_, PreviewTaskItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backMask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = PreviewTaskData:GetCurActivityID()
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	if slot0.lastPosition_ then
		slot0:RefreshScroll(true)

		slot0.lastPosition_ = nil
	else
		slot0:RefreshScroll()
	end

	slot0:RefreshTimeText()
end

function slot0.RefreshScroll(slot0, slot1)
	slot0:UpdateData()

	if slot1 then
		if slot0.lastPosition_ then
			slot2 = clone(slot0.lastPosition_)
			slot3 = nil

			FrameTimer.New(function ()
				uv0.scrollHelper_:StartScrollWithoutAnimator(#uv0._taskIDList, uv1)
				uv2:Stop()

				uv2 = nil
			end, 1, 1):Start()

			return
		end

		slot0.scrollHelper_:StartScrollWithoutAnimator(#slot0._taskIDList)
	else
		slot0.scrollHelper_:StartScroll(#slot0._taskIDList)
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0._taskIDList[slot1], slot0.activityID_)
end

function slot0.OnExit(slot0)
	if slot0.dailyTimer_ then
		slot0.dailyTimer_:Stop()

		slot0.dailyTimer_ = nil
	end

	slot0.lastPosition_ = slot0.scrollHelper_:GetScrolledPosition()

	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	slot0:StopTimer()
	uv0.super.Dispose(slot0)
end

function slot0.UpdateData(slot0)
	slot0._taskIDList = PreviewTaskData:GetSortTaskIDList(slot0.activityID_)
end

function slot0.OnPreviewTaskListChange(slot0)
	slot0:RefreshScroll(true)
end

function slot0.RefreshTimeText(slot0)
	if not ActivityData:GetActivityIsOpen(slot0.activityID_) then
		slot0.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	slot0.remainTimeText_.text = manager.time:GetLostTimeStr(slot0.stopTime_)

	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		uv0.remainTimeText_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()
	end

	slot0.timer_ = nil
end

return slot0
