slot1 = class("MatrixHeroHead", import("game.views.newHero.NewHeroHead"))

function slot1.SetHeroId(slot0, slot1)
	slot0.standardId_ = slot1
	slot0.heroId_ = HeroStandardSystemCfg[slot1].hero_id
	slot0.heroCfg_ = HeroCfg[slot0.heroId_]
	slot0.heroInfo_, slot4 = GetVirtualData(slot1)

	slot0:UpdateView()
end

function slot1.GetHeroStandardId(slot0)
	return slot0.standardId_
end

function slot1.UpdateView(slot0)
	slot0.headIcon_.sprite = HeroTools.GetHeadSprite(MatrixData:GetHeroSkin(slot0.heroId_))

	slot0.headIcon_:SetNativeSize()
	slot0.campController_:SetSelectedState(slot0.heroCfg_.race)
	slot0.lockedController_:SetSelectedState("false")

	slot0.levelText_.text = tostring(slot0.heroInfo_.level or 1)

	slot0.gradeController_:SetSelectedState(HeroStarCfg[slot0.heroInfo_.star].star)
end

return slot1
