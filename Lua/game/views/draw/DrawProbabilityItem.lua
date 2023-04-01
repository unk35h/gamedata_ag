slot0 = class("DrawProbabilityItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.RefreshData(slot0, slot1)
	slot0:Show(true)

	slot0.labName_.text = slot1.name
	slot0.labRate_.text = string.format(GetTips("DRAW_PROBABILITY"), slot1.probability)
	slot0.labRate2_.text = ""

	if slot1.guaranteeData then
		slot0.labRate2_.text = string.format(GetTips("DRAW_PROBABILITY_GUARANTEE"), slot1.guaranteeData.probability)
	else
		slot0.labRate2_.text = ""
	end

	slot3 = ""

	for slot7, slot8 in pairs(DrawInfoCfg.get_id_list_by_index[slot1.index]) do
		if (DrawInfoCfg[slot8].goods and slot9.goods[1] or 0) ~= 0 then
			slot11 = ItemCfg[slot10]
			slot3 = (slot7 ~= 1 or GetI18NText(slot11.name)) and GetI18NText(slot11.name) .. "/" .. GetI18NText(slot11.name)
		end
	end

	slot0.labContent_.text = slot3
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
