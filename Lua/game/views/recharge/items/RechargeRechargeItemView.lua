slot0 = class("RechargeRechargeItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:RegistEventListener(RECHARGE_UPDATE, function (slot0)
		if slot0 == uv0.configData_.id then
			uv0:UpdateView()
		end
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.firstController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "first")
	slot0.picController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "pic")
	slot0.firstChargeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "firstCharge")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_recharge_id = uv0.configData_.id
		})
		PayAction.RequestGSPay(uv0.configData_.id, 1)
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.configData_ = slot2
	slot0.serverData_ = slot3

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1 = CurrencyConst.GetPlatformDiamondId()
	slot0.addIcon_.sprite = ItemTools.getItemSprite(slot1)
	slot0.rewardIcon_.sprite = ItemTools.getItemSprite(slot1)
	slot3 = "￥"

	if PaymentCfg[slot0.configData_.id].currency_symbol then
		slot3 = slot2.currency_symbol
	end

	slot0.costLabel_.text = slot3 .. slot2.cost
	slot0.rewardValueLabel_.text = slot0.configData_.charge_num

	slot0.picController_:SetSelectedIndex(slot0.index_ - 1)

	if slot0:IsFirstRecharge() then
		slot0.firstController_:SetSelectedState("true")

		slot0.addValueLabel_.text = slot0.configData_.first_charge

		if slot0.configData_.first_charge > 0 then
			slot0.firstChargeController_:SetSelectedState("true")
		else
			slot0.firstChargeController_:SetSelectedState("false")
		end
	else
		slot0.firstController_:SetSelectedState("false")

		slot0.addValueLabel_.text = slot0.configData_.not_first_charge

		if slot0.configData_.not_first_charge > 0 then
			slot0.firstChargeController_:SetSelectedState("true")
		else
			slot0.firstChargeController_:SetSelectedState("false")
		end
	end
end

function slot0.IsFirstRecharge(slot0)
	return not RechargeData:HaveRecharged(slot0.configData_.id)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
