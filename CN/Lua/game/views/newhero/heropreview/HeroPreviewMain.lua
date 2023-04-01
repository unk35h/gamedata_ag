slot0 = class("HeroPreviewMain", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroPreview/HeroPreviewUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0.dirty_ = true
	slot0.curPageIndex_ = 1
	slot0.pageIndexS_ = {
		astrolabe = 3,
		property = 1,
		skill = 2
	}
	slot0.prefabList_ = {
		"UI/HeroPreview/HeroPreviewPropertyPage_new",
		"UI/Hero/HeroSkillPage",
		"UI/Hero/HeroAstrolabePage"
	}
	slot0.ClassList_ = {
		HeroPreviewPropertyPage,
		NewHeroSkillPage,
		NewHeroAstrolabePage
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
	slot0.emptyController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "empty")
	slot0.pages_ = {}
	slot0.completeScrollHelper_ = LuaList.New(handler(slot0, slot0.LongHeadRenderer), slot0.heroCompleteListGo_, NewHeroHead)
	slot0.curHeadItem_ = NewHeroHead.New(slot0.curHeadItemGo_)

	slot0.curHeadItem_:SetRedPointEnable(false)
	slot0.curHeadItem_:SetSelected(true)
	slot0.curHeadItem_:SetSize("short")

	slot0.heroInfoView_ = HeroPreviewPropertyPage.New(slot0, slot0.infoViewGo_)
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
	slot1 = slot0.heroAvatarView_

	slot1:SetShowInteractive(true)

	slot0.toggles_ = {
		slot0.toggle1_,
		slot0.toggle3_,
		slot0.toggle6_
	}
	slot0.filterView_ = HeroPreviewListFilterView.New(slot0.filterGo_)

	slot0.filterView_:SetListChangeHandler(handler(slot0, slot0.OnListChange))
end

function slot0.OnListChange(slot0, slot1)
	slot0.heroIdList_ = slot1

	slot0.completeScrollHelper_:StartScroll(#slot0.heroIdList_)

	if #slot0.heroIdList_ > 0 then
		slot0.emptyController_:SetSelectedState("false")

		if slot0.params_.isEnter == true then
			-- Nothing
		else
			slot0:SelectHero(slot0.heroIdList_[1])

			if not (slot0.heroIdList_[1] ~= slot0.curHeroId_ and true or false) then
				manager.audio:PlayUIAudioByVoice("hero_change")
			end
		end
	else
		slot0.emptyController_:SetSelectedState("true")
	end
end

function slot0.LongHeadRenderer(slot0, slot1, slot2)
	slot3 = slot0.heroIdList_[slot1]
	slot2.gameObject_.name = tostring(slot3)

	slot2:SetSize("long")
	slot2:SetHeroId(slot3, slot0.extra_)
	slot2:SetRedPointEnable(false)
	slot2:SetSelected(slot2.heroId_ == slot0.curHeroId_)
	slot2:RegisterClickListener(function ()
		uv0:SelectHero(uv1.heroId_)
	end)
end

function slot0.SelectHero(slot0, slot1)
	slot2 = slot1 ~= slot0.curHeroId_ and true or false

	if slot0.curHeroId_ ~= nil and slot0.curHeroId_ ~= slot1 and slot0.curPageIndex_ ~= 1 then
		slot0.waitToPlayInteraction_ = true
	end

	slot0.curHeroId_ = slot1
	slot0.curHeroInfo_ = HeroData:GetHeroList()[slot0.curHeroId_]
	slot5 = slot0.completeScrollHelper_
	slot7 = slot5

	for slot6, slot7 in pairs(slot5.GetItemList(slot7)) do
		slot7:SetSelected(slot7.heroId_ == slot1)
	end

	if slot0.mainPageController_:GetSelectedState() == "detail" then
		slot0:SwitchPage(slot0.curPageIndex_)
	else
		slot0:SwitchPage(1)
	end

	slot0.toggles_[slot0.curPageIndex_].isOn = true

	slot0:UpdateHeroView()

	if slot2 then
		slot0.pages_[slot0.curPageIndex_]:PlayEnterAni()

		if slot0.curPageIndex_ == slot0.pageIndexS_.equip then
			manager.audio:PlayEffect("ui_system", "equip_appear", "")
		elseif slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
			manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
		end
	end
end

function slot0.SwitchToDetail(slot0)
	slot0.mainPageController_:SetSelectedState("detail")
	slot0.curHeadItem_:SetHeroId(slot0.curHeroId_, slot0.extra_)

	slot0.playableDirector_.time = 0

	slot0.playableDirector_:Play()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.detailBtn_, nil, function ()
		uv0:SwitchToDetail()

		uv0.toggles_[1].isOn = true
	end)

	slot5 = nil

	slot0:AddBtnListener(slot0.portraitBtn_, slot5, function ()
		uv0:Go("heroPortrait", {
			heroID = uv0.curHeroId_
		})
	end)

	function slot4(slot0)
		if uv0.mainPageController_:GetSelectedState() == "list" then
			uv0:SelectHero(uv0.curHeroId_)
		else
			uv0:UpdateHeroView()
		end
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
			end
		end)
	end
end

function slot0.SwitchPage(slot0, slot1)
	if slot1 == 1 then
		slot0.heroAvatarView_:SetShowInteractive(true)
	else
		slot0.heroAvatarView_:SetShowInteractive(false)
	end

	if slot0.pages_[slot0.curPageIndex_] then
		slot2:Hide()
	end

	slot3 = slot0.curPageIndex_
	slot0.curPageIndex_ = slot1

	if not slot0.pages_[slot1] then
		if slot0.prefabList_[slot1] and slot0.ClassList_[slot1] then
			slot0.pages_[slot1] = slot0.ClassList_[slot1].New(slot0, Object.Instantiate(Asset.Load(slot0.prefabList_[slot1]), slot0.pageContainer_))

			slot0:CheckPageEnter(slot1)
		end
	else
		slot0.pages_[slot0.curPageIndex_]:Show()
	end

	if slot0.curPageIndex_ == slot0.pageIndexS_.equip then
		manager.audio:PlayEffect("ui_system", "equip_appear", "")
	elseif slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
		manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
	end

	slot0:UpdateAvatarView()

	if slot3 ~= nil and slot3 ~= slot1 and slot1 == 1 and slot0.waitToPlayInteraction_ then
		if slot0.heroAvatarView_ then
			slot0.heroAvatarView_:PlayChangeRoleInteraction()
		end

		slot0.waitToPlayInteraction_ = false
	end
end

function slot0.UpdateAvatarView(slot0)
	if slot0.mainPageController_:GetSelectedState() == "detail" and slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
		slot0.heroAvatarView_:ShowHeroModel(false)

		if slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
			slot0.heroAvatarView_:SetCameraToPage("heroAstrolabe")
		else
			slot0.heroAvatarView_:SwitchCameraToCurrentHero(false)
		end
	else
		slot0.heroAvatarView_:SetSkinId(HeroTools.HeroUsingSkinInfo(slot0.curHeroId_).id)
		slot0.heroAvatarView_:ShowHeroModel(true)
		slot0.heroAvatarView_:SwitchCameraToCurrentHero(false)
	end
end

function slot0.CheckPageEnter(slot0, slot1)
	if not slot0.enteredPage_[slot1] then
		slot0.pages_[slot1]:OnEnter(slot0.extra_)

		slot0.enteredPage_[slot1] = true
	end
end

function slot0.UpdateHeroView(slot0)
	slot4 = slot0.curHeroInfo_

	slot0.heroInfoView_:SetHeroInfo(slot4)
	slot0:UpdateAvatarView()

	for slot4, slot5 in pairs(slot0.pages_) do
		slot5:SetHeroInfo(slot0.curHeroInfo_)
	end

	slot1 = HeroCfg[slot0.curHeroId_].study_stage[1]
end

function slot0.OnTop(slot0)
	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:OnTop()
		end
	end

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnTop()
	end

	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
	if slot0.params_.notShowBar then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			CurrencyConst.CURRENCY_TYPE_GOLD,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	end

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		if uv0.params_.hid == nil and uv0.mainPageController_:GetSelectedState() == "detail" then
			uv0.mainPageController_:SetSelectedState("list")

			if table.indexof(uv0.heroIdList_, uv0.curHeroId_) then
				uv0.completeScrollHelper_:StartScroll(#uv0.heroIdList_, slot0)
			end
		else
			JumpTools:Back()
		end
	end)

	slot1 = manager.windowBar

	slot1:RegistHomeCallBack(function ()
		gameContext:Go("/home", nil, , true)
	end)
end

function slot0.OnBehind(slot0)
	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnBehind()
	end
end

function slot0.OnEnter(slot0)
	slot0.extra_ = {
		isPreview = true
	}
	slot0.enteredPage_ = {}

	if slot0.params_.isEnter then
		if slot0.filterView_ then
			slot0.filterView_:Reset()
		end

		slot0:InitConfig()
	end

	manager.ui:SetMainCamera("hero")

	slot1 = slot0.params_.isEnter

	if slot0.heroAvatarView_ then
		if slot0.params_.isEnter then
			slot0:OnMainHomeViewTop()

			slot0.params_.isEnter = nil
		end

		slot0.heroAvatarView_:OnEnter()
	end

	if slot0.heroInfoView_ then
		slot0.heroInfoView_:OnEnter(slot0.extra_)
	end

	for slot5, slot6 in pairs(slot0.pages_) do
		slot0:CheckPageEnter(slot5)
	end

	if slot0.params_.hid and slot1 then
		slot0:SelectHero(slot0.params_.hid)
		slot0:SwitchToDetail()

		slot0.toggles_[1].isOn = true
	else
		slot0:SelectHero(slot0.lastHeroId_ or slot0.heroIdList_[1])
		slot0.mainPageController_:SetSelectedState(slot0.lastPage_ or "list")
	end
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

	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:OnExit()
		end
	end

	if #slot0.heroIdList_ <= 0 then
		HeroData:ResetSortValue()
		slot0.filterView_:Reset()
	end

	slot0.lastPage_ = slot0.mainPageController_:GetSelectedState()
	slot0.lastHeroId_ = slot0.curHeroId_
	slot0.curHeroId_ = nil

	if slot0.talkTimer_ then
		slot0.talkTimer_:Stop()

		slot0.talkTimer_ = nil
	end

	HeroTools.StopTalk()
	manager.gc:Collect()
	Resources.UnloadUnusedAssets()
end

function slot0.OnMainHomeViewTop(slot0)
	slot0.lastPage_ = nil
	slot0.lastHeroId_ = nil

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnMainHomeViewTop()
	end
end

function slot0.Dispose(slot0)
	slot0.mainPageController_:RemoveAllListeners()
	slot0:RemoveAllListeners()

	if slot0.filterView_ then
		slot0.filterView_:Dispose()

		slot0.filterView_ = nil
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

function slot0.OnHeroSort(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.filterView_:RefreshSort(slot1, slot2, slot3, slot4, slot5)
end

return slot0
