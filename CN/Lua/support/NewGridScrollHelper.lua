slot0 = class("NewGridScrollHelper")

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0.handler_ = slot1
	slot0.itemPath_ = slot2
	slot0.pool_ = ObjectPoolItem.New()

	slot0.pool_:InitFromObjectPool(slot6, slot2, slot7 or 10)

	slot0.itemClass_ = slot3
	slot0.delegateFunc_ = slot4
	slot0.scrollObj_ = slot5
	slot0.scrollRect_ = slot0.scrollObj_:GetComponent("ScrollRectEx")
	slot0.layOut_ = slot6
	slot0.layOutGroup_ = slot6.gameObject:GetComponent("GridLayoutGroup")

	slot0:OnCtor()

	if not slot0.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(slot0)
	end

	slot0.ctored_ = true
end

function slot0.OnCtor(slot0)
	slot0.items_ = {}
	slot0.itemGos_ = {}
	slot0.headIndex_ = 0
	slot0.tailIndex_ = 0
	slot0.perLineNum_ = slot0.layOutGroup_.constraintCount
	slot0.viewSize_ = slot0.scrollObj_:GetComponent("RectTransform").rect.size
	slot0.perPageNum_ = 0

	if slot0.scrollRect_.vertical then
		slot1 = slot0.layOutGroup_.spacing.y
		slot0.perPageNum_ = slot0.perLineNum_ * (math.ceil((slot0.viewSize_.y - slot0.layOutGroup_.padding.top + slot1) / (slot0.layOutGroup_.cellSize.y + slot1)) + 2)
	else
		slot1 = slot0.layOutGroup_.spacing.x
		slot0.perPageNum_ = slot0.perLineNum_ * (math.ceil((slot0.viewSize_.x - slot0.layOutGroup_.padding.left + slot1) / (slot0.layOutGroup_.cellSize.x + slot1)) + 2)
	end

	slot1 = slot0.scrollRect_.onValueChanged

	slot1:AddListener(function (slot0)
		uv0:OnScroll(slot0)
	end)
end

function slot0.StartScroll(slot0, slot1)
	slot0.maxNum_ = slot1

	slot0:RecycleAllItem()

	slot0.headIndex_ = 0
	slot0.tailIndex_ = 0

	for slot5 = 1, slot0.perPageNum_ do
		if not slot0:GenerateNewItem(true) then
			break
		end
	end

	if slot0.tailIndex_ > 0 then
		slot0.headIndex_ = 1
	end
end

function slot0.RecycleAllItem(slot0)
	for slot4, slot5 in pairs(slot0.items_) do
		slot0:RecycleItem(slot4, false)
	end
end

function slot0.RecycleItem(slot0, slot1, slot2)
	slot2 = slot2 or false

	if slot0.items_[slot1] then
		SetActive(slot3.gameObject_, slot2)
		slot0.pool_:Return(slot3.gameObject_)

		if slot3.Dispose then
			slot3:Dispose()
		end

		slot0.items_[slot1] = nil
		slot0.itemGos_[slot1] = nil

		manager.classPool:ReturnClass(slot3)
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
	if slot0.pool_ then
		slot0.pool_:Dispose()

		slot0.pool_ = nil
	end

	for slot4 = slot0.headIndex_, slot0.tailIndex_ do
		if slot0.items_[slot4] and slot0.items_[slot4].Dispose then
			slot0.items_[slot4]:Dispose()
		end
	end

	slot0.scrollRect_.onValueChanged:RemoveAllListeners()

	slot0.items_ = nil
	slot0.itemGos = nil
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

	if slot4 <= slot0.maxNum_ then
		slot5 = slot0.pool_:Get()

		SetActive(slot5, true)

		slot5.name = "item" .. slot4

		if slot0.delegateFunc_(slot4, slot5, manager.classPool:GetOrCreateClass(slot0.itemClass_, slot0.handler_, slot5)) then
			slot8 = slot5

			if slot1 then
				slot0.tailIndex_ = slot4
			else
				slot0.headIndex_ = slot4
			end

			slot0.items_[slot4] = slot7
			slot0.itemGos_[slot4] = slot5

			slot8.transform:SetSiblingIndex(slot4 - slot0.headIndex_)

			return slot4
		end
	end

	return false
end

function slot0.RefreshList(slot0)
	for slot4 = slot0.headIndex_, slot0.tailIndex_ do
		slot0.delegateFunc_(slot4, slot0.items_[slot4].gameObject_, slot0.items_[slot4])
	end
end

return slot0
