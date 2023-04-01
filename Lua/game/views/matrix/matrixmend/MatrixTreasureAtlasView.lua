slot0 = class("MatrixTreasureAtlasView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Matrix/Prepare/MatrixTreasureAtlasUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.data = {}

	for slot5, slot6 in ipairs(MatrixItemCfg.get_id_list_by_matrix_item_type[MatrixConst.ITEM_TYPE.TREASURE]) do
		if MatrixItemCfg[slot6].show_altas then
			table.insert(slot0.data, slot6)
		end
	end

	table.sort(slot0.data, function (slot0, slot1)
		if MatrixItemCfg[slot0].rare ~= MatrixItemCfg[slot1].rare then
			return slot3.rare < slot2.rare
		end

		return slot0 < slot1
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, MatrixTreasureAtlasItem)
end

function slot0.OnTop(slot0)
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

function slot0.OnEnter(slot0)
	slot0.list_:StartScroll(#slot0.data)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.data[slot1])
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
