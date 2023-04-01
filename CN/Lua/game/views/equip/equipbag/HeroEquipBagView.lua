slot0 = class("HeroEquipBagView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Equip/HeroEquipBagUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.equipInfoView_ = HeroEquipInfoView.New(slot0, slot0.infoGo_)
	slot0.equipBag_ = EquipBagView.New(slot0, slot0.equipBagGo_, {
		suitPos = slot0.params_.suitPos
	})
	slot0.equipSwapView_ = EquipSwapView.New(slot0, slot0.swapGo_)
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.equipInfoView_

	slot1:RegistCallBack(function (slot0)
		slot1 = 0

		if slot0.prefab_id then
			uv0.equipSwapView_:SetInfoIsShow(true)
			uv0.equipSwapView_:RefreshEquipS(slot0, nil, EquipCfg[slot0.prefab_id].pos)
		else
			slot1 = slot0.pos
		end

		if uv0.params_.suitPos == slot1 and uv0.equipBag_:GetSelectType() ~= "pos" then
			uv0.equipSwapView_:SetInfoIsShow(false)
			uv0:SelectItem(nil, 0)
			uv0.equipBag_:RefreshData(uv0, {
				suitPos = 0
			})
		else
			if slot0.prefab_id then
				uv0.equipSwapView_:SetInfoIsShow(true)
				uv0.equipSwapView_:RefreshEquipS(slot0, nil, slot1)
			end

			uv0:SelectItem(uv0.equipInfoView_:GetItem(slot1), slot1)
			uv0.equipBag_:RefreshData(uv0, {
				suitPos = slot1
			})
		end
	end)
	slot0:AddBtnListenerScale(slot0.unloadAllBtn_, nil, function ()
		slot0 = SettingData:GetRemindSettingData()

		if not _G.SkipTip.SkipUninstallEquipTip and slot0.uninstall_equip_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_ONE_CLICK_UNINSTALL_WARNING"),
				OkCallback = function ()
					_G.SkipTip.SkipUninstallEquipTip = uv0.SkipUninstallEquipTip

					HeroAction.EquipUnloadAll(uv0.params_.heroId)
				end,
				ToggleCallback = function (slot0)
					uv0.SkipUninstallEquipTip = slot0
				end
			})
		else
			HeroAction.EquipUnloadAll(uv0.params_.heroId)
		end
	end)
	slot0:AddBtnListenerScale(slot0.schemeBtn_, nil, function ()
		uv0:Go("/EquipProposal", {
			heroID = uv0.params_.heroId
		})
	end)
	slot0:AddBtnListenerScale(slot0.recommendBtn_, nil, function ()
		PlayerAction.CheckRecommendEquip(uv0.params_.heroId, function ()
			slot0 = nil

			uv0:Go("equipRec", {
				hid = uv0.params_.heroId,
				pageIndex = (not uv0.equipRecPage_ or uv0.equipRecPage_) and (PlayerData:GetPlayerInfo().userLevel < GameDisplayCfg.equip_recommend_user_level.value[1] and 1 or slot2 < slot1[2] and 2 or 3),
				onPageChange = handler(uv0, uv0.OnRecPageChange)
			})
		end)
	end)
end

function slot0.OnRecPageChange(slot0, slot1)
	slot0.equipRecPage_ = slot1
end

function slot0.RefreshHeroEquipS(slot0)
	if slot0.heroInfo_ then
		slot0.equipInfoView_:RefreshData(slot0, slot0.heroInfo_)
	end
end

function slot0.RefreshEquipBag(slot0)
end

function slot0.SelectItem(slot0, slot1, slot2)
	if slot1 == nil then
		slot1 = slot0.equipInfoView_:GetItem(slot2)
	end

	if slot0.lastSelect_ then
		slot0.lastSelect_:ShowSelect(false)
	end

	slot0.lastSelect_ = slot1
	slot3 = {}

	if slot1 then
		slot3 = slot1:GetItemInfo()

		slot1:ShowSelect(true)
	end

	slot0.params_.suitPos = slot2

	slot0.equipBag_:RefreshKey("suitPos", slot2)
end

function slot0.ClickBagItem(slot0, slot1)
	slot2 = slot1.equip_info

	slot0.equipSwapView_:SetInfoIsShow(true)
	slot0:RefreshBagSelectStatus(slot2.equip_id)

	if slot0.heroInfo_.equip[EquipCfg[slot2.prefab_id].pos].equip_id == slot2.equip_id then
		slot0.equipSwapView_:RefreshEquipS(EquipData:GetEquipData(slot4), nil, 3)

		return
	end

	if slot4 and slot4 ~= 0 then
		slot0.equipSwapView_:RefreshEquipS(EquipData:GetEquipData(slot4), slot2)
	else
		slot0.equipSwapView_:RefreshEquipS(nil, slot2)
	end
end

function slot0.RefreshBagSelectStatus(slot0, slot1)
	slot0.equipBag_:RefreshSelectStatus(slot1)
end

function slot0.RefreshEquipLock(slot0, slot1, slot2)
	slot0.equipBag_:RefreshEquipLock(slot1, slot2)
end

function slot0.OnEquipSwap(slot0, slot1, slot2)
	slot0.heroInfo_ = HeroData:GetHeroData(slot0.params_.heroId)

	slot0:RefreshHeroEquipS()

	if isSuccess(slot1.result) then
		if slot2.equip_id == 0 then
			ShowTips("EQUIP_UNBIND")
		else
			ShowTips("EQUIP_BIND")
		end

		slot0.equipSwapView_:SetInfoIsShow(false)
		slot0:RefreshBagSelectStatus(0)
		slot0.equipInfoView_:RefreshItem(slot2.pos)
		slot0.equipBag_:RefreshEquipS()
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnEquipUnloadAll(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		ShowTips("EQUIP_UNBIND")
		slot0:RefreshHeroEquipS()
		slot0.equipBag_:RefreshEquipS()
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnEnter(slot0)
	slot0:ScreenAdapt()

	slot0.heroInfo_ = HeroData:GetHeroData(slot0.params_.heroId)

	if slot0.params_.isClearPos then
		slot0.equipBag_:ClearScrollPos()

		slot0.params_.isClearPos = nil
	end

	slot0.equipInfoView_:OnEnter()

	slot1 = slot0.params_.suitPos == nil or slot0.params_.suitPos == 0

	slot0.equipBag_:OnEnter({
		heroId = slot0.params_.heroId,
		suitPos = slot0.params_.suitPos
	})

	if slot0.params_.suit then
		slot0.equipBag_:SelectSuit(slot0.params_.suit)
	end

	slot0.equipSwapView_:OnEnter()
	slot0:RefreshHeroEquipS()
	slot0.equipSwapView_:RefreshData(slot0, {
		heroId = slot0.params_.heroId
	})

	slot2 = slot0.params_.suitPos

	slot0:SelectItem(nil, slot2)

	if slot0.equipInfoView_:GetItem(slot2) then
		info = slot3:GetItemInfo()

		if info and info.equip_id ~= 0 and slot0.params_.isOpenInfo then
			slot0.equipSwapView_:SetInfoIsShow(true)
			slot0.equipSwapView_:RefreshEquipS(info, nil, slot2, slot1)

			slot0.params_.isOpenInfo = nil
		else
			slot0.equipSwapView_:SetInfoIsShow(false)
			slot0:RefreshBagSelectStatus(0)
		end
	end
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		if uv0.equipBag_ then
			uv0.equipBag_:OnMainHomeViewTop()
		end

		uv0.equipRecPage_ = nil

		uv0:Back()
	end)

	if slot0.params_.needRefresh then
		slot0.equipBag_:RefreshData(slot0, {
			heroId = slot0.params_.heroId,
			suitPos = slot0.params_.suitPos,
			suit = slot0.params_.suit
		})

		if slot0.params_.suit then
			slot0.equipBag_:SelectSuit(slot0.params_.suit, slot0.params_.ids)
		end

		if slot0.params_.suitPos ~= 0 then
			slot0:SelectItem(nil, slot0.params_.suitPos)
		end
	end

	slot0.params_.suit = nil
	slot0.params_.needRefresh = nil
end

function slot0.ScreenAdapt(slot0)
	if slot0.ADAPT_RAITO < _G.SCREEN_WIDTH / _G.SCREEN_HEIGHT then
		slot0.swapGo_.transform.offsetMin = Vector2(slot0.VIEW_ADAPT_DISTANCE, 0)
		slot0.swapGo_.transform.offsetMax = Vector2(-1 * slot0.VIEW_ADAPT_DISTANCE, 0)
	end
end

function slot0.OnEquipLock(slot0, slot1)
	if slot1 then
		ShowTips("ERROR_EQUIP_LOCKED_SUCCESS")
	else
		ShowTips("ERROR_EQUIP_UNLOCKED_SUCCESS")
	end
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetGameHelpKey("EQUIP_EQUIP")
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0.equipInfoView_:OnExit()
	slot0.equipBag_:OnExit()
	slot0.equipSwapView_:OnExit()
	SetActive(slot0.swapGo_, false)
	OperationRecorder.RecordStayView("STAY_VIEW_HERO_EQUIP_BAG", slot0:GetStayTime(), slot0.params_.heroId)
end

function slot0.OnMainHomeViewTop(slot0)
	if slot0.equipBag_ then
		slot0.equipBag_:OnMainHomeViewTop()
	end

	slot0.equipRecPage_ = nil
end

function slot0.Dispose(slot0)
	if slot0.equipInfoView_ then
		slot0.equipInfoView_:Dispose()

		slot0.equipInfoView_ = nil
	end

	if slot0.equipBag_ then
		slot0.equipBag_:Dispose()

		slot0.equipBag_ = nil
	end

	if slot0.equipSwapView_ then
		slot0.equipSwapView_:Dispose()

		slot0.equipSwapView_ = nil
	end

	if slot0.lastSelect_ then
		slot0.lastSelect_:ShowSelect(false)
	end

	uv0.super.Dispose(slot0)
end

return slot0
