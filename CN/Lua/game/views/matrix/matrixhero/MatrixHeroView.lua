slot0 = class("MatrixHeroView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MatrixHero/MatrixHeroUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0.dirty_ = true
	slot0.curPageIndex_ = 1
	slot0.pageIndexS_ = {
		skill = 2,
		property = 1
	}
	slot0.prefabList_ = {
		[1.0] = "UI/MatrixHero/MatrixHeroAttributeUI",
		[2.0] = "UI/Hero/HeroSkillPage"
	}
	slot0.ClassList_ = {
		MatrixHeroAttributePageCom,
		MatrixHeroSkillPageCom
	}
	slot0.pageConditionList_ = {
		handler(slot0, slot0.ConditionOK),
		handler(slot0, slot0.ConditionOK)
	}
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.mainPageController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "mainPage")
	slot0.pages_ = {}
	slot0.shortScrollHelper_ = LuaList.New(handler(slot0, slot0.ShortHeadRenderer), slot0.heroShortListGo_, MatrixHeroHead)
	slot0.completeScrollHelper_ = LuaList.New(handler(slot0, slot0.LongHeadRenderer), slot0.heroCompleteListGo_, MatrixHeroHead)
	slot0.curScrollHelper_ = slot0.shortScrollHelper_
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
	slot1 = slot0.heroAvatarView_

	slot1:SetShowInteractive(true)

	slot0.toggles_ = {
		slot0.toggle1_,
		slot0.toggle2_
	}
	slot0.infoView = MatrixHeroAttributePageCom.New(slot0, slot0.infoViewGo_)
end

function slot0.ShortHeadRenderer(slot0, slot1, slot2)
	slot3 = slot0.heroList_[slot1]
	slot2.gameObject_.name = tostring(slot3)

	slot2:SetSize("short")
	slot2:SetHeroId(slot3)
	slot2:SetSelected(slot3 == slot0.curHeroId_)
	slot2:RegisterClickListener(function ()
		uv0:SelectHero(uv1)
	end)
end

function slot0.LongHeadRenderer(slot0, slot1, slot2)
	slot3 = slot0.heroList_[slot1]
	slot2.gameObject_.name = tostring(slot3)

	slot2:SetSize("long")
	slot2:SetHeroId(slot3)
	slot2:SetSelected(slot3 == slot0.curHeroId_)
	slot2:RegisterClickListener(function ()
		uv0:SelectHero(uv1)
	end)
end

function slot0.SelectHero(slot0, slot1)
	slot2 = slot1 ~= slot0.curHeroId_ and true or false

	if slot0.curHeroId_ ~= nil and slot0.curHeroId_ ~= slot1 and slot0.curPageIndex_ ~= 1 then
		slot0.waitToPlayInteraction_ = true
	end

	slot0.curHeroId_ = slot1
	slot5 = slot0.curScrollHelper_
	slot7 = slot5

	for slot6, slot7 in pairs(slot5.GetItemList(slot7)) do
		slot7:SetSelected(slot7:GetHeroStandardId() == slot1)
	end

	if slot0.dirty_ then
		slot0:SwitchPage(1)

		slot0.dirty_ = false
	else
		slot0:SwitchPage(slot0.curPageIndex_)
	end

	slot0:UpdateHeroView()

	slot0.toggles_[slot0.curPageIndex_].isOn = true
	slot0.params_.hid = slot1

	if slot2 then
		if slot0.pages_[slot0.curPageIndex_] then
			slot0.pages_[slot0.curPageIndex_]:PlayEnterAni()
		end

		if slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
			manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
		end
	end
end

function slot0.SwitchToDetail(slot0)
	slot0.mainPageController_:SetSelectedState("detail")

	if table.indexof(slot0.heroList_, slot0.curHeroId_) then
		slot0.shortScrollHelper_:StartScroll(#slot0.heroList_, slot1)
	end

	slot0.playableDirector_.time = 0

	slot0.playableDirector_:Play()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.detailBtn_, nil, function ()
		uv0:SwitchToDetail()
	end)

	slot5 = nil

	slot0:AddBtnListener(slot0.allHeroBtn_, slot5, function ()
		uv0.mainPageController_:SetSelectedState("list")

		if table.indexof(uv0.heroList_, uv0.curHeroId_) then
			uv0.completeScrollHelper_:StartScroll(#uv0.heroList_, slot0)
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
					uv0.pages_[uv1]:SetMatirxHeroInfo(uv0.curHeroId_)
				end

				print(uv1)
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

	if not slot2 then
		ShowTips(slot3)

		slot0.toggles_[slot0.curPageIndex_].isOn = true

		return
	end

	if slot0.curPageIndex_ == slot1 and not slot0.dirty_ then
		return
	end

	slot0.heroAvatarView_:SetShowInteractive(false)

	if slot0.pages_[slot0.curPageIndex_] then
		slot4:Hide()
	end

	slot5 = slot0.curPageIndex_
	slot0.curPageIndex_ = slot1

	if not slot0.pages_[slot1] then
		if slot0.prefabList_[slot1] and slot0.ClassList_[slot1] then
			slot0.pages_[slot1] = slot0.ClassList_[slot1].New(slot0, Object.Instantiate(Asset.Load(slot0.prefabList_[slot1]), slot0.pageContainer_))

			slot0:CheckPageEnter(slot1)
		end
	else
		slot0.pages_[slot0.curPageIndex_]:Show()
	end

	if slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
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
	if slot0.mainPageController_:GetSelectedState() == "detail" and slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
		slot0.heroAvatarView_:ShowHeroModel(false)

		if slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
			slot0.heroAvatarView_:SetCameraToPage("heroAstrolabe")
		else
			slot0.heroAvatarView_:SwitchCameraToCurrentHero(false)
		end
	else
		slot0.heroAvatarView_:SetSkinId(MatrixData:GetHeroSkin(HeroStandardSystemCfg[slot0.curHeroId_].hero_id))
		slot0.heroAvatarView_:ShowHeroModel(true)
		slot0.heroAvatarView_:SwitchCameraToCurrentHero(false)
	end
end

function slot0.CheckPageEnter(slot0, slot1)
	if not slot0.enteredPage_[slot1] then
		slot0.pages_[slot1]:OnEnter()

		slot0.enteredPage_[slot1] = true
	end
end

function slot0.UpdateHeroView(slot0)
	slot0:UpdateAvatarView()

	for slot4, slot5 in pairs(slot0.pages_) do
		slot5:SetMatirxHeroInfo(slot0.curHeroId_)
	end

	if slot0.mainPageController_:GetSelectedState() == "list" then
		slot0.infoView:SetMatirxHeroInfo(slot0.curHeroId_)
	end
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

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = MatrixConst.MATRIX_GAME_HELP_PAGES
		}
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
end

function slot0.OnBehind(slot0)
	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnBehind()
	end
end

function slot0.OnEnter(slot0)
	slot0.heroList_ = MatrixData:GetReadyHeroList()

	manager.windowBar:RegistBackCallBack(function ()
		if uv0.mainPageController_:GetSelectedState() == "list" then
			uv0:SwitchToDetail()
		else
			JumpTools:Back()
		end
	end)
	manager.ui:SetMainCamera("hero")

	slot0.enteredPage_ = {}
	slot1 = 1

	if slot0.heroAvatarView_ then
		if slot0.params_.isEnter then
			slot0:OnMainHomeViewTop()

			slot0.params_.isEnter = nil
		end

		slot0.heroAvatarView_:OnEnter()
	end

	for slot5, slot6 in pairs(slot0.pages_) do
		slot0:CheckPageEnter(slot5)
	end

	slot2 = #slot0.heroList_

	if slot0.params_.hid then
		slot0:SelectHero(slot0.params_.hid)
	else
		slot0:SelectHero(slot0.heroList_[1])
	end

	for slot6 = 1, #slot0.heroList_ do
		if slot0.curHeroId_ == slot0.heroList_[slot6] then
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
end

function slot0.ConditionOK(slot0)
	return true, ""
end

function slot0.OnMainHomeViewTop(slot0)
	slot0.dirty_ = true

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnMainHomeViewTop()
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnExit()
	end

	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:OnExit()
		end
	end

	slot0.curHeroId_ = nil

	if slot0.talkTimer_ then
		slot0.talkTimer_:Stop()

		slot0.talkTimer_ = nil
	end

	HeroTools.StopTalk()
	slot0:RecordStay(slot0.curPageIndex_)
end

function slot0.Dispose(slot0)
	slot0.mainPageController_:RemoveAllListeners()
	slot0:RemoveAllListeners()

	if slot0.shortScrollHelper_ then
		slot0.shortScrollHelper_:Dispose()

		slot0.shortScrollHelper_ = nil
	end

	if slot0.completeScrollHelper_ then
		slot0.completeScrollHelper_:Dispose()

		slot0.completeScrollHelper_ = nil
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

function slot0.RecordStay(slot0, slot1)
	if slot0:GetStayTime() == 0 then
		return
	end

	slot3 = 0

	if slot1 == slot0.pageIndexS_.skill then
		slot3 = 30106
	elseif slot1 == slot0.pageIndexS_.astrolabe then
		slot3 = 30107
	end

	OperationRecorder.RecordStayView("STAY_VIEW_MATRIX_HERO", slot2, slot3)
	slot0:UpdateLastOpenTime()
end

return slot0
