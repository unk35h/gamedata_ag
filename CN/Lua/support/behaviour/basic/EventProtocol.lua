slot1 = class("EventProtocol", import("..BehaviourBase"))

function slot1.Ctor(slot0)
	uv0.super.Ctor(slot0, "EventProtocol")

	slot0.listeners_ = {}
	slot0.nextListenerHandleIndex_ = 0
end

function slot1.AddEventListener(slot0, slot1, slot2, slot3)
	if slot0.listeners_[slot1] == nil then
		slot0.listeners_[slot1] = {}
	end

	slot4 = slot2
	slot0.listeners_[slot1][slot4] = {
		slot2,
		slot3
	}

	return slot4
end

function slot1.AddEventListenerShare(slot0, slot1, slot2, slot3)
	if slot0.listeners_[slot1] == nil then
		slot0.listeners_[slot1] = {}
	end

	slot0.nextListenerHandleIndex_ = slot0.nextListenerHandleIndex_ + 1
	slot4 = tostring(slot0.nextListenerHandleIndex_)
	slot0.listeners_[slot1][slot4] = {
		slot2,
		slot3
	}

	return slot4
end

function slot1.DispatchEvent(slot0, slot1)
	if slot0.listeners_[slot1.name or slot1.GetName and slot1:GetName()] == nil then
		return
	end

	slot1.emitter = slot0.target_

	for slot6, slot7 in pairs(slot0.listeners_[slot2]) do
		slot7[1](slot1)
	end

	return slot0.target_
end

function slot1.RemoveEventListener(slot0, slot1)
	for slot5, slot6 in pairs(slot0.listeners_) do
		for slot10, slot11 in pairs(slot6) do
			if slot10 == slot1 then
				slot6[slot10] = nil

				return slot0.target_
			end
		end
	end

	return slot0.target_
end

function slot1.RemoveEventListenersByTag(slot0, slot1)
	for slot5, slot6 in pairs(slot0.listeners_) do
		for slot10, slot11 in pairs(slot6) do
			if slot11[2] == slot1 then
				slot6[slot10] = nil
			end
		end
	end

	return slot0.target_
end

function slot1.RemoveEventListenersByEventAndTag(slot0, slot1, slot2)
	if not slot0.listeners_[slot1] then
		return slot0.target_
	end

	for slot7, slot8 in pairs(slot3) do
		if slot8[2] == slot2 then
			slot3[slot7] = nil
		end
	end

	return slot0.target_
end

function slot1.RemoveEventListenersByEvent(slot0, slot1)
	slot0.listeners_[slot1] = nil

	return slot0.target_
end

function slot1.RemoveAllEventListeners(slot0)
	slot0.listeners_ = {}

	return slot0.target_
end

function slot1.HasEventListener(slot0, slot1)
	for slot6, slot7 in pairs(slot0.listeners_[slot1]) do
		return true
	end

	return false
end

function slot1.DumpAllEventListeners(slot0)
	printInfo("---- EventProtocol:dumpAllEventListeners() ----")

	for slot4, slot5 in pairs(slot0.listeners_) do
		slot9 = slot4

		printInfo("-- event: %s", slot9)

		for slot9, slot10 in pairs(slot5) do
			printInfo("--     listener: %s, handle: %s", tostring(slot10[1]), tostring(slot9))
		end
	end

	return slot0.target_
end

function slot1.OnBind_(slot0)
	slot0:ExportMethods_({
		"AddEventListener",
		"AddEventListenerShare",
		"DispatchEvent",
		"RemoveEventListener",
		"RemoveEventListenersByTag",
		"RemoveEventListenersByEvent",
		"RemoveEventListenersByEventAndTag",
		"RemoveAllEventListeners",
		"HasEventListener",
		"DumpAllEventListeners"
	})

	return slot0.target_
end

function slot1.OnUnbind_(slot0)
end

return slot1
