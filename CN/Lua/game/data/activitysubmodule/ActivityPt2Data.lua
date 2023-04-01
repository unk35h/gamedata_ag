slot0 = singletonClass("ActivityPt2Data")
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = {}
slot5 = 0

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = {}
end

function slot0.SetNormalData(slot0, slot1)
	if not uv0[slot1.activity_id] then
		uv0[slot2] = {}
	end

	for slot6, slot7 in ipairs(slot1.pt_challenge_info) do
		uv0[slot2][slot7.id] = {
			id = slot7.id,
			clear_time = slot7.clear_time
		}
	end
end

function slot0.SetChallengeData(slot0, slot1)
	if not uv0[slot1.activity_id] then
		uv0[slot2] = {}
	end

	for slot6, slot7 in ipairs(slot1.pt_challenge_info) do
		uv0[slot2][slot7.id] = {
			id = slot7.id,
			clear_time = slot7.clear_time,
			use_time = slot7.use_time
		}
	end
end

function slot0.SetHardData(slot0, slot1)
	if not uv0[slot1.activity_id] then
		uv0[slot2] = {}
	end

	for slot6, slot7 in ipairs(slot1.pt_challenge_info) do
		uv0[slot2] = {
			id = slot7.id,
			clear_time = slot7.clear_time,
			score = slot7.score
		}
	end
end

function slot0.SetHardScore(slot0, slot1)
	uv0 = slot1.score
end

function slot0.GetHardScore(slot0)
	return uv0
end

function slot0.SetLastStage(slot0, slot1, slot2, slot3)
	uv0[slot1] = {
		type = slot2,
		index = slot3
	}
end

function slot0.GetLastStage(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetExScore(slot0, slot1)
	return uv0[slot1] and uv0[slot1].score or 0
end

function slot0.GetNormalData(slot0, slot1, slot2)
	return uv0[slot1] and uv0[slot1][slot2]
end

function slot0.GetChallengeData(slot0, slot1, slot2)
	return uv0[slot1] and uv0[slot1][slot2]
end

function slot0.GetNormalDataList(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetChallengeDataList(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetHardData(slot0, slot1)
	return uv0[slot1]
end

return slot0
