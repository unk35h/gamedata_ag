slot0 = class("MatrixAffixMiniView", ReduxView)

function slot0.UIBackCount(slot0)
	return 3
end

function slot0.UIName(slot0)
	return "UI/Matrix/Prepare/MatrixAffixMiniUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.customItems = {}
	slot0.regularItems = {}
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
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
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
end

function slot0.OnEnter(slot0)
	slot0.regularData = MatrixData:GetDifficultyData():GetRegularAffix()
	slot0.customData = MatrixData:GetCustomAffix()

	slot0:Refresh()
end

function slot0.OnTop(slot0)
	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot0:RefreshRegularItems(slot0.regularData)
	slot0.stateController_:SetSelectedIndex(#slot0.customData == 0 and 1 or 0)
	slot0:RefreshCustomItems(slot0.customData)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_contentRect)

	slot2 = 0
	slot3 = 0

	for slot7, slot8 in ipairs(slot0.regularData) do
		slot9 = MatrixAffixCfg[slot8]
		slot2 = slot2 + slot9.point
		slot3 = slot3 + slot9.multiple
	end

	for slot7, slot8 in ipairs(slot0.customData) do
		slot9 = MatrixAffixCfg[slot8]
		slot2 = slot2 + slot9.point
		slot3 = slot3 + slot9.multiple
	end

	slot0.m_scoreLab.text = "" .. slot2
	slot0.m_retaLab.text = string.format(GetTips("MATRIX_AFFIX_RATE"), slot3 / 10 .. "%")
end

function slot0.RefreshCustomItems(slot0, slot1)
	for slot6 = 1, #slot1 do
		if not slot0.customItems[slot6] then
			slot0.customItems[slot6] = MatrixAffixItem.New(Object.Instantiate(slot0.m_Item, slot0.m_customContent))
		end

		slot0.customItems[slot6]:Refresh(MatrixAffixCfg[slot1[slot6]].affix, 2)
		slot0.customItems[slot6]:SetActive(true)
	end

	for slot6 = slot2 + 1, #slot0.customItems do
		slot0.customItems[slot6]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_customContent)
end

function slot0.RefreshRegularItems(slot0, slot1)
	for slot6 = 1, #slot1 do
		if not slot0.regularItems[slot6] then
			slot0.regularItems[slot6] = MatrixAffixItem.New(Object.Instantiate(slot0.m_Item, slot0.m_regularContent))
		end

		slot0.regularItems[slot6]:Refresh(MatrixAffixCfg[slot1[slot6]].affix, 2)
		slot0.regularItems[slot6]:SetActive(true)
	end

	for slot6 = slot2 + 1, #slot0.regularItems do
		slot0.regularItems[slot6]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_regularContent)
end

function slot0.IndexAffixWeekItem(slot0, slot1, slot2)
	slot2:Refresh(MatrixAffixCfg[slot0.regularData[slot1]].affix, 2)
end

function slot0.IndexAffixOptionalItem(slot0, slot1, slot2)
	slot2:Refresh(MatrixAffixCfg[slot0.customData[slot1]].affix, 2)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.customItems) do
		slot5:Dispose()
	end

	slot0.customItems = {}

	for slot4, slot5 in ipairs(slot0.regularItems) do
		slot5:Dispose()
	end

	slot0.regularItems = {}

	uv0.super.Dispose(slot0)
end

return slot0
