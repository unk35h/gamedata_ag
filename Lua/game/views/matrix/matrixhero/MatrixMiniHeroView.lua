slot0 = class("MatrixMiniHeroView", ReduxView)

function slot0.UIBackCount(slot0)
	return 3
end

function slot0.UIName(slot0)
	return "UI/MatrixHero/MatrixMiniHeroUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0.dirty_ = true
	slot0.curPageIndex_ = -1
	slot0.pageIndexS_ = {
		weapon = 3,
		astrolabe = 5,
		skill = 2,
		property = 1,
		equip = 4
	}
	slot0.prefabList_ = {
		"UI/MatrixHero/MatrixHeroAttributeMiniUI",
		"UI/Hero/HeroSkillPage",
		"UI/MatrixHero/MatrixHeroWeaponUI",
		"UI/MatrixHero/MatrixHeroEquipUI",
		"UI/MatrixHero/MatrixHeroAstrolabePage"
	}
	slot0.ClassList_ = {
		MatrixHeroAttributePage,
		MatrixHeroSkillPage,
		MartixHeroWeaponPage,
		MatrixHeroEquipPage,
		MatrixHeroAstrolabePage
	}
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.pages_ = {}
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
	slot1 = slot0.heroAvatarView_

	slot1:SetShowInteractive(true)

	slot0.toggles_ = {
		slot0.toggle1_,
		slot0.toggle2_,
		slot0.toggle3_,
		slot0.toggle4_,
		slot0.toggle5_
	}
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in pairs(slot0.toggles_) do
		slot6 = slot5.onValueChanged

		slot6:AddListener(function (slot0)
			if slot0 then
				uv0:SwitchPage(uv1)

				if uv0.pages_[uv1] then
					uv0.pages_[uv1]:SetMatirxHeroInfo(uv0.curHeroId_)
				end
			end
		end)
	end
end

function slot0.SelectHero(slot0, slot1)
	slot2 = slot1 ~= slot0.curHeroId_ and true or false

	if slot0.curHeroId_ ~= nil and slot0.curHeroId_ ~= slot1 and slot0.curPageIndex_ ~= 1 then
		slot0.waitToPlayInteraction_ = true
	end

	slot0.curHeroId_ = slot1

	if slot0.dirty_ then
		slot0:SwitchPage(1)

		slot0.dirty_ = false
	else
		slot0:SwitchPage(slot0.curPageIndex_)
	end

	slot0:UpdateHeroView()

	slot0.toggles_[slot0.curPageIndex_].isOn = true
	slot0.params_.heroId = slot1

	if slot2 and slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
		manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
	end
end

function slot0.SwitchPage(slot0, slot1)
	if slot0.curPageIndex_ == slot1 and not slot0.dirty_ then
		return
	end

	slot0.heroAvatarView_:SetShowInteractive(false)

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

	if slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
		manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
	end

	slot0:UpdateAvatarView()

	if not slot0.dirty_ and slot3 ~= nil and slot3 ~= slot1 and slot1 == 1 and slot0.waitToPlayInteraction_ then
		if slot0.heroAvatarView_ then
			slot0.heroAvatarView_:PlayChangeRoleInteraction()
		end

		slot0.waitToPlayInteraction_ = false
	end
end

function slot0.UpdateAvatarView(slot0)
	SetActive(slot0.m_weaponIcon.gameObject, false)

	if slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
		slot0.heroAvatarView_:ShowHeroModel(false)

		if slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
			slot0.heroAvatarView_:SetCameraToPage("heroAstrolabe")
		else
			slot0.heroAvatarView_:SwitchCameraToCurrentHero(false)
		end
	elseif slot0.curPageIndex_ == slot0.pageIndexS_.equip then
		slot0.heroAvatarView_:ShowHeroModel(false)
	elseif slot0.curPageIndex_ == slot0.pageIndexS_.weapon then
		slot0.heroAvatarView_:ShowHeroModel(false)

		if slot0:GetHeroData(slot0.curHeroId_):GetWeaponServantEffect() ~= 0 then
			SetActive(slot0.m_weaponIcon.gameObject, true)

			slot0.m_weaponIcon.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/Portrait/" .. slot2)
		end
	else
		slot0.heroAvatarView_:SetSkinId(slot0:GetHeroSkin(slot0.curHeroId_))
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

	slot0:SelectHero(slot0.params_.heroId)

	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})

	slot1 = manager.windowBar

	slot1:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = MatrixConst.MATRIX_GAME_HELP_PAGES
		}
	})

	slot1 = manager.windowBar

	slot1:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, true)

	slot1 = manager.windowBar

	slot1:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)

	slot1 = manager.windowBar

	slot1:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare")
	end)
end

function slot0.OnBehind(slot0)
	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnBehind()
	end
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera("hero")

	slot0.enteredPage_ = {}
	slot1 = 1

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnEnter()
	end

	for slot5, slot6 in pairs(slot0.pages_) do
		slot0:CheckPageEnter(slot5)
	end

	slot0:SelectHero(slot0.params_.heroId)
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
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

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

function slot0.GetHeroData(slot0, slot1)
	return MatrixData:GetHeroData(slot1)
end

function slot0.GetHeroSkin(slot0, slot1)
	return MatrixData:GetHeroSkin(slot1)
end

return slot0
