slot0 = class("HorizontalScrollHelper")

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.delegateObj_ = slot1
	slot0.scrollView_ = slot2
	slot0.isVertical_ = slot3
	slot0.startIndex_ = 0
	slot0.endIndex_ = 0
	slot0.maxIndex_ = 0

	slot0:OnCtor()
end

function slot0.OnCtor(slot0)
	slot0.itemS_ = {}
	slot0.currentIndex_ = 0
end

function slot0.SetSpacing(slot0, slot1)
	slot0.space_ = slot1
end

function slot0.SetDataList(slot0, slot1)
	slot0.dataList_ = slot1
	slot0.maxIndex_ = #slot1
end

function slot0.RecycleAllItem(slot0)
	for slot4 = #slot0.itemS_, 1, -1 do
		slot0:RecycleItem(slot4)
	end

	slot0.itemS_ = {}
end

function slot0.RecycleItem(slot0, slot1)
	if slot0.itemS_[slot1] == nil then
		return
	end

	slot2:Show(false)

	if slot2.pools and slot2.recycleIndex then
		slot2.pools:FinishIndex(slot2.recycleIndex)

		slot2.isFree = true
	end

	table.remove(slot0.itemS_, slot1)
end

function slot0.Show(slot0, slot1)
	slot2 = slot0.scrollView_:GetViewBounds()
	slot3 = slot0.scrollView_:GetContentBounds()
	slot0.startIndex_ = slot1 - 1
	slot0.endIndex_ = slot0.startIndex_

	if slot0.isVertical_ == true then
		for slot7 = slot0.endIndex_, slot0.maxIndex_ do
			if slot3.max.y <= slot2.max.y then
				slot0:NewItemAtEnd()

				slot2 = slot0.scrollView_:GetViewBounds()
				slot3 = slot0.scrollView_:GetContentBounds()
			else
				break
			end
		end

		while slot2.max.y - slot2.min.y > slot3.max.y - slot3.min.y and slot0.startIndex_ > 0 do
			slot0:NewItemAtStart()

			slot2 = slot0.scrollView_:GetViewBounds()
			slot3 = slot0.scrollView_:GetContentBounds()
		end
	else
		for slot7 = slot0.startIndex_, slot0.maxIndex_ do
			if slot3.max.x <= slot2.max.x then
				slot0:NewItemAtEnd()

				slot2 = slot0.scrollView_:GetViewBounds()
				slot3 = slot0.scrollView_:GetContentBounds()
			else
				break
			end
		end

		while slot2.max.x - slot2.min.x - (slot3.max.x - slot3.min.x) > 0.001 and slot0.startIndex_ > 0 do
			slot0:NewItemAtStart()

			slot2 = slot0.scrollView_:GetViewBounds()
			slot3 = slot0.scrollView_:GetContentBounds()
		end
	end

	if not slot0.scrollView_.onUpdateItems then
		function slot0.scrollView_.onUpdateItems(slot0, slot1)
			uv0:UpdateItems(slot0, slot1)
		end
	end
end

function slot0.UpdateItems(slot0, slot1, slot2)
	if slot0.isVertical_ then
		slot0:UpdateVertical(slot1, slot2)
	else
		slot0:UpdateHorizontal(slot1, slot2)
	end
end

function slot0.UpdateVertical(slot0, slot1, slot2)
	if slot1.max.y > slot2.max.y - 0 * slot0:CaculateItemSize(1) then
		slot0:NewItemAtStart()
	end

	if slot1.min.y < slot2.min.y - 0 * slot0:CaculateItemSize(#slot0.itemS_) then
		slot0:NewItemAtEnd()
	end

	if slot0.scrollView_:GetViewBounds().max.y < slot0.scrollView_:GetContentBounds().max.y - 1 * slot0:CaculateItemSize(1) then
		slot0:RemoveItemAtStart()
	end

	if slot1.min.y > slot2.min.y + 1 * slot0:CaculateItemSize(#slot0.itemS_) then
		slot0:RemoveItemAtEnd()
	end
end

function slot0.UpdateHorizontal(slot0, slot1, slot2)
	if slot1.min.x < slot2.min.x - 0 * slot0:CaculateItemSize(1) then
		slot0:NewItemAtStart()
	end

	if slot1.max.x > slot2.max.x + 0 * slot0:CaculateItemSize(1) then
		slot0:NewItemAtEnd()
	end

	if slot0.scrollView_:GetViewBounds().min.x > slot0.scrollView_:GetContentBounds().min.x + 1 * slot0:CaculateItemSize(1) then
		slot0:RemoveItemAtStart()
	end

	if slot1.max.x < slot2.max.x - 1 * slot0:CaculateItemSize(#slot0.itemS_) then
		slot0:RemoveItemAtEnd()
	end
end

function slot0.NewItemAtStart(slot0)
	if slot0.startIndex_ < 1 then
		return
	end

	table.insert(slot0.itemS_, 1, slot0.delegateObj_:GetItem(slot0.startIndex_))

	slot0.startIndex_ = slot0.startIndex_ - 1

	slot0.itemS_[1]:Show(true)
	slot0.itemS_[1].gameObject_.transform:SetAsFirstSibling()

	if slot0.isVertical_ then
		slot0.scrollView_:AddContentPosition(Vector2(0, slot0:CaculateItemSize(1) * 1))
	else
		slot0.scrollView_:AddContentPosition(Vector2(slot0:CaculateItemSize(1) * -1, 0))
	end
end

function slot0.RemoveItemAtStart(slot0)
	if slot0.maxIndex_ <= slot0.endIndex_ then
		return
	end

	slot0:RecycleItem(1)

	slot0.startIndex_ = slot0.startIndex_ + 1

	if slot0.isVertical_ then
		slot0.scrollView_:AddContentPosition(Vector2(0, slot0:CaculateItemSize(1) * -1))
	else
		slot0.scrollView_:AddContentPosition(Vector2(slot0:CaculateItemSize(1), 0))
	end
end

function slot0.NewItemAtEnd(slot0)
	if slot0.maxIndex_ <= slot0.endIndex_ then
		return
	end

	slot0.endIndex_ = slot0.endIndex_ + 1

	table.insert(slot0.itemS_, slot0.delegateObj_:GetItem(slot0.endIndex_))
	slot0.itemS_[#slot0.itemS_]:Show(true)
	slot0.itemS_[#slot0.itemS_].gameObject_.transform:SetAsLastSibling()
end

function slot0.RemoveItemAtEnd(slot0)
	slot0:RecycleItem(#slot0.itemS_)

	slot0.endIndex_ = slot0.endIndex_ - 1
end

function slot0.CaculateItemSize(slot0, slot1)
	if slot0.isVertical_ then
		return slot0:CaculateVerticalItemSize(slot1)
	else
		return slot0:CaculateHorizontalItemSize(slot1)
	end
end

function slot0.CaculateVerticalItemSize(slot0, slot1)
	slot2 = 0
	slot3 = slot0.itemS_[slot1]

	if slot1 <= 0 or not slot3 then
		return slot2
	end

	if slot3:GetRectTransform() then
		slot2 = slot2 + slot4.sizeDelta.y + slot0.space_
	end

	return slot2
end

function slot0.CaculateHorizontalItemSize(slot0, slot1)
	slot2 = 0
	slot3 = slot0.itemS_[slot1]

	if slot1 <= 0 or not slot3 then
		return slot2
	end

	if slot3:GetRectTransform() then
		slot2 = slot2 + slot4.sizeDelta.x + slot0.space_
	end

	return slot2
end

function slot0.GetStartIndex(slot0)
	return slot0.startIndex_
end

function slot0.GetEndIndex(slot0)
	return slot0.endIndex_
end

function slot0.OnDispose(slot0)
	slot0.scrollView_.onUpdateItems = nil
	slot0.dataList_ = nil
	slot0.itemS_ = nil
end

return slot0
