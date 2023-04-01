slot0 = class("ScrollPartner")

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.gameObject_ = slot1
	slot0.partner_ = slot2
	slot0.scrollRect_ = slot1:GetComponent("ScrollRectEx")
	slot0.grid_ = slot1.transform:Find("Grid").gameObject
	slot0.rect_ = slot0.grid_.gameObject:GetComponent("RectTransform")
	slot0.partnerRect_ = slot3:GetComponent("RectTransform")
	slot0.gameObject_.transform.localPosition = slot2.transform.localPosition
	slot0.gameObject_:GetComponent("RectTransform").sizeDelta = slot2:GetComponent("RectTransform").sizeDelta
	slot0.helper_ = slot4
	slot0.childCnt_ = slot0.grid_.transform.childCount
	slot0.ceilPos_ = slot5

	slot0:OnCtor()
end

function slot0.OnCtor(slot0)
	slot0.children_ = {}

	for slot4 = 1, slot0.childCnt_ do
		slot5 = slot0.grid_.transform:Find("item" .. slot4)
		slot0.children_[slot4] = {
			trs = slot5,
			x = slot5.localPosition.x
		}

		if slot4 == 1 then
			slot0.startPos_ = -slot5.localPosition.y
		end
	end

	slot1 = slot0.partner_:GetComponent("ScrollRectEx")
	slot0.timer_ = FrameTimer.New(function ()
		uv1:OnScroll(uv0.normalizedPosition)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.OnScroll(slot0, slot1)
	slot0:SetPage()

	slot0.scrollRect_.normalizedPosition = slot1
end

function slot0.SetPage(slot0)
	slot2 = slot0.helper_.maxNum_
	slot3 = slot0.helper_.tailIndex_
	slot5 = slot0.helper_.perPageNum_

	if math.ceil(((slot0.helper_.layOutGroup_.spacing.y + slot0.helper_.layOutGroup_.cellSize.y) * math.floor(slot0.helper_.headIndex_ / slot0.helper_.perLineNum_) - slot0.startPos_) / slot0.ceilPos_) + 1 < 1 then
		slot10 = 1
	end

	if slot0.startPos_ + (slot10 - 1) * slot0.ceilPos_ - slot9 < 0 then
		slot11 = 0
	end

	slot10 = (slot10 - 1) % slot0.childCnt_ + 1
	slot12 = slot0.pageSize_
	slot13 = slot5 / slot4

	if slot2 <= slot5 then
		slot13 = math.ceil(slot2 / slot4)
	end

	slot0.pageSize_ = slot13 * slot8 + (slot13 - 1) * slot7

	if slot0.pageSize_ ~= slot12 then
		slot0.rect_.sizeDelta = Vector2(slot0.rect_.sizeDelta.x, slot0.pageSize_)
	end

	if slot0.head_ == slot1 then
		return
	end

	slot0.head_ = slot1
	slot14 = slot11
	slot15 = 0

	for slot19 = slot10, slot0.childCnt_ do
		slot20 = slot0.children_[slot19]
		slot20.trs.localPosition = Vector3(slot20.x, -slot15 * slot0.ceilPos_ - slot14, 0)
		slot15 = slot15 + 1
	end

	for slot19 = 1, slot10 - 1 do
		slot20 = slot0.children_[slot19]
		slot20.trs.localPosition = Vector3(slot20.x, -slot15 * slot0.ceilPos_ - slot14, 0)
		slot15 = slot15 + 1
	end
end

function slot0.Dispose(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
