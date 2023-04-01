slot0 = singletonClass("ActivityAdvertiseData")

function slot0.Init(slot0)
	slot0.openAdvertiseFlag_ = {}
end

function slot0.SetOpenAdvertiseFlag(slot0, slot1, slot2)
	slot0.openAdvertiseFlag_[slot1] = slot2
end

function slot0.GetOpenAdvertiseFlag(slot0, slot1)
	return slot0.openAdvertiseFlag_[slot1]
end

return slot0
