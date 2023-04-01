slot0 = class("EventListener")

function slot0.Ctor(slot0)
	slot0.listeners = {}
end

function slot0.Register(slot0, slot1, slot2)
	if slot0.listeners[slot1] then
		manager.notify:RemoveListener(slot1, slot0.listeners[slot1])
	end

	slot0.listeners[slot1] = slot2

	manager.notify:RegistListener(slot1, slot2)
end

function slot0.RemoveAll(slot0)
	for slot4, slot5 in pairs(slot0.listeners) do
		manager.notify:RemoveListener(slot4, slot5)

		slot0.listeners[slot4] = nil
	end
end

return slot0
