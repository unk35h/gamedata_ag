slot0 = class("RegressionNewPage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot3 = Object.Instantiate(Asset.Load("UI/ReturnUI/RegressionTaskUI"), slot1)
	slot0.gameObject_ = slot3
	slot0.transform_ = slot3.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.scrollView_, TaskDailyItemView)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		TaskAction:TryToSubmitTaskList(TaskData:GetFinishTaskIds(uv0.taskType_), uv0.taskType_)
	end)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetData(slot0, slot1)
	if slot1 == nil then
		return
	end

	slot0.taskType_ = slot1
	slot0._taskIDList = TaskData:GetSortTaskIDList(slot0.taskType_)
	slot0._finishList = TaskData:GetFinishTaskIds(slot0.taskType_)

	slot0.scrollHelper_:StartScroll(#slot0._taskIDList)
	slot0:RefreshRecivedAll()
end

function slot0.Refresh(slot0)
	slot0._taskIDList = TaskData:GetSortTaskIDList(slot0.taskType_)
	slot0._finishList = TaskData:GetFinishTaskIds(slot0.taskType_)

	slot0.scrollHelper_:Refresh()
	slot0:RefreshRecivedAll()
end

function slot0.RefreshRecivedAll(slot0)
	if #slot0._finishList > 0 then
		SetActive(slot0.goAllAccept_, true)
	else
		SetActive(slot0.goAllAccept_, false)
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:ReEnter(slot0._taskIDList[slot1])
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.RefreshScroll(slot0)
	slot0._taskIDList = TaskData:GetSortTaskIDList(slot0.taskType_)

	slot0.scrollHelper_:StartScrollWithoutAnimator(#slot0._taskIDList, slot0.scrollHelper_:GetScrolledPosition())
end

function slot0.OnTaskListChange(slot0)
	slot0:RefreshScroll()

	slot0._finishList = TaskData:GetFinishTaskIds(slot0.taskType_)

	slot0:RefreshRecivedAll()
end

return slot0
