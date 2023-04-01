slot0 = class("GridScrollHelper")

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.delegateFunc_ = slot1
	slot0.scrollObj_ = slot2
	slot0.scrollRect_ = slot0.scrollObj_:GetComponent("ScrollRectEx")
	slot0.layOut_ = slot3
	slot0.layOutGroup_ = slot3.gameObject:GetComponent("GridLayoutGroup")

	slot0:OnCtor()

	if not slot0.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(slot0)
	end

	slot0.ctored_ = true
end

function slot0.OnCtor(slot0)
	slot0.items_ = {}
	slot0.headIndex_ = 0
	slot0.tailIndex_ = 0
	slot0.perLineNum_ = slot0.layOutGroup_.constraintCount

	slot0:SetPageInfo(slot0.perLineNum_)

	slot1 = slot0.scrollRect_.onValueChanged

	slot1:AddListener(function (slot0)
		uv0:OnScroll(slot0)
	end)
end

function slot0.SetPageInfo(slot0, slot1)
	slot0.perPageNum_ = 0
	slot0.viewSize_ = slot0.scrollObj_:GetComponent("RectTransform").rect.size

	if slot0.scrollRect_.vertical then
		slot2 = slot0.layOutGroup_.spacing.y
		slot5 = math.ceil((slot0.viewSize_.y - slot0.layOutGroup_.padding.top + slot2) / (slot0.layOutGroup_.cellSize.y + slot2))
		slot0.lineNum_ = slot5
		slot0.perPageNum_ = slot1 * (slot5 + 2)
	else
		slot2 = slot0.layOutGroup_.spacing.x
		slot5 = math.ceil((slot0.viewSize_.x - slot0.layOutGroup_.padding.left + slot2) / (slot0.layOutGroup_.cellSize.x + slot2))
		slot0.lineNum_ = slot5
		slot0.perPageNum_ = slot1 * (slot5 + 2)
	end
end

function slot0.ResetPageInfo(slot0)
	slot0.perLineNum_ = math.floor((slot0.layOutGroup_.transform.rect.width + slot0.layOutGroup_.spacing.x) / (slot0.layOutGroup_.cellSize.x + slot0.layOutGroup_.spacing.x))

	slot0:SetPageInfo(slot0.perLineNum_)
end

function slot0.StartScroll(slot0, slot1, slot2, slot3)
	slot0.maxNum_ = slot1

	slot0:RecycleAllItem(slot1)

	slot2 = not slot2 and 0 or 0 - 1
	slot3 = slot3 or 0
	slot0.headIndex_ = slot2
	slot0.tailIndex_ = slot2

	for slot7 = 1, slot0.perPageNum_ do
		if not slot0:GenerateNewItem(true) then
			break
		end
	end

	if slot0.scrollRect_.vertical then
		slot0.scrollRect_.verticalNormalizedPosition = 1 - slot3
	else
		slot0.scrollRect_.horizontalNormalizedPosition = slot3
	end

	if slot0.tailIndex_ > 0 then
		slot0.headIndex_ = slot0.headIndex_ + 1
	end
end

function slot0.GetHeadIndex(slot0)
	return slot0.headIndex_
end

function slot0.GetPosition(slot0)
	if slot0.scrollRect_.vertical then
		return 1 - slot0.scrollRect_.verticalNormalizedPosition
	else
		return slot0.scrollRect_.horizontalNormalizedPosition
	end
end

function slot0.RecycleAllItem(slot0, slot1)
	if slot0.headIndex_ and slot0.tailIndex_ then
		for slot5 = slot0.headIndex_, slot0.tailIndex_ do
			slot0:RecycleItem(slot5, false)
		end
	end
end

function slot0.RecycleItem(slot0, slot1, slot2)
	slot2 = slot2 or false

	if slot0.items_[slot1] then
		SetActive(slot3.gameObject_, slot2)

		if slot3.pools and slot3.recycleIndex then
			slot3.pools:FinishIndex(slot3.recycleIndex)
		end

		if slot3.Dispose then
			slot3:Dispose()
		else
			manager.classPool:ReturnClass(slot3)
		end

		slot0.items_[slot1] = nil
	end
end

function slot0.GetItemS(slot0)
	slot1 = {}

	for slot5 = slot0.headIndex_, slot0.tailIndex_ do
		table.insert(slot1, slot0.items_[slot5])
	end

	return slot1
end

function slot0.Dispose(slot0)
	for slot4 = slot0.headIndex_, slot0.tailIndex_ do
		if slot0.items_[slot4] and slot0.items_[slot4].Dispose then
			slot0.items_[slot4]:Dispose()
		end
	end

	slot0.scrollRect_.onValueChanged:RemoveAllListeners()

	slot0.items_ = nil
	slot0.headIndex_ = nil
	slot0.tailIndex_ = nil
	slot0.callBackFunc_ = nil

	ReduxFactory.GetInstance():OnManagedObjDisposed(slot0)
end

function slot0.RegistScrollCallBack(slot0, slot1)
	slot0.callBackFunc_ = slot1
end

function slot0.OnScroll(slot0, slot1)
	if (slot0.scrollRect_.vertical and slot1.y or slot1.x) < 0 then
		if slot2 then
			if slot0.tailIndex_ < slot0.maxNum_ then
				slot0:RecycleOnelineItem(true)
				slot0:GenerateOneLineItem(true)
				slot0.scrollRect_:AddContentPosition(slot0:CaculateOffset(true))
			end
		elseif slot0.headIndex_ > 1 then
			slot0:RecycleOnelineItem(false)
			slot0:GenerateOneLineItem(false)
			slot0.scrollRect_:AddContentPosition(slot0:CaculateOffset(false))
		end
	elseif slot3 > 1 then
		if slot2 then
			if slot0.headIndex_ > 1 then
				slot0:RecycleOnelineItem(false)
				slot0:GenerateOneLineItem(false)
				slot0.scrollRect_:AddContentPosition(slot0:CaculateOffset(false))
			end
		elseif slot0.tailIndex_ < slot0.maxNum_ then
			slot0:RecycleOnelineItem(true)
			slot0:GenerateOneLineItem(true)
			slot0.scrollRect_:AddContentPosition(slot0:CaculateOffset(true))
		end
	end

	if slot0.callBackFunc_ then
		slot0.callBackFunc_()
	end
end

function slot0.CaculateOffset(slot0, slot1)
	if slot0.scrollRect_.vertical then
		slot2 = slot0.layOutGroup_.cellSize.y + slot0.layOutGroup_.spacing.y

		return Vector2(0, slot1 and -slot2 or slot2)
	else
		slot3 = slot0.layOutGroup_.cellSize.x + slot0.layOutGroup_.spacing.x

		return Vector2(slot1 and slot3 or -slot3, 0)
	end
end

function slot0.RefreshItemSiblingIndex(slot0)
	for slot4 = slot0.headIndex_, slot0.tailIndex_ do
		if slot0.items_[slot4].gameObject_ then
			slot5.transform:SetSiblingIndex(slot4 - slot0.headIndex_)
		end
	end
end

function slot0.RecycleOnelineItem(slot0, slot1)
	slot2 = 0
	slot3 = 0

	if slot1 then
		slot3 = slot0.headIndex_ + slot0.perLineNum_ - 1
	else
		slot2 = math.floor((slot0.tailIndex_ - slot0.headIndex_) / slot0.perLineNum_) * slot0.perLineNum_ + slot0.headIndex_
		slot3 = slot0.tailIndex_
	end

	for slot7 = slot2, slot3 do
		if slot0.items_[slot7] then
			slot0:RecycleItem(slot7)
		end
	end

	if slot1 then
		slot0.headIndex_ = slot0.headIndex_ + slot0.perLineNum_
	else
		slot0.tailIndex_ = slot0.tailIndex_ - (slot3 - slot2 + 1)
	end

	slot0:RefreshItemSiblingIndex()
end

function slot0.GenerateOneLineItem(slot0, slot1)
	slot2 = 0

	for slot6 = 1, slot0.perLineNum_ do
		if slot0:GenerateNewItem(slot1) then
			slot2 = slot2 + 1
		end
	end

	return slot2 > 0
end

function slot0.GenerateNewItem(slot0, slot1)
	if (slot1 and slot0.tailIndex_ or slot0.headIndex_) + (slot1 and 1 or -1) < 1 then
		return false
	end

	if slot0.delegateFunc_(slot4) then
		slot6 = slot5.gameObject_

		if slot1 then
			slot0.tailIndex_ = slot4
		else
			slot0.headIndex_ = slot4
		end

		slot0.items_[slot4] = slot5

		slot6.transform:SetSiblingIndex(slot4 - slot0.headIndex_)

		return slot4
	end

	return false
end

return slot0
