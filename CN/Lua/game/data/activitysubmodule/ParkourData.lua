slot0 = singletonClass("ParkourData")
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = {}
end

function slot0.InitParkourCollectData(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.item_list) do
		table.insert(slot2, slot7)
	end

	uv0[slot1.activity_id] = slot2
end

function slot0.InitParkourData(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.achieve_star) do
		table.insert(slot2, slot7)
	end

	slot3 = {}

	for slot7, slot8 in ipairs(slot1.achieve_star_reward) do
		table.insert(slot3, slot8)
	end

	uv0[slot1.activity_id] = {
		stars = slot2,
		rewards = slot3
	}
end

function slot0.GetParkourEntrustData(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetParkCollect(slot0, slot1)
	return uv0[slot1] or {}
end

function slot0.SetParkourEntrustReward(slot0, slot1, slot2)
	if uv0[slot1] then
		table.insert(slot3.rewards, slot2)
	end
end

function slot0.GetParkourStarState(slot0, slot1, slot2)
	if uv0[slot1] then
		return not not table.indexof(uv0[slot1].stars, slot2)
	end

	return false
end

function slot0.GetParkourCollectList(slot0)
	return uv0
end

function slot0.GetStarCount(slot0, slot1)
	if uv0[slot1] then
		if table.indexof(slot2.stars, 4) then
			return #slot2.stars - 1
		else
			return #slot2.stars
		end
	end

	return 0
end

function slot0.GetAllStarCount(slot0, slot1)
	if uv0[slot1] then
		return #slot2.stars
	end

	return 0
end

function slot0.SetRead(slot0, slot1)
	table.insert(uv0, slot1)
end

function slot0.GetRead(slot0, slot1)
	return table.indexof(uv0, slot1)
end

function slot0.GetCollectRedList(slot0, slot1)
	if not uv0[slot1] then
		uv0[slot1] = getData("Parkour", tostring(slot1))
	end

	if type(uv0[slot1]) ~= "table" then
		uv0[slot1] = {}
	end

	return uv0[slot1]
end

function slot0.SetParkourCollectRedPoint(slot0, slot1, slot2)
	if table.indexof(slot0:GetCollectRedList(slot1), slot2) then
		table.remove(slot3, slot4)
		saveData("Parkour", tostring(slot1), slot3)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_COLLECT, slot1), #slot3 > 0 and 1 or 0)
	end
end

return slot0
