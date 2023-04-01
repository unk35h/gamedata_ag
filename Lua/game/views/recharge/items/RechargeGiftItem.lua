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
	slot0.haveTimeLimitController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "haveTimeLimit")
	slot0.costTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "costType")
	slot0.tipController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "tip")
	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		SendMessageManagerToSDK("purchase_click_gp_once")

		if uv0.statusController_:GetSelectedState() == "normal" then
			JumpTools.OpenPageByJump("rechargeGiftPop", {
				goodId = uv0.goodId_,
				buyTime = uv0.buyTime_,
				itemCfg = uv0.itemCfg_,
				shopId = uv0.shopId_,
				shopCfg = uv0.goodCfg_
			})
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_giftbox = uv0.goodId_
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.shopId_ = slot2
	slot0.goodId_ = slot3
	slot0.goodCfg_ = getShopCfg(slot3)
	slot0.shopCfg_ = ShopListCfg[slot0.goodCfg_.shop_id]
	slot0.itemCfg_ = ItemCfg[slot0.goodCfg_.give_id]
	slot0.buyTime_ = ShopData.GetShop(slot2)[slot3] ~= nil and ShopData.GetShop(slot2)[slot3].buy_times or 0

	slot0:UpdateView()
	slot0:UpdateTimer()
end

function slot0.UpdateTimer(slot0)
	if #slot0.goodCfg_.close_time > 0 then
		slot0.haveTimeLimitController_:SetSelectedState("true")

		if TimeMgr.GetInstance():parseTimeFromConfig(slot0.goodCfg_.close_time) <= TimeMgr.GetInstance():GetServerTime() then
			slot0.lastTimeLabel_.text = GetTips("TIP_EXPIRED")

			if slot0.outOfDateHandler_ ~= nil then
				slot0.outOfDateHandler_(slot0.goodId_)
			end
		else
			slot0.lastTimeLabel_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:GetLostTimeStr(slot2))
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.countdownTransform_)
	else
		slot0.haveTimeLimitController_:SetSelectedState("false")

		slot0.lastTimeLabel_.text = ""
	end

	slot1, slot2, slot3 = ShopTools.IsOnDiscountArea(slot0.goodCfg_.goods_id)

	if slot2 and slot3 and slot1 then
		slot0.isOnDiscountAreaController_:SetSelectedState("true")

		if TimeMgr.GetInstance():parseTimeFromConfig(slot0.goodCfg_.cheap_close_time) <= TimeMgr.GetInstance():GetServerTime() then
			slot0.discountLastTimeLabel_.text = "0" .. GetTips("SECOND")
		else
			slot0.discountLastTimeLabel_.text = string.format("%s", manager.time:GetLostTimeStr(slot5))
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.discountTransform_)
	else
		slot0.isOnDiscountAreaController_:SetSelectedState("false")

		slot0.discountLastTimeLabel_.text = ""
	end

	slot0:UpdatePrice()
end

function slot0.SetOutOfDateHandler(slot0, slot1)
	slot0.outOfDateHandler_ = slot1
end

function slot0.UpdateView(slot0)
	slot0.nameLabel_.text = string.format("%s", slot0.itemCfg_.name)
	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/PrizeItem/" .. slot0.itemCfg_.icon)
	slot0.limitTitle_.text = ""
	slot1 = false
	slot2 = true
	slot3 = false

	if slot0.goodCfg_.limit_num ~= nil and slot0.goodCfg_.limit_num ~= -1 then
		slot4 = slot0.goodCfg_.limit_num - slot0.buyTime_
		slot0.limitLabel_.text = string.format("%d/%d", slot4, slot0.goodCfg_.limit_num)
		slot0.limitTitle_.text = GetTips(ShopConst.SHOP_LIMIT_TEXT[slot0.goodCfg_.refresh_cycle])

		if slot4 <= 0 then
			slot1 = true
		end
	end

	if #slot0.goodCfg_.level_limit > 0 then
		if slot0.goodCfg_.level_limit[1][1] ~= nil then
			if slot0.goodCfg_.level_limit[1][1] == 1 and PlayerData:GetPlayerInfo().userLevel < slot0.goodCfg_.level_limit[1][2] then
				slot2 = false
			end
		elseif slot0.goodCfg_.level_limit[1].type and slot0.goodCfg_.level_limit[1].type == 1 and PlayerData:GetPlayerInfo().userLevel < slot0.goodCfg_.level_limit[1].num then
			slot2 = false
		end
	end

	slot4, slot5, slot6 = ShopTools.IsOnDiscountArea(slot0.goodCfg_.goods_id)

	if slot4 and slot6 then
		if slot5 then
			slot0.tipController_:SetSelectedState("time_limit_discount")
		else
			slot0.tipController_:SetSelectedState("discount")
		end

		slot0.discountLabel_.text = ShopTools.GetDiscountLabel(slot0.goodCfg_.goods_id)
	elseif slot0.goodCfg_.tag == 1 then
		slot0.tipController_:SetSelectedState("superValue")
	else
		slot0.tipController_:SetSelectedState("none")
	end

	if slot1 then
		slot0.statusController_:SetSelectedState("soldout")
	elseif not slot2 then
		slot0.statusController_:SetSelectedState("locked")

		slot0.lockLabel_.text = string.format(GetTips("PLAYER_LEVEL_UNLOCK_SHOP_GOODS"), slot0.goodCfg_.level_limit[1][2] or slot0.goodCfg_.level_limit[1].num)
	else
		slot0.statusController_:SetSelectedState("normal")
	end

	slot7, slot8, slot9 = ShopTools.GetPrice(slot0.goodCfg_.goods_id)

	if slot7 <= 0 and not slot1 and slot2 then
		slot3 = true
	end

	SetActive(slot0.redPointGo_, slot3 and not OperationData:IsFunctionStoped(slot0.shopCfg_.operation_stop_id))
end

function slot0.UpdatePrice(slot0)
	slot1, slot0.oldPriceLabel_.text, slot3 = ShopTools.GetPrice(slot0.goodCfg_.goods_id)

	if slot1 <= 0 then
		slot0.costTypeController_:SetSelectedState("free")
	elseif ShopTools.IsRMB(slot0.goodCfg_.goods_id) then
		slot0.costTypeController_:SetSelectedState("money")

		slot0.costLabel_.text = slot1
	else
		slot0.costTypeController_:SetSelectedState("currency")

		slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(slot0.goodCfg_.cost_id)

		if slot0:GetHave() < slot1 then
			slot0.costLabel_.text = "<color=#cf5050>" .. slot1 .. "</color>"
		else
			slot0.costLabel_.text = slot1
		end
	end

	if ShopTools.IsOnDiscountArea(slot0.goodCfg_.goods_id) then
		slot0.isDiscountController_:SetSelectedState("true")
	else
		slot0.isDiscountController_:SetSelectedState("false")
	end

	if slot0.goodCfg_.tag == 2 then
		if ShopTools.IsOnDiscountArea(slot0.goodCfg_.goods_id) then
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
	if ItemCfg[slot0.goodCfg_.cost_id].type == ItemConst.ITEM_TYPE.CURRENCY then
		if slot1.cost_id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE then
			return CurrencyData:GetRechargeDiamond()
		end

		return CurrencyData:GetCurrencyNum(slot1.cost_id)
	elseif (slot2.type == ItemConst.ITEM_TYPE.MATERIAL or slot2.type == ItemConst.ITEM_TYPE.PROPS) and MaterialData:GetMaterialList()[slot1.cost_id] then
		return slot3.num
	end

	return 0
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
