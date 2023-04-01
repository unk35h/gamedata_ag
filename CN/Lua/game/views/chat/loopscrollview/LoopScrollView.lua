slot0 = class("LoopScrollView", BaseView)

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.parentView_ = slot1
	slot0.scrollView_ = slot2
	slot0.rectGrid_ = slot3
	slot0.itemList_ = {}
	slot0.contentHeight_ = 0
	slot0.itemSpace_ = slot5
	slot0.currentHeight_ = slot4
	slot0.isBottom_ = slot6

	slot0:AddListeners()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.itemList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddToggleListener(slot0.scrollView_, function (slot0)
		if slot0.y < 0 or slot0.y == 0 and uv0.rectGrid_.anchoredPosition.y > 0 then
			uv0:DeleteItem(true)
			uv0:AddTailItem()
		elseif slot0.y > 1 or slot0.y == 1 and uv0.rectGrid_.anchoredPosition.y < 0 then
			uv0:DeleteItem(false)
			uv0:AddHeadItem()
		end
	end)
end

function slot0.GetContentHeight(slot0)
	return slot0.currentHeight_
end

function slot0.SetContentHeight(slot0, slot1)
	slot0.currentHeight_ = slot1
end

function slot0.RestoredScroll(slot0, slot1, slot2)
	slot0:NavigateIndex(slot1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectGrid_)

	slot0.scrollView_.verticalNormalizedPosition = slot2

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectGrid_)
end

function slot0.NavigateIndex(slot0, slot1)
	slot0.scrollView_.verticalNormalizedPosition = 0.9999

	for slot5 = #slot0.itemList_, 1, -1 do
		slot0.parentView_:LsRemoveItem(slot0.itemList_[slot5])
		table.remove(slot0.itemList_, #slot0.itemList_)
	end

	slot0.contentHeight_ = 0

	for slot6 = slot1, #slot0.parentView_:LsGetItemData() do
		slot7 = slot0.parentView_:LsAddItem(slot2[slot6], slot6)

		table.insert(slot0.itemList_, slot7)
		slot7.itemView:SetAsLastSibling()

		if slot7.itemView:IsActive() then
			slot0.contentHeight_ = slot0.contentHeight_ + slot0.itemSpace_ + slot7.itemView:GetItemHeight()
		end

		if slot0:GetContentHeight() <= slot0.contentHeight_ then
			break
		end
	end

	if slot0.isBottom_ and slot0.contentHeight_ < slot0:GetContentHeight() then
		slot0:Scroll2End()
	end
end

function slot0.Scroll2End(slot0)
	for slot4 = #slot0.itemList_, 1, -1 do
		slot0.parentView_:LsRemoveItem(slot0.itemList_[slot4])
		table.remove(slot0.itemList_, slot4)
	end

	slot0.contentHeight_ = 0

	for slot5 = #slot0.parentView_:LsGetItemData(), 1, -1 do
		slot6 = slot0.parentView_:LsAddItem(slot1[slot5], slot5)

		table.insert(slot0.itemList_, 1, slot6)
		slot6.itemView:SetAsFirstSibling()

		if slot6.itemView:IsActive() then
			slot0.contentHeight_ = slot0.contentHeight_ + slot0.itemSpace_ + slot6.itemView:GetItemHeight()
		end

		if slot0:GetContentHeight() <= slot0.contentHeight_ then
			break
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectGrid_)

	slot0.scrollView_.verticalNormalizedPosition = 1e-05

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectGrid_)
end

function slot0.RefreshScrollView(slot0, slot1, slot2)
	slot3 = 0.99999

	if slot2 then
		slot3 = slot0.scrollView_.verticalNormalizedPosition
	end

	if #slot0.itemList_ <= 0 then
		slot0:NavigateIndex(1)

		slot0.scrollView_.verticalNormalizedPosition = slot3

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectGrid_)

		return
	end

	slot4 = slot0.itemList_[1].itemView:GetIndex()

	if slot0.itemList_[1].itemView:IsActive() == false then
		slot0:NavigateIndex(slot4)

		slot0.scrollView_.verticalNormalizedPosition = slot3

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectGrid_)

		return
	end

	if #slot0.parentView_:LsGetItemData() <= 0 then
		slot0:DeleteAllItem()

		slot0.scrollView_.verticalNormalizedPosition = slot3

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectGrid_)

		return
	end

	slot6 = slot5[slot4]

	if slot1 then
		slot0:DeleteAllItem()
		slot0:NavigateIndex(slot4)

		slot0.scrollView_.verticalNormalizedPosition = slot3

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectGrid_)

		return
	else
		slot10 = slot0.itemList_[1]

		slot0.parentView_:LsUpdateItem(slot10, slot6, slot4)

		for slot10 = #slot0.itemList_, 2, -1 do
			slot0.parentView_:LsRemoveItem(slot0.itemList_[slot10])
			table.remove(slot0.itemList_, slot10)
		end

		slot0.contentHeight_ = slot0.itemSpace_ + slot0.itemList_[1].itemView:GetItemHeight()
	end

	slot0:AddTail2End()
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectGrid_)

	slot0.scrollView_.verticalNormalizedPosition = slot3

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectGrid_)
end

function slot0.AddTail2End(slot0)
	if #slot0.parentView_:LsGetItemData() <= 0 then
		return
	end

	while slot0.contentHeight_ < slot0:GetContentHeight() do
		slot2 = 1

		if #slot0.itemList_ > 0 and slot0.itemList_[#slot0.itemList_].itemView:GetIndex() + 1 > #slot1 then
			break
		end

		slot0:AddTailItem()
	end

	slot0:AddTailItem()

	while slot0.contentHeight_ < slot0:GetContentHeight() do
		slot2 = 1

		if #slot0.itemList_ > 0 and slot0.itemList_[1].itemView:GetIndex() - 1 <= 0 then
			break
		end

		slot0:AddHeadItem()
	end
end

function slot0.DeleteIndex(slot0, slot1)
	for slot5 = #slot0.itemList_, slot1, -1 do
		slot6 = slot0.itemList_[slot5]

		slot0.parentView_:LsRemoveItem(slot6)

		if slot6.itemView:IsActive() then
			slot0.contentHeight_ = slot0.contentHeight_ - slot0.itemSpace_ - slot6.itemView:GetItemHeight()
		end

		table.remove(slot0.itemList_, #slot0.itemList_)
	end

	slot0:AddTail2End()
end

function slot0.DeleteItem(slot0, slot1)
	while slot0:GetContentHeight() < slot0.contentHeight_ do
		slot2 = 1

		if slot1 then
			slot0:DeleteHeadItem()
		else
			slot0:DeleteTailItem()

			slot2 = #slot0.itemList_
		end

		if slot2 <= 0 then
			break
		end

		if slot0.itemList_[slot2] == nil then
			break
		end

		if slot0.contentHeight_ - slot0.itemSpace_ - slot3.itemView:GetItemHeight() < slot0:GetContentHeight() then
			break
		end
	end
end

function slot0.DeleteHeadItem(slot0)
	if slot0:GetContentHeight() < slot0.contentHeight_ - slot0.itemSpace_ - slot0.itemList_[1].itemView:GetItemHeight() then
		slot0.parentView_:LsRemoveItem(slot1)
		table.remove(slot0.itemList_, 1)

		if slot1.itemView:IsActive() then
			slot0.scrollView_:AddContentPosition(Vector2(0, -slot0.itemSpace_ - slot1.itemView:GetItemHeight()))

			slot0.contentHeight_ = slot0.contentHeight_ - slot0.itemSpace_ - slot1.itemView:GetItemHeight()
		else
			slot0:DeleteHeadItem()
		end
	end
end

function slot0.DeleteTailItem(slot0)
	if slot0:GetContentHeight() < slot0.contentHeight_ - slot0.itemSpace_ - slot0.itemList_[#slot0.itemList_].itemView:GetItemHeight() then
		slot0.parentView_:LsRemoveItem(slot1)
		table.remove(slot0.itemList_, #slot0.itemList_)

		if slot1.itemView:IsActive() then
			slot0.contentHeight_ = slot0.contentHeight_ - slot0.itemSpace_ - slot1.itemView:GetItemHeight()
		else
			slot0:DeleteTailItem()
		end
	end
end

function slot0.AddTailItem(slot0)
	if #slot0.parentView_:LsGetItemData() <= 0 then
		return
	end

	slot2 = 1

	if #slot0.itemList_ > 0 and slot0.itemList_[#slot0.itemList_].itemView:GetIndex() + 1 > #slot1 then
		return
	end

	slot4 = slot0.parentView_:LsAddItem(slot1[slot2], slot2)

	table.insert(slot0.itemList_, slot4)
	slot4.itemView:SetAsLastSibling()

	if slot4.itemView:IsActive() then
		slot0.contentHeight_ = slot0.contentHeight_ + slot0.itemSpace_ + slot4.itemView:GetItemHeight()
	else
		slot0:AddTailItem()
	end
end

function slot0.AddHeadItem(slot0)
	if #slot0.parentView_:LsGetItemData() <= 0 then
		return
	end

	slot2 = 1

	if #slot0.itemList_ > 0 and slot0.itemList_[1].itemView:GetIndex() - 1 <= 0 then
		return
	end

	slot4 = slot0.parentView_:LsAddItem(slot1[slot2], slot2)

	table.insert(slot0.itemList_, 1, slot4)
	slot4.itemView:SetAsFirstSibling()

	if slot4.itemView:IsActive() then
		slot0.contentHeight_ = slot0.contentHeight_ + slot0.itemSpace_ + slot4.itemView:GetItemHeight()

		slot0.scrollView_:AddContentPosition(Vector2(0, slot0.itemSpace_ + slot4.itemView:GetItemHeight()))
	else
		slot0:AddHeadItem()
	end
end

function slot0.DeleteAllItem(slot0)
	for slot4 = #slot0.itemList_, 1, -1 do
		slot0.parentView_:LsRemoveItem(slot0.itemList_[slot4])
		table.remove(slot0.itemList_, slot4)
	end

	slot0.contentHeight_ = 0
end

function slot0.GetItemList(slot0)
	return slot0.itemList_
end

function slot0.IsFillContent(slot0)
	return slot0:GetContentHeight() <= slot0.contentHeight_
end

return slot0
