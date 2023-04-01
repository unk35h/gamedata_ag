slot0 = class("MatrixProcessSelectHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
	slot0:AddUIListener()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_clickBtn, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.heroId)
		end
	end)
end

function slot0.GetHeroId(slot0)
	return slot0.heroId
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0.heroId = slot1
	slot0.m_icon.sprite = getSpriteViaConfig("HeroLittleIcon", slot0:GetHeroSkin(slot1))

	slot0.stateController_:SetSelectedIndex(slot2 and 0 or 1)
end

function slot0.SetSelected(slot0, slot1)
	slot0.selectController_:SetSelectedIndex(slot1 and 1 or 0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.GetHeroSkin(slot0, slot1)
	return MatrixData:GetHeroSkin(slot1)
end

return slot0
