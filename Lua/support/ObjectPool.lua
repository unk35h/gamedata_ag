slot0 = class("ObjectPool")

function slot0.Ctor(slot0)
	slot0.uselessParent_ = GameObject.Find("/Pool").transform
	slot0.freeDic_ = {}

	slot0:Preload()
end

function slot0.Preload(slot0)
end

function slot0.Create(slot0, slot1, slot2)
	slot3 = Asset.Load(slot1)
	slot7 = slot1

	slot0:CheckToInitList(slot7)

	for slot7 = 1, slot2 do
		table.insert(slot0.freeDic_[slot1], Object.Instantiate(slot3, slot0.uselessParent_))
	end
end

function slot0.Get(slot0, slot1)
	slot0:CheckToInitList(slot1)

	if #slot0.freeDic_[slot1] == 0 then
		slot0:Create(slot1, 1)
	end

	slot2 = slot0.freeDic_[slot1]

	table.remove(slot2, #slot2)

	return slot2[#slot2]
end

function slot0.Return(slot0, slot1, slot2)
	slot0:CheckToInitList(slot1)
	slot2.transform:SetParent(slot0.uselessParent_, false)
	table.insert(slot0.freeDic_[slot1], slot2)
end

function slot0.CheckToInitList(slot0, slot1)
	if not slot0.freeDic_[slot1] then
		slot0.freeDic_[slot1] = {}
	end
end

function slot0.IsRecycleAssetPath(slot0, slot1)
	if slot1 == "UI/Common/CommonItem" then
		return true
	end

	return false
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.freeDic_) do
		for slot9, slot10 in ipairs(slot5) do
			Object.Destroy(slot10)
		end
	end

	slot0.freeDic_ = {}
end

return slot0
