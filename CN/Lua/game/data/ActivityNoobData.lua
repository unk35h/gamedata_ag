slot0 = singletonClass("ActivityNoobData")

function slot0.Init(slot0)
	slot0.openCurVersion_ = false
	slot0.completedTime_ = 0
	slot0.signDay_ = 0
	slot0.signTimestamp_ = 0
	slot0.upgradeFinishList_ = {}
	slot0.rechargeStatus_ = {}
	slot0.firstRechargeRewardStatus_ = {}
	slot0.firstMonthlyCardStatus_ = {}
	slot0.bpRewardStatus_ = 0
	slot0.unlockPhase_ = 0
	slot0.noobAccumulateReceivedList_ = {}
end

function slot0.InitData(slot0, slot1)
	slot0.openCurVersion_ = true
	slot0.completedTime_ = slot1.completed_time

	if slot1.newbie_recharge_reward then
		slot0:InitRechargeData(slot1.newbie_recharge_reward)
	end

	if slot0:IsFinishAllActivity() == true then
		return
	end

	if slot1.newbie_sign then
		slot0:InitSignData(slot1.newbie_sign)
	end

	if slot1.newbie_level_reward then
		slot0:InitUpgradeData(slot1.newbie_level_reward)
	end

	if slot1.trigger_time then
		slot0.trigger_time = slot1.trigger_time
	end

	slot0.unlockPhase_ = slot1.max_phase
	slot0.noobAccumulateReceivedList_ = {}

	for slot5, slot6 in ipairs(slot1.got_pt_id_list) do
		slot0.noobAccumulateReceivedList_[slot6] = true
	end
end

function slot0.IsOpenCurVersion(slot0)
	return slot0.openCurVersion_
end

function slot0.IsFinishAllActivity(slot0)
	if slot0.completedTime_ == 0 then
		return false
	else
		return slot0.completedTime_ <= manager.time:GetServerTime()
	end
end

function slot0.IsFinishClientJudge(slot0)
	if slot0.trigger_time then
		return slot0.trigger_time + manager.time:GetHourInType(GameSetting.newbie_time_limit.value[1] * 24, 2) - manager.time:GetServerTime() > 0
	end

	return false
end

function slot0.GetUnlockPhase(slot0)
	return slot0.unlockPhase_
end

function slot0.GetAccumulateReceivedList(slot0)
	return slot0.noobAccumulateReceivedList_
end

function slot0.SetAccumulateReceivedList(slot0, slot1)
	slot0.noobAccumulateReceivedList_[slot1] = true
end

function slot0.CacheSelectedPhase(slot0, slot1)
	slot0.cachePhase_ = slot1
end

function slot0.GetSelectedPhase(slot0)
	return slot0.cachePhase_
end

function slot0.InitSignData(slot0, slot1)
	slot0.signDay_ = slot1.now_sign_times
	slot0.signTimestamp_ = slot1.last_sign_timestamp
	slot2 = #GameSetting.newbie_sign_14.value

	if slot0.signTimestamp_ < manager.time:GetTodayFreshTime() and slot0.signDay_ < slot2 then
		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.NEWBIE_SIGN, math.ceil((slot0.signDay_ + 1) / 7)), 1)
	end
end

function slot0.GetSignDay(slot0)
	return slot0.signDay_
end

function slot0.GetSignTimestamp(slot0)
	return slot0.signTimestamp_
end

function slot0.SignIn(slot0)
	slot0.signDay_ = slot0.signDay_ + 1
	slot0.signTimestamp_ = manager.time:GetServerTime()

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.NEWBIE_SIGN, math.ceil(slot0.signDay_ / 7)), 0)
end

function slot0.InitUpgradeData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.received_level_list) do
		table.insert(slot0.upgradeFinishList_, slot6)
	end
end

function slot0.GetUpgradeFinishList(slot0)
	return slot0.upgradeFinishList_
end

function slot0.SetUpgradeFinish(slot0, slot1)
	table.insert(slot0.upgradeFinishList_, slot1)
end

function slot0.InitRechargeData(slot0, slot1)
	slot0:UpdateRecharge(slot1)
end

function slot0.UpdateRecharge(slot0, slot1)
	slot2 = slot1.first_recharge_reward
	slot0.firstRechargeRewardStatus_ = {
		firstGearStatus = slot2.first_gear_recharge_reward,
		secondGearStatus = slot2.second_gear_recharge_flag,
		signTimes = slot2.now_sign_times,
		lastSignTimestamp = slot2.last_sign_timestamp
	}
	slot3 = slot1.first_monthly_card_reward
	slot0.firstMonthlyCardStatus_ = {
		isRecharged = slot3.flag,
		heroRewardFlag = slot3.role_reward_flag,
		signTimes = slot3.sign_times,
		signRewardFlag = slot3.sign_reward_flag
	}
	slot0.bpRewardStatus_ = slot1.first_battlepass_reward
end

function slot0.GetFirstRechargeStatus(slot0)
	return slot0.firstRechargeRewardStatus_
end

function slot0.ReceiveFirstRecharge(slot0, slot1)
	if slot1 == 0 then
		slot0.firstRechargeRewardStatus_.firstGearStatus = 2
	else
		slot0.firstRechargeRewardStatus_.signTimes = slot0.firstRechargeRewardStatus_.signTimes + 1
		slot0.firstRechargeRewardStatus_.lastSignTimestamp = manager.time:GetServerTime()
	end
end

function slot0.GetFirstMonthlyCardStatus(slot0)
	return slot0.firstMonthlyCardStatus_
end

function slot0.ReceiveMonthlyCard(slot0, slot1)
	if slot1 == 0 then
		slot0.firstMonthlyCardStatus_.heroRewardFlag = true
	else
		slot0.firstMonthlyCardStatus_.signRewardFlag = true
	end
end

function slot0.SetMonthlyCardSign(slot0)
	slot0.firstMonthlyCardStatus_.signTimes = slot0.firstMonthlyCardStatus_.signTimes + 1
end

function slot0.GetBpRewardStatus(slot0)
	return slot0.bpRewardStatus_
end

function slot0.SetBpRewardStatus(slot0)
	slot0.bpRewardStatus_ = 2
end

function slot0.GetRechargeStatus(slot0)
	return slot0.rechargeStatus_
end

function slot0.GetNewbieOpenTime(slot0)
	return slot0.trigger_time
end

function slot0.SetNewbieOpenTime(slot0, slot1)
	slot0.trigger_time = slot1
end

return slot0
