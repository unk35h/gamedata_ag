slot0 = class("WeaponModuleLevelUpPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Hero/HeroModuleUI/HeroModuleUpgradePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		gameContext:Go("/weaponModuleView", {
			heroID = uv0.heroID_
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.heroID_ = slot0.params_.heroID
	slot0.nameText_.text = WeaponModuleCfg[slot0.heroID_].name
	slot0.levelText_.text = HeroData:GetCurModuleLevel(slot0.heroID_)
	slot0.moduleImage_.sprite = getSpriteWithoutAtlas("Textures/WeaponModule/" .. slot0.heroID_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
