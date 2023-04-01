slot0 = singletonClass("SlayerData")
slot1 = {}
slot2 = {}
slot3 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
end

function slot0.InitSlayerData(slot0, slot1)
	slot2 = slot1.slayer
	slot3 = slot2.activity_id
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(slot2.got_reward_id_list) do
		table.insert(slot4, slot10)
	end

	for slot9, slot10 in ipairs(slot2.sub_activity_list) do
		slot5[slot10.activity_id] = slot10.point
	end

	uv0[slot3] = clone(uv1[slot3])
	uv1[slot3] = {
		got_reward_id_list = slot4,
		slayer_point_list = slot5
	}
end

function slot0.GetPoint(slot0, slot1, slot2)
	if uv0[slot1] then
		return slot3.slayer_point_list[slot2] or 0
	end

	return 0
end

function slot0.GetRewardCount(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].got_reward_id_list and #slot3 or 0
	end

	return 0
end

function slot0.GetReceivedReward(slot0, slot1, slot2)
	if uv0[slot1] then
		return not not table.indexof(slot3.got_reward_id_list, slot2)
	end

	return false
end

function slot0.SetReceivedReward(slot0, slot1, slot2)
	if uv0[slot1] then
		table.insert(slot3.got_reward_id_list, slot2)
	end
end

function slot0.GetOldGetPoint(slot0, slot1, slot2)
	if uv0[slot1] then
		return slot3.slayer_point_list[slot2] or 0
	end

	return 0
end

function slot0.GetSlayerList(slot0)
	return uv0
end

function slot0.SetRead(slot0, slot1)
	table.insert(uv0, slot1)
end

function slot0.GetRead(slot0, slot1)
	return table.indexof(uv0, slot1)
end

function slot0.GetSelectIndex(slot0, slot1)
	return getData(string.format("Slayer_%d", slot1), "selectIndex")
end

function slot0.SetSelectIndex(slot0, slot1, slot2)
	saveData(string.format("Slayer_%d", slot1), "selectIndex", slot2)
end

return slot0
