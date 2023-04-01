slot0 = class("WeaponModuleAttributeItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject_)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.typeImage_.sprite = getSprite("Atlas/Common", PublicAttrCfg[slot1].icon)
	slot0.typeText_.text = PublicAttrCfg[slot1].name
	slot0.numText_.text = "+" .. slot2
end

function slot0.SetIsShow(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
