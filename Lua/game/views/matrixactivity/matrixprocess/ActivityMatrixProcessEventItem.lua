slot0 = class("ActivityMatrixProcessEventItem", MatrixProcessEventItem)

function slot0.Refresh(slot0, slot1, slot2, slot3)
	slot0.id = slot1
	slot0.index = slot2

	if slot0.id and ActivityMatrixEventTemplateCfg[slot0.id] or nil then
		slot5 = slot4.event_type

		slot0.typeController_:SetSelectedIndex(slot5 - 1)

		if (MatrixConst.EVENT_TYPE.CURRENCY == slot5 or MatrixConst.EVENT_TYPE.CURRENCY_ELITE == slot5) and ItemCfg[ActivityMatrixTools.GetCoinItem(slot3)] then
			slot0.m_name.text = slot7.name
		end
	end
end

return slot0
