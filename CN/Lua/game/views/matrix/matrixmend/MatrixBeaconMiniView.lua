slot0 = import("game.views.matrix.matrixPrepare.MatrixSelectBeaconItem")
slot1 = class("MatrixTreasureMiniView", ReduxView)

function slot1.UIBackCount(slot0)
	return 3
end

function slot1.UIName(slot0)
	return "UI/Matrix/Prepare/MatrixBeaconMiniUI"
end

function slot1.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot1.Init(slot0)
	slot0:InitUI()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexBeaconItem), slot0.m_list, uv0)
	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot1.OnTop(slot0)
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

function slot1.OnEnter(slot0)
	slot0.beaconData = MatrixData:GetUseBeaconList()
	slot1 = #slot0.beaconData

	slot0.list_:StartScroll(slot1)
	slot0.stateController_:SetSelectedIndex(slot1 == 0 and 1 or 0)
end

function slot1.IndexBeaconItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.beaconData[slot1])
end

function slot1.Dispose(slot0)
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot1
