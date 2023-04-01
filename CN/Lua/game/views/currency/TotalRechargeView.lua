slot0 = class("TotalRechargeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/TotalRecharge"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.rechargeBtn_, nil, function ()
		JumpTools.GoToSystem("/rechargeMain", {
			page = 5
		}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.RefreshUI(slot0)
	slot1 = CurrencyData:GetCurrencyMap()
	slot0.freeText_.text = slot1[CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE].num
	slot0.paidText_.text = slot1[CurrencyConst.GetPlatformDiamondId()].num
	slot0.totalText_.text = CurrencyData:GetRechargeDiamond()
end

return slot0
