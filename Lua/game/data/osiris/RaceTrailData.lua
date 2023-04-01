slot0 = singletonClass("RaceTrailData")

function slot0.Init(slot0)
	slot0.totalScore_ = 0
	slot0.battleData_ = {
		get_id_list = {}
	}
	slot0.scoreRewardData_ = {}
	slot0.battleState_ = {
		complete = 2,
		received = 3,
		incomplete = 1
	}
end

function slot0.InitData(slot0, slot1)
	slot2 = slot1.activity_id

	slot0:ModifyScoreRewardData(slot1.got_reward_list or {})

	for slot7, slot8 in ipairs(ActivityData:GetActivityData(slot2).subActivityIdList) do
		slot0:RefreshRedPoint(slot8)
	end
end

function slot0.InitBattleData(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityData:GetActivityData(slot1).subActivityIdList) do
		slot0.battleData_[slot7] = {
			point = 0,
			state = 1,
			id = slot7,
			customList = {}
		}
	end

	slot0.battleData_.get_id_list = {}
end

function slot0.InitScoreRewardData(slot0, slot1)
	if ActivityPointRewardCfg.get_id_list_by_activity_id[slot1] ~= nil then
		for slot6, slot7 in ipairs(slot2) do
			slot0.scoreRewardData_[slot7] = {
				id = slot7,
				receive_flag = false
			}
		end
	end
end

function slot0.ModifyScoreRewardData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0.scoreRewardData_[slot6].receive_flag = true
	end
end

function slot0.RefreshBattleData(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(slot1.challenge.custom_affix_list) do
		slot3[slot7] = slot8
	end

	slot0.battleData_[slot2.activity_id] = {
		id = slot2.activity_id,
		state = slot2.first_clear_reward_apply_state,
		customList = slot3,
		point = slot2.point
	}

	slot0:RefreshRedPoint(slot2.activity_id)
end

function slot0.GetTotalScore(slot0, slot1)
	slot0.totalScore_ = 0

	for slot6, slot7 in ipairs(ActivityData:GetActivityData(slot1).subActivityIdList) do
		slot0.totalScore_ = slot0.totalScore_ + (slot0.battleData_[slot7] and slot8.point or 0)
	end

	return slot0.totalScore_
end

function slot0.GetCurLv(slot0, slot1)
	slot2 = nil

	for slot7, slot8 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot1]) do
		if not slot0.scoreRewardData_[slot8].receive_flag then
			return slot2.id
		end
	end

	return slot3[#slot3]
end

function slot0.GetFirstRewardSortList(slot0, slot1)
	slot2 = nil
	slot3 = {}
	slot4 = {}
	slot5 = {}
	slot6 = {}

	for slot11, slot12 in ipairs(ActivityData:GetActivityData(slot1).subActivityIdList) do
		if slot0.battleData_[slot12].state == slot0.battleState_.incomplete then
			table.insert(slot5, slot12)
		elseif slot2.state == slot0.battleState_.complete then
			table.insert(slot4, slot12)
		elseif slot2.state == slot0.battleState_.received then
			table.insert(slot6, slot12)
		end
	end

	table.insertto(slot3, slot4)
	table.insertto(slot3, slot5)
	table.insertto(slot3, slot6)

	return slot3
end

function slot0.GetBattleData(slot0, slot1)
	return slot0.battleData_[slot1]
end

function slot0.GetScoreRewardSortList(slot0, slot1)
	slot2, slot3 = nil
	slot4 = {}
	slot5 = {}
	slot6 = {}
	slot7 = {}

	for slot12, slot13 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot1]) do
		slot3 = ActivityPointRewardCfg[slot13].need

		if slot0.scoreRewardData_[slot13].receive_flag then
			table.insert(slot7, slot2.id)
		elseif slot3 <= slot0.totalScore_ then
			table.insert(slot5, slot2.id)
		else
			table.insert(slot6, slot2.id)
		end
	end

	table.insertto(slot4, slot5)
	table.insertto(slot4, slot6)
	table.insertto(slot4, slot7)

	return slot4
end

function slot0.GetScoreRewardByID(slot0, slot1)
	return slot0.scoreRewardData_[slot1]
end

function slot0.GetRaceTrailStartTime(slot0, slot1)
	return ActivityData:GetActivityData(slot1).startTime
end

function slot0.GetRaceTrailEndTime(slot0, slot1)
	return ActivityData:GetActivityData(slot1).stopTime
end

function slot0.GetCustomList(slot0, slot1)
	return slot0.battleData_[slot1].customList
end

function slot0.GetCustomListByStageID(slot0, slot1)
	slot2 = nil

	for slot7, slot8 in ipairs(ActivityRaceTrialCfg.all) do
		if slot1 == ActivityRaceTrialCfg[slot8].stage_id then
			return slot0.battleData_[slot2.id].customList
		end
	end

	print("匹配出错")

	return {}
end

function slot0.ReceiveScoreReward(slot0, slot1)
	slot0.scoreRewardData_[slot1].receive_flag = true

	for slot7, slot8 in ipairs(ActivityData:GetActivityData(ActivityPointRewardCfg[slot1].activity_id).subActivityIdList) do
		slot0:RefreshScoreRedPoint(slot8)
	end
end

function slot0.ReceiveFirstReward(slot0, slot1)
	slot0.battleData_[slot1].state = slot0.battleState_.received

	slot0:RefreshFirstRedPoint(slot1)
end

function slot0.SaveCustomList(slot0, slot1, slot2)
	slot0.battleData_[slot1].customList = slot2 or {}
end

function slot0.RefreshRedPoint(slot0, slot1)
	slot0:RefreshBattleRedPoint(slot1)
	slot0:RefreshScoreRedPoint(slot1)
	slot0:RefreshFirstRedPoint(slot1)
end

function slot0.RefreshBattleRedPoint(slot0, slot1)
	slot4 = 1

	manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, ActivityRaceTrialCfg[slot1].main_activity_id, slot1), ActivityData:GetActivityIsOpen(slot1) and slot0.battleData_[slot1].point <= 0 and 1 or 0)
end

function slot0.RefreshScoreRedPoint(slot0, slot1)
	slot2 = false
	slot3, slot4 = nil
	slot5 = ActivityRaceTrialCfg[slot1].main_activity_id
	slot6 = slot0:GetTotalScore(slot5)

	for slot11, slot12 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot5]) do
		slot4 = slot0.scoreRewardData_[slot12]

		if ActivityPointRewardCfg[slot12].need <= slot6 and slot4.receive_flag == false then
			slot2 = true

			break
		end
	end

	manager.redPoint:setTip(string.format("%s_%s_PointReward", RedPointConst.ACTIVITY_RACE_TRIAL, slot5), slot2 and 1 or 0)
end

function slot0.RefreshFirstRedPoint(slot0, slot1)
	slot2 = false
	slot3 = ActivityRaceTrialCfg[slot1].main_activity_id

	if slot0.battleData_[slot1].state == slot0.battleState_.complete then
		slot2 = true
	end

	manager.redPoint:setTip(string.format("%s_%s_%d_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, slot3, slot1), slot2 and 1 or 0)
end

function slot0.SetBattleRedPointOn(slot0, slot1, slot2)
	manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, ActivityRaceTrialCfg[slot2].main_activity_id, slot2), 0)
end

function slot0.GetBattleResultGoal(slot0, slot1)
	slot2 = slot0.battleData_[slot1].customList or {}
	slot3 = ActivityRaceTrialCfg[slot1].base_point
	slot4 = nil

	for slot8, slot9 in ipairs(slot2) do
		slot3 = slot3 + ActivityAffixPoolCfg[slot9].point
	end

	return slot3
end

return slot0
