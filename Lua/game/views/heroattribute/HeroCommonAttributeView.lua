slot0 = class("HeroCommonAttributeView", HeroAttributeView)

function slot0.OnEnter(slot0)
	slot0.attribute_ = slot0.params_.attribute

	for slot4, slot5 in pairs(slot0.attributeItemList_) do
		slot5:SetData(slot0.attribute_[slot4])
	end

	slot0.scrollView_.verticalNormalizedPosition = 1
end

return slot0
