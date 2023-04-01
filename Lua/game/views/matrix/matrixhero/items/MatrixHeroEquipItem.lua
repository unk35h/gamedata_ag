slot0 = class("MatrixHeroEquipItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.Refresh(slot0, slot1)
	slot0.m_icon.sprite = MatrixTools.GetMatrixItemSprite(slot1)
	slot0.m_nameLab.text = MatrixItemCfg[slot1].name
	slot0.m_desLab.text = MatrixTools.GetMatrixItemDes(slot1)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_content)

	if slot0.m_viewport.rect.height < slot0.m_content.rect.height then
		slot0.m_scroller.enabled = true
	else
		slot0.m_scroller.enabled = false
	end
end

return slot0
