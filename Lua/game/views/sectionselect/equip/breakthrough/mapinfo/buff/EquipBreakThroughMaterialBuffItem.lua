slot0 = class("EquipBreakThroughMaterialBuffItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1)
	slot2 = EquipBreakThroughMaterialItemCfg[slot1]
	slot0.nameText_.text = slot2.name
	slot0.descText_.text = getAffixDesc(slot2.params)
	slot0.icon_.sprite = getSprite("Atlas/EquipBreakThroughMaterialIcon", slot2.icon)
end

return slot0
