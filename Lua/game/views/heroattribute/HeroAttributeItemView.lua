slot0 = class("HeroAttributeItemView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()

	slot0.textName_.text = PublicAttrCfg[slot4].name
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")

	if slot3 % 2 == 1 then
		slot0.controller_:SetSelectedState("0")
	else
		slot0.controller_:SetSelectedState("1")
	end

	slot0.attributeID_ = slot4
end

function slot0.SetData(slot0, slot1)
	if PublicAttrCfg[slot0.attributeID_].percent == 1 then
		slot0.textNum_.text = string.format("%.2f%%", slot1 / 10)
	else
		slot0.textNum_.text = math.floor(slot1)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
