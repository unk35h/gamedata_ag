slot0 = class("AstrolabeAdjustView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Astrolabe/AstrolabeAdjustUI"
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

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.lockCon_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.infoSGo_ = {}
	slot0.astrolabeMessageView_ = AstrolabeInfoView.New(slot0, slot0.messageGo_)
	slot0.astrolabeUnlockView_ = AstrolabeUnlockView.New(slot0, slot0.unlockGo_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.loadBtn_, nil, function ()
		slot0 = uv0.lastSelectItem_:GetItemInfo()

		if AstrolabeConst.ASTROLABE_MAX_NUM <= uv0.equipNum_ then
			ShowTips("TIP_ASTROLABE_NUM_MAX")

			return
		end

		if not AstrolabeTools.GetLastIsEquiped(slot0.id, slot0.heroId) then
			slot1 = HeroAstrolabeCfg[slot0.id - 1]

			ShowTips(string.format(GetTips("TIP_ASTROLABE_FRONT"), GetI18NText(slot1.suit_name), GetI18NText(slot1.name)))

			return
		end

		AstrolabeAction.AstrolabeEquip(slot0.heroId, slot0.id)
	end)
	slot0:AddBtnListener(slot0.unloadBtn_, nil, function ()
		slot0 = uv0.lastSelectItem_:GetItemInfo()
		slot1 = HeroAstrolabeCfg[slot0.id]

		if AstrolabeTools.GetNextIsEquiped(slot0.id, slot0.heroId) then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("TIP_ASTROLABE_UNINSTALL"),
				OkCallback = function ()
					AstrolabeAction.AstrolabeUnload(uv0.heroId, uv0.id)
				end
			})
		else
			AstrolabeAction.AstrolabeUnload(slot0.heroId, slot0.id)
		end
	end)
	slot0:AddBtnListener(slot0.loadAllBtn_, nil, function ()
		slot0 = uv0.lastSelectItem_:GetItemInfo()

		AstrolabeAction.AstrolabeEquipAll(slot0.heroId, HeroAstrolabeCfg[slot0.id].hero_astrolabe_suit_id)
	end)
	slot0:AddBtnListener(slot0.unloadAllBtn_, nil, function ()
		AstrolabeAction.AstrolabeUnloadAll(uv0.lastSelectItem_:GetItemInfo().heroId)
	end)
end

function slot0.SelectItem(slot0, slot1)
	if slot0.lastSelectItem_ then
		slot0.lastSelectItem_:ShowSelect(false)
	end

	slot2 = slot1:GetItemInfo()

	slot1:ShowSelect(true)
	slot0.astrolabeMessageView_:RefreshUI(slot2, slot0.extra_)

	slot0.lastSelectItem_ = slot1

	slot0:RefreshState(slot2)
end

function slot0.RefreshUI(slot0)
	if slot0.isPolyhedron_ then
		slot0.heroInfo_ = PolyhedronData:GetPolyhedronHeroData(slot0.params_.heroId)
	else
		slot0.heroInfo_ = HeroData:GetHeroData(slot0.params_.heroId)
	end

	SetActive(slot0.resetBtnGo_, slot0:Adjustable())
	slot0:RefreshAstrolabeInfo()
end

function slot0.RefreshAstrolabeInfo(slot0)
	if slot0.heroInfo_ then
		slot0.equipNum_ = #slot0.heroInfo_.using_astrolabe
		slot0.numText_.text = string.format(GetTips("ASTROLABE_NUM_MAX"), slot0.equipNum_, AstrolabeConst.ASTROLABE_MAX_NUM)

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
			slot0.astrolabeInfoView_:ChangeStyle("Default")

			slot0.lastRace_ = slot0.currentRace_
		end

		slot0.astrolabeInfoView_:RefreshUI(slot0.heroInfo_, slot0.params_.extra)
	end
end

function slot0.GetHeroAstrolabeInfoView(slot0)
	return HeroAstrolabeInfoView
end

function slot0.RefreshState(slot0, slot1)
	if not slot0:Adjustable() then
		slot0.stateController_:SetSelectedState("none")

		return
	end

	if slot1.isUnlock then
		slot2 = HeroAstrolabeCfg[slot1.id]

		if slot1.isEquiped then
			slot0.stateController_:SetSelectedState("equip")
		elseif slot2.pos == 3 then
			slot0.stateController_:SetSelectedState("all")
		else
			slot0.stateController_:SetSelectedState("one")
		end

		slot0.lockCon_:SetSelectedState("false")
	else
		slot0.stateController_:SetSelectedState("lock")
		slot0.lockCon_:SetSelectedState("true")
		slot0.astrolabeUnlockView_:RefreshUI(slot1)
	end
end

function slot0.PlayHeroTalk(slot0, slot1)
	if slot0.isTalkCD_ then
		return
	end

	HeroTools.PlayTalk(slot1, "echo")

	slot0.isTalkCD_ = true
	slot0.talkCDTimer_ = Timer.New(function ()
		uv0.isTalkCD_ = false
	end, 10, 1)

	slot0.talkCDTimer_:Start()
end

function slot0.OnAstrolabeUnlock(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		ShowTips("ASTROLABE_UNLOCK")
		slot0:RefreshUI()
		slot0.astrolabeMessageView_:RefreshUI(slot0.lastSelectItem_:GetItemInfo())
		slot0:RefreshState(slot0.lastSelectItem_:GetItemInfo())
		slot0.astrolabeUnlockView_:OnAstrolabeUnlock(slot1, slot2)
		slot0.astrolabeInfoView_:RefreshRedPoint()
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnAstrolabeEquip(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		ShowTips("ASTROLABE_BIND")
		slot0:RefreshUI()
		slot0.astrolabeMessageView_:RefreshUI(slot0.lastSelectItem_:GetItemInfo())
		slot0:RefreshState(slot0.lastSelectItem_:GetItemInfo())
		slot0:PlayHeroTalk(slot0.heroInfo_.id)
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnAstrolabeUnload(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		if slot2.astrolabe_id then
			ShowTips("ASTROLABE_UNBIND")
		else
			ShowTips("ASTROLABE_RESET")
		end

		slot0:RefreshUI()
		slot0.astrolabeMessageView_:RefreshUI(slot0.lastSelectItem_:GetItemInfo())
		slot0:RefreshState(slot0.lastSelectItem_:GetItemInfo())
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnTop(slot0)
	slot0.astrolabeInfoView_:RefreshRedPoint()

	if slot0.lastSelectItem_ and slot0.lastSelectItem_:GetItemInfo() ~= nil and not slot1.isUnlock then
		slot0.astrolabeUnlockView_:RefreshCost()
	end
end

function slot0.OnEnter(slot0)
	slot0.extra_ = slot0.params_.extra
	slot0.isPreview_ = slot0.extra_ and slot0.extra_.isPreview
	slot0.isPolyhedron_ = slot0.extra_ and slot0.extra_.isPolyhedron

	slot0:ShowDefaultBar()
	slot0:RefreshUI()

	if slot0.params_.selectPos and slot1[1] ~= 0 then
		slot0:SelectItem(slot0.astrolabeInfoView_:GetItem(slot1[1], slot1[2]))
	else
		slot0:SelectItem(slot0.astrolabeInfoView_:GetFirstSelectItem())
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.lastSelectItem_ then
		slot0.lastSelectItem_:ShowSelect(false)

		slot0.lastSelectItem_ = nil
	end

	if slot0.astrolabeInfoView_ then
		slot0.astrolabeInfoView_:OnExit()
	end

	slot0.astrolabeMessageView_:OnExit()
	slot0.astrolabeUnlockView_:OnExit()

	if slot0.talkCDTimer_ then
		slot0.talkCDTimer_:Stop()

		slot0.talkCDTimer_ = nil
	end

	slot0.isTalkCD_ = nil
end

function slot0.Adjustable(slot0)
	if slot0.isPreview_ then
		return false
	end

	if slot0.isPolyhedron_ then
		return false
	end

	return true
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.astrolabeInfoView_ then
		slot0.astrolabeInfoView_:Dispose()

		slot0.astrolabeInfoView_ = nil
	end

	slot0.astrolabeMessageView_:Dispose()
	slot0.astrolabeUnlockView_:Dispose()
end

return slot0
