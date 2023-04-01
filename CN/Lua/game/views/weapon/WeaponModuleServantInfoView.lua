slot0 = class("WeaponModuleServantInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Hero/HeroModuleUI/HeroModuleKeyPopUI"
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
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.heroID_ = slot0.params_.heroID
	slot1 = HeroTools.GetHeroSpecServant(slot0.heroID_)
	slot0.nameText1_.text = ItemCfg[slot1].name
	slot0.nameText2_.text = ItemCfg[slot1].name
	slot2, slot3 = nil
	slot4 = WeaponServantCfg[slot1].effect[1]
	slot0.frontDesText_.text = GetCfgDescription(WeaponEffectCfg[slot4].description[1], 1)
	slot0.nextDesText_.text = GetCfgDescription(WeaponEffectCfg[slot4].strengthen_description[2], 1)

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.frontcontentTrans_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.nextcontentTrans_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
