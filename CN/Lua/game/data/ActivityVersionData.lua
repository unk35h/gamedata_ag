slot0 = singletonClass("ActivityVersionData")

function slot0.Init(slot0)
	slot0.selectActivityID_ = {}
end

function slot0.SetSelectActivityID(slot0, slot1, slot2)
	slot0.selectActivityID_[slot1] = slot0.selectActivityID_[slot1] or {}
	slot0.selectActivityID_[slot1] = slot2
end

function slot0.GetSelectActivityID(slot0, slot1)
	return slot0.selectActivityID_[slot1]
end

return slot0
