slot0 = class("ActivityNoobTaskView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Activity/NewbieTaskUI_new"), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:BindCfgUI()

	slot0.taskItemList_ = LuaList.New(handler(slot0, slot0.RefreshTaskItem), slot0.taskItemScroll_, ActivityNoobTaskItem)
	slot0.phaseList_ = LuaList.New(handler(slot0, slot0.RefreshPhaseItem), slot0.phaseItemScroll_, ActivityNoobPhaseItem)
	slot0.progressList_ = LuaList.New(handler(slot0, slot0.RefreshProgressItem), slot0.progressItemScroll_, ActivityNoobTaskProgressItem)
	slot0.noobTaskUpdateHandler_ = handler(slot0, slot0.NoobTaskUpdate)
	slot0.clickPhaseHandler_ = handler(slot0, slot0.OnClickPhase)
	slot0.AccumulateReceiveHandler_ = handler(slot0, slot0.OnNoobAccumulateReceive)

	manager.notify:RegistListener(NEWBIE_TASK_UPDATE, slot0.noobTaskUpdateHandler_)
	manager.notify:RegistListener(NOOB_ACCUMULATE_RECEIVE, slot0.AccumulateReceiveHandler_)
end

function slot0.Dispose(slot0)
	manager.notify:RemoveListener(NEWBIE_TASK_UPDATE, slot0.noobTaskUpdateHandler_)
	manager.notify:RemoveListener(NOOB_ACCUMULATE_RECEIVE, slot0.AccumulateReceiveHandler_)
	slot0.taskItemList_:Dispose()

	slot0.taskItemList_ = nil

	slot0.phaseList_:Dispose()

	slot0.phaseList_ = nil

	slot0.progressList_:Dispose()

	slot0.progressList_ = nil
	slot0.noobTaskUpdateHandler_ = nil
	slot0.clickPhaseHandler_ = nil
	slot0.AccumulateReceiveHandler_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetIsBack(slot0, slot1)
	slot0.isBack = slot1
end

function slot0.SetData(slot0)
	if not slot0.isBack then
		slot0.curPhase_ = slot0:GetCurPhase()

		ActivityNoobData:CacheSelectedPhase(slot0.curPhase_)
	else
		slot0.curPhase_ = ActivityNoobData:GetSelectedPhase()
	end

	slot0.isBack = false

	slot0:RefreshPhase()
	slot0:RefreshTask()
	slot0:RefreshProgress()
end

function slot0.RefreshPhase(slot0)
	slot0.phaseList_:StartScroll(#TaskData:GetNoobPhaseTask(), slot0.curPhase_)
end

function slot0.GetCurPhase(slot0)
	slot1 = TaskData:GetNoobPhaseTask()

	for slot6 = 1, ActivityNoobData:GetUnlockPhase() do
		for slot11, slot12 in pairs(TaskData:GetNoobTaskByPhase(slot6)) do
			if slot12.progress < AssignmentCfg[slot12.id].need or slot12.complete_flag == 0 then
				return slot6
			end
		end
	end

	return slot2
end

function slot0.RefreshPhaseItem(slot0, slot1, slot2)
	slot2:SetData(slot1)
	slot2:SetClickHandler(slot0.clickPhaseHandler_)
	slot2:SetSelect(slot0.curPhase_)
end

function slot0.OnClickPhase(slot0, slot1)
	if slot0.curPhase_ == slot1 then
		return
	end

	slot0.curPhase_ = slot1

	ActivityNoobData:CacheSelectedPhase(slot0.curPhase_)
	slot0:RefreshTask()

	for slot6, slot7 in pairs(slot0.phaseList_:GetItemList()) do
		slot7:SetSelect(slot1)
	end
end

function slot0.RefreshTask(slot0)
	slot0.taskList_ = TaskData:GetNoobTaskSortList(slot0.curPhase_)

	slot0.taskItemList_:StartScroll(#slot0.taskList_)
end

function slot0.RefreshTaskItem(slot0, slot1, slot2)
	slot2:SetData(slot0.taskList_[slot1].id)
end

function slot0.RefreshProgress(slot0, slot1)
	slot3 = TaskData:GetNoobCompletedList()
	slot4 = 0

	for slot8 = 1, ActivityNoobData:GetUnlockPhase() do
		slot4 = slot4 + slot3[slot8]
	end

	slot0.progressCfg_ = GameSetting.newbie_task.value
	slot0.completedTaskNum_ = slot4
	slot0.progressText_.text = string.format("%s/%s", slot0.completedTaskNum_, slot0.progressCfg_[#slot0.progressCfg_][1])

	if slot1 == true then
		slot0.progressList_:Refresh()
	else
		slot0.progressList_:StartScroll(#slot0.progressCfg_)
	end
end

function slot0.RefreshProgressItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.progressCfg_[slot1], slot0.completedTaskNum_)
end

function slot0.OnNoobAccumulateReceive(slot0)
	slot0:RefreshProgress(true)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.NoobTaskUpdate(slot0)
	slot0:RefreshTask()
	slot0:RefreshProgress()
	slot0:RefreshPhase()
end

return slot0
