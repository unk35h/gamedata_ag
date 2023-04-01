slot0 = class("LoopScrollViewBaseItem", ReduxView)

function slot0.GetIndex(slot0)
	return slot0.index_
end

function slot0.IsActive(slot0)
	return true
end

function slot0.IsTimeBar(slot0)
	return false
end

function slot0.SetData(slot0, slot1, slot2)
end

function slot0.GetItemHeight(slot0)
	return slot0.rectGo_.sizeDelta.y
end

function slot0.SetAsLastSibling(slot0)
	slot0.transform_:SetAsLastSibling()
end

function slot0.SetAsFirstSibling(slot0)
	slot0.transform_:SetAsFirstSibling()
end

return slot0
