slot0 = class("Dispatcher")

function slot0.Emit(slot0, slot1, ...)
	slot2 = {
		...
	}

	if slot0.events[slot1] then
		slot3 = {}
		slot7 = slot0.events[slot1]

		table.merge(slot3, slot7)

		for slot7, slot8 in ipairs(slot3) do
			slot8(slot1, unpack(slot2))
		end
	end
end

function slot0.Bind(slot0, slot1, slot2)
	slot0.events = slot0.events or {}

	if not slot0.events[slot1] then
		slot0.events[slot1] = {}
	end

	if not table.indexof(slot3, slot2) then
		table.insert(slot3, slot2)
	end
end

function slot0.Unbind(slot0, slot1, slot2)
	if slot0.events[slot1] then
		if slot2 ~= nil then
			table.removebyvalue(slot0.events[slot1], slot2)
		else
			slot0.events[slot1] = {}
		end
	end
end

function slot0.Dispose(slot0)
	slot0.events = nil
end

return slot0
