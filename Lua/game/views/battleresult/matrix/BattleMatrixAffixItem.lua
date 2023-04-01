slot0 = class("BattleMatrixAffixItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.nullController = ControllerUtil.GetController(slot0.transform_, "null")
end

function slot0.SetData(slot0, slot1)
	if slot1 then
		slot0.nullController:SetSelectedIndex(0)

		slot0.m_lab.text = getAffixName(slot1)
		slot0.m_icon.sprite = getAffixSprite(slot1)
	else
		slot0.nullController:SetSelectedIndex(1)

		slot0.m_lab.text = ""
	end
end

return slot0
