slot0 = singletonClass("ActivityAffixSelectData")
slot1 = nil
slot2 = {}

function slot0.Init(slot0)
	uv0 = {
		activityId = 1,
		got_reward_list = {},
		subActivityData = {}
	}
	uv1 = {}
end

function slot0.OnPushMainActivityData(slot0, slot1)
	uv0.activityId = slot1.activity_id

	for slot5, slot6 in ipairs(slot1.got_reward_list) do
		table.insert(uv0.got_reward_list, slot6)
	end

	manager.notify:Invoke(AFFIX_SELECT_MAIN_ACTIVITY_UPDATE, {})
end

function slot0.OnPushSubActivityData(slot0, slot1)
	slot2 = {
		activityId = slot1.activity_id,
		clearState = slot1.first_clear_reward_apply_state,
		affixList = {},
		point = slot1.point
	}

	for slot6, slot7 in ipairs(slot1.custom_affix_list) do
		table.insert(slot2.affixList, slot7)
	end

	uv0.subActivityData[slot1.activity_id] = slot2

	manager.notify:Invoke(AFFIX_SELECT_SUB_ACTIVITY_UPDATE, {})
end

function slot0.GetClearState(slot0, slot1)
	if not uv0[slot1] then
		error("找不到对应的活动，未开启")

		return 0
	end

	return slot2.clearState
end

function slot0.HaveGotScoreReward(slot0, slot1)
	if not table.indexof(uv0.got_reward_list, slot1) then
		return false
	end

	return true
end

function slot0.OnGetFirstBonus(slot0, slot1)
	if not uv0.subActivityData[slot1] then
		error("找不到对应的活动，未开启")
	end

	slot2.clearState = 3

	manager.notify:Invoke(AFFIX_SELECT_FIRST_BONUS_UPDATE, slot1)
end

function slot0.OnSetAffix(slot0, slot1, slot2)
	if not uv0.subActivityData[slot1] then
		error("找不到对应的活动，未开启")
	end

	slot3.affixList = slot2

	manager.notify:Invoke(AFFIX_SELECT_CUSTOM_AFFIX_UPDATE, slot1)
end

function slot0.GetSubActivityData(slot0, slot1)
	return uv0.subActivityData[slot1]
end

function slot0.GetOpenedSubActivityDatas(slot0)
	return uv0.subActivityData
end

function slot0.GetGodRewardList(slot0)
	return uv0.got_reward_list or {}
end

function slot0.GetCurrentActivityReward(slot0)
	for slot5, slot6 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_1_7_AFFIX_SELECT]) do
		if slot0:GetRewardStatus(slot6) == 1 or slot7 == 2 then
			return slot6
		end
	end

	return slot1[#slot1]
end

function slot0.ScoreRewardGetCount(slot0)
	return uv0.got_reward_list and #uv0.got_reward_list or 0
end

function slot0.GetTotalScore(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(uv0.subActivityData) do
		slot1 = slot1 + slot6.point
	end

	return slot1
end

function slot0.GetLevelScore(slot0, slot1)
	slot3 = ActivityAffixSelectCfg[slot1].base_point

	for slot8, slot9 in ipairs(uv0.subActivityData[slot1].affixList) do
		slot3 = slot3 + ActivityAffixPoolCfg[slot9].point
	end

	return slot3
end

function slot0.GetRewardStatus(slot0, slot1)
	slot2 = false

	if table.indexof(uv0.got_reward_list, slot1) then
		slot2 = true
	end

	if slot2 then
		return 0
	end

	if ActivityPointRewardCfg[slot1].need <= slot0:GetTotalScore() then
		return 2
	end

	return 1
end

function slot0.OnScoreRewardGet(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot8 = ActivityPointRewardCfg[slot6]

		if not table.indexof(uv0.got_reward_list, slot6) and slot8.activity_id == ActivityConst.ACTIVITY_1_7_AFFIX_SELECT then
			table.insert(uv0.got_reward_list, slot6)
		end
	end
end

function slot0.GetAffix(slot0, slot1)
	table.insert({}, ActivityAffixSelectCfg[slot1].boss_affix)

	if uv0.subActivityData[slot1] then
		for slot10, slot11 in ipairs(slot5.affixList) do
			table.insert(slot4, ActivityAffixPoolCfg[slot11].affix)
		end
	end

	return slot4
end

function slot0.ReadInnerRedPoint(slot0, slot1)
	uv0[slot1] = true
end

function slot0.HaveReadInnerPoint(slot0, slot1)
	return uv0[slot1] ~= nil
end

return slot0
