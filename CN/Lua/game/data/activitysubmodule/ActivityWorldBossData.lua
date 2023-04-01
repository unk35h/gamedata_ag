slot0 = singletonClass("ActivityWorldBossData")
slot1 = {}
slot2 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
end

function slot0.InitWorldBossData(slot0, slot1)
	slot2 = slot1.activity_id
	slot3 = slot1.affix
	slot4 = {
		slot3.id,
		slot3.level,
		slot3.object
	}
	slot5 = {}

	for slot9, slot10 in ipairs(slot1.got_total_damage_reward_list) do
		table.insert(slot5, slot10)
	end

	slot6 = {}

	for slot10, slot11 in ipairs(slot1.clear_index_list) do
		table.insert(slot6, slot11)
	end

	uv0[slot2] = {
		activity_id = slot2,
		left_health_point = slot1.left_health_point,
		affix = slot4,
		got_total_damage_reward_list = slot5,
		got_coin_num = slot1.got_coin_num,
		clear_index_list = slot6
	}
end

function slot0.InitWorldBossSocre(slot0, slot1)
	uv0[slot1.activity_id] = slot1.score
end

function slot0.GetHealthRewardState(slot0, slot1, slot2)
	if not uv0[slot1] then
		return 0
	end

	if table.indexof(slot3.got_total_damage_reward_list, slot2) then
		return 2
	end

	if slot3.left_health_point <= ActivityWorldBossCfg[slot1].health_reward_list[slot2][1] then
		return 1
	end

	return 0
end

function slot0.SetHealthRewarded(slot0, slot1, slot2)
	if not uv0[slot1] then
		return
	end

	table.insert(slot3.got_total_damage_reward_list, slot2)
end

function slot0.GetMaxCoinNum(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityCfg[slot1].sub_activity_list) do
		if ActivityData:GetActivityIsOpen(slot7) then
			return ActivityWorldBossPhaseCfg[slot7].coin_limit
		end
	end

	return 0
end

function slot0.GetCointCount(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].got_coin_num
	else
		return 0
	end
end

function slot0.UpdateCoinCount(slot0, slot1, slot2)
	if uv0[slot1] then
		uv0[slot1].got_coin_num = uv0[slot1].got_coin_num + slot2
	end
end

function slot0.GetLeftHealthPoint(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].left_health_point
	else
		return 0
	end
end

function slot0.GetAffix(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].affix
	else
		return nil
	end
end

function slot0.GetStageId(slot0, slot1)
	if not uv0[slot1] then
		return 0
	end

	slot4 = slot2.left_health_point
	slot5 = slot2.clear_index_list
	slot6, slot7 = nil

	for slot11, slot12 in ipairs(ActivityWorldBossCfg[slot1].health_stage) do
		if slot4 <= slot12[1] and (not slot6 or slot13 < slot6[1]) then
			slot6 = slot12
			slot7 = slot11
		end
	end

	slot8 = slot6[2]

	if slot7 == 1 then
		if not table.indexof(slot5, slot7) then
			return slot3.story_stage_id[1] or slot8
		else
			return slot8
		end
	else
		slot9 = table.indexof(slot5, 1)
		slot10 = table.indexof(slot5, 2)

		if table.indexof(slot5, 3) then
			return slot8
		elseif not slot9 and not slot10 then
			return slot3.story_stage_id[3] or slot8
		elseif not slot10 then
			return slot3.story_stage_id[2] or slot8
		else
			return slot8
		end
	end
end

function slot0.GetBossScore(slot0, slot1)
	return uv0[slot1] or 0
end

return slot0
