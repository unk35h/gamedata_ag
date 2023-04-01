slot0 = class("RechargeEnterView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Recharge/RechargeEnterUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		JumpTools.GoToSystem("/shop", {
			shopId = 7
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.rechargeBtn_, nil, function ()
		JumpTools.GoToSystem("/rechargeMain", {
			page = 1
		}, ViewConst.SYSTEM_ID.RECHARGE)
	end)
end

function slot0.UpdateBar(slot0)
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
end

function slot0.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.rechargeBtn_.transform, RedPointConst.RECHARGE)
	manager.redPoint:bindUIandKey(slot0.shopBtn_.transform, RedPointConst.SHOP)
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.rechargeBtn_.transform, RedPointConst.RECHARGE)
	manager.redPoint:unbindUIandKey(slot0.shopBtn_.transform, RedPointConst.SHOP)
	manager.windowBar:HideBar()
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
