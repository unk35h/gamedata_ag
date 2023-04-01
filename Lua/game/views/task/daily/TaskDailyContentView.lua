slot0 = class("TaskDailyContentView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.taskType_ = slot2
	slot0.pointType_ = slot3

	slot0:InitUI()

	slot0.giftItems_ = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.scrollView_, TaskDailyItemView)
	slot0.receiveBtnController_ = ControllerUtil.GetController(slot0.transform_, "receiveBtn_all")

	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		TaskAction:TryToSubmitTaskList(TaskData:GetFinishTaskIds(uv0.taskType_), uv0.taskType_)
	end)
end

function slot0.Init(slot0)
	slot0._taskIDList = TaskData:GetSortTaskIDList(slot0.taskType_)
	slot0._finishList = TaskData:GetFinishTaskIds(slot0.taskType_)

	slot0:RefreshActivityPoint()
	slot0:RefreshTimeText()
	slot0:RefreshGiftItems()
	slot0:RefreshRecivedAll()
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
	slot2:ReEnter(slot0._taskIDList[slot1])
end

function slot0.Show(slot0, slot1, slot2)
	if slot1 then
		if slot2 then
			-- Nothing
		end

		slot0:OnEnter()
	else
		slot0:OnExit(true)
	end
end

function slot0.OnEnter(slot0)
	slot0:Init()

	if slot0.lastPosition_ then
		slot0:RefreshScroll(true)

		slot0.lastPosition_ = nil
	else
		slot0:RefreshScroll()
	end

	SetActive(slot0.gameObject_, true)
end

function slot0.OnExit(slot0, slot1)
	SetActive(slot0.gameObject_, false)

	if slot0.dailyTimer_ then
		slot0.dailyTimer_:Stop()

		slot0.dailyTimer_ = nil
	end

	if not slot1 then
		slot0.lastPosition_ = slot0.scrollHelper_:GetScrolledPosition()
	end
end

function slot0.ClearCache(slot0)
	slot0.lastPosition_ = nil
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()

	if slot0.giftItems_ then
		for slot4, slot5 in pairs(slot0.giftItems_) do
			slot5:Dispose()
		end
	end

	slot0.giftItems_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.UpdateData(slot0)
	slot0._taskIDList = TaskData:GetSortTaskIDList(slot0.taskType_)
end

function slot0.OnTaskListChange(slot0)
	slot0:RefreshScroll(true)

	slot0._finishList = TaskData:GetFinishTaskIds(slot0.taskType_)

	slot0:RefreshRecivedAll()
end

function slot0.OnActivityPtUpdate(slot0)
	for slot4, slot5 in pairs(slot0.giftItems_) do
		slot5:RefreshGift()
	end

	slot0:RefreshActivityPoint()
	slot0:RefreshRecivedAll()
end

function slot0.RefreshActivityPoint(slot0)
	slot1 = ActivityPtData:GetCurrentActivityPt(slot0.pointType_)
	slot0.ptNumberText_.text = "" .. slot1
	slot3 = slot0.ptProgressBg_.rect.width

	slot0.ptProgressBar_:SetInsetAndSizeFromParentEdge(RectTransform.Edge.Left, 0, Mathf.Clamp(slot1 / ActivityPtCfg[slot0.pointType_].target[#ActivityPtCfg[slot0.pointType_].target] * slot3, 0, slot3))
end

function slot0.RefreshTimeText(slot0)
	slot0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), slot0:GetTimeText(TimeMgr.GetInstance():GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0) - TimeMgr.GetInstance():GetServerTime()))

	if slot0.dailyTimer_ then
		slot0.dailyTimer_:Stop()
	end

	slot0.dailyTimer_ = Timer.New(function ()
		uv0 = uv1 - TimeMgr.GetInstance():GetServerTime()

		if uv0 < 0 then
			uv0 = TimeMgr.GetInstance():GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0) - TimeMgr.GetInstance():GetServerTime()
		end

		uv2.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), uv2:GetTimeText(uv0))
	end, 1, -1)

	slot0.dailyTimer_:Start()
end

function slot0.RefreshGiftItems(slot0)
	slot4 = slot0.pointType_

	for slot4, slot5 in ipairs(ActivityPtCfg[slot4].target) do
		if slot0.giftItems_[slot4] then
			slot0.giftItems_[slot4]:SetIndex(slot4)
		else
			slot0.giftItems_[slot4] = TaskDailyGiftItem.New(slot0.ptGiftItem_, slot0.ptGiftParent_, slot4, slot0.pointType_)
		end
	end
end

function slot0.IsGiftCanReceive(slot0)
	for slot5 = 1, #ActivityPtCfg[slot0.pointType_].target do
		slot7 = TaskTools.ActivityPtCanReceive(slot0.pointType_, slot5)

		if not TaskTools.ActivityPtIsReceived(slot0.pointType_, slot5) and slot7 then
			return true
		end
	end
end

function slot0.RefreshRecivedAll(slot0)
	if #slot0._finishList > 0 or slot0:IsGiftCanReceive() then
		SetActive(slot0.goAllAccept_, true)
	else
		SetActive(slot0.goAllAccept_, false)
	end
end

function slot0.GetTimeText(slot0, slot1)
	slot3 = math.floor(slot1 / 3600)
	slot4 = math.floor(slot1 / 60 % 60)
	slot5 = math.floor(slot1 % 60)

	if math.ceil(slot1 / 3600 / 24) > 1 then
		return slot2 .. GetTips("DAY")
	end

	if slot5 < 10 then
		slot5 = "0" .. slot5
	end

	if slot4 < 10 then
		slot4 = "0" .. slot4
	end

	if slot3 < 10 then
		slot3 = "0" .. slot3
	end

	return slot3 .. ":" .. slot4 .. ":" .. slot5
end

return slot0
