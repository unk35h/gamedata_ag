slot0 = class("StrategyMatrixRwardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/StrategyMatrix/StrategyMatriRewardUI"
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

	slot0.list = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, StrategyMatrixRwardItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_mask, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0.taskType_ = TaskConst.TASK_TYPE.STRATEGY_MATRIX
	slot0._taskIDList = TaskData:GetSortTaskIDList(slot0.taskType_)

	slot0.list:StartScroll(#slot0._taskIDList)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.RefreshScroll(slot0)
	slot0._taskIDList = TaskData:GetSortTaskIDList(slot0.taskType_)

	slot0.list:StartScrollWithoutAnimator(#slot0._taskIDList, slot0.list:GetScrolledPosition())
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0._taskIDList[slot1])
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnTaskListChange(slot0)
	slot0:RefreshScroll()
end

return slot0
