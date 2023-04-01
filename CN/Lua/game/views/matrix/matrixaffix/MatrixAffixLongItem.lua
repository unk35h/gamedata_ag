slot0 = class("MatrixAffixLongItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()
end

function slot0.Refresh(slot0, slot1)
	slot0.m_icon.sprite = getAffixSprite(slot1)
	slot0.m_name.text = GetI18NText(getAffixName(slot1)) .. (({
		"Ⅰ",
		"Ⅱ",
		"Ⅲ",
		"Ⅳ",
		"Ⅴ",
		"Ⅵ",
		"Ⅶ",
		"Ⅷ",
		"Ⅸ"
	})[slot1[2]] or "")
	slot0.m_des.text = getAffixDesc(slot1)
end

return slot0
