HeroListFilterView = import("game.views.newHero.HeroListFilterView")
slot0 = class("EquipHeroRebuildFilter", HeroListFilterView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroSorter_ = HeroSorter.New()
end

function slot0.AddUIListener(slot0)
end

return slot0
