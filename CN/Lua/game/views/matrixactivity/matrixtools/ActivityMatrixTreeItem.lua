slot0 = class("ActivityMatrixTreeItem", MatrixTreeItem)

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.id = slot2
	slot0.tag = slot1
	slot0.matrix_activity_id = slot3

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1 = ActivityMatrixData:GetHeroData(slot0.matrix_activity_id, slot0.id)
	slot0.m_name.text = HeroCfg[slot0.id].name
	slot0.m_icon.sprite = HeroTools.GetHeadSprite(ActivityMatrixData:GetHeroSkin(slot0.matrix_activity_id, slot0.id))
	slot0.m_filled.fillAmount = slot1:GetHeroMaxHP() == 0 and 0 or slot1:GetHeroHP() / slot4
end

return slot0
