slot0 = class("Pool")

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0._parent = slot2
	slot0._template = slot1
	slot0._count = slot3
	slot0._pool = {}
	slot0._isUsing = {}
	slot0._queue = {}

	slot0:OnCtor()
end

function slot0.OnCtor(slot0)
	for slot4 = 1, slot0._count do
		slot5 = Object.Instantiate(slot0._template, slot0._parent.transform)
		slot5.transform.localScale = Vector3(1, 1, 1)
		slot0._pool[slot4] = slot5
		slot0._isUsing[slot4] = true
	end
end

function slot0.AddPool(slot0)
	slot0._count = slot0._count + 1
	slot1 = Object.Instantiate(slot0._template, slot0._parent.transform)
	slot1.transform.localScale = Vector3(1, 1, 1)
	slot0._pool[slot0._count] = slot1
	slot0._isUsing[slot0._count] = true
end

function slot0.GetCanUsingObj(slot0)
	for slot4 = 1, slot0._count do
		if slot0._isUsing[slot4] == true then
			slot0._isUsing[slot4] = false

			table.insert(slot0._queue, slot4)

			return slot0._pool[slot4], slot4
		end
	end

	slot0:AddPool()

	slot0._isUsing[slot0._count] = false

	table.insert(slot0._queue, slot0._count)

	return slot0._pool[slot0._count], slot0._count
end

function slot0.GetUseingIndexObj(slot0, slot1)
	return slot0._pool[slot1]
end

function slot0.FinishIndex(slot0, slot1)
	table.removebyvalue(slot0._queue, slot1)

	slot0._isUsing[slot1] = true
end

function slot0.GetQueueHead(slot0)
	return slot0._queue[1]
end

function slot0.AllUsed(slot0)
	for slot4, slot5 in ipairs(slot0._isUsing) do
		if slot5 then
			return false
		end
	end

	return true
end

function slot0.GetPool(slot0)
	return slot0._pool
end

function slot0.Dispose(slot0)
	if slot0._pool then
		for slot4, slot5 in ipairs(slot0._pool) do
			Object.Destroy(slot5)
		end

		slot0._pool = nil
	end

	slot0._isUsing = nil
	slot0._queue = nil
	slot0._template = nil
end

return slot0
