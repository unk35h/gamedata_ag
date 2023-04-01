slot0 = singletonClass("SurviveSoloData")
slot1 = {}
slot2 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
end

function slot0.InitData(slot0, slot1)
	if not uv0[slot1.activity_id] then
		uv0[slot2] = {
			time = 0,
			rewards = {},
			activityID = slot2
		}
	end

	uv0[slot2].time = slot1.survival_time
	uv0[slot2].rewards = slot1.got_reward_list or {}
end

function slot0.GetData(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetReward(slot0, slot1, slot2)
	if not table.indexof(uv0[slot1].rewards, slot2) then
		table.insert(uv0[slot1].rewards, slot2)
	end
end

function slot0.GetLastIndex(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetLastIndex(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

return slot0
