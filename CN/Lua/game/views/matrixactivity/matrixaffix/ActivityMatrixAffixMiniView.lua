slot0 = class("ActivityMatrixAffixMiniView", MatrixAffixMiniView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/SoloRoguelike/ActivityMatrixAffixMiniUI"
end

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id
	slot0.regularData = {}
	slot0.customData = ActivityMatrixData:GetCustomAffix(slot0.matrix_activity_id) or {}

	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot1 = #slot0.customData

	slot0.affixCustomList_:StartScroll(slot1)
	slot0.stateController_:SetSelectedIndex(slot1 == 0 and 1 or 0)

	slot2 = 0
	slot3 = 0

	for slot7, slot8 in ipairs(slot0.regularData) do
		slot9 = MatrixAffixCfg[slot8]
		slot2 = slot2 + slot9.point
		slot3 = slot3 + slot9.multiple
	end

	for slot7, slot8 in ipairs(slot0.customData) do
		slot9 = MatrixAffixCfg[slot8]
		slot2 = slot2 + slot9.point
		slot3 = slot3 + slot9.multiple
	end

	slot0.m_scoreLab.text = "" .. slot2
	slot0.m_retaLab.text = string.format(GetTips("MATRIX_AFFIX_RATE"), slot3 / 10 .. "%")
end

return slot0
