slot0 = class("HeroSurpassAttributeItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()
end

function slot0.Refresh(slot0, slot1)
	slot3 = slot1[2]
	slot4 = PublicAttrCfg[slot1[1]]
	slot0.m_nameText.text = slot4.name
	slot0.m_icon.sprite = getSprite("Atlas/Common", slot4.icon)

	if slot4.percent == 1 then
		slot0.m_addText.text = string.format("+%.2f", slot3 / 10) .. "%"
	else
		slot0.m_addText.text = string.format("+%.0f", slot3)
	end
end

return slot0
