slot0 = class("MatrixTreasureMiniView", ReduxView)

function slot0.UIBackCount(slot0)
	return 3
end

function slot0.UIName(slot0)
	return "UI/Matrix/Prepare/MatrixTreasureMiniUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, MatrixTreasureAtlasItem)
end

function slot0.OnTop(slot0)
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

function slot0.OnEnter(slot0)
	slot0.data = slot0:GetArtifactList()

	table.sort(slot0.data, function (slot0, slot1)
		if MatrixItemCfg[slot0.id].rare ~= MatrixItemCfg[slot1.id].rare then
			return slot3.rare < slot2.rare
		end

		return slot0.id < slot1.id
	end)
	slot0.list_:StartScroll(#slot0.data)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.data[slot1].id, slot0.data[slot1].wins)
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.GetArtifactList(slot0)
	return MatrixData:GetArtifactList()
end

return slot0
