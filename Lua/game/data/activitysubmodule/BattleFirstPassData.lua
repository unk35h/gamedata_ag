slot0 = singletonClass("BattleFirstPassData")
slot1 = {}
slot2 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
end

function slot0.SetData(slot0, slot1)
	if not uv0[slot1.activity_id] then
		uv0[slot1.activity_id] = {
			isNeedRedPoint = true,
			activityID = slot1.activity_id
		}
	end

	slot2 = {}
	uv0[slot1.activity_id].battleList = {}

	for slot6, slot7 in ipairs(slot1.sub_shot_list) do
		slot2[slot7.activity_id] = {
			battleID = slot7.activity_id,
			battleState = slot7.first_clear_reward_apply_state
		}

		table.insert(uv0[slot1.activity_id].battleList, slot7.activity_id)
	end

	uv0[slot1.activity_id].battleInfo = slot2
end

function slot0.SetBattleState(slot0, slot1, slot2)
	uv0[slot1].battleInfo[slot2].battleState = ActivityConst.BATTLE_FIRST_PASS_STATE.REWARDED
end

function slot0.SetIsNeedRedPoint(slot0, slot1, slot2)
	uv0[slot1].isNeedRedPoint = slot2
end

function slot0.SetLastBattleID(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.GetBattleFirstPassActivityData(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetBattleList(slot0, slot1)
	return uv0[slot1].battleList
end

function slot0.GetBattleData(slot0, slot1, slot2)
	return uv0[slot1].battleInfo[slot2]
end

function slot0.GetLastBattleID(slot0, slot1)
	return uv0[slot1]
end

return slot0
