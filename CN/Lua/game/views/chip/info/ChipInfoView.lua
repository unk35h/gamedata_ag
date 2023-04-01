slot0 = class("ChipInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Chip/ChipInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.chipUIList_ = LuaList.New(handler(slot0, slot0.RefreshChipItem), slot0.uiList_, slot0:GetChipItem())
	slot0.chipLockView_ = ChipLockView.New(slot0.lockPanel_)
	slot0.chipFilterView_ = ChipFilterView.New(slot0.filterPanel_)
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

	slot0.filterID_ = -1
	slot0.sortChipIDList_ = slot0:SortChip()
	slot0.defaultSelectID_ = slot0:GetChipData()[slot0.params_.selectChipIndex] or slot0:GetFirstUnSelectID()

	slot0.chipUIList_:StartScroll(#slot0.sortChipIDList_, 1)
	slot0:RefreshUI()
	slot0.chipFilterView_:OnEnter()

	slot0.unlockChipHandler_ = handler(slot0, slot0.OnUnlockChip)

	manager.notify:RegistListener(UNLOCK_CHIP, slot0.unlockChipHandler_)

	slot0.enabledChipHandler_ = handler(slot0, slot0.OnEnabledChip)

	manager.notify:RegistListener(ENABLED_CHIP, slot0.enabledChipHandler_)

	slot0.clickItemHandler_ = handler(slot0, slot0.OnClickItem)

	manager.notify:RegistListener(ON_CLICK_CHIP_ITEM, slot0.clickItemHandler_)

	slot0.clickFilterItemHandler_ = handler(slot0, slot0.OnClickFilterItem)

	manager.notify:RegistListener(ON_CLICK_CHIP_FILTER, slot0.clickFilterItemHandler_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0.chipFilterView_:OnExit()
	manager.notify:RemoveListener(UNLOCK_CHIP, slot0.unlockChipHandler_)
	manager.notify:RemoveListener(ENABLED_CHIP, slot0.enabledChipHandler_)
	manager.notify:RemoveListener(ON_CLICK_CHIP_ITEM, slot0.clickItemHandler_)
	manager.notify:RemoveListener(ON_CLICK_CHIP_FILTER, slot0.clickFilterItemHandler_)

	slot0.unlockChipHandler_ = nil
	slot0.enabledChipHandler_ = nil
	slot0.clickItemHandler_ = nil
	slot0.clickFilterItemHandler_ = nil
end

function slot0.OnUpdate(slot0)
	slot0.defaultSelectID_ = slot0.params_.selectChipID or slot0.sortChipIDList_[1]

	slot0:OnEnabledChip()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		ChipAction.EnabledChipID(uv0.params_.chipManagerID, uv0.defaultSelectID_)
	end)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		ChipAction.UnlockChip(uv0.defaultSelectID_)
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		ChipAction.ResetChipManager(uv0.params_.chipManagerID)
	end)
	slot0:AddBtnListener(slot0.unloadBtn_, nil, function ()
		ChipAction.EnabledChipID(uv0.params_.chipManagerID, uv0.defaultSelectID_)
	end)
end

function slot0.OnUnlockChip(slot0)
	slot0.sortChipIDList_ = slot0:SortChip()

	slot0:OnEnabledChip()
end

function slot0.OnEnabledChip(slot0)
	slot0:RefreshUI()
	slot0.chipUIList_:Refresh()
end

function slot0.OnClickItem(slot0, slot1)
	slot0:Go("/chipInfo", {
		chipManagerID = slot0.params_.chipManagerID,
		selectChipID = slot1,
		selectChipIndex = slot0.params_.selectChipIndex
	})
end

function slot0.OnClickFilterItem(slot0, slot1)
	slot0.chipFilterView_:OnClickFilterItem(slot1)

	if slot0.filterID_ == slot1 then
		return
	end

	slot0.filterID_ = slot1

	if slot1 == -1 then
		OperationRecorder.Record("ChipInfoView", "allType")
	else
		OperationRecorder.Record("ChipInfoView", "oneType")
	end

	slot0.sortChipIDList_ = slot0:SortChip()

	if slot0.params_.selectChipID and table.keyof(slot0.sortChipIDList_, slot0.params_.selectChipID) then
		slot0.defaultSelectID_ = slot0.params_.selectChipID
	else
		slot0.defaultSelectID_ = slot0:GetFirstUnSelectID()
	end

	if (table.keyof(slot0.sortChipIDList_, slot0.defaultSelectID_) or 1) >= 3 then
		slot2 = slot2 - 3
	end

	slot0.chipUIList_:StartScroll(#slot0.sortChipIDList_, slot2)
	slot0:RefreshUI()
end

function slot0.GetFirstUnSelectID(slot0)
	slot1 = slot0:GetChipData()

	for slot5, slot6 in ipairs(slot0.sortChipIDList_) do
		if not table.keyof(slot1, slot6) then
			return slot6
		end
	end

	return slot0.sortChipIDList_[1]
end

function slot0.RefreshChipItem(slot0, slot1, slot2)
	slot2:SetChipID(slot0.sortChipIDList_[slot1])
	slot2:RefreshUI(slot0.defaultSelectID_, slot0.params_.chipManagerID)
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

	slot2 = false
	slot3 = {}
	slot5 = ""
	slot6 = 1

	for slot10, slot11 in ipairs(slot0:GetChipData()) do
		slot13 = ChipCfg[slot11].spec_char
		slot14 = ChipCfg.get_id_list_by_spec_char[slot13]

		if slot13 ~= 0 and table.keyof(slot14, slot0.defaultSelectID_) and slot11 ~= slot0.defaultSelectID_ then
			for slot18, slot19 in ipairs(slot14) do
				if slot19 ~= slot11 then
					slot2 = true

					if not table.keyof(slot3, slot11) then
						if slot6 > 1 then
							slot5 = slot5 .. "、"
						end

						slot5 = slot5 .. string.format("【%s】", ChipCfg[slot11].suit_name)
						slot6 = slot6 + 1

						table.insert(slot3, slot11)
					end
				end
			end
		end
	end

	if slot2 then
		slot0.prohibitText_.text = string.format(GetTips("CHIP_MUTEX_TEXT"), slot5)
	end

	SetActive(slot0.prohibitPanel_, slot2)

	slot0.isMutex_ = slot2

	if table.keyof(slot0:GetUnlockChipIDList(), slot0.defaultSelectID_) then
		SetActive(slot0.lockPanel_, false)

		if table.keyof(slot0:GetChipData(), slot0.defaultSelectID_) == nil then
			slot0.controller_:SetSelectedState("enable")
		else
			slot0.controller_:SetSelectedState("unload")
		end

		if slot2 then
			slot0.controller_:SetSelectedState("unuse")
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

	slot0.chipFilterView_:Dispose()

	slot0.chipFilterView_ = nil
end

function slot0.GetChipItem(slot0)
	return ChipItem
end

function slot0.GetChipTypeCntList(slot0)
	return ChipTools.GetChipTypeCntList(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP])
end

function slot0.GetChipData(slot0)
	return ChipData:GetChipManagerList()[slot0.params_.chipManagerID]
end

function slot0.SortChip(slot0)
	return ChipTools.SortChip(slot0.chipTypeCntList_[slot0.filterID_], slot0.params_.chipManagerID)
end

function slot0.GetUnlockChipIDList(slot0)
	return ChipData:GetUnlockChipIDList()
end

return slot0
