slot0 = singletonClass("NewDemonChallengeData")
slot1 = {}
slot2 = {}
slot3 = {}

function slot0.InitData(slot0)
	uv0 = {}
	uv1 = {}
end

function slot0.SetSubActivityData(slot0, slot1)
	slot2 = slot1.activity_id
	uv0[slot2] = {
		activityId = slot2
	}
	slot3 = {}

	for slot7, slot8 in ipairs(slot1.info) do
		slot3[slot8.difficulty] = {
			challenge_state = slot8.challenge_state,
			hurt_state = slot8.hurt_state
		}
	end

	uv0[slot2].challengeInfo = slot3
end

function slot0.SetMainActivityData(slot0, slot1)
	uv0[slot1.activity_id] = {}

	for slot6, slot7 in ipairs(slot1.complete_list) do
		uv0[slot2][slot7] = ActivityConst.DEMON_CHALLENGE_REWARD_STATE.RECEIVED
	end

	for slot7, slot8 in ipairs(NewDemonChallengeRewardCfg.get_id_list_by_activity_id[slot2]) do
		if uv0[slot2][slot8] == nil then
			uv0[slot2][slot8] = ActivityConst.DEMON_CHALLENGE_REWARD_STATE.UNRECEIVE
		end
	end
end

function slot0.GetRewardStateList(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetRewardState(slot0, slot1, slot2, slot3)
	uv0[slot1][slot2] = slot3
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

function slot0.GetCompletedDifficultyCountList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(ActivityData:GetActivityData(slot1).subActivityIdList) do
		if uv0[slot8] ~= nil then
			for slot13, slot14 in pairs(slot9.challengeInfo) do
				slot2[slot13] = slot2[slot13] or 0

				if slot14.challenge_state == ActivityConst.DEMON_CHALLENGE_STATE.FINISHED then
					slot2[slot13] = slot2[slot13] + 1
				end
			end
		end
	end

	return slot2
end

return slot0
