slot0 = singletonClass("SubDemonChallengeData")
slot1 = {}
slot2 = {}

function slot0.InitData(slot0)
	uv0 = {}
end

function slot0.SetData(slot0, slot1)
	slot2 = slot1.activity_id
	uv0[slot2] = {
		activityId = slot2
	}
	slot3 = {}

	for slot7, slot8 in ipairs(slot1.info) do
		slot3[slot8.difficulty] = {
			challenge_state = slot8.challenge_state,
			reward_state = slot8.reward_state,
			hurt_state = slot8.hurt_state
		}
	end

	uv0[slot2].challengeInfo = slot3
end

function slot0.SetRewardState(slot0, slot1, slot2, slot3)
	uv0[slot1].challengeInfo[table.indexof(DemonChallengeCfg.get_id_list_by_activity_id[slot1], slot2)].reward_state = slot3
end

function slot0.GetChallengeInfo(slot0, slot1)
	return uv0[slot1]
end

function slot0.AddSelectedActivityId(slot0, slot1)
	uv0[slot1] = true
end

function slot0.GetIsSelected(slot0, slot1)
	return uv0[slot1]
end

return slot0
