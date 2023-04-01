slot0 = singletonClass("TaskData")

function slot0.Init(slot0)
	slot0.taskList_ = {}
	slot0.newbieTask_ = {}
	slot0.newbiePhaseTask_ = {}
	slot0.newbieTaskNeedSort_ = {}
	slot0.newbieTaskSortList_ = {}
	slot0.newbieTaskPhase_ = 1
	slot0.newbieDailyTask_ = {}
	slot0.newbieDailyTaskFinish_ = {}
	slot0.plotPhase_ = 1
	slot0.activityTask_ = {}
	slot0.activitySortTaskList_ = {}
	slot0.needSortActivity_ = {}
	slot0.noobTask_ = {}
	slot0.noobTaskNeedSort_ = {}
	slot0.noobTaskSortList_ = {}
	slot0.noobCompletedNumList_ = {}
	slot0.noobAdvanceTask_ = {}
	slot0.noobAdvanceTaskNeedSort_ = {}
	slot0.noobAdvanceTaskSortList_ = {}
	slot0.isCompletedAllNoobAdvanceTask_ = false
end

function slot0.TaskInit(slot0, slot1, slot2)
	slot0.taskList_ = {}

	slot0:TaskModify(slot1)

	slot0.newbieTaskPhase_ = slot2
end

function slot0.TaskUpdate(slot0, slot1, slot2)
	slot0:TaskModify(slot1)
end

function slot0.TaskModify(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if AssignmentCfg[slot6.id] == nil then
			print("TaskCfg没有对应ID:" .. slot6.id)

			break
		end

		if slot7.type == TaskConst.TASK_TYPE.ALPHA then
			slot0:UpdateNewbieTask(slot6)
		elseif slot7.type == TaskConst.TASK_TYPE.NOOB then
			slot0:UpdateNoobTask(slot6)
		elseif slot7.type == TaskConst.TASK_TYPE.NOOB_ADVANCE then
			slot0:UpdateNoobAdvanceTask(slot6)
		elseif slot7.type == TaskConst.TASK_TYPE.DAILY_OFFER then
			slot0:UpdateNewbieDailyTask(slot6)
		elseif slot7.activity_id ~= 0 then
			slot0:UpdateActivityTask(slot6)
		else
			slot0.taskList_[slot6.id] = slot0:ParseTaskData(slot6)

			slot0:UpdatePloatPhase(slot6.id)
		end
	end
end

function slot0.TaskDelete(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if AssignmentCfg[slot6].activity_id ~= 0 then
			slot0.activityTask_[slot7.activity_id][slot6] = nil

			slot0:UpdateActivityTaskRedTip(slot7.activity_id)

			slot0.needSortActivity_[slot7.activity_id] = true
		else
			slot0.taskList_[slot6] = nil
		end
	end
end

function slot0.TaskSubmit(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if slot0.taskList_[slot6.id] then
			slot0.taskList_[slot6.id].complete_flag = slot0.taskList_[slot6.id].complete_flag + slot6.vary
		end
	end
end

function slot0.UpdatePloatPhase(slot0, slot1)
	if AssignmentCfg[slot1].type == TaskConst.TASK_TYPE.PLOT and slot0.plotPhase_ < slot2.phase then
		slot0.plotPhase_ = slot2.phase
	end
end

function slot0.GetTaskList(slot0)
	return slot0.taskList_ or {}
end

function slot0.GetTaskIDList(slot0, slot1)
	return TaskTools.GetTaskList(slot0.taskList_, slot1)
end

function slot0.GetSortTaskIDList(slot0, slot1)
	slot3 = {}
	slot4 = {}
	slot5 = {}
	slot6 = {}

	for slot10, slot11 in pairs(TaskTools.GetTaskList(slot0.taskList_, slot1)) do
		slot12 = AssignmentCfg[slot11]

		if slot0.taskList_[slot11].complete_flag >= 1 then
			if slot12.type == TaskConst.TASK_TYPE.PLOT then
				if slot0.plotPhase_ <= slot12.phase then
					table.insert(slot6, slot11)
				end
			else
				table.insert(slot6, slot11)
			end
		elseif slot12.condition == GameSetting.task_top_type.value[1] and slot12.type == TaskConst.TASK_TYPE.PLOT then
			-- Nothing
		elseif AssignmentCfg[slot11].need <= slot0.taskList_[slot11].progress then
			table.insert(slot4, slot11)
		else
			table.insert(slot5, slot11)
		end
	end

	table.insertto(slot3, slot4)
	table.insertto(slot3, slot5)
	table.insertto(slot3, slot6)

	return slot3
end

function slot0.GetPlotPhaseID(slot0)
	for slot5, slot6 in pairs(TaskTools.GetTaskList(slot0.taskList_, TaskConst.TASK_TYPE.PLOT)) do
		if AssignmentCfg[slot6].condition == GameSetting.task_top_type.value[1] and slot7.type == TaskConst.TASK_TYPE.PLOT and slot0.plotPhase_ <= slot7.phase then
			return slot6
		end
	end

	print("剧情任务没有阶段任务")
end

function slot0.GetFinishTaskIds(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in pairs(TaskTools.GetTaskList(slot0.taskList_, slot1)) do
		if AssignmentCfg[slot8].need <= slot0.taskList_[slot8].progress and slot0.taskList_[slot8].complete_flag == 0 then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0.GetIsAllFinish(slot0, slot1)
	for slot6, slot7 in pairs(TaskTools.GetTaskList(slot0.taskList_, slot1)) do
		if slot0.taskList_[slot7].complete_flag < 1 then
			return false
		end
	end

	return true
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

function slot0.ParseTaskData(slot0, slot1)
	return {
		id = slot1.id,
		progress = slot1.progress,
		complete_flag = slot1.complete_flag,
		expired_timestamp = slot1.expired_timestamp
	}
end

function slot0.SortTask(slot0, slot1)
	if slot1 == nil then
		return {}
	end

	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in pairs(slot1) do
		if slot10.complete_flag == 0 then
			if slot10.progress < AssignmentCfg[slot10.id].need then
				if slot11.timer_id ~= 0 then
					if manager.time:GetServerTime() < ActivityData:GetActivityData(slot12).startTime then
						table.insert(slot2, slot10)
					else
						table.insert(slot3, slot10)
					end
				else
					table.insert(slot3, slot10)
				end
			else
				table.insert(slot4, slot10)
			end
		elseif slot10.complete_flag >= 1 then
			table.insert(slot5, slot10)
		end
	end

	table.sort(slot4, function (slot0, slot1)
		return AssignmentCfg[slot0.id].type < AssignmentCfg[slot1.id].type and true or slot0.id < slot1.id
	end)
	table.sort(slot3, function (slot0, slot1)
		return AssignmentCfg[slot0.id].type < AssignmentCfg[slot1.id].type and true or slot0.id < slot1.id
	end)
	table.sort(slot5, function (slot0, slot1)
		return AssignmentCfg[slot0.id].type < AssignmentCfg[slot1.id].type and true or slot0.id < slot1.id
	end)
	table.sort(slot2, function (slot0, slot1)
		return AssignmentCfg[slot0.id].type < AssignmentCfg[slot1.id].type and true or slot0.id < slot1.id
	end)
	table.insertto(slot4, slot3)
	table.insertto(slot4, slot2)
	table.insertto(slot4, slot5)

	return slot4
end

function slot0.GetAssignmentPhase(slot0)
	return slot0.newbieTaskPhase_ or 1
end

function slot0.GetNewbieTaskSortList(slot0, slot1)
	if slot0.newbieTaskNeedSort_[slot1] ~= false then
		slot0.newbieTaskNeedSort_[slot1] = false
		slot0.newbieTaskSortList_[slot1] = slot0:SortTask(slot0.newbieTask_[slot1])
	end

	return slot0.newbieTaskSortList_[slot1]
end

function slot0.GetNewbieTask(slot0, slot1)
	return slot0.newbieTask_[AssignmentCfg[slot1].phase][slot1]
end

function slot0.GetNewbiePhaseTask(slot0)
	return slot0.newbiePhaseTask_
end

function slot0.UpdateNewbieTask(slot0, slot1)
	slot2 = AssignmentCfg[slot1.id]
	slot3 = slot2.phase

	if slot2.condition == TaskConst.STAGE_TASK_ID and slot2.additional_parameter[1] == TaskConst.TASK_TYPE.ALPHA then
		slot0.newbiePhaseTask_[slot3] = slot0:ParseTaskData(slot1)
	else
		slot0.newbieTask_[slot3] = slot0.newbieTask_[slot3] or {}
		slot0.newbieTask_[slot3][slot1.id] = slot0:ParseTaskData(slot1)
	end

	slot0.newbieTaskNeedSort_[slot3] = true

	slot0:UpdateNewbieTaskRedPoint()
end

function slot0.NewbieTaskSubmit(slot0, slot1)
	slot2 = AssignmentCfg[slot1]
	slot3 = slot2.phase

	if slot2.condition == TaskConst.STAGE_TASK_ID and slot2.additional_parameter[1] == TaskConst.TASK_TYPE.ALPHA then
		slot0.newbiePhaseTask_[slot3].complete_flag = 1
	else
		slot0.newbieTask_[slot3][slot1].complete_flag = 1
	end

	slot0.newbieTaskNeedSort_[slot3] = true

	slot0:UpdateNewbieTaskRedPoint()
end

function slot0.UpdateNewbieTaskRedPoint(slot0)
	slot2 = slot0:GetNewbieTaskSortList(slot0:GetAssignmentPhase()) or {}

	for slot6, slot7 in pairs(slot2) do
		if AssignmentCfg[slot7.id].need <= slot7.progress and slot7.complete_flag < 1 then
			manager.redPoint:setTip(RedPointConst.NEWBIE_TASK, 1)

			return
		end
	end

	if slot0:GetNewbiePhaseTask()[slot1] and AssignmentCfg[slot3.id].need <= slot3.progress and slot3.complete_flag < 1 then
		manager.redPoint:setTip(RedPointConst.NEWBIE_TASK, 1)

		return
	end

	manager.redPoint:setTip(RedPointConst.NEWBIE_TASK, 0)
end

function slot0.UpdateNewbieDailyTask(slot0, slot1)
	slot2 = nil

	if slot0.newbieDailyTask_[slot1.id] == nil then
		slot2 = true
	end

	slot0.newbieDailyTask_[slot1.id] = slot0:ParseTaskData(slot1)

	if slot0.newbieDailyTask_[slot1.id].complete_flag == 1 and not table.keyof(slot0.newbieDailyTaskFinish_, slot1.id) then
		table.insert(slot0.newbieDailyTaskFinish_, slot1.id)
	end

	slot0:UpdateNewbieDailyTaskRedTip()

	if slot2 then
		manager.notify:Invoke(NEWBIE_DAILY_UPDATE)
	end
end

function slot0.GetNewbieDailyTask(slot0)
	return slot0.newbieDailyTask_
end

function slot0.NewbieDailyTaskSubmit(slot0, slot1)
	slot0.newbieDailyTask_[slot1].complete_flag = 1

	table.insert(slot0.newbieDailyTaskFinish_, slot1)
	slot0:UpdateNewbieDailyTaskRedTip()
	manager.notify:Invoke(NEWBIE_DAILY_SUBMIT)
end

function slot0.GetNewbieDailyTaskFinishCnt(slot0)
	return #slot0.newbieDailyTaskFinish_
end

function slot0.UpdateNewbieDailyTaskRedTip(slot0)
	slot1 = slot0:GetNewbieDailyTask() or {}

	for slot5, slot6 in pairs(slot1) do
		if AssignmentCfg[slot6.id].need <= slot6.progress and slot6.complete_flag < 1 then
			manager.redPoint:setTip(RedPointConst.NEWBIE_DAILY_TASK, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.NEWBIE_DAILY_TASK, 0)
end

function slot0.UpdateActivityTask(slot0, slot1)
	slot2 = AssignmentCfg[slot1.id]

	slot0:InitAnniversaryFirstTask(slot2.activity_id)

	slot0.activityTask_[slot2.activity_id] = slot0.activityTask_[slot2.activity_id] or {}
	slot0.activityTask_[slot2.activity_id][slot1.id] = slot0:ParseTaskData(slot1)

	slot0:UpdateActivityTaskRedTip(slot2.activity_id)

	slot0.needSortActivity_[slot2.activity_id] = true
end

function slot0.GetActivityTaskList(slot0, slot1)
	return slot0.activityTask_[slot1]
end

function slot0.GetCanGetActivityTaskList(slot0, slot1)
	slot2 = slot0:GetActivityTaskList(slot1) or {}
	slot3 = {}

	for slot7, slot8 in pairs(slot2) do
		slot9 = AssignmentCfg[slot8.id]
		slot10 = slot0:GetActivityTask(slot1, slot8.id).progress

		if not slot0:GetActivityTaskComplete(slot1, slot8.id) and slot9.need <= slot10 then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0.GetActivityTask(slot0, slot1, slot2)
	if slot0:GetActivityTaskList(slot1) == nil then
		return nil
	end

	return slot3[slot2]
end

function slot0.GetActivityTaskComplete(slot0, slot1, slot2)
	if slot0:GetActivityTaskList(slot1) == nil then
		-- Nothing
	end

	return slot3[slot2].complete_flag >= 1
end

function slot0.OsirisTaskSubmit(slot0, slot1)
	slot2 = AssignmentCfg[slot1].activity_id
	slot0.activityTask_[slot2][slot1].complete_flag = 1

	slot0:UpdateActivityTaskRedTip(slot2)

	slot0.needSortActivity_[slot2] = true
end

function slot0.GetActivityTaskSortList(slot0, slot1)
	if slot0.needSortActivity_[slot1] == true then
		slot0.activitySortTaskList_[slot1] = slot0:SortTask(slot0.activityTask_[slot1])
		slot0.needSortActivity_[slot1] = false
	end

	return slot0.activitySortTaskList_[slot1] or {}
end

function slot0.UpdateActivityTaskRedTip(slot0, slot1)
	slot2 = slot0:GetActivityTaskList(slot1) or {}
	slot3 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot1)

	for slot7, slot8 in pairs(slot2) do
		if AssignmentCfg[slot8.id].need <= slot8.progress and slot8.complete_flag < 1 then
			manager.redPoint:setTip(slot3, 1)

			return
		end
	end

	manager.redPoint:setTip(slot3, 0)
end

function slot0.InitAnniversaryFirstTask(slot0, slot1)
	if slot1 ~= ActivityConst.ACTIVITY_2_0_ANNIVERSARY_NORMAL_TASK then
		return
	end

	if slot0.activityTask_[slot1] ~= nil then
		return
	end

	slot0.activityTask_[slot1] = {}
	slot5 = ActivityConst.ACTIVITY_2_0_ANNIVERSARY_NORMAL_TASK

	for slot5, slot6 in ipairs(AssignmentCfg.get_id_list_by_activity_id[slot5]) do
		slot0.activityTask_[slot1][slot6] = slot0:ParseTaskData({
			complete_flag = 0,
			progress = 0,
			id = slot6
		})
	end
end

function slot0.GetNoobPhaseTask(slot0)
	return slot0.noobTask_
end

function slot0.GetNoobTaskSortList(slot0, slot1)
	if slot0.noobTaskNeedSort_[slot1] ~= false then
		slot0.noobTaskNeedSort_[slot1] = false
		slot0.noobTaskSortList_[slot1] = slot0:SortTask(slot0.noobTask_[slot1])
	end

	return slot0.noobTaskSortList_[slot1]
end

function slot0.GetNoobTaskByPhase(slot0, slot1)
	return slot0.noobTask_[slot1]
end

function slot0.GetNoobTask(slot0, slot1)
	return slot0.noobTask_[AssignmentCfg[slot1].phase][slot1]
end

function slot0.UpdateNoobTask(slot0, slot1)
	slot0.noobTask_[slot3] = slot0.noobTask_[AssignmentCfg[slot1.id].phase] or {}
	slot0.noobTask_[slot3][slot1.id] = slot0:ParseTaskData(slot1)
	slot0.noobTaskNeedSort_[slot3] = true
	slot4 = 0

	for slot8, slot9 in pairs(slot0.noobTask_[slot3]) do
		if slot9.complete_flag >= 1 then
			slot4 = slot4 + 1
		end
	end

	slot0.noobCompletedNumList_[slot3] = slot4

	slot0:UpdateNoobTaskRedPoint(slot3)
end

function slot0.NoobTaskSubmit(slot0, slot1)
	slot3 = AssignmentCfg[slot1].phase
	slot0.noobTask_[slot3][slot1].complete_flag = 1
	slot0.noobTaskNeedSort_[slot3] = true
	slot4 = 0

	for slot8, slot9 in pairs(slot0.noobTask_[slot3]) do
		if slot9.complete_flag >= 1 then
			slot4 = slot4 + 1
		end
	end

	slot0.noobCompletedNumList_[slot3] = slot4

	slot0:UpdateNoobTaskRedPoint(slot3)
end

function slot0.GetNoobCompletedList(slot0)
	return slot0.noobCompletedNumList_
end

function slot0.UpdateNoobTaskRedPoint(slot0, slot1)
	slot2 = ActivityNoobData:GetUnlockPhase()
	slot3 = slot0:GetNoobTaskByPhase(slot1) or {}

	for slot7, slot8 in pairs(slot3) do
		if AssignmentCfg[slot8.id].phase <= slot2 and AssignmentCfg[slot8.id].need <= slot8.progress and slot8.complete_flag < 1 then
			manager.redPoint:setTip(string.format("%s_%d", RedPointConst.NEWBIE_TASK, slot1), 1)

			return
		end
	end

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.NEWBIE_TASK, slot1), 0)
end

function slot0.GetNoobAdvanceTaskSortList(slot0, slot1)
	if slot0.noobAdvanceTaskNeedSort_[slot1] ~= false then
		slot0.noobAdvanceTaskNeedSort_[slot1] = false
		slot0.noobAdvanceTaskSortList_[slot1] = slot0:SortTask(slot0.noobAdvanceTask_[slot1])
	end

	return slot0.noobAdvanceTaskSortList_[slot1]
end

function slot0.GetNoobAdvanceTaskByPhase(slot0, slot1)
	return slot0.noobAdvanceTask_[slot1]
end

function slot0.GetNoobAdvanceTask(slot0, slot1)
	return slot0.noobAdvanceTask_[AssignmentCfg[slot1].phase][slot1]
end

function slot0.UpdateNoobAdvanceTask(slot0, slot1)
	slot0.noobAdvanceTask_[slot3] = slot0.noobAdvanceTask_[AssignmentCfg[slot1.id].phase] or {}
	slot0.noobAdvanceTask_[slot3][slot1.id] = slot0:ParseTaskData(slot1)
	slot0.noobAdvanceTaskNeedSort_[slot3] = true

	slot0:UpdateNoobAdvanceTaskRedPoint(slot3)
end

function slot0.NoobAdvanceTaskSubmit(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot9 = AssignmentCfg[slot7].phase
		slot0.noobAdvanceTask_[slot9][slot7].complete_flag = 1
		slot0.noobAdvanceTaskNeedSort_[slot9] = true
		slot2[slot9] = true
	end

	for slot6, slot7 in pairs(slot2) do
		slot0:UpdateNoobAdvanceTaskRedPoint(slot6)
	end
end

function slot0.UpdateNoobAdvanceTaskRedPoint(slot0, slot1)
	for slot6, slot7 in ipairs(GameSetting.advanced_task_tad.value) do
		for slot11, slot12 in ipairs(slot7[2]) do
			if slot12[1] == slot1 then
				slot13 = slot6

				for slot18, slot19 in pairs(slot0:GetNoobAdvanceTaskByPhase(slot1)) do
					if AssignmentCfg[slot19.id].need <= slot19.progress and slot19.complete_flag == 0 then
						manager.redPoint:setTip(string.format("%s_%d_%d", RedPointConst.NOOB_ADVANCE, slot13, slot1), 1)

						return
					end
				end

				manager.redPoint:setTip(string.format("%s_%d_%d", RedPointConst.NOOB_ADVANCE, slot13, slot1), 0)

				return
			end
		end
	end
end

function slot0.IsCompletedAllNoobAdvanceTask(slot0)
	if slot0.isCompletedAllNoobAdvanceTask_ == true then
		return true
	end

	for slot4, slot5 in ipairs(slot0.noobAdvanceTask_) do
		for slot9, slot10 in pairs(slot5) do
			if slot10.progress < AssignmentCfg[slot10.id].need or slot10.complete_flag == 0 then
				slot0.isCompletedAllNoobAdvanceTask_ = false

				return false
			end
		end
	end

	slot0.isCompletedAllNoobAdvanceTask_ = true

	return true
end

return slot0
