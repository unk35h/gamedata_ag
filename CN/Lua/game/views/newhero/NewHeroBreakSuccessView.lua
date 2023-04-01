slot0 = class("NewHeroBreakSuccessView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroPromotion/HeroBreakSuccessUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.propName_.text, slot2, slot0.iconImg_.sprite = SkillTools.GetAttr({
		HeroConst.HERO_ATTRIBUTE.CRITICAL,
		0
	})
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0.heroInfo_ = HeroData:GetHeroList()[slot0.params_.heroId]
	slot0.heroCfg_ = HeroCfg[slot0.params_.heroId]
	slot0.breakCfg_ = HeroTools.GetHeroBreakConfig(slot0.heroCfg_.race, slot0.params_.breakLevel)

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.levelTopText_.text = tostring(slot0.breakCfg_.max_level)
	slot0.fromCritText_.text = string.format("%.2f", slot0.params_.oldCrit / 10) .. (PublicAttrCfg[HeroConst.HERO_ATTRIBUTE.CRITICAL].percent == 1 and "%" or "")
	slot2 = HeroTools.CaculateHeroAttribute(slot0.heroInfo_, EquipTools.CalHeroEquipAttribute(slot0.heroInfo_.equip, slot0.heroInfo_.id))

	HeroTools.CalFinalAttribute(slot2)

	slot0.toCritText_.text = string.format("%.2f", slot2[HeroConst.HERO_ATTRIBUTE.CRITICAL] / 10) .. (PublicAttrCfg[HeroConst.HERO_ATTRIBUTE.CRITICAL].percent == 1 and "%" or "")
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
