slot0 = class("EquipBreakThroughMaterialAttributeItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot3 = EquipBreakThroughMaterialItemCfg[slot1]
	slot0.icon_.sprite = getSprite("Atlas/EquipBreakThroughMaterialIcon", slot3.icon)
	slot0.descText_.text = string.format(slot3.desc, getAttributeAffixValue(slot1, slot2) / 10)
end

return slot0
