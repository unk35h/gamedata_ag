slot0 = class("NewHeroView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Hero/HeroUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
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
		"UI/Hero/HeroPropertyPage",
		"UI/Hero/HeroSkillPage",
		"UI/Hero/HeroWeaponPage",
		"UI/Equip/NewHeroEquipPage",
		"UI/Hero/HeroAstrolabePage",
		"UI/Hero/HeroChipUI",
		"UI/Equip/EquipTransitionUI"
	}
	slot0.ClassList_ = {
		NewHeroPropertyPage,
		NewHeroSkillPage,
		NewHeroWeaponPage,
		NewHeroEquipPage,
		NewHeroAstrolabePage,
		NewHeroChipPage,
		NewHeroTransitionPage
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

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitConfig(slot0)
	slot0.filterView_:SetExtraSorter(nil)
	slot0.filterView_:SetHeroIdList(HeroCfg.get_id_list_by_private[0])
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
	slot0.shortScrollHelper_ = LuaList.New(handler(slot0, slot0.ShortHeadRenderer), slot0.heroShortListGo_, NewHeroHead)
	slot0.completeScrollHelper_ = LuaList.New(handler(slot0, slot0.LongHeadRenderer), slot0.heroCompleteListGo_, NewHeroHead)
	slot0.curScrollHelper_ = slot0.shortScrollHelper_
	slot0.heroInfoView_ = NewHeroInfoView.New(slot0, slot0.infoViewGo_)
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

function slot0.OnListChange(slot0, slot1)
	slot0.heroIdList_ = slot1

	if manager.guide:IsPlaying() then
		table.sort(slot0.heroIdList_, function (slot0, slot1)
			if (slot0 == 1148 or slot0 == 1084 or false) ~= (slot1 == 1148 or slot1 == 1084 or false) then
				return slot2
			end
		end)

		slot0.guidePlaying = true
	else
		slot0.guidePlaying = false
	end

	slot0.completeScrollHelper_:StartScroll(#slot0.heroIdList_)

	if #slot0.heroIdList_ > 0 then
		slot0.emptyController_:SetSelectedState("false")

		if not slot0.dirty_ then
			if not slot0.params_.isEnter then
				slot2 = slot0.curHeroId_

				if table.indexof(slot0.heroIdList_, slot0.curHeroId_) then
					slot0:SelectHero(slot0.curHeroId_)

					slot2 = slot0.curHeroId_
				else
					slot0:SelectHero(slot0.heroIdList_[1])

					slot2 = slot0.heroIdList_[1]
				end

				if not (slot2 ~= slot0.curHeroId_ and true or false) then
					manager.audio:PlayUIAudioByVoice("hero_change")
				end
			end
		end
	else
		slot0.emptyController_:SetSelectedState("true")
	end
end

function slot0.ShortHeadRenderer(slot0, slot1, slot2)
	slot3 = slot0.heroIdList_[slot1]
	slot2.gameObject_.name = tostring(slot3)

	slot2:SetSize("short")
	slot2:SetHeroId(slot3, slot0.extra_)
	slot2:SetRedPointEnable(not slot0.extra_)
	slot2:SetSelected(slot2.heroId_ == slot0.curHeroId_)
	slot2:RegisterClickListener(function ()
		uv0:SelectHero(uv1.heroId_)
		OperationRecorder.Record("hero", "selectHero")
	end)
end

function slot0.LongHeadRenderer(slot0, slot1, slot2)
	slot3 = slot0.heroIdList_[slot1]
	slot2.gameObject_.name = tostring(slot3)

	slot2:SetSize("long")
	slot2:SetHeroId(slot3, slot0.extra_)
	slot2:SetRedPointEnable(not slot0.extra_)
	slot2:SetSelected(slot2.heroId_ == slot0.curHeroId_)
	slot2:RegisterClickListener(function ()
		uv0:SelectHero(uv1.heroId_)
		OperationRecorder.Record("hero", "selectHero")
	end)
end

function slot0.GetCurHeroInfo(slot0, slot1)
	return HeroData:GetHeroList()[slot1]
end

function slot0.SelectHero(slot0, slot1)
	slot2 = slot1 ~= slot0.curHeroId_ and true or false

	if slot0.curHeroId_ ~= nil and slot0.curHeroId_ ~= slot1 and slot0.curPageIndex_ ~= 1 then
		slot0.waitToPlayInteraction_ = true
	end

	slot0.curHeroId_ = slot1

	HeroAction.UpdateModuleRedPointByHeroID(slot0.curHeroId_)

	if slot0.extra_ then
		if slot0.isForeign_ then
			slot0.curHeroInfo_ = ForeignInfoData:GetHeroInfo(slot0.curHeroId_)
		elseif slot0.isTemp_ then
			slot0.curHeroInfo_ = TempHeroData:GetHeroDataByHeroID(slot0.extra_.tempHeroList, slot0.curHeroId_)
		elseif slot0.isPolyhedron_ then
			slot0.curHeroInfo_ = PolyhedronData:GetPolyhedronHeroData(slot0.curHeroId_)
		end
	else
		slot0.curHeroInfo_ = slot0:GetCurHeroInfo(slot0.curHeroId_)
	end

	slot5 = slot0.curScrollHelper_
	slot7 = slot5

	for slot6, slot7 in pairs(slot5.GetItemList(slot7)) do
		slot7:SetSelected(slot7.heroId_ == slot1)
	end

	if slot0.curHeroInfo_.unlock == 0 then
		if slot0.curPageIndex_ == slot0.pageIndexS_.chip then
			slot0.toggles_[slot0.curPageIndex_].isOn = false
			slot0.toggles_[1].isOn = true
		end

		slot0:SwitchPage(1)
	elseif slot0.dirty_ then
		if slot0.params_.pageIndex then
			slot0:SwitchPage(slot0.params_.pageIndex)

			slot0.params_.pageIndex = nil
		else
			slot0:SwitchPage(_G.newHeroViewPageIndex_ or 1)
		end

		slot0.dirty_ = false
	else
		slot0:SwitchPage(slot0.curPageIndex_)
	end

	slot0:UpdateHeroView()

	if slot0.curHeroInfo_.unlock == 1 and slot0.mainPageController_:GetSelectedState() == "detail" then
		slot0.toggles_[slot0.curPageIndex_].isOn = true
	end

	slot0.params_.hid = slot1

	if slot2 then
		slot0.pages_[slot0.curPageIndex_]:PlayEnterAni()

		if slot0.mainPageController_:GetSelectedState() == "detail" and slot0.curPageIndex_ == slot0.pageIndexS_.equip then
			manager.audio:PlayEffect("ui_system", "page", "")
		elseif slot3 == "detail" and slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
			manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
		end

		if slot0.curPageIndex_ == slot0.pageIndexS_.chip then
			if slot0.mainPageController_:GetSelectedState() == "list" then
				if ChipData:GetHeroIsHaveChip(slot0.curHeroId_) == false then
					slot0.isChangePageAndBack_ = true
				else
					slot0.isChangePageAndBack_ = false
				end
			elseif ChipData:GetHeroIsHaveChip(slot0.curHeroId_) == false then
				slot0.toggles_[slot0.curPageIndex_].isOn = false

				slot0:SwitchPage(1)

				slot0.toggles_[slot0.curPageIndex_].isOn = true
			end
		end
	end

	slot0:RefreshChipLock()
	slot0:RefreshFavorite()
end

function slot0.SwitchToDetail(slot0)
	if slot0.heroIdList_ and #slot0.heroIdList_ <= 0 then
		slot0.filterView_:RefreshSort(true, 0, {}, {}, {})
	end

	slot0.mainPageController_:SetSelectedState("detail")

	if table.indexof(slot0.heroIdList_, slot0.curHeroId_) then
		slot0.shortScrollHelper_:StartScroll(#slot0.heroIdList_, slot1)
	end

	slot0.playableDirector_.time = 0

	slot0.playableDirector_:Play()

	if slot0.isChangePageAndBack_ then
		slot0.isChangePageAndBack_ = false
		slot0.toggles_[slot0.curPageIndex_].isOn = false

		slot0:SwitchPage(1)

		slot0.toggles_[slot0.curPageIndex_].isOn = true
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.detailBtn_, nil, function ()
		uv0:SwitchToDetail()
	end)
	slot0:AddBtnListener(slot0.allHeroBtn_, nil, function ()
		uv0.mainPageController_:SetSelectedState("list")

		if table.indexof(uv0.heroIdList_, uv0.curHeroId_) then
			uv0.completeScrollHelper_:StartScroll(#uv0.heroIdList_, slot0)
		end
	end)

	slot5 = nil

	slot0:AddBtnListener(slot0.favoriteBtn_, slot5, function ()
		if HeroData:IsFavorite(uv0.curHeroId_) then
			HeroAction.SetFavoriteHeroOff(uv0.curHeroId_)
		else
			HeroAction.SetFavoriteHeroOn(uv0.curHeroId_)
		end
	end)

	function slot4(slot0)
		if uv0.mainPageController_:GetSelectedState() == "detail" then
			uv0.curScrollHelper_ = uv0.shortScrollHelper_
		else
			uv0.curScrollHelper_ = uv0.completeScrollHelper_
		end

		uv0:SelectHero(uv0.curHeroId_)
	end

	slot0.mainPageController_:AddSelectChangeListener(slot4)

	for slot4, slot5 in pairs(slot0.toggles_) do
		slot6 = slot5.onValueChanged

		slot6:AddListener(function (slot0)
			if slot0 then
				uv0:SwitchPage(uv1)

				if uv0.pages_[uv1] then
					uv0.pages_[uv1]:SetHeroInfo(uv0.curHeroInfo_)
				end

				if uv1 == 1 then
					OperationRecorder.Record("hero", "propertyPage")
				elseif uv1 == 2 then
					OperationRecorder.Record("hero", "skillPage")
				elseif uv1 == 3 then
					OperationRecorder.Record("hero", "weaponPage")
				elseif uv1 == 4 then
					OperationRecorder.Record("hero", "equipPage")
				elseif uv1 == 5 then
					OperationRecorder.Record("hero", "astroPage")
				elseif uv1 == 6 then
					OperationRecorder.Record("hero", "chipPage")
				elseif uv1 == 7 then
					OperationRecorder.Record("hero", "transition")
				end
			end
		end)
	end
end

function slot0.SwitchPage(slot0, slot1)
	slot2 = true
	slot3 = ""

	if slot0.pageConditionList_[slot1] then
		slot2, slot3 = slot0.pageConditionList_[slot1]()
	end

	if slot0.extra_ and not slot0.extra_.isPolyhedron then
		slot2 = true
	end

	if not slot2 then
		ShowTips(slot3)

		slot0.toggles_[slot0.curPageIndex_].isOn = true

		return
	end

	if slot0.curPageIndex_ == slot1 and not slot0.dirty_ then
		return
	end

	if slot1 == 1 then
		slot0.heroAvatarView_:SetShowInteractive(true)
	else
		slot0.heroAvatarView_:SetShowInteractive(false)
	end

	if slot0.pages_[slot0.curPageIndex_] then
		slot4:Hide()
	end

	slot5 = slot0.curPageIndex_
	slot0.curPageIndex_ = slot1
	_G.newHeroViewPageIndex_ = slot1

	if not slot0.pages_[slot1] then
		if slot0.prefabList_[slot1] and slot0.ClassList_[slot1] then
			slot0.pages_[slot1] = slot0.ClassList_[slot1].New(slot0, Object.Instantiate(Asset.Load(slot0.prefabList_[slot1]), slot0.pageContainer_))

			slot0:CheckPageEnter(slot1)
		end
	else
		slot0.pages_[slot0.curPageIndex_]:Show()
	end

	if slot0.mainPageController_:GetSelectedState() == "list" or slot0.curHeroInfo_.unlock == 0 then
		for slot9, slot10 in ipairs(slot0.toggles_) do
			slot10.isOn = slot9 == slot0.curPageIndex_
		end
	end

	if slot0.curPageIndex_ == slot0.pageIndexS_.equip then
		manager.audio:PlayEffect("ui_system", "equip_appear", "")
	elseif slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
		manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
	end

	slot0:UpdateAvatarView()

	if not slot0.dirty_ and slot5 ~= nil and slot5 ~= slot1 and slot1 == 1 and slot0.waitToPlayInteraction_ then
		if slot0.heroAvatarView_ then
			slot0.heroAvatarView_:PlayChangeRoleInteraction()
		end

		slot0.waitToPlayInteraction_ = false
	end

	slot0:RecordStay(slot5)
end

function slot0.UpdateAvatarView(slot0)
	if slot0.mainPageController_:GetSelectedState() == "detail" and (slot0.curPageIndex_ == slot0.pageIndexS_.weapon or slot0.curPageIndex_ == slot0.pageIndexS_.equip or slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe or slot0.curPageIndex_ == slot0.pageIndexS_.transition) then
		slot0.heroAvatarView_:ShowHeroModel(false)

		if slot0.curPageIndex_ == slot0.pageIndexS_.weapon then
			slot0.heroAvatarView_:SetCameraToPage("heroWeapon")
		elseif slot0.curPageIndex_ == slot0.pageIndexS_.equip then
			slot0.heroAvatarView_:SetCameraToPage("heroEquip")
		elseif slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
			slot0.heroAvatarView_:SetCameraToPage("heroAstrolabe")
		elseif slot0.curPageIndex_ == slot0.pageIndexS_.transition then
			slot0.heroAvatarView_:SetCameraToPage("transition")
		else
			slot0.heroAvatarView_:SwitchCameraToCurrentHero(false)
		end
	else
		if slot0.extra_ then
			if slot0.isForeign_ then
				slot0.heroAvatarView_:SetSkinId(ForeignInfoData:HeroUsingSkinInfo(slot0.curHeroId_).id)
			elseif slot0.isTemp_ then
				slot0.heroAvatarView_:SetSkinId(TempHeroData:HeroUsingSkinInfo(slot0.extra_.tempHeroList, slot0.curHeroId_).id)
			elseif slot0.isPolyhedron_ then
				slot0.heroAvatarView_:SetSkinId(HeroStandardSystemCfg[PolyhedronHeroCfg[slot0.curHeroId_].standard_id].skin_id)
			end
		else
			slot0.heroAvatarView_:SetSkinId(HeroTools.HeroUsingSkinInfo(slot0.curHeroId_).id)
		end

		slot0.heroAvatarView_:ShowHeroModel(true)
		slot0.heroAvatarView_:SwitchCameraToCurrentHero(false)
	end

	if slot1 == "detail" and (slot0.curPageIndex_ == slot0.pageIndexS_.equip or slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe) then
		slot0.weaponAvatarView_:ShowWeaponModel(false)
	elseif slot1 == "detail" and slot0.curPageIndex_ == slot0.pageIndexS_.weapon then
		slot2 = nil

		if slot0.extra_ then
			if slot0.isForeign_ then
				slot2 = ForeignInfoData:HeroUsingSkinInfo(slot0.curHeroId_).id
			elseif slot0.isTemp_ then
				slot2 = TempHeroData:HeroUsingSkinInfo(slot0.extra_.tempHeroList, slot0.curHeroId_).id
			elseif slot0.isPolyhedron_ then
				slot2 = HeroTools.HeroUsingSkinInfo(slot0.curHeroId_).id
			end
		else
			slot2 = HeroTools.HeroUsingSkinInfo(slot0.curHeroId_).id
		end

		slot0.weaponAvatarView_:SetWeaponID(slot2)
		slot0.weaponAvatarView_:ShowWeaponModel(true)
	else
		slot0.weaponAvatarView_:ShowWeaponModel(false)
	end
end

function slot0.CheckPageEnter(slot0, slot1)
	if not slot0.enteredPage_[slot1] then
		slot0.pages_[slot1]:OnEnter(slot0.extra_)

		slot0.enteredPage_[slot1] = true
	end
end

function slot0.UpdateHeroView(slot0)
	slot0.heroInfoView_:SetHeroInfo(slot0.curHeroInfo_)
	slot0:UpdateAvatarView()
	slot0.unlockController_:SetSelectedState(slot0.curHeroInfo_.unlock == 1 and "true" or "false")

	for slot4, slot5 in pairs(slot0.pages_) do
		slot5:SetHeroInfo(slot0.curHeroInfo_)
	end

	SetActive(slot0.redPoint3Go_, BattleTeachData:GetHeroTeachInfo(slot0.curHeroId_, HeroCfg[slot0.curHeroId_].study_stage[1]) <= 0 and not slot0.extra_)
	SetActive(slot0.redPoint6Go_, AstrolabeTools.GetIsHaveCanUnlock(slot0.curHeroInfo_.id) and not slot0.extra_)

	if not slot0.extra_ then
		manager.redPoint:bindUIandKey(slot0.propertyNoticePos_, RedPointConst.HERO_PROPERTY_PAGE .. slot0.curHeroInfo_.id, {
			x = 0,
			y = 0
		})
		manager.redPoint:bindUIandKey(slot0.toggle4_.transform, RedPointConst.HERO_WEAPON .. slot0.curHeroInfo_.id)
	else
		SetActive(slot0.redPoint4Go_, false)
	end
end

function slot0.OnTop(slot0)
	SetActive(slot0.redPoint6Go_, AstrolabeTools.GetIsHaveCanUnlock(slot0.curHeroInfo_.id) and not slot0.extra_)

	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:OnTop()
		end
	end

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnTop()
	end

	slot1 = {
		BACK_BAR,
		HOME_BAR
	}

	if not slot0.extra_ then
		table.insert(slot1, INFO_BAR)
	end

	if slot0.params_.notShowBar then
		manager.windowBar:SwitchBar(slot1)
	else
		table.insert(slot1, CurrencyConst.CURRENCY_TYPE_VITALITY)
		table.insert(slot1, CurrencyConst.CURRENCY_TYPE_GOLD)
		table.insert(slot1, CurrencyConst.CURRENCY_TYPE_DIAMOND)
		manager.windowBar:SwitchBar(slot1)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	end

	if not slot0.extra_ then
		manager.windowBar:SetGameHelpKey({
			view = "gameHelpPro",
			type = "jump",
			params = {
				pages = {
					"Textures/ChapterPaint/chapter/hero_courses_01",
					"Textures/ChapterPaint/chapter/hero_courses_02",
					"Textures/ChapterPaint/chapter/hero_courses_03",
					"Textures/ChapterPaint/chapter/hero_courses_04",
					"Textures/ChapterPaint/chapter/hero_courses_05"
				}
			}
		})
		ChipAction:UpdateChipRed()
		HeroAction.UpdateModuleRedPointByHeroID(slot0.curHeroId_)
	end

	manager.windowBar:RegistBackCallBack(function ()
		if uv0.mainPageController_:GetSelectedState() == "list" then
			uv0:SwitchToDetail()
		else
			JumpTools:Back()
		end
	end)

	if manager.windowBar:GetWhereTag() ~= "guildActivity" and slot2 ~= "chess" then
		slot3 = manager.windowBar

		slot3:RegistHomeCallBack(function ()
			gameContext:Go("/home", nil, , true)
		end)
	end

	if slot0.params_.nextJump ~= nil then
		slot0:HandleNextJump(slot0.params_.nextJump)

		slot0.params_.nextJump = nil
	end
end

function slot0.OnBehind(slot0)
	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnBehind()
	end
end

function slot0.OnEnter(slot0)
	slot0.isForeign_ = slot0.params_.isForeign
	slot0.isTemp_ = slot0.params_.isTemp

	if slot0.isForeign_ or slot0.isTemp_ or slot0.isPolyhedron_ then
		slot0.extra_ = {
			isForeign = slot0.isForeign_,
			isTemp = slot0.isTemp_,
			tempHeroList = slot0.params_.tempHeroList,
			isPolyhedron = slot0.isPolyhedron_
		}
	else
		slot0.extra_ = nil
	end

	slot0.enteredPage_ = {}

	if slot0.params_.pageIndex then
		slot0.dirty_ = true
	end

	if slot0.extra_ then
		if slot0.filterView_ then
			slot0.filterView_:Reset()
		end

		if slot0.isForeign_ then
			slot0:InitForeignHero()
		elseif slot0.isTemp_ then
			slot0.filterView_:SetExtraSorter(nil)

			if slot0.params_.hid and table.indexof(slot0.extra_.tempHeroList, slot0.params_.hid) then
				slot0.params_.hid = SkinCfg[HeroStandardSystemCfg[slot1].hero_id].hero
			end

			slot0:InitTempHero()
		elseif slot0.isPolyhedron_ then
			slot0:InitPolyhedronHero()
		end
	elseif slot0.dirty_ or slot0.params_.isEnter or slot0.guidePlaying then
		if slot0.filterView_ then
			slot0.filterView_:Reset()
		end

		slot0:InitConfig()
	end

	slot0.isSelfController_:SetSelectedState(slot0.extra_ and "true" or "false")
	SetActive(slot0.detailBtn_.gameObject, not slot0.isForeign_)
	manager.ui:SetMainCamera("hero")

	slot1 = 1

	if slot0.heroInfoView_ then
		slot0.heroInfoView_:OnEnter(slot0.extra_)
	end

	if slot0.heroAvatarView_ then
		if slot0.params_.isEnter then
			slot0:OnMainHomeViewTop()

			slot0.params_.isEnter = nil
		end

		slot0.heroAvatarView_:OnEnter()
	end

	if slot0.weaponAvatarView_ then
		slot0.weaponAvatarView_:OnEnter(1)
	end

	for slot5, slot6 in pairs(slot0.pages_) do
		slot0:CheckPageEnter(slot5)
	end

	slot2 = #slot0.heroIdList_

	slot0:RegistEventListener(HERO_DATA_MODIFY, handler(slot0, slot0.OnHeroUpdate))
	slot0:RegistEventListener(HERO_PIECE_MODIFY, handler(slot0, slot0.OnHeroUpdate))
	slot0:RegistEventListener(HERO_UNLOCK_SUCCESS, handler(slot0, slot0.OnHeroUnlock))
	slot0:RegistEventListener(HERO_DISPLAY_EXIT, handler(slot0, slot0.OnRefreshHeroScroll))
	slot0:RegistEventListener(FAVORITE_HERO, handler(slot0, slot0.OnHeroFavorite))

	if slot0.params_.hid then
		slot0:SelectHero(slot0.params_.hid)
	else
		slot0:SelectHero(slot0.heroIdList_[1])
	end

	for slot6 = 1, #slot0.heroIdList_ do
		if slot0.curHeroId_ == slot0.heroIdList_[slot6] then
			slot1 = slot6

			break
		end
	end

	slot3 = "detail"

	slot0.mainPageController_:SetSelectedState(slot3)

	if slot0.mainPageController_:GetSelectedState() == slot3 then
		slot0.shortScrollHelper_:StartScroll(slot2, slot1)
	else
		slot0.completeScrollHelper_:StartScroll(slot2, slot1)
	end

	slot0:CheckLocked()
	SetActive(slot0.allHeroBtn_.gameObject, not slot0.isForeign_)
	SetActive(slot0.favoriteBtn_.gameObject, not slot0.extra_)
	slot0:RefreshChipLock()
	ChipAction:UpdateChipRed()
end

function slot0.RefreshFavorite(slot0)
	SetActive(slot0.favoriteBtn_.gameObject, not slot0.extra_)
	slot0.favoriteCon_:SetSelectedState(HeroData:IsFavorite(slot0.curHeroId_) == false and "false" or "true")
end

function slot0.OnHeroFavorite(slot0)
	slot0:RefreshFavorite()
	slot0.curScrollHelper_:Refresh()
end

function slot0.CheckLocked(slot0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_ASTROLABE) and not slot0.extra_ then
		ControllerUtil.GetController(slot0.toggle6_.gameObject.transform, "locked"):SetSelectedState("true")
	else
		ControllerUtil.GetController(slot0.toggle6_.gameObject.transform, "locked"):SetSelectedState("false")
	end

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TRANSITION) and not slot0.extra_ then
		ControllerUtil.GetController(slot0.toggle8_.gameObject.transform, "locked"):SetSelectedState("true")
	else
		ControllerUtil.GetController(slot0.toggle8_.gameObject.transform, "locked"):SetSelectedState("false")
	end
end

function slot0.OnHeroUnlock(slot0, slot1)
	if slot1 == slot0.curHeroId_ then
		HeroTools.StopTalk()

		slot0.curPageIndex_ = 1

		slot0:SelectHero(slot1)
	end
end

function slot0.OnServantLock(slot0, slot1, slot2)
	slot0.pages_[3]:OnServantLock(slot1, slot2)
end

function slot0.OnHeroSkillUpgrade(slot0, slot1, slot2)
	if isSuccess(slot1.result) and slot2.hero_id == slot0.curHeroId_ and slot0.pages_[slot0.pageIndexS_.skill] and slot0.curPageIndex_ == slot0.pageIndexS_.skill then
		slot0.pages_[slot0.pageIndexS_.skill]:OnHeroSkillUpgrade(slot1, slot2)
	end
end

function slot0.OnHeroStarUp(slot0, slot1, slot2)
	if isSuccess(slot1.result) and slot2.id == slot0.curHeroId_ and slot0.pages_[slot0.pageIndexS_.star] and slot0.curPageIndex_ == slot0.pageIndexS_.star then
		slot0.pages_[slot0.pageIndexS_.star]:OnHeroStarUp(slot1, slot2)
	end
end

function slot0.OnHeroUpdate(slot0, slot1)
	slot4 = slot0.shortScrollHelper_
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		if slot6.heroId_ == slot1 then
			slot6:SetHeroData(slot1, slot6.heroDataType_, slot6.extra_)
		end
	end

	slot4 = slot0.completeScrollHelper_
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		if slot6.heroId_ == slot1 then
			slot6:SetHeroData(slot1, slot6.heroDataType_, slot6.extra_)
		end
	end

	if slot1 == slot0.curHeroId_ then
		slot0:UpdateHeroView()
	end
end

function slot0.ConditionOK(slot0)
	return true, ""
end

function slot0.CheckWeaponAvailable(slot0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.WEAPON) then
		return true, ""
	else
		return false, JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.WEAPON, slot1)
	end
end

function slot0.CheckEquipAvailable(slot0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_EQUIP) then
		return true, ""
	else
		return false, JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.HERO_EQUIP, slot1)
	end
end

function slot0.CheckAstrolabeAvailable(slot0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_ASTROLABE) then
		return true, ""
	else
		return false, JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.HERO_ASTROLABE, slot1)
	end
end

function slot0.CheckChipAvailable(slot0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_CHIP) then
		return true, ""
	else
		return false, JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.HERO_CHIP, slot1)
	end
end

function slot0.CheckTransitionAvailable(slot0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TRANSITION) then
		return true, ""
	else
		return false, JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.TRANSITION, slot1)
	end
end

function slot0.OnMainHomeViewTop(slot0)
	slot0.dirty_ = true
	_G.newHeroViewPageIndex_ = 1

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnMainHomeViewTop()
	end
end

function slot0.GetPopContainer(slot0)
	return slot0.pageContainerPop_
end

function slot0.OnExit(slot0)
	slot0.exited_ = true

	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()

	if slot0.heroInfoView_ then
		slot0.heroInfoView_:OnExit()
	end

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnExit()
	end

	if slot0.weaponAvatarView_ then
		slot0.weaponAvatarView_:OnExit()
	end

	if #slot0.heroIdList_ <= 0 then
		HeroData:ResetSortValue()
		slot0.filterView_:Reset()

		if not slot0.extra_ then
			slot0:InitConfig()
		end
	end

	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:OnExit()
		end
	end

	manager.redPoint:unbindUIandKey(slot0.propertyNoticePos_)
	manager.redPoint:unbindUIandKey(slot0.toggle4_.transform)
	manager.redPoint:unbindUIandKey(slot0.chipredpointTrans_)
	slot0:RecordStay(slot0.curPageIndex_)

	slot0.curHeroId_ = nil

	if slot0.talkTimer_ then
		slot0.talkTimer_:Stop()

		slot0.talkTimer_ = nil
	end

	HeroTools.StopTalk()
	manager.gc:Collect()
	Resources.UnloadUnusedAssets()
end

function slot0.Dispose(slot0)
	slot0.mainPageController_:RemoveAllListeners()
	slot0:RemoveAllListeners()

	if slot0.filterView_ then
		slot0.filterView_:Dispose()

		slot0.filterView_ = nil
	end

	if slot0.shortScrollHelper_ then
		slot0.shortScrollHelper_:Dispose()

		slot0.shortScrollHelper_ = nil
	end

	if slot0.completeScrollHelper_ then
		slot0.completeScrollHelper_:Dispose()

		slot0.completeScrollHelper_ = nil
	end

	if slot0.heroInfoView_ then
		slot0.heroInfoView_:Dispose()

		slot0.heroInfoView_ = nil
	end

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:Dispose()

		slot0.heroAvatarView_ = nil
	end

	if slot0.weaponAvatarView_ then
		slot0.weaponAvatarView_:Dispose()

		slot0.weaponAvatarView_ = nil
	end

	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:Dispose()
		end

		slot0.pages_ = nil
	end

	if slot0.toggles_ then
		for slot4, slot5 in pairs(slot0.toggles_) do
			slot5.onValueChanged:RemoveAllListeners()
		end

		slot0.toggles_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.RecordStay(slot0, slot1)
	if slot0:GetStayTime() == 0 then
		return
	end

	slot3 = 0

	if slot1 == slot0.pageIndexS_.property then
		slot3 = 20101
	elseif slot1 == slot0.pageIndexS_.skill then
		slot3 = 20102
	elseif slot1 == slot0.pageIndexS_.weapon then
		slot3 = 20103
	elseif slot1 == slot0.pageIndexS_.equip then
		slot3 = 20104
	elseif slot1 == slot0.pageIndexS_.astrolabe then
		slot3 = 20105
	end

	OperationRecorder.RecordStayView("STAY_VIEW_HERO", slot2, slot0.curHeroId_, slot3)
	slot0:UpdateLastOpenTime()
end

function slot0.InitForeignHero(slot0)
	slot0.filterView_:SetExtraSorter(function (slot0, slot1)
		return true, ForeignInfoData:GetHeroNO(slot0) < ForeignInfoData:GetHeroNO(slot1)
	end)
	slot0.filterView_:SetHeroIdList(ForeignInfoData:GetHeroList(), slot0.extra_)
end

function slot0.InitTempHero(slot0)
	slot0.filterView_:SetHeroIdList(TempHeroData:GetTempHeroList(slot0.params_.tempHeroList), slot0.extra_)
end

function slot0.InitPolyhedronHero(slot0)
	if not slot0.params_.isBack then
		slot0.filterView_:SetExtraSorter(function (slot0, slot1)
			if (not PolyhedronData:GetPolyhedronHeroUnlock(slot0) and 0 or 1) ~= (not PolyhedronData:GetPolyhedronHeroUnlock(slot1) and 0 or 1) then
				return true, slot3 < slot2
			end

			return false, false
		end)
		slot0.filterView_:SetHeroIdList(PolyhedronHeroCfg.get_id_list_by_is_leader[1])
	end
end

function slot0.OnRefreshHeroScroll(slot0)
	if table.indexof(slot0.heroIdList_, slot0.curHeroId_) then
		slot0.shortScrollHelper_:StartScroll(#slot0.heroIdList_, slot1)
	end
end

function slot0.RefreshChipLock(slot0)
	if slot0.isTemp_ then
		SetActive(slot0.redPoint7Go_, false)
		slot0.chipController_:SetSelectedState("nochip")
	elseif slot0.isForeign_ then
		SetActive(slot0.redPoint7Go_, false)

		if ChipData:GetHeroIsHaveChip(slot0.curHeroId_) then
			slot0.chipController_:SetSelectedState("unlockchip")
		else
			slot0.chipController_:SetSelectedState("nochip")
		end
	elseif ChipData:GetHeroIsHaveChip(slot0.curHeroId_) then
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_CHIP) then
			slot0.chipController_:SetSelectedState("lockchip")
		else
			slot0.chipController_:SetSelectedState("unlockchip")
			manager.redPoint:bindUIandKey(slot0.chipredpointTrans_, string.format("%s", slot0.curHeroId_))
		end
	else
		slot0.chipController_:SetSelectedState("nochip")
	end
end

function slot0.OnHeroSort(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.filterView_:RefreshSort(slot1, slot2, slot3, slot4, slot5)
end

function slot0.HandleNextJump(slot0, slot1)
	if slot1[1] == 231 then
		for slot5, slot6 in ipairs(slot0.heroIdList_) do
			if #HeroRecordCfg[HeroTools.GetHeroOntologyID(slot6)].plot_id > 0 then
				table.insert(slot1, slot6)
				slot0:SelectHero(slot6)
				JumpTools.JumpToPage2(slot1)

				return
			end
		end
	else
		table.insert(slot1, slot0.curHeroId_)
		JumpTools.JumpToPage2(slot1)

		return
	end
end

return slot0
