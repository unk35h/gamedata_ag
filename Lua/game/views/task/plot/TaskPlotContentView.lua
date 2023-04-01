slot0 = class("TaskPlotContentView", ReduxView)
slot1 = import("game.const.TaskConst")
slot2 = import("game.tools.TaskTools")
slot3 = import("game.const.ActivityPtConst")

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()

	slot0.systemItemList_ = {}
end

function slot0.Init(slot0)
	slot0._taskIDList = TaskData:GetTaskIDList(uv0.TASK_TYPE.PLOT)
	slot0._finishList = TaskData:GetFinishTaskIds(uv0.TASK_TYPE.PLOT)

	slot0:RefreshAllFinish()
	slot0:RefreshRecivedAll()
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()

	if slot0.systemItemList_ then
		for slot4, slot5 in pairs(slot0.systemItemList_) do
			slot5:Dispose()
		end

		slot0.systemItemList_ = nil
	end

	slot0.phaseView_:Dispose()
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.scrollView_, TaskPlotItemView)
	slot0.receiveBtnController_ = ControllerUtil.GetController(slot0.transform_, "receiveBtn_all")
	slot0.finishAllController_ = ControllerUtil.GetController(slot0.transform_, "conName")

	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		TaskAction:TryToSubmitTaskList(TaskData:GetFinishTaskIds(uv0.TASK_TYPE.PLOT), uv0.TASK_TYPE.PLOT)
	end)

	slot0.phaseView_ = TaskPlotPhaseView.New(slot0.goPhase_)
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

function slot0.OnEnter(slot0)
	slot0:Init()

	if slot0.lastPosition_ then
		slot0:RefreshScroll(true)

		slot0.lastPosition_ = nil
	else
		slot0:RefreshScroll()
	end

	SetActive(slot0.gameObject_, true)
	slot0.phaseView_:RefreshUI()
end

function slot0.OnExit(slot0, slot1)
	if slot0.systemItemList_ then
		for slot5, slot6 in pairs(slot0.systemItemList_) do
			slot6:Dispose()

			slot0.systemItemList_[slot5] = nil
		end
	end

	SetActive(slot0.gameObject_, false)

	if not slot1 then
		slot0.lastPosition_ = slot0.scrollHelper_:GetScrolledPosition()
	end
end

function slot0.ClearCache(slot0)
	slot0.lastPosition_ = nil
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

function slot0.UpdateData(slot0)
	slot0._taskIDList = TaskData:GetSortTaskIDList(uv0.TASK_TYPE.PLOT)
end

function slot0.OnTaskListChange(slot0)
	slot0:RefreshScroll(true)

	slot0._finishList = TaskData:GetFinishTaskIds(uv0.TASK_TYPE.PLOT)

	slot0:RefreshRecivedAll()
	slot0.phaseView_:RefreshUI()
end

function slot0.RefreshAllFinish(slot0)
end

function slot0.RefreshSystemItem(slot0)
end

function slot0.RefreshRecivedAll(slot0)
	if #slot0._finishList > 0 then
		SetActive(slot0.goAllAccept_, true)
	else
		SetActive(slot0.goAllAccept_, false)
	end
end

return slot0
