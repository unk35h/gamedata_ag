slot1 = class("PolyhedronTeamHeadItem", import("game.views.heroTeamInfo.HeroTeamHeadItem"))

function slot1.SetHeroData(slot0, slot1, slot2, slot3)
	slot0.extra_ = slot3

	if slot2 == HeroConst.HERO_DATA_TYPE.TRIAL or slot2 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		slot0.trialID_ = slot1
		slot0.heroId_ = HeroStandardSystemCfg[slot1].hero_id
		slot1 = slot0.heroId_
	else
		slot0.heroId_ = slot1
		slot0.trialID_ = 0
	end

	slot0.heroCfg_ = HeroCfg[slot1]
	slot0.heroInfo_ = PolyhedronData:GetPolyhedronHeroData(slot1)
	slot0.heroDataType_ = HeroConst.HERO_DATA_TYPE.POLYHEDRON

	slot0:UpdateView()

	slot4 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS)

	if not PolyhedronData:GetPolyhedronHeroUnlock(slot0.heroId_) and slot0.heroInfo_.unlock == 1 and slot4 > 0 then
		manager.redPoint:SetRedPointIndependent(slot0.noticePos_, true, {
			x = 0,
			y = 0
		})
	else
		manager.redPoint:SetRedPointIndependent(slot0.noticePos_, false)
	end

	slot0.loveCon_:SetSelectedState("off")
end

return slot1
