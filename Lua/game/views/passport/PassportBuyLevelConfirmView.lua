slot0 = class("PassportBuyLevelConfirmView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Passport/PassportBuyLevelConfirmUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(GameSetting.battlepass_level_price.value[1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) < uv0.params_.cost then
			JumpTools.OpenPopUp("rechargeDiamondExchange", {
				defaultNum = 0,
				getBaseNum = 1,
				useBaseNum = 1,
				useId = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
				getId = CurrencyConst.CURRENCY_TYPE_DIAMOND
			}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)

			return
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_bp_level_buy = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)
		})
		PassportAction.BuyLevel(uv0.params_.num)
		uv0:Back()

		if uv0.params_.callback then
			slot1()
		end
	end)
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0.costLabel_.text = slot0.params_.cost
	slot0.levelLabel_.text = slot0.params_.level
end

function slot0.OnExit(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
