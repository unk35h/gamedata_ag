slot1 = class("RecallSystemTaskView", import("game.views.recall.pages.RecallPageBase"))

function slot1.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:Init()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, RecallSystemMissionItem)
	slot0.handler_ = handler(slot0, slot0.UpdateView)

	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, slot0.handler_)
end

function slot1.IndexItem(slot0, slot1, slot2)
	slot2:SetData(ActivityRecallData:GetDataByPara("taskList")[slot1])
end

function slot1.OnTop(slot0)
end

function slot1.UpdateView(slot0)
	ActivityRecallData:UpdateTaskData()
	ActivityRecallData:TaskSort()
	slot0.list_:StartScroll(#ActivityRecallData:GetDataByPara("taskList"))

	slot0.activityTimeTxt_.text = ActivityRecallData:GetDataByPara("taskTime")
end

function slot1.OnEnter(slot0)
	slot0:UpdateView()
end

function slot1.OnExit(slot0)
	manager.notify:RemoveListener(OSIRIS_TASK_UPDATE, slot0.handler_)

	slot0.handler_ = nil
end

function slot1.Hide(slot0)
	uv0.super.Hide(slot0)
end

function slot1.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
