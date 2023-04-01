slot0 = class("matrixBeaconOperateView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Matrix/Prepare/MatrixBeaconOperateUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, MatrixBeaconOperateItem)
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
	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot0.data = MatrixBeaconCfg.all

	table.sort(slot0.data, function (slot0, slot1)
		if MatrixData:GetBeaconIsLock(slot0) == MatrixData:GetBeaconIsLock(slot1) then
			if MatrixTools.GetBeaconIsUnlockCondition(slot0) == MatrixTools.GetBeaconIsUnlockCondition(slot1) then
				return slot0 < slot1
			else
				return slot4
			end
		else
			return slot3
		end
	end)
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

function slot0.OnMatrixUserUpdate(slot0)
	for slot5, slot6 in pairs(slot0.list_:GetItemList()) do
		slot6:UpdateView()
	end
end

return slot0
