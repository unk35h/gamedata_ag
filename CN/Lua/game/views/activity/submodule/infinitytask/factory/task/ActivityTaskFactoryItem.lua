ActivityTaskBaseItem = import("game.views.activity.Submodule.infinityTask.base.task.ActivityTaskBaseItem")
slot0 = class("ActivityTaskFactoryItem", ActivityTaskBaseItem)

function slot0.RefreshUI(slot0)
	slot1 = slot0.taskID_
	slot2 = AssignmentCfg[slot1]
	slot0.textContent_.text = slot2.name
	slot0.textDesc_.text = slot2.desc

	if slot2.need < (TaskData:GetActivityTaskList(slot2.activity_id)[slot1].progress or 0) then
		slot4 = slot5
	end

	slot0.finishCntText_.text = slot4
	slot0.targetCntText_.text = slot5

	if slot2.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		slot0.typeController_:SetSelectedState("daily")
	else
		slot0.typeController_:SetSelectedState("challenge")
	end
end

function slot0.GetRewardItem(slot0, slot1)
	return RewardPoolFactoryItem.New(slot0.goItemParent_, slot1, true)
end

return slot0
