slot0 = singletonClass("CultivateHeroData")

function slot0.Init(slot0)
	slot0.dailyTaskStatus_ = {}
	slot0.heroTaskInfoList_ = {}
	slot0.accumulateTaskInfoList_ = {}
	slot0.accumulateTaskAllReceivedList_ = {}
end

function slot0.SetData(slot0, slot1)
	slot2 = slot1.activity_id
	slot0.heroTaskInfoList_[slot2] = {}
	slot0.accumulateTaskInfoList_[slot2] = {}

	for slot6, slot7 in ipairs(slot1.task_info_list) do
		slot0.heroTaskInfoList_[slot2][slot7.id] = {
			progress = slot7.progress
		}

		if CultivateHeroTaskCfg[slot7.id].condition <= slot7.progress then
			slot0.heroTaskInfoList_[slot2][slot7.id].isCompleted = true
		end
	end

	for slot6, slot7 in ipairs(slot1.got_reward_task_id_list) do
		slot0.heroTaskInfoList_[slot2][slot7] = slot0.heroTaskInfoList_[slot2][slot7] or {}
		slot0.heroTaskInfoList_[slot2][slot7].isCompleted = true
		slot0.heroTaskInfoList_[slot2][slot7].isReceived = true
	end

	if slot1.daily_pt_task_got_flag == true then
		slot0.dailyTaskStatus_[slot2] = true
	else
		slot0.dailyTaskStatus_[slot2] = nil
	end

	for slot6, slot7 in ipairs(slot1.got_point_id_list) do
		slot0.accumulateTaskInfoList_[slot2][slot7] = {
			isReceived = true
		}
	end

	slot0.accumulateTaskAllReceivedList_[slot2] = nil

	slot0:RefreshDailyRedPoint(slot2)
	slot0:RefreshAccumulateRedPoint(slot2)
	slot0:RefreshHeroTaskRedPoint(slot2)
	slot0:RefreshSelectRedPoint(slot2)
end

function slot0.UpdateDailyTask(slot0, slot1)
	slot2 = slot1.activity_id

	if slot1.daily_pt_task_got_flag == true then
		slot0.dailyTaskStatus_[slot2] = true
	else
		slot0.dailyTaskStatus_[slot2] = nil
	end

	slot0:RefreshDailyRedPoint(slot2)
end

function slot0.UpdateHeroTask(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.task_info_list) do
		slot8 = CultivateHeroTaskCfg[slot7.id].activity_id
		slot2[slot8] = true
		slot0.heroTaskInfoList_[slot8][slot7.id] = {
			progress = slot7.progress
		}

		if CultivateHeroTaskCfg[slot7.id].condition <= slot7.progress then
			slot0.heroTaskInfoList_[slot8][slot7.id].isCompleted = true
		end
	end

	for slot6, slot7 in pairs(slot2) do
		slot0:RefreshHeroTaskRedPoint(slot6)
	end
end

function slot0.GetSortHeroTaskList(slot0, slot1, slot2)
	slot4 = {}
	slot5 = {}
	slot6 = {}
	slot7 = {}

	for slot11, slot12 in pairs(CultivateHeroTaskCfg.get_id_list_by_group_id[slot1]) do
		if slot0.heroTaskInfoList_[slot2][slot12].isReceived == true then
			table.insert(slot7, slot12)
		elseif slot0.heroTaskInfoList_[slot2][slot12].isCompleted == true then
			table.insert(slot5, slot12)
		else
			table.insert(slot6, slot12)
		end
	end

	slot8 = handler(slot0, slot0.Compare)

	table.sort(slot5, slot8)
	table.sort(slot6, slot8)
	table.sort(slot7, slot8)
	table.insertto(slot4, slot5)
	table.insertto(slot4, slot6)
	table.insertto(slot4, slot7)

	return slot4, #slot5 > 0
end

function slot0.Compare(slot0, slot1, slot2)
	return CultivateHeroTaskCfg[slot1].id < CultivateHeroTaskCfg[slot2].id
end

function slot0.GetDailyTaskStatus(slot0)
	return slot0.dailyTaskStatus_
end

function slot0.GetCompletedTaskList(slot0)
	return slot0.completedTaskList_ or {}
end

function slot0.GetReceivedTaskList(slot0)
	return slot0.receivedTaskList_ or {}
end

function slot0.GetHeroTaskInfoList(slot0, slot1)
	if slot1 ~= nil then
		return slot0.heroTaskInfoList_[slot1] or {}
	end

	return slot0.heroTaskInfoList_
end

function slot0.GetAccumulateTaskInfoList(slot0, slot1)
	if slot1 ~= nil then
		return slot0.accumulateTaskInfoList_[slot1] or {}
	end

	return slot0.accumulateTaskInfoList_
end

function slot0.SetReceivedHeroTaskList(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		slot0.heroTaskInfoList_[slot2][slot7].isReceived = true
	end

	slot0:RefreshAccumulateRedPoint(slot2)
	slot0:RefreshHeroTaskRedPoint(slot2)
end

function slot0.SetReceivedAccumulateTask(slot0, slot1, slot2)
	slot0.accumulateTaskInfoList_[slot2][slot1] = slot0.accumulateTaskInfoList_[slot2][slot1] or {}
	slot0.accumulateTaskInfoList_[slot2][slot1].isReceived = true

	slot0:RefreshAccumulateRedPoint(slot2)
end

function slot0.SetReceivedDailyTask(slot0, slot1)
	slot0.dailyTaskStatus_[slot1] = true

	slot0:RefreshDailyRedPoint(slot1)
end

function slot0.GetSelectHeroID(slot0, slot1)
	return getData(string.format("CultivateHero_%d", slot1), "selectHeroID")
end

function slot0.SetSelectHeroID(slot0, slot1, slot2)
	saveData(string.format("CultivateHero_%d", slot1), "selectHeroID", slot2)
	manager.redPoint:setTip(string.format("%s_%s_Select", RedPointConst.CULTIVATE_HERO, slot1), 0)
end

function slot0.RefreshSelectRedPoint(slot0, slot1)
	manager.redPoint:setTip(string.format("%s_%s_Select", RedPointConst.CULTIVATE_HERO, slot1), slot0:GetSelectHeroID(slot1) == nil and 1 or 0)
end

function slot0.RefreshDailyRedPoint(slot0, slot1)
	if slot0:IsAllReceived(slot1) == true then
		return
	end

	slot4 = CultivateHeroData:GetDailyTaskStatus()[slot1]
	slot5 = 0

	if 100 <= ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT) and slot4 ~= true then
		slot5 = 1
	end

	manager.redPoint:setTip(string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, slot1), slot5)
end

function slot0.RefreshAccumulateRedPoint(slot0, slot1)
	if slot0:IsAllReceived(slot1) == true then
		return
	end

	slot2 = ItemTools.getItemNum(ActivityCultivateHeroCfg[slot1].coin_id)
	slot4 = 0

	for slot8, slot9 in ipairs(ActivityCultivateHeroCfg[slot1].task_list) do
		slot11 = slot0.accumulateTaskInfoList_[slot1][slot9] and slot0.accumulateTaskInfoList_[slot1][slot9].isReceived

		if ActivityPointRewardCfg[slot9].need <= slot2 and slot11 ~= true then
			slot4 = 1

			break
		end
	end

	manager.redPoint:setTip(string.format("%s_%s_Accumulate_Reward", RedPointConst.CULTIVATE_HERO, slot1), slot4)
end

function slot0.RefreshHeroTaskRedPoint(slot0, slot1)
	if slot0:IsAllReceived(slot1) == true then
		return
	end

	for slot6, slot7 in ipairs(ActivityCultivateHeroCfg[slot1].group) do
		slot9 = 0

		for slot13, slot14 in ipairs(CultivateHeroTaskCfg.get_id_list_by_group_id[slot7]) do
			slot16 = slot0.heroTaskInfoList_[slot1][slot14].isReceived

			if slot0.heroTaskInfoList_[slot1][slot14].isCompleted == true and not slot16 then
				slot9 = 1

				break
			end
		end

		manager.redPoint:setTip(string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, slot1, slot7), slot9)
	end
end

function slot0.IsAllReceived(slot0, slot1)
	if slot0.accumulateTaskAllReceivedList_[slot1] == true or slot0.accumulateTaskInfoList_[slot1] == nil then
		return true
	end

	slot3 = true

	for slot7, slot8 in ipairs(ActivityCultivateHeroCfg[slot1].task_list) do
		if not (slot0.accumulateTaskInfoList_[slot1][slot8] and slot0.accumulateTaskInfoList_[slot1][slot8].isReceived) then
			slot3 = false

			break
		end
	end

	slot0.accumulateTaskAllReceivedList_[slot1] = slot3

	if slot3 == true then
		manager.redPoint:setTip(string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, slot1), 0)

		slot9 = "%s_%s_Accumulate_Reward"
		slot8 = 0

		manager.redPoint:setTip(string.format(slot9, RedPointConst.CULTIVATE_HERO, slot1), slot8)

		for slot8, slot9 in ipairs(ActivityCultivateHeroCfg[slot1].group) do
			manager.redPoint:setTip(string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, slot1, slot9), 0)
		end
	end

	return slot3
end

return slot0
