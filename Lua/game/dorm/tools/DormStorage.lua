slot0 = singletonClass("DormStorage")

function slot0.Ctor(slot0)
end

function slot0.Reset(slot0)
	slot0.storage = {}
end

function slot0.ClearData(slot0, slot1)
	slot0.storage[slot1] = nil
end

function slot0.RecordData(slot0, slot1, slot2, slot3)
	slot4 = slot0.storage[slot1] or {}
	slot4[slot2] = slot3
	slot0.storage[slot1] = slot4
end

function slot0.PickData(slot0, slot1)
	if slot0.storage[slot1] then
		slot3, slot4 = next(slot2)

		return slot4
	end
end

function slot1(slot0)
	return slot0[math.random(1, #slot0)]
end

function slot0.RndPickData(slot0, slot1, slot2)
	if slot0.storage[slot1] then
		slot4 = nil

		if slot2 then
			return uv0(slot3)
		else
			slot4 = {}

			for slot8, slot9 in pairs(slot3) do
				table.insert(slot4, slot8)
			end

			return slot3[uv0(slot4)]
		end
	end
end

function slot0.PushBackData(slot0, slot1, slot2)
	slot3 = slot0.storage[slot1] or {}

	table.insert(slot3, slot2)

	slot0.storage[slot1] = slot3
end

function slot0.PopFrontData(slot0, slot1)
	if slot0.storage[slot1] then
		table.remove(slot2, 1)

		slot0.storage[slot1] = slot2

		return slot2[1]
	end
end

function slot0.ForeachData(slot0, slot1, slot2)
	if slot0.storage[slot1] then
		return slot2(slot3)
	else
		return function ()
		end, nil, 
	end
end

function slot0.MapToData(slot0, slot1, slot2)
	slot0.storage[slot1] = slot2

	return slot0.storage[slot1]
end

function slot0.GetData(slot0, slot1, slot2, slot3)
	if slot3 then
		slot4 = slot0.storage[slot1] or {}
		slot0.storage[slot1] = slot4
		slot4[slot2] = slot4[slot2] or slot3

		return slot4[slot2]
	end

	return nullable(slot0.storage, slot1, slot2)
end

return slot0
