slot0 = singletonClass("CowboyData")
slot1 = {}
slot2 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.InitData(slot0, slot1)
	if not uv0[slot1.activity_id] then
		uv0[slot2] = {
			activityID = slot1.activity_id,
			open = slot1.activity_point > -10000
		}
	end

	uv0[slot2].score = slot1.activity_point or -10000
	uv0[slot2].reward = cleanProtoTable(slot1.reward_info, {
		"point_id",
		"point_reward_state"
	})
end

function slot0.SetLastLevel(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.GetLastLevel(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetOpen(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].open = true
	end
end

function slot0.GetOpen(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].open
	end

	return false
end

function slot0.SetReward(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(uv0[slot1].reward) do
		if slot7.point_id == slot2 then
			slot7.point_reward_state = 2

			break
		end
	end
end

function slot0.SetScore(slot0, slot1, slot2)
	uv0[slot1].score = slot2
end

function slot0.GetList(slot0, slot1)
	slot2 = {}

	for slot8, slot9 in ipairs(ActivityData:GetActivityData(slot1).subActivityIdList) do
		if uv0[slot9] then
			table.insert(slot2, slot9)
		end
	end

	return slot2
end

function slot0.GetData(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetHistoryScore(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].score
	end

	return 0
end

function slot0.GetRewardCount(slot0, slot1)
	slot2 = 0
	slot3 = 0

	for slot9, slot10 in ipairs(ActivityData:GetActivityData(slot1).subActivityIdList) do
		if uv0[slot10] then
			slot3 = slot3 + 1

			for slot14, slot15 in ipairs(uv0[slot10].reward) do
				if slot15.point_reward_state == 2 then
					slot2 = slot2 + 1
				end
			end
		end
	end

	return slot2, slot3 * 3
end

function slot0.IsRewardRedPointShow(slot0, slot1)
	if uv0[slot1] then
		slot2 = uv0[slot1].score

		for slot6, slot7 in ipairs(uv0[slot1].reward) do
			if ActivityPointRewardCfg[slot7.point_id].need < slot2 and slot7.point_reward_state == 1 then
				return true
			end
		end
	end

	return false
end

return slot0
