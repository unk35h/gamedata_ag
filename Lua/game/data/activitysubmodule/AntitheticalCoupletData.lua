slot0 = singletonClass("AntitheticalCoupletData")
slot1 = {}
slot2 = {}

function slot0.Init(slot0)
	slot1 = {}
	slot2 = {}
end

function slot0.InitData(slot0, slot1)
	if not uv0[slot1.activity_id] then
		uv0[slot2] = {
			id = slot2,
			isOpen = slot1.select_id ~= 0
		}
	end

	uv0[slot2].chooseID = slot1.select_id
	uv0[slot2].isReward = slot1.is_already_receive
end

function slot0.GetData(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetReward(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].isReward = true
	end
end

function slot0.SetChooseID(slot0, slot1, slot2)
	if uv0[slot1] then
		uv0[slot1].chooseID = slot2
	end
end

function slot0.SetOpen(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].isOpen = true

		manager.redPoint:setTip(RedPointConst.ANTITHETICAL_COUPLET_OPEN .. "_" .. slot1, 0)
	end
end

function slot0.GetLastLevel(slot0, slot1)
	return uv0[slot1]
end

function slot0.SaveLastSelect(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

return slot0
