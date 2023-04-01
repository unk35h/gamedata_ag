slot0 = class("MatrixHeroHeadItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index = 0

	slot0:initUI()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.floorController = ControllerUtil.GetController(slot0.m_floorController, "floor")
end

function slot0.Refresh(slot0, slot1)
	if not HeroStandardSystemCfg[slot1] then
		slot0.floorController:SetSelectedIndex(0)

		return
	end

	slot0.floorController:SetSelectedIndex(1)

	slot0.m_icon.sprite = getSpriteViaConfig("HeroLittleIcon", MatrixData:GetHeroSkin(slot2.hero_id))
end

return slot0
