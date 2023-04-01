slot0 = class("RechargeGiftPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Recharge/RechargeGiftPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0.selectNum_ = 1
	slot0.immeRewardItemList_ = {}
	slot0.dailyRewardItemList_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "rewardType")
	slot0.costTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "costType")
	slot0.haveTimeLimitController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "haveTimeLimit")
	slot0.tipController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "tip")
	slot0.rmbController_ = ControllerUtil.GetController(slot0.buyBtn_.transform, "rmb")
	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, RechargeGiftPopItem)
	slot0.useNumTriggerListener_ = slot0.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.itemCfg_.param[slot1][1], slot0.itemCfg_.param[slot1][2] * slot0.shopCfg_.give)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buyBtn_, nil, function ()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_giftbox_buy = uv0.goodId_
		})

		if OperationData:IsFunctionStoped(ShopListCfg[getShopCfg(uv0.goodId_).shop_id].operation_stop_id) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		if ShopTools.IsRMB(uv0.goodId_) then
			slot3 = nil

			PayAction.RequestGSPay(((not uv0:IsOnDiscountArea() or PaymentCfg[uv0.shopCfg_.cheap_cost_id]) and PaymentCfg[uv0.shopCfg_.cost_id]).id, uv0.selectNum_, uv0.shopCfg_.shop_id, uv0.shopCfg_.goods_id)
		else
			if ShopTools.GetPrice(uv0.goodId_) == 0 then
				uv0:Back()
				ShopAction.BuyItem(uv0.goodId_, uv0.selectNum_)

				return
			end

			ShopTools.ConfirmBuyItem(uv0.goodId_, uv0.selectNum_, function (slot0)
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_giftbox_check = 0
				})
				uv0:Back()
			end, function ()
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_giftbox_check = 1
				})
				uv0:UpdateRealtimePrice()
				uv0:UpdatePreview()
			end)
		end
	end)

	slot1 = slot0.useNumSlider_.onValueChanged

	slot1:AddListener(function ()
		uv0.selectNum_ = uv0.useNumSlider_.value

		if uv0.selectNum_ < 1 then
			uv0.selectNum_ = 1

			uv0:UpdateSliderPositionBySelectNum()
		end

		uv0:UpdateDelAddBtn()
		uv0:UpdatePreview()
	end)

	slot1 = slot0.useNumTriggerListener_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:FormatSliderPosition()
		uv0:UpdateDelAddBtn()
		uv0:UpdatePreview()
	end))
	slot0:AddPressingByTimeListener(slot0.delBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum_ > 1 then
			uv0.selectNum_ = uv0.selectNum_ - 1

			uv0:UpdateSliderPositionBySelectNum()
			uv0:UpdateDelAddBtn()
			uv0:UpdatePreview()

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.addBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum_ < uv0.canUseMaxNum_ then
			uv0.selectNum_ = uv0.selectNum_ + 1

			uv0:UpdateSliderPositionBySelectNum()
			uv0:UpdateDelAddBtn()
			uv0:UpdatePreview()

			return true
		end

		return false
	end)
end

function slot0.UpdateDelAddBtn(slot0)
	slot0.delBtn_.interactable = slot0.selectNum_ > 1
	slot0.addBtn_.interactable = slot0.selectNum_ < slot0.canUseMaxNum_
end

function slot0.UpdateSliderPositionBySelectNum(slot0)
	slot0.useNumSlider_.value = slot0.selectNum_
end

function slot0.FormatSliderPosition(slot0)
end

function slot0.UpdateRealtimePrice(slot0)
	slot0.price_, slot0.oldPrice_, slot0.pricePercent_ = ShopTools.GetPrice(slot0.goodId_)
end

function slot0.UpdatePreview(slot0)
	slot0.buyNumLabel_.text = tostring(slot0.selectNum_)

	if slot0.price_ * slot0.selectNum_ <= 0 then
		slot0.costTypeController_:SetSelectedState("free")
		slot0.rmbController_:SetSelectedState("buy")
	elseif ShopTools.IsRMB(slot0.goodId_) then
		slot0.rmbController_:SetSelectedState("rmb")
		slot0.costTypeController_:SetSelectedState("money")

		slot0.moneyCostLabel_.text = slot1
		slot0.rmbLabel_.text = "¥" .. slot1
	else
		slot0.rmbController_:SetSelectedState("buy")
		slot0.costTypeController_:SetSelectedState("currency")

		slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(slot0.shopCfg_.cost_id)

		if slot0:GetHave() < slot1 then
			slot0.totleLabel_.text = "<color=#FF0000>" .. slot1 .. "</color>"
		else
			slot0.totleLabel_.text = slot1
		end
	end
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
	manager.windowBar:SetAsLastSibling()
	slot0:UpdateView()
	slot0:UpdatePreview()
end

function slot0.OnEnter(slot0)
	slot0.itemCfg_ = slot0.params_.itemCfg
	slot0.goodId_ = slot0.params_.goodId
	slot0.buyTime_ = slot0.params_.buyTime
	slot0.shopId_ = slot0.params_.shopId
	slot0.shopCfg_ = slot0.params_.shopCfg
	slot0.useNumSlider_.value = 1
	slot0.selectNum_ = 1
	slot0.multipleScrollRect_.verticalNormalizedPosition = 1

	slot0:UpdateRealtimePrice()

	slot0.canUseMaxNum_ = slot0:GetMaxNum()

	slot0:UpdateView()
	slot0:UpdateTimer()

	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
	slot0:UpdateDelAddBtn()
	slot0:UpdatePreview()
	slot0:AddEventListeners()
end

function slot0.UpdateTimer(slot0)
	if #slot0.shopCfg_.close_time > 0 then
		slot0.haveTimeLimitController_:SetSelectedState("true")

		if TimeMgr.GetInstance():parseTimeFromConfig(slot0.shopCfg_.close_time) <= TimeMgr.GetInstance():GetServerTime() then
			slot0.lastLabel_.text = GetTips("TIP_EXPIRED")
		else
			slot0.lastLabel_.text = string.format("%s%s", GetTips("REMAINING_TIME"), manager.time:GetLostTimeStr(slot2))
		end
	else
		slot0.haveTimeLimitController_:SetSelectedState("false")

		slot0.lastLabel_.text = ""
	end
end

function slot0.UpdateView(slot0)
	slot0.useNumSlider_.minValue = 1
	slot0.useNumSlider_.maxValue = slot0.canUseMaxNum_
	slot0.nameLabel_.text = slot0.itemCfg_.name

	getSpriteWithoutAtlasAsync("Textures/PrizeItem/" .. slot0.itemCfg_.icon, function (slot0)
		uv0.image_.sprite = slot0

		uv0.image_:SetNativeSize()
	end)

	if slot0.shopCfg_.limit_num ~= nil and slot0.shopCfg_.limit_num ~= -1 then
		slot0.limitLabel_.text = string.format("%d/%d", slot0.shopCfg_.limit_num - slot0.buyTime_, slot0.shopCfg_.limit_num)
		slot0.limitTitle_.text = GetTips(ShopConst.SHOP_LIMIT_TEXT[slot0.shopCfg_.refresh_cycle])
	end

	if slot0:IsOnDiscountArea() then
		slot0.tipController_:SetSelectedState("discount")

		slot0.tipLabel_.text = ShopTools.GetDiscountLabel(slot0.shopCfg_.goods_id)
	elseif slot0.shopCfg_.tag == 1 then
		slot0.tipController_:SetSelectedState("superValue")
	else
		slot0.tipController_:SetSelectedState("none")
	end

	if slot0.itemCfg_.sub_type == 501 then
		slot0.rewardTypeController_:SetSelectedState("normal")
		slot0.list_:StartScroll(#slot0.itemCfg_.param)
	elseif slot0.itemCfg_.sub_type == 505 then
		slot0.rewardTypeController_:SetSelectedState("multiple")

		if #(slot0.itemCfg_.param[1] or {}) > 0 then
			for slot5, slot6 in ipairs(slot1) do
				if slot5 <= #slot0.immeRewardItemList_ then
					slot0.immeRewardItemList_[slot5]:SetData(slot5, slot6[1], slot6[2] * slot0.shopCfg_.give)
				else
					slot8 = RechargeGiftPopItem.New(Object.Instantiate(slot0.GiftPopItemPrefab_, slot0.immeList_))

					slot8:SetData(slot5, slot6[1], slot6[2] * slot0.shopCfg_.give)
					table.insert(slot0.immeRewardItemList_, slot8)
				end
			end

			SetActive(slot0.immeLabelGo_, true)
		else
			SetActive(slot0.immeLabelGo_, false)
		end

		while #slot1 < #slot0.immeRewardItemList_ do
			slot0.immeRewardItemList_[#slot0.immeRewardItemList_]:Dispose()
			table.remove(slot0.immeRewardItemList_, #slot0.immeRewardItemList_)
		end

		slot8 = "CONSECUTIVE_DAYS"
		slot7 = tostring
		slot0.dailyLabel_.text = string.format(GetTips(slot8), slot7(slot0.itemCfg_.param[3]))

		for slot7, slot8 in ipairs(slot0.itemCfg_.param[2]) do
			if slot7 <= #slot0.dailyRewardItemList_ then
				slot0.dailyRewardItemList_[slot7]:SetData(slot7, slot8[1], slot8[2] * slot0.shopCfg_.give)
			else
				slot10 = RechargeGiftPopItem.New(Object.Instantiate(slot0.GiftPopItemPrefab_, slot0.dailyList_))

				slot10:SetData(slot7, slot8[1], slot8[2] * slot0.shopCfg_.give)
				table.insert(slot0.dailyRewardItemList_, slot10)
			end
		end

		while #slot3 < #slot0.dailyRewardItemList_ do
			slot0.dailyRewardItemList_[#slot0.dailyRewardItemList_]:Dispose()
			table.remove(slot0.dailyRewardItemList_, #slot0.dailyRewardItemList_)
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.multipleContainer_)
	end

	if slot0.canUseMaxNum_ == 1 then
		slot0.useNumSlider_.minValue = 0
	else
		slot0.useNumSlider_.minValue = 1
	end
end

function slot0.GetHave(slot0)
	if ItemCfg[slot0.shopCfg_.cost_id].type == ItemConst.ITEM_TYPE.CURRENCY then
		return CurrencyData:GetCurrencyNum(slot1.cost_id)
	elseif (slot2.type == ItemConst.ITEM_TYPE.MATERIAL or slot2.type == ItemConst.ITEM_TYPE.PROPS) and MaterialData:GetMaterialList()[slot1.cost_id] then
		return slot3.num
	end

	return 0
end

function slot0.GetMaxNum(slot0)
	slot1 = 1

	if slot0.shopCfg_.limit_num ~= nil and slot0.shopCfg_.limit_num ~= -1 then
		slot1 = slot0.shopCfg_.limit_num - slot0.buyTime_
	end

	if slot1 < 1 then
		slot1 = 1
	end

	return slot1
end

function slot0.OnShopBuyResult(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 0 then
		slot5 = getShopCfg(slot2)
		slot7 = slot5.give

		slot0:Back()

		if ItemCfg[slot5.give_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			getReward({
				{
					slot6,
					slot7
				}
			}, {
				ItemConst.ITEM_TYPE.HERO_SKIN
			})
		elseif slot8 == ItemConst.ITEM_TYPE.EQUIP then
			if EquipData:GetEquipBagFull() then
				showEquipSendMail(nil)
				EquipAction.EquipBagFull(false)
			else
				ShowTips("TRANSACTION_SUCCESS")
			end
		else
			ShowTips("TRANSACTION_SUCCESS")
		end
	elseif slot1 == 899 then
		ShowMessageBox({
			content = GetTips("EQUIP_NUM_MAX"),
			OkCallback = function ()
				JumpTools.GoToSystem("/bag", {
					type = "equip"
				}, ViewConst.SYSTEM_ID.BAG)
			end
		})
	elseif slot1 == 406 then
		ShowTips("ITEM_INVALID")
	else
		ShowTips(slot1)
	end
end

function slot0.IsOnDiscountArea(slot0)
	slot1, slot2, slot3 = ShopTools.IsOnDiscountArea(slot0.shopCfg_.goods_id)

	if slot1 and slot3 then
		return true
	else
		return false
	end
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(RECHARGE_SUCCESS, function (slot0)
		slot1 = nil
		slot1 = (not uv0:IsOnDiscountArea() or PaymentCfg[uv0.shopCfg_.cheap_cost_id]) and PaymentCfg[uv0.shopCfg_.cost_id]

		if slot0 == uv0.shopCfg_.cheap_cost_id or slot0 == uv0.shopCfg_.cost_id then
			uv0:Back()
		end
	end)
	slot0:RegistEventListener(CURRENCY_UPDATE, function (slot0)
		uv0:UpdateView()
	end)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	if slot0.immeRewardItemList_ then
		for slot4, slot5 in ipairs(slot0.immeRewardItemList_) do
			slot5:Dispose()
		end

		slot0.immeRewardItemList_ = nil
	end

	if slot0.dailyRewardItemList_ then
		for slot4, slot5 in ipairs(slot0.dailyRewardItemList_) do
			slot5:Dispose()
		end

		slot0.dailyRewardItemList_ = nil
	end

	slot0.useNumSlider_.onValueChanged:RemoveAllListeners()
	slot0.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	uv0.super.Dispose(slot0)
end

return slot0
