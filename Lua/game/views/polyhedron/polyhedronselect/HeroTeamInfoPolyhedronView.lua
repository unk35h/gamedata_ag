slot1 = class("HeroTeamInfoPolyhedronView", import("game.views.heroTeamInfo.HeroTeamInfoBaseView"))

function slot1.UIName(slot0)
	return "UI/Polyhedron/HeroPolyhedronTeamInfoUI"
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.emptyController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "empty")
	slot0.contorller_ = ControllerUtil.GetController(slot0.joinBtn_.transform, "upgradeBtn")
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
	slot0.heroHeadList_ = LuaList.New(handler(slot0, slot0.HeadRenderer), slot0.uiListGo_, PolyhedronTeamHeadItem)
	slot0.filterView_ = slot0:GetFilterClass().New(slot0.filterGo_)

	slot0.filterView_:SetExtraSorter(handler(slot0, slot0.ExtraSorter))
	slot0.filterView_:SetListChangeHandler(handler(slot0, slot0.OnListChange))
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.m_infoBtn, nil, function ()
		PolyhedronData:SetCacheSelectHero(uv0.selectID_)

		if not table.keyof(uv0:GetCustomHeroList(), uv0.selectTrialID_) then
			slot0 = uv0.trialHeroList_
		end

		uv0:Go("/polyhedronHero", {
			isEnter = true,
			hid = uv0.selectTrialID_ ~= 0 and uv0.selectTrialID_ or uv0.selectID_,
			isTemp = uv0.selectTrialID_ ~= 0 and true or false,
			tempHeroList = slot0
		})
	end)
	slot0:AddBtnListener(slot0.m_okBtn, nil, function ()
		PolyhedronData:SetCacheSelectHero(uv0.selectID_)
		JumpTools.OpenPageByJump("/polyhedronBeacon", {})
	end)
	slot0:AddBtnListener(slot0.m_backBtn, nil, function ()
		uv0:Back()
	end)
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	uv0.super.HeadRenderer(slot0, slot1, slot2)
	slot2.lockedController_:SetSelectedState("false")

	slot2.levelText_.text = HeroStandardSystemCfg[PolyhedronHeroCfg[slot0.heroDataList_[slot1].id].standard_id].hero_lv
end

function slot1.UpdateHeroView(slot0)
	slot1 = slot0.selectID_
	slot2 = HeroCfg[slot1]
	slot0.m_heroName.text = slot2.name
	slot0.m_heroSuffix.text = slot2.suffix

	slot0.heroAvatarView_:SetSkinId(HeroStandardSystemCfg[PolyhedronHeroCfg[slot1].standard_id].skin_id)

	slot0.fightPowerText_.text = getBattlePower(PolyhedronData:GetPolyhedronHeroData(slot1))
end

function slot1.IsInTeam(slot0, slot1, slot2)
	return false, false, -1
end

function slot1.GetHeroTeam(slot0)
	slot0.heroTeam_ = slot0.params_.heroTeam
	slot0.lockStateList_ = {}
	slot0.lockHeroList_ = {}
	slot0.heroTrialList_ = {
		0
	}
end

function slot1.GetDefaultHeroData(slot0)
	if PolyhedronData:GetCacheSelectHero() ~= 0 then
		return slot1, 0
	end

	if (slot0.heroTeam_[slot0.params_.selectHeroPos] or 0) == 0 then
		for slot6, slot7 in pairs(slot0.heroDataList_) do
			if not slot0:IsInTeam(slot7.id) and not table.keyof(slot0.lockHeroList_, slot8) then
				return slot8, 0
			end
		end
	end

	if slot2 == 0 then
		for slot6, slot7 in pairs(slot0.heroDataList_) do
			return slot7.id, 0
		end
	end

	return slot2, 0
end

function slot1.GetHeroList(slot0)
	return PolyhedronData:GetUnlockHeroList()
end

return slot1
