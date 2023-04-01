slot0 = class("PopularEventItem", CommonItem)

function slot0.ShowPresent(slot0, slot1)
	SetActive(slot0.presentGo_, slot1)
end

function slot0.ShowSelect(slot0, slot1)
	SetActive(slot0.selectGo_, slot1)
end

return slot0
