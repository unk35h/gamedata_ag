slot0 = class("RechargeDiamondExchangeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Recharge/RechargeExchangeUI"
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

	slot0.typeCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "type")
	slot0.useNumTriggerListener_ = slot0.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
	slot0:UpdateBar()
	SDKTools.SendPaymentMessageToSDK("payment_touch", {
		payment_flower_to_diamond = "{" .. CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) .. "," .. CurrencyData:GetRechargeDiamond()
	})
	manager.windowBar:SetAsLastSibling()
end

function slot0.ConfirmToDo(slot0, slot1)
	slot8 = CurrencyData

	SDKTools.SendPaymentMessageToSDK("payment_touch", {
		payment_ticket_check = slot8:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)
	})
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = string.format(GetTips("CONFIRM_BUY"), GetI18NText(ItemCfg[slot0.params_.useId].name), slot0.params_.useBaseNum * slot0.useNumSlider_.value, GetI18NText(ItemCfg[slot0.params_.getId].name), slot0.params_.getBaseNum * slot0.useNumSlider_.value),
		OkCallback = function ()
			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_flower_to_diamond_check = 0
			})
			uv0()
		end,
		CancelCallback = function ()
			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_flower_to_diamond_check = 1
			})
		end
	})
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		uv0:CheckBuy()
	end)
	slot0:AddPressingByTimeListener(slot0.addBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.useNumSlider_.value < uv0.canUseMaxNum_ then
			uv0.useNumSlider_.value = uv0.useNumSlider_.value + 1

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.delBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.useNumSlider_.value > 1 then
			uv0.useNumSlider_.value = uv0.useNumSlider_.value - 1

			if uv0.useNumSlider_.value < 1 then
				uv0.useNumSlider_.value = 1
			end

			return true
		end

		return false
	end)
	slot0:AddBtnListener(slot0.maxBtn_, nil, function ()
		uv0.useNumSlider_.value = uv0.canUseMaxNum_
	end)
	slot0:AddToggleListener(slot0.useNumText_, function ()
		slot0 = math.min(uv0.canUseMaxNum_, math.max(1, tonumber(uv0.useNumText_.text) or 0))
		uv0.useNumText_.text = slot0
		uv0.useNumSlider_.value = slot0
	end)

	slot1 = slot0.useNumSlider_.onValueChanged

	slot1:AddListener(function ()
		uv0:UpdateCnt()
	end)
end

function slot0.UpdateView(slot0)
	if slot0.params_.getId == CurrencyConst.CURRENCY_TYPE_DIAMOND then
		slot0.typeCon_:SetSelectedState("inputfield")
	else
		slot0.typeCon_:SetSelectedState("slider")
	end

	if slot0.params_.useId then
		slot0.icon1_.sprite = ItemTools.getItemLittleSprite(slot0.params_.useId)
		slot0.useNameText_.text = ItemCfg[slot0.params_.useId].name
	end

	if slot0.params_.getId then
		slot0.icon2_.sprite = ItemTools.getItemLittleSprite(slot0.params_.getId)
		slot0.getNameText_.text = ItemCfg[slot0.params_.getId].name
		slot0.title_.text = string.format(GetTips("EXCHANGE_TIP"), GetI18NText(ItemCfg[slot0.params_.getId].name))
	end

	slot0.canUseMaxNum_ = math.floor(slot0:GetTotal() / (slot0.params_.useBaseNum or 1))
	slot0.canUseMaxNum_ = math.max(slot0.canUseMaxNum_, 1)
	slot0.useNumSlider_.minValue = 1
	slot0.useNumSlider_.maxValue = slot0.canUseMaxNum_
	slot2 = slot0.useNumSlider_.minValue ~= slot0.useNumSlider_.maxValue
	slot0.handleGo_.raycastTarget = slot2
	slot0.fillGo_.raycastTarget = slot2
	slot0.bgGo_.raycastTarget = slot2

	if slot0.useNumSlider_.minValue == slot0.useNumSlider_.maxValue then
		slot0.useNumSlider_.minValue = 0
		slot0.useNumSlider_.maxValue = 1
	end

	slot0.useNumSlider_.value = slot0.params_.defaultNum ~= 0 and slot0.params_.defaultNum or 1

	slot0:UpdatePreview()
	slot0:UpdateDelAddBtn()
end

function slot0.UpdateBar(slot0)
	slot0.lastBarList_ = manager.windowBar:GetLastBarList() or {}
	slot0.lastAddBarList_ = manager.windowBar:GetLastAddBarList()
	slot0.lastCanClickBarList_ = manager.windowBar:GetLastCanClickBarList()
	slot0.lastBarTypeList_ = manager.windowBar:GetLastBarTypeList()

	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)

	if whereami ~= "battle" and whereami ~= "battleResult" then
		manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	end
end

function slot0.GetTotal(slot0)
	if slot0.params_.useId == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE or slot0.params_.useId == CurrencyConst.GetPlatformDiamondId() then
		return CurrencyData:GetRechargeDiamond()
	end

	return CurrencyData:GetCurrencyNum(slot0.params_.useId)
end

function slot0.UpdateCnt(slot0)
	slot0:UpdatePreview()
	slot0:UpdateDelAddBtn()
end

function slot0.UpdatePreview(slot0)
	slot1 = slot0.useNumSlider_.value
	slot0.buyText.text = tostring(slot1)
	slot0.useNumText_.text = tostring(slot1)
	slot0.useText_.text = (slot0.params_.useBaseNum or 1) * slot1
	slot0.getText_.text = (slot0.params_.getBaseNum or 1) * slot1
end

function slot0.UpdateDelAddBtn(slot0)
	slot0.delBtn_.interactable = slot0.useNumSlider_.value > 1
	slot0.addBtn_.interactable = slot1 < slot0.canUseMaxNum_
	slot0.maxBtn_.interactable = slot1 < slot0.canUseMaxNum_
	slot0.useNumText_.interactable = true
end

function slot0.CheckBuy(slot0)
	slot1 = slot0.useNumSlider_.value

	if slot0.params_.defaultNum ~= 0 then
		slot1 = slot1 * slot0.params_.useBaseNum
	end

	if slot0.params_.getId == CurrencyConst.CURRENCY_TYPE_DIAMOND then
		if slot1 <= CurrencyData:GetRechargeDiamond() then
			slot0:ConfirmToDo(function ()
				CurrencyAction.BuyDiamond(uv0)
			end)
		else
			if whereami == "battle" or whereami == "battleResult" then
				ShowTips("ERROR_RECHARGE_DIAMOND_NOT_ENOUGH_NO_BUY")

				return
			end

			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
				ShowMessageBox({
					isTop = true,
					content = GetTips("ERROR_RECHARGE_DIAMOND_NOT_ENOUGH"),
					OkCallback = function ()
						SDKTools.SendPaymentMessageToSDK("payment_touch", {
							payment_pay_flower_check = 0
						})
						JumpTools.GoToSystem("/rechargeMain", {
							page = 5
						}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
					end,
					CancelCallback = function ()
						SDKTools.SendPaymentMessageToSDK("payment_touch", {
							payment_pay_flower_check = 1
						})
					end
				})
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_DIAMOND")
			end
		end
	elseif slot0.params_.exchangeId then
		if ExchangeCfg[slot0.params_.exchangeId].cost_id == CurrencyConst.CURRENCY_TYPE_DIAMOND then
			if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) < slot2.cost * slot1 then
				slot0:Back()
				JumpTools.OpenPopUp("rechargeDiamondExchange", {
					defaultNum = 0,
					getBaseNum = 1,
					useBaseNum = 1,
					useId = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
					getId = CurrencyConst.CURRENCY_TYPE_DIAMOND
				}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)

				return
			end
		elseif slot3 == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE and CurrencyData:GetRechargeDiamond() < slot2.cost * slot1 then
			slot0:Back()

			if whereami == "battle" or whereami == "battleResult" then
				ShowTips("ERROR_RECHARGE_DIAMOND_NOT_ENOUGH_NO_BUY")

				return
			end

			ShowMessageBox({
				isTop = true,
				content = GetTips("ERROR_RECHARGE_DIAMOND_NOT_ENOUGH"),
				OkCallback = function ()
					SDKTools.SendPaymentMessageToSDK("payment_touch", {
						payment_pay_flower_check = 0
					})
					JumpTools.GoToSystem("/rechargeMain", {
						page = 5
					}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
				end,
				CancelCallback = function ()
					SDKTools.SendPaymentMessageToSDK("payment_touch", {
						payment_pay_flower_check = 1
					})
				end
			})

			return
		end

		slot0:ConfirmToDo(function ()
			ShopAction.BuyItem(uv0.goods_id, uv1)
		end)
	end
end

function slot0.RestoreBar(slot0)
	if slot0.lastBarList_ then
		manager.windowBar:SwitchBar(slot0.lastBarList_)
	end

	if slot0.lastAddBarList_ then
		for slot4, slot5 in ipairs(slot0.lastAddBarList_) do
			manager.windowBar:SetBarCanAdd(slot5, true)
		end
	end

	if slot0.lastCanClickBarList_ then
		for slot4, slot5 in ipairs(slot0.lastCanClickBarList_) do
			manager.windowBar:SetBarCanClick(slot5, true)
		end
	end

	if slot0.lastBarTypeList_ then
		for slot4, slot5 in pairs(slot0.lastBarTypeList_) do
			manager.windowBar:SetBarType(slot4, slot5)
		end
	end
end

function slot0.OnBuyDiamond(slot0, slot1, slot2)
	if slot1.result == 0 then
		slot0:Back()
		ShowTips("TRANSACTION_SUCCESS")
	end
end

function slot0.OnBuyTicket(slot0, slot1, slot2)
	slot3 = slot0.useNumSlider_.value

	if slot1.result == 0 then
		CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_DIAMOND, -slot3 * slot0.params_.useBaseNum)
		CurrencyAction.CurrencyModify(slot0.params_.getId, slot3 * slot0.params_.getBaseNum)
		ShowTips("TRANSACTION_SUCCESS")
		slot0:Back()
	end
end

function slot0.OnShopBuyResult(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 0 then
		slot0:Back()
	end
end

function slot0.OnExit(slot0)
	slot0:RestoreBar()
	manager.windowBar:SetAsFirstSibling()

	slot0.lastBarList_ = nil
	slot0.lastAddBarList_ = nil
	slot0.lastCanClickBarList_ = nil
	slot0.lastBarTypeList_ = nil
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.toggles_ then
		for slot4, slot5 in pairs(slot0.toggles_) do
			slot5.onValueChanged:RemoveAllListeners()
		end

		slot0.toggles_ = nil
	end

	slot0.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	slot0.useNumSlider_.onValueChanged:RemoveAllListeners()

	slot0.useNumTriggerListener_ = nil
	slot0.useNumSlider_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
