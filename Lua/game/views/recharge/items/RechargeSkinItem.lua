slot0 = class("RechargeGiftItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.isOnDiscountAreaController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isOnDiscountArea")
	slot0.isDiscountController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isDiscount")
	slot0.costTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "costType")
	slot0.tipController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "tip")
	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.isLimitTimeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isLimitTime")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		SendMessageManagerToSDK("purchase_click_skin")
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_skin = uv0.skinCfg_.id
		})
		uv0:Go("/heroSkinPreview", {
			heroID = uv0.skinCfg_.hero,
			skinID = uv0.skinCfg_.id,
			goodId = uv0.goodId_
		})
	end)
	slot0:AddBtnListener(slot0.bottomBtn_, nil, function ()
		if uv0.skinCfg_.id == 104204 then
			uv0:ShowDiscountTip()
		else
			uv0:Go("skinBuyCheck", {
				goodID = uv0.goodId_,
				heroID = uv0.skinCfg_.hero,
				skinID = uv0.skinCfg_.id
			})
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.goodId_ = slot1
	slot0.shopCfg_ = getShopCfg(slot1)
	slot0.skinCfg_ = SkinCfg[ItemCfg[slot0.shopCfg_.give_id].param[1]]
	slot0.heroCfg_ = HeroCfg[slot0.skinCfg_.hero]
	slot0.shopItemList_ = slot2

	slot0:UpdateView()
	slot0:UpdateTimer()
end

function slot0.SetOutOfDateHandler(slot0, slot1)
	slot0.outOfDateHandler_ = slot1
end

function slot0.UpdateTimer(slot0)
	if #slot0.shopCfg_.close_time > 0 then
		slot0.isLimitTimeController_:SetSelectedState("true")

		slot0.lastTimeLabel_.text = TimeMgr.GetInstance():parseTimeFromConfig(slot0.shopCfg_.close_time)

		if TimeMgr.GetInstance():parseTimeFromConfig(slot0.shopCfg_.close_time) <= TimeMgr.GetInstance():GetServerTime() then
			slot0.lastTimeLabel_.text = GetTips("TIP_EXPIRED")

			if slot0.outOfDateHandler_ ~= nil then
				slot0.outOfDateHandler_(slot0.goodId_)
			end
		else
			slot0.lastTimeLabel_.text = string.format("%s", manager.time:GetLostTimeStr(slot2))
		end
	else
		slot0.isLimitTimeController_:SetSelectedState("false")

		slot0.lastTimeLabel_.text = ""
	end

	slot1, slot2, slot3 = ShopTools.IsOnDiscountArea(slot0.shopCfg_.goods_id)

	if slot2 and slot3 and slot1 then
		slot0.isOnDiscountAreaController_:SetSelectedState("true")

		if TimeMgr.GetInstance():parseTimeFromConfig(slot0.shopCfg_.cheap_close_time) <= TimeMgr.GetInstance():GetServerTime() then
			slot0.discountLastTimeLabel_.text = "0" .. GetTips("SECOND")
		else
			slot0.discountLastTimeLabel_.text = string.format("%s", manager.time:GetLostTimeStr(slot5))
		end
	else
		slot0.isOnDiscountAreaController_:SetSelectedState("false")

		slot0.discountLastTimeLabel_.text = ""
	end

	slot0:UpdatePrice()
end

function slot0.UpdateView(slot0)
	slot0.nameLabel_.text = string.format("%s", slot0.skinCfg_.name)
	slot0.titleLabel_.text = ItemCfg[slot0.skinCfg_.hero].name
	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/Character/Icon/" .. slot0.skinCfg_.picture_id)
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(slot0.skinCfg_.id)
	slot2, slot3, slot4 = ShopTools.IsOnDiscountArea(slot0.shopCfg_.goods_id)

	if slot2 and slot4 then
		if slot3 then
			slot0.tipController_:SetSelectedState("time_limit_discount")
		else
			slot0.tipController_:SetSelectedState("discount")
		end
	elseif slot0.shopCfg_.tag == 1 then
		slot0.tipController_:SetSelectedState("superValue")
	else
		slot0.tipController_:SetSelectedState("none")
	end

	slot0:UpdatePrice()

	if ShopTools.HaveSkin(slot0.skinCfg_.id) or HeroTools.CanChangeSkin(slot0.skinCfg_.id) then
		slot0.statusController_:SetSelectedState("sellout")

		slot0.bgBtn_.interactable = false
		slot0.bottomBtn_.interactable = false
	else
		slot0.statusController_:SetSelectedState("normal")

		slot0.bgBtn_.interactable = true
		slot0.bottomBtn_.interactable = true
	end
end

function slot0.UpdatePrice(slot0)
	slot1, slot0.oldPriceLabel_.text, slot3 = slot0:GetPrice()

	if slot0:IsRMB() then
		slot0.costTypeController_:SetSelectedState("money")

		slot0.costLabel_.text = slot1
	else
		slot0.costTypeController_:SetSelectedState("currency")

		slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(slot0.shopCfg_.cost_id)

		if slot0:GetHave() < slot1 then
			slot0.costLabel_.text = "<color=#FF0000>" .. slot1 .. "</color>"
		else
			slot0.costLabel_.text = slot1
		end
	end

	if slot0:IsOnDiscountArea() then
		slot0.isDiscountController_:SetSelectedState("true")
	else
		slot0.isDiscountController_:SetSelectedState("false")
	end

	if slot0.shopCfg_.tag == 2 then
		if slot0:IsOnDiscountArea() then
			slot0.tipController_:SetSelectedState("discount")
		else
			slot0.tipController_:SetSelectedState("none")
		end
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.GetHave(slot0)
	if ItemCfg[slot0.shopCfg_.cost_id].type == ItemConst.ITEM_TYPE.CURRENCY then
		if slot1.cost_id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE then
			return CurrencyData:GetRechargeDiamond()
		end

		return CurrencyData:GetCurrencyNum(slot1.cost_id)
	elseif (slot2.type == ItemConst.ITEM_TYPE.MATERIAL or slot2.type == ItemConst.ITEM_TYPE.PROPS) and MaterialData:GetMaterialList()[slot1.cost_id] then
		return slot3.num
	end

	return 0
end

function slot0.GetPrice(slot0)
	slot1 = 0
	slot2 = 1
	slot3 = nil

	if slot0:IsRMB() then
		slot4 = nil
		slot3 = PaymentCfg[slot0.shopCfg_.cost_id].cost
		slot2 = ((not slot0:IsOnDiscountArea() or PaymentCfg[slot0.shopCfg_.cheap_cost_id]) and PaymentCfg[slot0.shopCfg_.cost_id]).cost == slot3 and 1 or slot1 / slot3
	else
		slot2 = ((not slot0:IsOnDiscountArea() or slot0.shopCfg_.cheap_cost) and slot0.shopCfg_.cost) == slot0.shopCfg_.cost and 1 or slot1 / slot3
	end

	return slot1, slot3, slot2
end

function slot0.IsRMB(slot0)
	return slot0.shopCfg_.cost_type == 1
end

function slot0.IsOnDiscountArea(slot0)
	slot1, slot2, slot3 = ShopTools.IsOnDiscountArea(slot0.shopCfg_.goods_id)

	if slot1 and slot3 then
		return true
	else
		return false
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.ShowDiscountTip(slot0)
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("BUY_TREASURE_SKIN_TIP"),
		BtnText = {
			GetTips("CONTINUE_BUY"),
			GetTips("CONTINUE_BUY"),
			GetTips("GO_UP_TO")
		},
		OkCallback = function ()
			JumpTools.JumpToPage2({
				527
			})
		end,
		CancelCallback = function ()
			uv0:Go("skinBuyCheck", {
				goodID = uv0.goodId_,
				heroID = uv0.skinCfg_.hero,
				skinID = uv0.skinCfg_.id
			})
		end
	})
end

return slot0
