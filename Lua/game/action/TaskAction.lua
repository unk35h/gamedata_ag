slot1 = manager.net

slot1:Bind(28001, function (slot0)
	if slot0.send_type == 0 then
		TaskData:TaskInit(slot0.assignment_list, slot0.assignment_phase, slot0.newbie_phase)
	elseif slot0.send_type then
		TaskData:TaskUpdate(slot0.assignment_list, slot0.assignment_phase, slot0.newbie_phase)
	end

	TaskAction:OnTaskChange()
end)

slot1 = manager.net

slot1:Bind(28005, function (slot0)
	TaskData:TaskDelete(slot0.id_list)
	TaskAction:OnTaskChange()
end)

slot1 = manager.net

slot1:Bind(28007, function (slot0)
	TaskData:TaskModify(slot0.progress_list)
	TaskAction:OnTaskChange()
end)

slot1 = manager.notify

slot1:RegistListener(BATTLE_STAGE_PLOT_CHANGE, function (slot0)
	TaskAction:UpdateTaskRedTip()
end)

return {
	TryToSubmitTask = function (slot0, slot1)
		manager.net:SendWithLoadingNew(28010, {
			id = slot1
		}, 28011, handler(slot0, slot0.OnTryToSubmitTask))
	end,
	OnTryToSubmitTask = function (slot0, slot1, slot2)
		slot3 = AssignmentCfg[slot2.id]

		if isSuccess(slot1.result) then
			TaskData:TaskSubmit({
				{
					vary = 1,
					id = slot2.id
				}
			})
			TaskAction:OnTaskChange()

			slot4 = deepClone(slot3.reward)
			slot5 = deepClone(slot4)
			slot6 = 0
			slot7 = 0
			slot6, slot9, slot4 = slot0:FilterPassportWeeklyBonus(slot3.type, slot4)

			if slot9 > 0 then
				PassportData:AddWeeklyExp(slot7)
			end

			if #slot5 > 0 then
				showRewardUI(slot5, {
					ItemConst.ITEM_TYPE.HERO,
					ItemConst.ITEM_TYPE.WEAPON_SERVANT
				})
			end

			if slot6 > 0 then
				getRewardData(slot4)
			end
		else
			ShowTips(slot1.result)
		end
	end,
	SubmitTask = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(28010, {
			id = slot0
		}, 28011, function (slot0)
			uv0(slot0)
		end)
	end,
	TryToSubmitPassportTaskList = function (slot0, slot1, slot2, slot3)
		uv0.passportDailyIdList_ = slot1
		uv0.passportWeeklyIdList_ = slot2
		uv0.passportChallengeIdList_ = slot3
		slot4 = {}

		table.insertto(slot4, slot1)
		table.insertto(slot4, slot2)
		table.insertto(slot4, slot3)
		manager.net:SendWithLoadingNew(28014, {
			id_list = slot4,
			type = TaskConst.TASK_TYPE.PASSPORT_MULTIPLE_TASK_TYPE
		}, 28015, handler(uv0, uv0.OnTryToSubmitTaskList))
	end,
	TryToSubmitTaskList = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(28014, {
			id_list = slot1,
			type = slot2
		}, 28015, handler(uv0, uv0.OnTryToSubmitTaskList))
	end,
	TryToSubmitActivityTaskList = function (slot0, slot1)
		manager.net:SendWithLoadingNew(28014, {
			type = 0,
			id_list = slot1
		}, 28015, handler(uv0, uv0.OnTryToSubmitActivityTaskList))
	end,
	TryToSubmitTaskListWithCallback = function (slot0, slot1, slot2, slot3)
		slot5 = manager.net

		slot5:SendWithLoadingNew(28014, {
			id_list = slot1,
			type = slot2
		}, 28015, function (slot0, slot1)
			if uv0 then
				uv0(slot0, slot1)
			end
		end)
	end,
	OnTryToSubmitActivityTaskList = function (slot0, slot1, slot2)
		slot3 = {}

		if not isSuccess(slot1.result) then
			ShowTips(slot1.result)

			return
		end

		for slot7, slot8 in ipairs(slot2.id_list) do
			TaskData:OsirisTaskSubmit(slot8)
			table.insertto(slot3, AssignmentCfg[slot8].reward or {})
		end

		if #mergeReward(slot3) > 0 then
			getReward(slot3)
		end

		TaskAction:OnTaskChange()
	end,
	OnTryToSubmitTaskList = function (slot0, slot1, slot2)
		slot3 = {}

		if not isSuccess(slot1.result) then
			ShowTips(slot1.result)

			return
		end

		for slot7, slot8 in ipairs(slot2.id_list) do
			TaskData:TaskSubmit({
				{
					vary = 1,
					id = slot8
				}
			})
			table.insertto(slot3, AssignmentCfg[slot8].reward or {})
		end

		if slot2.type == TaskConst.TASK_TYPE.DAILY then
			slot7 = ActivityPtConst.TASK_DAILY_ACTIVITY_PT

			for slot7, slot8 in ipairs(ActivityPtCfg[slot7].target) do
				slot10 = TaskTools.ActivityPtCanReceive(ActivityPtConst.TASK_DAILY_ACTIVITY_PT, slot7)

				if not TaskTools.ActivityPtIsReceived(ActivityPtConst.TASK_DAILY_ACTIVITY_PT, slot7) and slot10 then
					ActivityPtData:TaskDailySubmit({
						activityID = ActivityPtConst.TASK_DAILY_ACTIVITY_PT,
						activityPt = ActivityPtData:GetGiftPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT, slot7)
					})
					table.insertto(slot3, ActivityPtCfg[ActivityPtConst.TASK_DAILY_ACTIVITY_PT].reward[slot7])
				end
			end

			ActivityPtAction:UpdateActivityPt()
		elseif slot2.type == TaskConst.TASK_TYPE.WEEK then
			slot7 = ActivityPtConst.TASK_WEEK_ACTIVITY_PT

			for slot7, slot8 in ipairs(ActivityPtCfg[slot7].target) do
				slot10 = TaskTools.ActivityPtCanReceive(ActivityPtConst.TASK_WEEK_ACTIVITY_PT, slot7)

				if not TaskTools.ActivityPtIsReceived(ActivityPtConst.TASK_WEEK_ACTIVITY_PT, slot7) and slot10 then
					ActivityPtData:TaskDailySubmit({
						activityID = ActivityPtConst.TASK_WEEK_ACTIVITY_PT,
						activityPt = ActivityPtData:GetGiftPt(ActivityPtConst.TASK_WEEK_ACTIVITY_PT, slot7)
					})
					table.insertto(slot3, ActivityPtCfg[ActivityPtConst.TASK_WEEK_ACTIVITY_PT].reward[slot7])
				end
			end

			ActivityPtAction:UpdateActivityPt()
		end

		slot4 = deepClone(mergeReward(slot3))
		slot5 = 0
		slot6 = 0

		if slot2.type == TaskConst.TASK_TYPE.PASSPORT_MULTIPLE_TASK_TYPE then
			slot8 = {}

			for slot12, slot13 in ipairs(slot0.passportDailyIdList_) do
				table.insertto(slot8, AssignmentCfg[slot13].reward or {})
			end

			for slot12, slot13 in ipairs(slot0.passportWeeklyIdList_) do
				table.insertto(slot8, AssignmentCfg[slot13].reward or {})
			end

			slot9, slot10 = nil
			slot14 = TaskConst.TASK_TYPE.PASSPORT_DAILY
			slot15 = deepClone(mergeReward(slot8))
			slot9, slot10, slot8 = slot0:FilterPassportWeeklyBonus(slot14, slot15)

			for slot14, slot15 in ipairs(slot0.passportChallengeIdList_) do
				table.insertto(slot8, AssignmentCfg[slot15].reward or {})
			end

			slot11, slot12 = nil
			slot13, slot14, slot15 = slot0:FilterPassportWeeklyBonus(0, mergeReward(slot8))
			slot5 = slot13 + slot9
			slot6 = slot14 + slot10
			slot3 = slot15
		else
			slot5, slot6, slot3 = slot0:FilterPassportWeeklyBonus(slot2.type, slot3)
		end

		if slot6 > 0 then
			PassportData:AddWeeklyExp(slot6)
		end

		if #slot4 > 0 then
			showRewardUI(slot4, {
				ItemConst.ITEM_TYPE.HERO
			})
		end

		if slot5 > 0 then
			getRewardData(slot3)
		end

		TaskAction:OnTaskChange()
	end,
	FilterPassportWeeklyBonus = function (slot0, slot1, slot2)
		slot3 = 0
		slot4 = 0

		for slot8, slot9 in pairs(slot2) do
			if slot1 == TaskConst.TASK_TYPE.PASSPORT_WEEKLY or slot1 == TaskConst.TASK_TYPE.PASSPORT_DAILY then
				if slot9[1] == CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP then
					slot9[2] = math.min(GameSetting.battlepass_exp_limit_weekly.value[1] - PassportData:GetExpWeekly(), slot9[2])
					slot4 = slot9[2]
				end

				if slot9[2] == 0 then
					table.remove(slot2, slot8)
				else
					slot3 = slot3 + 1
				end
			else
				slot3 = slot3 + 1
			end
		end

		return slot3, slot4, slot2
	end,
	SubmitTaskOneKey = function (slot0, slot1)
		return manager.net:SendWithLoading(28014, {
			type = slot1
		}, 28015)
	end,
	UpdateTaskProgress = function (slot0, slot1, slot2, slot3)
		return manager.net:SendWithLoading(28012, {
			progress_info = {
				id = slot1,
				progress = slot2,
				complete_flag = slot3
			}
		}, 28013)
	end,
	OnTaskChange = function (slot0)
		manager.notify:CallUpdateFunc(TASK_LIST_CHANGE)
		manager.notify:Invoke(OSIRIS_TASK_UPDATE)
		TaskAction:UpdateTaskRedTip()
	end,
	UpdateTaskRedTip = function (slot0)
		slot0:UpdateDailyTaskRedTip()
		slot0:UpdatePlotTaskRedTip()
		slot0:UpdateWeekTaskRedTip()
		slot0:UpdatePassportTaskRedTip()
		slot0:UpdateClubTaskRedTip()
		RegressionAction.CheckTaskRedPoint()
		StrategyMatrixAction.CheckAllRedPoint()
	end,
	UpdatePassportTaskRedTip = function (slot0)
		if not (PassportData:IsOpen() and PassportData:IsUnlock()) then
			manager.redPoint:setTip(RedPointConst.PASSPORT_TASK_BONUS_7, 0)
			manager.redPoint:setTip(RedPointConst.PASSPORT_TASK_BONUS_8, 0)
			manager.redPoint:setTip(RedPointConst.PASSPORT_TASK_BONUS_9, 0)
		else
			slot2 = GameSetting.battlepass_exp_limit_weekly.value[1] <= PassportData:GetExpWeekly()
			slot4 = PassportData:GetLevel() >= #BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type]
			slot6 = manager.time:GetServerTime()

			for slot10, slot11 in ipairs({
				TaskConst.TASK_TYPE.PASSPORT_DAILY,
				TaskConst.TASK_TYPE.PASSPORT_WEEKLY
			}) do
				slot12 = 0

				for slot17, slot18 in ipairs(TaskData:GetFinishTaskIds(slot11)) do
					if (TaskData:GetTask(slot18).expired_timestamp or 0) > 0 and slot20 - slot6 > 0 or slot20 == 0 then
						slot12 = slot12 + 1
					end
				end

				manager.redPoint:setTip(RedPointConst["PASSPORT_TASK_BONUS_" .. slot11], slot12 > 0 and not slot2 and not slot4 and 1 or 0)
			end

			for slot11, slot12 in ipairs({
				TaskConst.TASK_TYPE.PASSPORT_CHALLENGE
			}) do
				slot13 = 0

				for slot18, slot19 in ipairs(TaskData:GetFinishTaskIds(slot12)) do
					if (TaskData:GetTask(slot19).expired_timestamp or 0) > 0 and slot21 - slot6 > 0 or slot21 == 0 then
						slot13 = slot13 + 1
					end
				end

				manager.redPoint:setTip(RedPointConst["PASSPORT_TASK_BONUS_" .. slot12], slot13 > 0 and not slot4 and 1 or 0)
			end
		end
	end,
	UpdateDailyTaskRedTip = function (slot0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TASK_DAILY) then
			manager.redPoint:setTip(RedPointConst.TASK_DAILY, 0)

			return false
		end

		for slot5, slot6 in pairs(TaskData:GetTaskIDList(TaskConst.TASK_TYPE.DAILY)) do
			slot7 = TaskData:GetTask(slot6)

			if AssignmentCfg[slot7.id].need <= slot7.progress and slot7.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.TASK_DAILY, 1)

				return true
			end
		end

		for slot6 = 1, #ActivityPtCfg[ActivityPtConst.TASK_DAILY_ACTIVITY_PT].target do
			if slot2.target[slot6] <= ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT) and not ActivityPtData:GetDailyGetRewardList()[ActivityPtConst.TASK_DAILY_ACTIVITY_PT][slot2.target[slot6]] then
				manager.redPoint:setTip(RedPointConst.TASK_DAILY, 1)

				return true
			end
		end

		manager.redPoint:setTip(RedPointConst.TASK_DAILY, 0)

		return false
	end,
	UpdatePlotTaskRedTip = function (slot0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TASK_PLOT) then
			manager.redPoint:setTip(RedPointConst.TASK_PLOT, 0)

			return false
		end

		for slot5, slot6 in pairs(TaskData:GetTaskIDList(TaskConst.TASK_TYPE.PLOT)) do
			slot7 = TaskData:GetTask(slot6)

			if AssignmentCfg[slot7.id].need <= slot7.progress and slot7.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.TASK_PLOT, 1)

				return true
			end
		end

		manager.redPoint:setTip(RedPointConst.TASK_PLOT, 0)

		return false
	end,
	UpdateWeekTaskRedTip = function (slot0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TASK_WEEK) then
			manager.redPoint:setTip(RedPointConst.TASK_WEEK, 0)

			return false
		end

		for slot5, slot6 in pairs(TaskData:GetTaskIDList(TaskConst.TASK_TYPE.WEEK)) do
			slot7 = TaskData:GetTask(slot6)

			if AssignmentCfg[slot7.id].need <= slot7.progress and slot7.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.TASK_WEEK, 1)

				return true
			end
		end

		for slot6 = 1, #ActivityPtCfg[ActivityPtConst.TASK_WEEK_ACTIVITY_PT].target do
			if slot2.target[slot6] <= ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_WEEK_ACTIVITY_PT) and not ActivityPtData:GetDailyGetRewardList()[ActivityPtConst.TASK_WEEK_ACTIVITY_PT][slot2.target[slot6]] then
				manager.redPoint:setTip(RedPointConst.TASK_WEEK, 1)

				return true
			end
		end

		manager.redPoint:setTip(RedPointConst.TASK_WEEK, 0)

		return false
	end,
	UpdateClubTaskRedTip = function (slot0)
		slot1 = GuildData:GetGuildInfo()

		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CLUB_TASK) or slot1 == nil or slot1.id == nil then
			manager.redPoint:setTip(RedPointConst.CLUB_TASK, 0)

			return false
		end

		for slot6, slot7 in pairs(TaskData:GetTaskIDList(TaskConst.TASK_TYPE.CLUB_TASK)) do
			slot8 = TaskData:GetTask(slot7)

			if AssignmentCfg[slot8.id].need <= slot8.progress and slot8.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.CLUB_TASK, 1)

				return true
			end
		end

		manager.redPoint:setTip(RedPointConst.CLUB_TASK, 0)

		return false
	end
}
