slot0 = class("MatrixTreasureAtlasItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.rareController_ = ControllerUtil.GetController(slot0.transform_, "rare")
end

function slot0.Refresh(slot0, slot1, slot2)
	slot3 = MatrixItemCfg[slot1]
	slot0.m_name.text = GetI18NText(slot3.name)
	slot0.m_des.text = MatrixTools.GetMatrixItemDes(slot1)
	slot0.m_icon.sprite = MatrixTools.GetMatrixItemSprite(slot1)

	slot0.rareController_:SetSelectedIndex(slot3.rare)

	if slot2 and MatrixConst.EFFECT_ACTION.AFFIX == MatrixEffectCfg[slot3.params[1]].action then
		slot9 = nil

		if AffixTypeCfg[slot5.params[1]].max_level ~= 1 then
			slot0.m_name.text = GetI18NText(slot3.name) .. "Lv" .. math.min(slot2, slot8.max_level)
		end
	end
end

return slot0
