slot1 = import("game.const.ShopConst")

return {
	FilterShopDataList = function (slot0, slot1)
		slot1 = slot1 or false
		slot2 = {}
		slot3 = {}

		for slot8, slot9 in pairs(ShopData.GetShop(slot0).shopItemIDs) do
			if uv0.IsGoodCanDisplay(slot0, slot9, slot1) then
				table.insert(slot2, slot9)
			end
		end

		function slot8(slot0, slot1)
			return ShopCfg[slot1].shop_sort < ShopCfg[slot0].shop_sort
		end

		table.sort(slot2, slot8)

		for slot8, slot9 in ipairs(slot2) do
			slot10 = ShopCfg[slot9]

			table.insert(slot3, {
				id = slot9,
				shopId = slot0,
				buyTime = ShopData.GetShop(slot0)[slot9] ~= nil and slot11.buy_times or 0,
				next_refresh_timestamp = slot11 ~= nil and slot11.next_refresh_timestamp or 0
			})
		end

		return slot3
	end,
	IsGoodCanDisplay = function (slot0, slot1, slot2)
		slot3 = ShopCfg[slot1]
		slot5 = true
		slot6 = true
		slot7 = true
		slot8 = true
		slot9 = false

		if ShopData.GetShop(slot0)[slot1] ~= nil and slot3.limit_num ~= nil and slot3.limit_num ~= -1 and slot3.limit_num - (slot4.buy_times or 0) <= 0 then
			slot9 = true
		end

		if #ShopData.GetNextGoods(slot1) > 0 and slot9 then
			slot6 = false
		end

		if slot3.pre_goods_id ~= nil and #slot3.pre_goods_id > 0 then
			for slot13, slot14 in ipairs(slot3.pre_goods_id) do
				slot15 = ShopCfg[slot14]

				if ShopData.GetShop(slot0)[slot14] ~= nil and slot15.limit_num ~= nil and slot15.limit_num ~= -1 and slot15.limit_num - (slot16.buy_times or 0) > 0 then
					slot5 = false

					break
				end
			end

			if #ShopData.GetNextGoods(slot1) == 0 and slot9 and not slot2 then
				slot7 = false
			end
		end

		slot10 = true
		slot11 = TimeMgr.GetInstance():GetServerTime()
		slot10 = #slot3.open_time < 2 and true or TimeMgr.GetInstance():parseTimeFromConfig(slot3.open_time) <= slot11 and true or false
		slot12 = true
		slot12 = #slot3.close_time < 2 and true or slot11 < TimeMgr.GetInstance():parseTimeFromConfig(slot3.close_time) and true or false
		slot8 = slot3.limit_display == 1 or ShopData.IsGoodUnlock(slot3.goods_id) == 1

		if slot3.taken_down == 0 and slot5 and slot6 and slot7 and slot10 and slot12 and slot8 then
			if ShopTools.GetPrice(slot3.goods_id) == 0 then
				ShopData.IsGoodUnlock(slot3.goods_id)
			end

			return true
		end

		return false
	end,
	JudgeIsLvLimit = function (slot0)
		slot1 = PlayerData:GetPlayerInfo().userLevel

		for slot5, slot6 in ipairs(slot0) do
			if uv0.SHOP_LIMIT.PLAYER_LV == slot6[1] and slot1 < slot6[2] then
				return true, slot6
			end
		end

		return false
	end,
	IsSkinOnSell = function (slot0)
		for slot5, slot6 in ipairs(ShopCfg.get_id_list_by_shop_id[10]) do
			if ShopCfg[slot6].give_id == slot0 then
				return true
			end
		end

		return false
	end,
	HaveSkin = function (slot0)
		if table.indexof(HeroTools.HeroUnlockSkinS(SkinCfg[slot0].hero), slot0) then
			return true
		end

		return false
	end,
	ConfirmBuyItem = function (slot0, slot1, slot2, slot3)
		uv0.onBuyCallback_ = slot2
		uv0.onCancelCallback = slot3
		slot6, slot7 = uv0.GetHave(slot0)
		slot8, slot9, slot10 = uv0.GetPrice(slot0)
		slot11 = 1
		slot11 = slot6.type == ItemConst.ITEM_TYPE.CURRENCY and ((slot4.cost_id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE or slot4.cost_id == CurrencyConst.GetPlatformDiamondId()) and 1 or 2) or 3

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("CONFIRM_BUY"), GetI18NText(slot6.name), slot8 * slot1, GetI18NText(ItemCfg[ShopCfg[slot0].give_id].name), slot1),
			OkCallback = function ()
				if uv0 < uv1 * uv2 then
					if uv3 == 1 then
						ShowMessageBox({
							title = GetTips("PROMPT"),
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
					elseif uv3 == 2 then
						JumpTools.OpenPopUp("rechargeDiamondExchange", {
							defaultNum = 0,
							getBaseNum = 1,
							useBaseNum = 1,
							useId = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
							getId = CurrencyConst.CURRENCY_TYPE_DIAMOND
						}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)
					elseif uv3 == 3 then
						ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")
					end
				else
					if ShopData.IsGoodOutOfDate(uv4) then
						ShowTips("GOODS_HAS_BEEN_REMOVED")

						return
					end

					if uv5.onBuyCallback_ then
						uv5.onBuyCallback_(uv4)
					end

					ShopAction.BuyItem(uv4, uv2, uv1)
				end

				uv5.onBuyCallback_ = nil
				uv5.onCancelCallback = nil
			end,
			CancelCallback = function ()
				uv0.onBuyCallback_ = nil

				if uv0.onCancelCallback ~= nil then
					uv0.onCancelCallback()
				end

				uv0.onCancelCallback = nil
			end
		})
	end,
	GetHave = function (slot0)
		if ItemCfg[ShopCfg[slot0].cost_id].type == ItemConst.ITEM_TYPE.CURRENCY then
			if slot1.cost_id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE then
				return slot2, CurrencyData:GetRechargeDiamond()
			end

			return slot2, CurrencyData:GetCurrencyNum(slot1.cost_id)
		elseif (slot2.type == ItemConst.ITEM_TYPE.MATERIAL or slot2.type == ItemConst.ITEM_TYPE.PROPS) and MaterialData:GetMaterialList()[slot1.cost_id] then
			return slot2, slot3.num
		end

		return slot2, 0
	end,
	IsOnDiscountArea = function (slot0)
		slot1 = ShopCfg[slot0]

		if uv0.GetDiscount(slot0) ~= 100 then
			if #slot1.cheap_close_time > 0 then
				slot4 = TimeMgr.GetInstance():parseTimeFromConfig(slot1.cheap_close_time)

				if TimeMgr.GetInstance():parseTimeFromConfig(slot1.cheap_open_time) <= TimeMgr.GetInstance():GetServerTime() and slot2 <= slot4 then
					return true, true, true
				else
					return true, true, false
				end
			else
				return true, false, true
			end
		else
			return false, false, false
		end
	end,
	GetPrice = function (slot0)
		slot3, slot4, slot5 = uv0.IsOnDiscountArea(slot0)
		slot6 = uv0.GetDiscountPrice(slot0) == uv0.GetOriPrice(slot0) and 1 or slot1 / slot2

		if slot3 and slot5 then
			return slot1, slot2, slot6
		else
			return slot1, slot1, 1
		end
	end,
	IsRMB = function (slot0)
		return ShopCfg[slot0].cost_type == 1
	end,
	GetSkinIDViaShopID = function (slot0)
		return ItemCfg[ShopCfg[slot0].give_id].param[1]
	end,
	FilterShopDatas = function ()
	end,
	GetDiscountLabel = function (slot0)
		slot1 = uv0.GetDiscount(slot0)

		if SettingData:GetSettingData().sound.text_language == "jp" or slot2.sound.text_language == "en" then
			return string.format("%s", GetTips("LABEL_DISCOUNT"))
		elseif slot2.sound.text_language == "kr" then
			return string.format("%d%%%s", 100 - slot1, GetTips("LABEL_DISCOUNT"))
		else
			return string.format("%.1f%s", slot1 / 10, GetTips("LABEL_DISCOUNT"))
		end
	end,
	GetDiscount = function (slot0)
		slot2 = nil

		return (ShopCfg[slot0].is_limit_time_discount ~= 1 or (not uv0.IsRMB(slot0) or math.ceil(100 * PaymentCfg[slot1.cheap_cost_id].cost / PaymentCfg[slot1.cost_id].cost)) and math.ceil(100 * slot1.cheap_cost / slot1.cost)) and (slot1.discount == 0 or slot1.discount) and 100
	end,
	GetOriPrice = function (slot0)
		slot2 = uv0.GetDiscount(slot0)

		if ShopCfg[slot0].is_limit_time_discount == 1 or slot2 == 100 then
			if uv0.IsRMB(slot0) then
				return PaymentCfg[slot1.cost_id].cost
			else
				return slot1.cost
			end
		else
			slot3 = nil

			return math.ceil(((not uv0.IsRMB(slot0) or PaymentCfg[slot1.cheap_cost_id].cost) and slot1.cheap_cost) / (slot2 / 100))
		end
	end,
	GetDiscountPrice = function (slot0)
		slot1 = ShopCfg[slot0]

		if uv0.GetDiscount(slot0) ~= 100 then
			if uv0.IsRMB(slot0) then
				return PaymentCfg[slot1.cheap_cost_id].cost
			else
				return slot1.cheap_cost
			end
		else
			return uv0.GetOriPrice(slot0)
		end
	end,
	IsShopOpen = function (slot0)
		if ShopListCfg[slot0].activity_id == 0 then
			return true, 0
		elseif ActivityData:GetActivityIsOpen(slot1.activity_id) then
			return true, 1
		else
			slot3 = manager.time:GetServerTime()

			if ActivityData:GetActivityData(slot1.activity_id) and slot3 < slot2.startTime then
				return false, 3
			else
				return false, 2
			end
		end
	end
}
