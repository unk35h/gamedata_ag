slot0 = class("HeroChipView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Chip/ChipInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.curHeroId_ = slot0.params_.HeroId
	slot0.chipUIList_ = LuaList.New(handler(slot0, slot0.RefreshChipItem), slot0.uiList_, slot0:GetChipItem())
	slot0.chipLockView_ = ChipLockView.New(slot0.lockPanel_)
	slot0.chipTypeCntList_ = slot0:GetChipTypeCntList()
	slot0.controller_ = ControllerUtil.GetController(slot0.transformBtnPanel_, "conName")
end

function slot0.OnEnter(slot0)
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

	if slot0.params_.HeroId then
		slot0.curHeroId_ = slot0.params_.HeroId
	end

	slot0.sortChipIDList_ = slot0:SortChip()
	slot0.defaultSelectID_ = slot0.sortChipIDList_[1]

	slot0.chipUIList_:StartScroll(#slot0.sortChipIDList_, 1)
	slot0:RefreshUI()
	SetActive(slot0.goResetBtn_, false)
	SetActive(slot0.filterPanel_, false)
	SetActive(slot0.prohibitPanel_, false)

	slot0.unlockChipHandler_ = handler(slot0, slot0.OnUnlockHeroChip)

	manager.notify:RegistListener(UNLOCK_HEROCHIP, slot0.unlockChipHandler_)

	slot0.enabledChipHandler_ = handler(slot0, slot0.OnEnabledHeroChip)

	manager.notify:RegistListener(ENABLED_HEROCHIP, slot0.enabledChipHandler_)

	slot0.clickItemHandler_ = handler(slot0, slot0.OnClickHeroItem)

	manager.notify:RegistListener(ON_CLICK_HEROCHIP_ITEM, slot0.clickItemHandler_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(UNLOCK_HEROCHIP, slot0.unlockChipHandler_)
	manager.notify:RemoveListener(ENABLED_HEROCHIP, slot0.enabledChipHandler_)
	manager.notify:RemoveListener(ON_CLICK_HEROCHIP_ITEM, slot0.clickItemHandler_)

	slot0.unlockChipHandler_ = nil
	slot0.enabledChipHandler_ = nil
	slot0.clickItemHandler_ = nil
end

function slot0.OnUpdate(slot0)
	slot0.defaultSelectID_ = slot0.params_.selectChipID or slot0.sortChipIDList_[1]

	slot0:OnEnabledHeroChip()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		ChipAction.EnabledHeroChip(uv0.curHeroId_, uv0.defaultSelectID_)
	end)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		ChipAction.UnlockHeroChip(uv0.defaultSelectID_)
	end)
	slot0:AddBtnListener(slot0.unloadBtn_, nil, function ()
		ChipAction.EnabledHeroChip(uv0.curHeroId_, 0)
	end)
end

function slot0.OnUnlockHeroChip(slot0)
	slot0.sortChipIDList_ = slot0:SortChip()

	slot0:OnEnabledHeroChip()
end

function slot0.OnEnabledHeroChip(slot0)
	slot0:RefreshUI()
	slot0.chipUIList_:Refresh()
end

function slot0.OnClickHeroItem(slot0, slot1)
	slot0:Go("/heroChipView", {
		chipManagerID = slot0.params_.chipManagerID,
		selectChipID = slot1,
		selectChipIndex = slot0.params_.selectChipIndex
	})
end

function slot0.RefreshChipItem(slot0, slot1, slot2)
	slot2:SetChipID(slot0.sortChipIDList_[slot1], slot0.curHeroId_)
	slot2:RefreshUI(slot0.defaultSelectID_, slot0.curHeroId_)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshRightInfo()
	slot0.chipLockView_:SetChipID(slot0.defaultSelectID_, slot0.params_.chipManagerID)
end

function slot0.RefreshRightInfo(slot0)
	slot1 = ChipCfg[slot0.defaultSelectID_]
	slot0.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", slot1.picture_id)
	slot0.name_.text = slot1.suit_name
	slot0.effectText_.text = slot1.desc

	if slot1.spec_char ~= 0 then
		slot0.typeText_.text = GetTips("EXCLUSIVE_CHIP")
	else
		slot0.typeText_.text = GetTips("NORMAL_CHIP")
	end

	if table.keyof(slot0:GetUnlockChipIDList(), slot0.defaultSelectID_) then
		SetActive(slot0.lockPanel_, false)

		if ChipData:GetHeroChipIsEquiped(slot0.curHeroId_, slot0.defaultSelectID_) then
			slot0.controller_:SetSelectedState("unload")
		else
			slot0.controller_:SetSelectedState("enable")
		end
	else
		SetActive(slot0.lockPanel_, true)
		slot0.controller_:SetSelectedState("unlock")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.chipUIList_ then
		slot0.chipUIList_:Dispose()

		slot0.chipUIList_ = nil
	end

	slot0.chipLockView_:Dispose()

	slot0.chipLockView_ = nil
end

function slot0.GetChipItem(slot0)
	return HeroChipItem
end

function slot0.GetChipTypeCntList(slot0)
	return ChipData:GetHeroChipsByHeroId(slot0.curHeroId_)
end

function slot0.SortChip(slot0)
	return ChipTools.SortChipList(ChipData:GetCurHeroChip(slot0.curHeroId_), ChipData:GetHeroChipsByHeroId(slot0.curHeroId_), nil, true)
end

function slot0.GetUnlockChipIDList(slot0)
	return ChipData:GetUnlockHeroChipIDList()
end

return slot0
