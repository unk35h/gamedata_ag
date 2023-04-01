slot0 = class("MatrixTreeItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.id = slot2
	slot0.tag = slot1

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1 = MatrixData:GetHeroData(slot0.id)
	slot0.m_name.text = HeroCfg[slot0.id].name
	slot0.m_icon.sprite = HeroTools.GetHeadSprite(MatrixData:GetHeroSkin(slot0.id))
	slot0.m_filled.fillAmount = slot1:GetHeroMaxHP() == 0 and 0 or slot1:GetHeroHP() / slot4
end

function slot0.GetToggle(slot0)
	return slot0.m_toggle
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

return slot0
