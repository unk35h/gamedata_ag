slot0 = class("ScrollContentLineView", BaseView)

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.goLineItem_ = slot1
	slot0.goItemParent_ = slot2
	slot0.stageItemWidth_ = slot3
	slot0.offsetX_ = slot4
	slot0.lineHeight_ = slot5
	slot0.lineItemList_ = {}
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4 = #slot0.lineItemList_, 1, -1 do
		Object.Destroy(slot0.lineItemList_[slot4])
	end

	slot0.lineItemList_ = nil
end

function slot0.CreateLineItemList(slot0, slot1, slot2, slot3)
	for slot7 = #slot0.lineItemList_, 1, -1 do
		SetActive(slot0.lineItemList_[slot7], false)
	end

	for slot7, slot8 in ipairs(slot2) do
		if slot7 > 1 and slot1[slot8] then
			slot9 = slot3[slot7 - 1]:GetLocalPosition() + Vector3(slot0.stageItemWidth_ / 2 - slot0.offsetX_, 0, 0)
			slot10 = slot3[slot7]:GetLocalPosition() + Vector3(slot0.stageItemWidth_ / -2 + slot0.offsetX_, 0, 0)
			slot11 = slot0.lineItemList_[slot7] or Object.Instantiate(slot0.goLineItem_, slot0.goItemParent_.transform)

			if not slot0.lineItemList_[slot7] then
				table.insert(slot0.lineItemList_, slot11)
			end

			slot12 = slot11.transform
			slot12.localPosition = slot0:GetMidpoint(slot9, slot10)
			slot12:GetComponent("RectTransform").sizeDelta = Vector2(slot0:GetDistance(slot9, slot10), slot0.lineHeight_)
			slot12:GetComponent("RectTransform").localEulerAngles = Vector3(0, 0, slot0:GetAngle(slot9, slot10))

			slot12:SetAsFirstSibling()
			SetActive(slot11, true)
		end
	end
end

function slot0.GetDistance(slot0, slot1, slot2)
	return math.sqrt((slot1.x - slot2.x) * (slot1.x - slot2.x) + (slot1.y - slot2.y) * (slot1.y - slot2.y))
end

function slot0.GetMidpoint(slot0, slot1, slot2)
	return (slot1 + slot2) / 2
end

function slot0.GetAngle(slot0, slot1, slot2)
	slot3 = slot0:GetDistance(slot1, slot2)

	if slot1.x - slot2.x < 0 then
		return math.asin((slot1.y - slot2.y) / slot3) / math.pi * -180
	else
		return math.asin((slot1.y - slot2.y) / slot3) / math.pi * 180 + 180
	end
end

return slot0
