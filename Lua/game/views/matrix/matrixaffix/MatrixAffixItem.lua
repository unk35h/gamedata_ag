slot0 = class("MatrixAffixItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0.m_icon.sprite = getAffixSprite(slot1)
	slot4 = getAffixName(slot1)
	slot5 = getAffixDesc(slot1)
	slot6 = ({
		"Ⅰ",
		"Ⅱ",
		"Ⅲ",
		"Ⅳ",
		"Ⅴ",
		"Ⅵ",
		"Ⅶ",
		"Ⅷ",
		"Ⅸ"
	})[slot1[2]] or ""

	if slot2 == 2 then
		slot0.m_text.text = GetI18NText(slot4) .. slot6 .. "\n" .. GetI18NText(slot5)
	else
		slot0.m_text.text = GetI18NText(slot4) .. slot6
	end
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
