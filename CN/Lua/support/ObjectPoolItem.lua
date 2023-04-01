slot0 = class("ObjectPoolItem")

function slot0.Ctor(slot0)
	slot0.fromObjectPool = false
	slot0.objects_ = {}
	slot0.freeList_ = {}
	slot0.usingList = {}
end

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.itemPrefab_ = slot2
	slot0.parent_ = slot1
	slot0.fromObjectPool = false

	for slot7 = 1, slot3 do
		slot0:Create()
	end
end

function slot0.InitFromObjectPool(slot0, slot1, slot2, slot3)
	slot0.parent_ = slot1
	slot0.assetPath_ = slot2
	slot0.fromObjectPool = true

	for slot7 = 1, slot3 do
		slot0:Create()
	end
end

function slot0.Create(slot0)
	slot1 = nil

	if ((not slot0.fromObjectPool or manager.objectPool:Get(slot0.assetPath_)) and Object.Instantiate(slot0.itemPrefab_, slot0.parent_)).transform.parent ~= slot0.parent_ then
		slot2:SetParent(slot0.parent_, false)
	end

	table.insert(slot0.objects_, slot1)
	table.insert(slot0.freeList_, slot1)

	return slot1
end

function slot0.Get(slot0)
	if #slot0.freeList_ <= 0 then
		slot0:Create()
	end

	slot1 = slot0.freeList_[#slot0.freeList_]
	slot1.transform.localScale = Vector3(1, 1, 1)
	slot1.transform.localPosition = Vector3(1, 1, 1)

	table.insert(slot0.usingList, slot1)
	table.remove(slot0.freeList_, #slot0.freeList_)

	return slot1
end

function slot0.Return(slot0, slot1)
	if table.indexof(slot0.usingList, slot1) ~= false then
		table.insert(slot0.freeList_, slot1)
		table.remove(slot0.usingList, slot2)
	end
end

function slot0.Dispose(slot0)
	if slot0.fromObjectPool and manager.objectPool:IsRecycleAssetPath(slot0.assetPath_) then
		for slot4 = 1, #slot0.objects_ do
			manager.objectPool:Return(slot0.assetPath_, slot0.objects_[slot4])
		end
	else
		for slot4 = 1, #slot0.objects_ do
			Object.Destroy(slot0.objects_[slot4])
		end
	end
end

return slot0
