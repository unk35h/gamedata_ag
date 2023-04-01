slot1 = class("RegressionTaskNewPage", import("game.views.regression.pages.RegressionTaskPage"))

function slot1.OnCtor(slot0, slot1)
	slot3 = Object.Instantiate(Asset.Load("UI/ReturnTwoUI/RT2stReturnMissionUI"), slot1)
	slot0.gameObject_ = slot3
	slot0.transform_ = slot3.transform

	slot0:Init()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.scrollView_, RegressionTaskNewItem)
end

function slot1.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot1.SetData(slot0, slot1)
	if slot1 == nil then
		return
	end

	slot0.taskType_ = slot1
	slot0._taskIDList = TaskData:GetSortTaskIDList(slot0.taskType_)
	slot0._finishList = TaskData:GetFinishTaskIds(slot0.taskType_)

	slot0.scrollHelper_:StartScroll(#slot0._taskIDList)
	slot0:RefreshRecivedAll()
end

return slot1
