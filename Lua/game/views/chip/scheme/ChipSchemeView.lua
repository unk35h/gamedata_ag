slot0 = class("ChipSchemeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Chip/ChipProjectPUIop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.schemeUIList_ = LuaList.New(handler(slot0, slot0.RefreshSchemeItem), slot0.uiList_, slot0:GetChipSchemeItem())
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:SetAsLastSibling()

	slot0.chipManagerID_ = slot0.params_.chipManagerID
	slot0.sortSchemeList_ = slot0:GetSchemeList()

	slot0.schemeUIList_:StartScroll(#slot0.sortSchemeList_, 1)
	slot0:RefreshUI()

	slot0.enabledSchemeHandler_ = handler(slot0, slot0.OnEnabledScheme)

	manager.notify:RegistListener(ENABLED_SCHEME, slot0.enabledSchemeHandler_)

	slot0.deleteSchemeHandler_ = handler(slot0, slot0.OnDeleteScheme)

	manager.notify:RegistListener(DELETE_CHIP_SCHEME, slot0.deleteSchemeHandler_)

	slot0.saveHandler_ = handler(slot0, slot0.OnSaveChipScheme)

	manager.notify:RegistListener(SAVE_CHIP_SCHEME, slot0.saveHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(ENABLED_SCHEME, slot0.enabledSchemeHandler_)

	slot0.enabledSchemeHandler_ = nil

	manager.notify:RemoveListener(DELETE_CHIP_SCHEME, slot0.deleteSchemeHandler_)

	slot0.deleteSchemeHandler_ = nil

	manager.notify:RemoveListener(SAVE_CHIP_SCHEME, slot0.saveHandler_)

	slot0.saveHandler_ = nil
end

function slot0.RefreshSchemeItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.chipManagerID_, slot1, slot0.sortSchemeList_[slot1])
end

function slot0.RefreshUI(slot0)
	slot0.schemeCnt_.text = string.format("%s/%s", table.length(ChipData:GetSchemeList()), GameSetting.ai_chip_proposal_num_max.value[1])
end

function slot0.GetChipSchemeItem(slot0)
	return ChipSchemeItem
end

function slot0.GetSchemeList(slot0)
	return ChipTools.SortScheme(slot0.chipManagerID_)
end

function slot0.OnEnabledScheme(slot0)
	slot0:OnDeleteScheme()
end

function slot0.OnDeleteScheme(slot0)
	slot0.sortSchemeList_ = slot0:GetSchemeList()

	slot0.schemeUIList_:StartScroll(#slot0.sortSchemeList_, 1)
	slot0:RefreshUI()
end

function slot0.OnSaveChipScheme(slot0, slot1)
	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.schemeUIList_ then
		slot0.schemeUIList_:Dispose()

		slot0.schemeUIList_ = nil
	end
end

return slot0
