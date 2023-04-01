slot1 = manager.net

slot1:Bind(11023, function (slot0)
	RaceTrailData:InitData(slot0.race_trial)
end)

slot1 = manager.net

slot1:Bind(11019, function (slot0)
	RaceTrailData:RefreshBattleData(slot0)
end)

return {
	ReceiveScoreReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(60054, {
			point_reward_id_list = {
				slot1
			}
		}, 60055, handler(slot0, slot0.OnReceiveScoreReward))
	end,
	OnReceiveScoreReward = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			RaceTrailData:ReceiveScoreReward(slot2.point_reward_id_list[1])
			getReward(ActivityPointRewardCfg[slot2.point_reward_id_list[1]].reward_item_list)
			manager.notify:CallUpdateFunc(RACE_TRIAL_POINT_RECEIVE)
		else
			ShowTips(slot1.result)
		end
	end,
	ReceiveFirstReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(11020, {
			id = slot1
		}, 11021, handler(slot0, slot0.OnReceiveFirstReward))
	end,
	OnReceiveFirstReward = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			RaceTrailData:ReceiveFirstReward(slot2.id)
			getReward(ActivityRaceTrialCfg[slot2.id].reward_item_list)
			manager.notify:CallUpdateFunc(RACE_TRIAL_FIRST_RECEIVE)
		else
			ShowTips(slot1.result)
		end
	end,
	SaveCustomList = function (slot0, slot1, slot2)
		if not ActivityData:GetActivityIsOpen(slot1) then
			return
		end

		slot3 = RaceTrailData

		slot3:SaveCustomList(slot1, slot2)
		manager.net:SendWithLoadingNew(11038, {
			id = slot1,
			race_trial_affix_id_list = slot2
		}, 11039, handler(slot0, slot0.OnSaveCustomList))
	end,
	OnSaveCustomList = function (slot0, slot1, slot2)
		if not isSuccess(slot1.result) then
			ShowTips(slot1.result)
		end
	end,
	Init = function (slot0)
		for slot5, slot6 in ipairs(ActivityData:GetActivityData(slot0).subActivityIdList) do
			ActivityRaceTrialCfg[slot6].main_activity_id = slot0
		end

		RaceTrailData:InitBattleData(slot0)
		RaceTrailData:InitScoreRewardData(slot0)
	end,
	InitRedPointKey = function (slot0)
		slot3 = {}
		slot4 = {}

		for slot8, slot9 in pairs(ActivityData:GetActivityData(slot0).subActivityIdList) do
			slot3[#slot3 + 1] = string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, slot0, slot9)
			slot4[#slot4 + 1] = string.format("%s_%s_%d_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, slot0, slot9)
		end

		manager.redPoint:addGroup(string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, slot0), slot4)

		slot3[#slot3 + 1] = string.format("%s_%s_PointReward", RedPointConst.ACTIVITY_RACE_TRIAL, slot0)
		slot3[#slot3 + 1] = string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, slot0)

		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, slot0), slot3)
	end,
	UpdateRedPoint = function (slot0)
		if not ActivityData:GetActivityIsOpen(slot0) then
			if #ActivityCfg[slot0].sub_activity_list > 0 then
				slot2 = slot0

				for slot6, slot7 in ipairs(slot1) do
					manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, slot2, slot7), 0)
					manager.redPoint:setTip(string.format("%s_%s_%d_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, slot2, slot7), 0)
				end

				manager.redPoint:setTip(string.format("%s_%s_PointReward", RedPointConst.ACTIVITY_RACE_TRIAL, slot2), 0)
			else
				slot2 = ActivityRaceTrialCfg[slot0].main_activity_id

				manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, slot2, slot0), 0)
				manager.redPoint:setTip(string.format("%s_%s_%d_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, slot2, slot0), 0)
			end
		end
	end
}
