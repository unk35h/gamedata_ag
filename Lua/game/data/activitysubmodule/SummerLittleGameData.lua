slot0 = singletonClass("SummerLittleGameData")
slot1 = {}
slot2 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
end

function slot0.InitLeviathanGameData(slot0, slot1)
	uv0[slot1.activity_id] = slot1.challenge_state
end

function slot0.GetLeviathanState(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetLeviathanGameReward(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.InitSkadiGameData(slot0, slot1)
	uv0[slot1.activity_id] = {
		star = cleanProtoTable(slot1.achieve_star),
		reward = cleanProtoTable(slot1.achieve_star_reward)
	}
end

function slot0.GetSkadiStars(slot0, slot1)
	if not uv0[slot1] then
		return {}
	end

	return uv0[slot1].star
end

function slot0.GetSkadiReward(slot0, slot1)
	if not uv0[slot1] then
		return {}
	end

	return uv0[slot1].reward
end

function slot0.SetSkadiGameReward(slot0, slot1, slot2)
	table.insert(uv0[slot1].reward, slot2)
end

function slot0.GetSkadiRewardNum(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(uv0) do
		slot1 = slot1 + #slot6.reward
	end

	return slot1
end

function slot0.IsSkadiRewardPointShow(slot0)
	for slot4, slot5 in pairs(uv0) do
		if #slot5.reward < #slot5.star then
			return true
		end
	end

	return false
end

function slot0.IsSkadiLevelPointShow(slot0)
	for slot4, slot5 in pairs(uv0) do
		slot7 = ActivityData:GetActivityData(slot4).stopTime

		if ActivityData:GetActivityData(slot4).startTime <= manager.time:GetServerTime() and slot8 <= slot7 and #slot5.star < 1 then
			return true
		end
	end

	return false
end

function slot0.IsLeviathanRewardPointShow(slot0)
	for slot4, slot5 in pairs(uv0) do
		if slot5 == 1 then
			return true
		end
	end

	return false
end

function slot0.IsLeviathanLevelPointShow(slot0)
	for slot4, slot5 in pairs(uv0) do
		slot7 = ActivityData:GetActivityData(slot4).stopTime

		if ActivityData:GetActivityData(slot4).startTime <= manager.time:GetServerTime() and slot8 <= slot7 and slot5 == 0 then
			return true
		end
	end

	return false
end

return slot0
