slot0 = class("AstrolabeAdjustView", ReduxView)

function slot0.UIBackCount(slot0)
	return 3
end

function slot0.UIName(slot0)
	return "UI/MatrixHero/MatrixAstrolabeAdjustUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.overviewBtn_, nil, function ()
		JumpTools.OpenPageByJump("matrixOrigin/matrixMiniHero")
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.infoSGo_ = {}
	slot0.astrolabeMessageView_ = MatrixAstrolabeInfoView.New(slot0, slot0.messageGo_)
end

function slot0.OnTop(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		JumpTools.OpenPageByJump("matrixOrigin/matrixMiniHero")
	end)
end

function slot0.SelectItem(slot0, slot1)
	if slot0.lastSelectItem_ then
		slot0.lastSelectItem_:ShowSelect(false)
	end

	slot1:ShowSelect(true)
	slot0.astrolabeMessageView_:RefreshUI(slot1:GetItemInfo(), slot0.heroInfo_.servantId)

	slot0.lastSelectItem_ = slot1
end

function slot0.RefreshUI(slot0)
	slot1 = slot0:GetHeroData(slot0.params_.heroId)
	slot3 = nil
	slot0.heroInfo_ = (not slot1:GetIsOwnerHero() or GetPracticalData(slot1:GetEntrySnapShot())) and GetVirtualData(slot1:GetStandardId())
	slot0.heroInfo_.using_astrolabe = slot1:GetAstrolabeEffectList()
	slot0.heroInfo_.unlocked_astrolabe = HeroAstrolabeCfg.all
	slot0.heroInfo_.servantId = slot1:GetWeaponServantEffect()

	slot0:RefreshAstrolabeInfo()
end

function slot0.RefreshAstrolabeInfo(slot0)
	if slot0.heroInfo_ then
		slot0.equipNum_ = #slot0.heroInfo_.using_astrolabe

		slot0:RefreshAstrolabeView()
	end
end

function slot0.RefreshAstrolabeView(slot0)
	if slot0.heroInfo_ then
		slot0.currentRace_ = slot0.heroInfo_.id

		if slot0.astrolabeInfoView_ and slot0.lastRace_ and slot0.lastRace_ ~= slot0.currentRace_ then
			SetActive(slot0.infoSGo_[slot0.lastRace_], false)
			slot0.astrolabeInfoView_:Dispose()

			slot0.astrolabeInfoView_ = nil
		end

		if slot0.astrolabeInfoView_ == nil then
			if slot0.infoSGo_[slot0.currentRace_] == nil then
				slot0.infoSGo_[slot0.currentRace_] = Object.Instantiate(Asset.Load("UI/Astrolabe/Race_" .. slot0.currentRace_), slot0.infoTrs_)
			end

			SetActive(slot0.infoSGo_[slot0.currentRace_], true)

			slot0.astrolabeInfoView_ = slot0:GetHeroAstrolabeInfoView().New(slot0, slot0.infoSGo_[slot0.currentRace_])

			slot0.astrolabeInfoView_:RegistCallBack(handler(slot0, slot0.SelectItem))

			slot0.lastRace_ = slot0.currentRace_
		end

		slot0.astrolabeInfoView_:RefreshUI(slot0.heroInfo_)
	end
end

function slot0.GetHeroAstrolabeInfoView(slot0)
	return HeroAstrolabeInfoView
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()

	if slot0.params_.selectPos and slot1[1] ~= 0 then
		slot0:SelectItem(slot0.astrolabeInfoView_:GetItem(slot1[1], slot1[2]))
	else
		slot0:SelectItem(slot0.astrolabeInfoView_:GetFirstSelectItem())
	end
end

function slot0.OnExit(slot0)
	if slot0.lastSelectItem_ then
		slot0.lastSelectItem_:ShowSelect(false)

		slot0.lastSelectItem_ = nil
	end

	if slot0.astrolabeInfoView_ then
		slot0.astrolabeInfoView_:OnExit()
	end

	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.astrolabeInfoView_ then
		slot0.astrolabeInfoView_:Dispose()

		slot0.astrolabeInfoView_ = nil
	end

	if slot0.astrolabeMessageView_ then
		slot0.astrolabeMessageView_:Dispose()

		slot0.astrolabeMessageView_ = nil
	end
end

function slot0.GetHeroData(slot0, slot1)
	return MatrixData:GetHeroData(slot1)
end

return slot0
