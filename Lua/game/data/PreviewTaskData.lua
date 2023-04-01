slot0 = singletonClass("PreviewTaskData")

function slot0.Init(slot0)
	slot0.taskList_ = {}
	slot0.activityIDList_ = {}
end

function slot0.TaskModify(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if AssignmentCfg[slot6.id] == nil then
			print("TaskCfg没有对应ID:" .. slot6.id)

			break
		end

		if slot7.activity_id ~= 0 then
			slot0.curActivityID_ = slot7.activity_id
			slot0.activityIDList_[slot0.curActivityID_] = true
			slot0.taskList_[slot6.id] = slot0:ParseTaskData(slot6)
		end
	end
end

function slot0.TaskDelete(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = AssignmentCfg[slot6]
		slot0.taskList_[slot6] = nil
	end
end

function slot0.TaskSubmit(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if slot0.taskList_[slot6.id] then
			slot0.taskList_[slot6.id].complete_flag = slot0.taskList_[slot6.id].complete_flag + slot6.vary
		end
	end
end

function slot0.GetTaskList(slot0)
	return slot0.taskList_ or {}
end

function slot0.GetSortTaskIDList(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in pairs(slot0.taskList_) do
		if AssignmentCfg[slot8].activity_id == slot0.curActivityID_ and ActivityData:GetActivityIsOpen(slot10.activity_id) then
			if slot0.taskList_[slot8].complete_flag >= 1 then
				table.insert(slot4, slot8)
			elseif AssignmentCfg[slot8].need <= slot0.taskList_[slot8].progress then
				table.insert(slot2, slot8)
			else
				table.insert(slot3, slot8)
			end
		end
	end

	slot5 = handler(slot0, slot0.Compare)

	table.sort(slot2, slot5)
	table.sort(slot3, slot5)
	table.sort(slot4, slot5)
	table.insertto(slot1, slot2)
	table.insertto(slot1, slot3)
	table.insertto(slot1, slot4)

	return slot1
end

function slot0.Compare(slot0, slot1, slot2)
	return AssignmentCfg[slot1].type < AssignmentCfg[slot2].type and true or slot3.id < slot4.id
end

function slot0.GetTask(slot0, slot1)
	return slot0.taskList_[slot1]
end

function slot0.GetTaskProgress(slot0, slot1)
	if slot0.taskList_[slot1] then
		return slot0.taskList_[slot1].progress
	end

	return 0
end

function slot0.GetTaskComplete(slot0, slot1)
	if slot0.taskList_[slot1] then
		return slot0.taskList_[slot1].complete_flag >= 1
	end

	return false
end

function slot0.GetCurActivityID(slot0)
	return slot0.curActivityID_ or 0
end

function slot0.GetActivityIDList(slot0)
	return slot0.activityIDList_
end

function slot0.ParseTaskData(slot0, slot1)
	return {
		id = slot1.id,
		progress = slot1.progress,
		complete_flag = slot1.complete_flag,
		expired_timestamp = slot1.expired_timestamp
	}
end

return slot0
