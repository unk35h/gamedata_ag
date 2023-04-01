slot0 = class("EquipBreakThroughMaterialBuffView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.buffList_ = LuaList.New(handler(slot0, slot0.RefreshBuffItem), slot0.buffUIList_, EquipBreakThroughMaterialBuffItem)
	slot0.attributeList_ = LuaList.New(handler(slot0, slot0.RefreshAttributeItem), slot0.attributeUIList_, EquipBreakThroughMaterialAttributeItem)
end

function slot0.OnEnter(slot0)
	slot0.buffDataList_ = EquipBreakThroughMaterialData:GetBuffList()
	slot4 = #slot0.buffDataList_

	slot0.buffList_:StartScroll(slot4)

	slot0.attributeDataList_ = EquipBreakThroughMaterialData:GetAttributeList()
	slot0.itemIDList_ = {}

	for slot4, slot5 in pairs(slot0.attributeDataList_) do
		table.insert(slot0.itemIDList_, slot4)
	end

	slot0.attributeList_:StartScroll(#slot0.itemIDList_)
end

function slot0.OnEixt(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.buffList_:Dispose()

	slot0.buffList_ = nil

	slot0.attributeList_:Dispose()

	slot0.attributeList_ = nil
end

function slot0.RefreshBuffItem(slot0, slot1, slot2)
	slot2:SetData(slot0.buffDataList_[slot1])
end

function slot0.RefreshAttributeItem(slot0, slot1, slot2)
	slot3 = slot0.itemIDList_[slot1]

	slot2:SetData(slot3, slot0.attributeDataList_[slot3])
end

return slot0
