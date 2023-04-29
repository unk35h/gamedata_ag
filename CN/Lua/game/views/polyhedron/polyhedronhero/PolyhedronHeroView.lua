slot0 = class("PolyhedronHeroView", NewHeroView)

function slot0.UIName(slot0)
	return "UI/PolyhedronHero/PolyhedronHeroUI"
end

function slot0.OnCtor(slot0)
	slot0.dirty_ = true
	slot0.curPageIndex_ = 1
	slot0.isChangePageAndBack_ = false
	slot0.pageIndexS_ = {
		weapon = 3,
		astrolabe = 5,
		skill = 2,
		chip = 6,
		transition = 7,
		property = 1,
		equip = 4
	}
	slot0.prefabList_ = {
		"UI/PolyhedronHero/PolyhedronHeroPropertyPage",
		"UI/Hero/HeroSkillPage",
		"UI/PolyhedronHero/PolyhedronHeroWeaponPage",
		"UI/PolyhedronHero/PolyhedronHeroEquipPage",
		"UI/PolyhedronHero/PolyhedronHeroAstrolabePage",
		"UI/PolyhedronHero/PolyhedronHeroChipUI",
		"UI/PolyhedronHero/PolyhedronEquipTransitionUI"
	}
	slot0.ClassList_ = {
		PolyhedronHeroPropertyPage,
		PolyhedronHeroSkillPage,
		PolyhedronHeroWeaponPage,
		PolyhedronHeroEquipPage,
		PolyhedronHeroAstrolabePage,
		PolyhedronHeroChipPage,
		PolyhedronHeroTransitionPage
	}
	slot0.pageConditionList_ = {
		handler(slot0, slot0.ConditionOK),
		handler(slot0, slot0.ConditionOK),
		handler(slot0, slot0.CheckWeaponAvailable),
		handler(slot0, slot0.CheckEquipAvailable),
		handler(slot0, slot0.CheckAstrolabeAvailable),
		handler(slot0, slot0.CheckChipAvailable),
		handler(slot0, slot0.CheckTransitionAvailable)
	}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.mainPageController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "mainPage")
	slot0.unlockController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "unlock")
	slot0.emptyController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "empty")
	slot0.isSelfController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isSelf")
	slot0.chipController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "chipstatus")
	slot0.favoriteCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "favorite")
	slot0.pages_ = {}
	slot0.shortScrollHelper_ = LuaList.New(handler(slot0, slot0.ShortHeadRenderer), slot0.heroShortListGo_, PolyhedronHeroHead)
	slot0.completeScrollHelper_ = LuaList.New(handler(slot0, slot0.LongHeadRenderer), slot0.heroCompleteListGo_, PolyhedronHeroHead)
	slot0.curScrollHelper_ = slot0.shortScrollHelper_
	slot0.heroInfoView_ = PolyhedronHeroInfoView.New(slot0, slot0.infoViewGo_)
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)

	slot0.heroAvatarView_:SetShowInteractive(true)

	slot0.weaponAvatarView_ = WeaponAvatarView.New(slot0, slot0.displayGo_)

	if slot0.pageContainerPop_ ~= nil then
		slot0.pageContainerPop_.parent = slot0.pageContainer_.parent
	end

	slot0.toggles_ = {
		slot0.toggle1_,
		slot0.toggle3_,
		slot0.toggle4_,
		slot0.toggle5_,
		slot0.toggle6_,
		slot0.toggle7_,
		slot0.toggle8_
	}
	slot0.filterView_ = NewHeroListFilterView.New(slot0.filterGo_)

	slot0.filterView_:SetListChangeHandler(handler(slot0, slot0.OnListChange))
end

function slot0.OnTop(slot0)
	uv0.super.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS, true)
end

function slot0.OnEnter(slot0)
	slot0.isPolyhedron_ = true

	uv0.super.OnEnter(slot0)
end

function slot0.SelectHero(slot0, slot1)
	uv0.super.SelectHero(slot0, slot1)

	slot5 = slot1

	PolyhedronData:SetHeroClicked(slot5)

	slot4 = slot0.curScrollHelper_
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		slot6:SetRedPoint()
	end
end

function slot0.UpdateHeroView(slot0)
	slot0.heroInfoView_:SetHeroInfo(slot0.curHeroInfo_)
	slot0:UpdateAvatarView()
	slot0.unlockController_:SetSelectedState(slot0.curHeroInfo_.unlock == 1 and "true" or "false")

	for slot4, slot5 in pairs(slot0.pages_) do
		slot5:SetHeroInfo(slot0.curHeroInfo_)
	end

	SetActive(slot0.redPoint4Go_, false)
	SetActive(slot0.propertyNoticePos_.gameObject, false)
	SetActive(slot0.toggle4_.transform:Find("notice_img").gameObject, false)
end

function slot0.GetCurHeroInfo(slot0, slot1)
	return GetVirtualData(PolyhedronHeroCfg[slot1].standard_id)
end

function slot0.OnPolyhedronHeroUnlock(slot0)
	slot0.curScrollHelper_:Refresh()
	slot0:SelectHero(slot0.curHeroId_)
end

function slot0.RefreshChipLock(slot0)
	uv0.super.RefreshChipLock(slot0)
	slot0.chipController_:SetSelectedState("nochip")
end

return slot0
