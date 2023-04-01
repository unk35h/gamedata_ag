slot1 = manager.net

slot1:Bind(20005, function (slot0)
	ShopData.SingleShopUpdate(slot0.changed_shop_info)
end)

slot1 = manager.net

slot1:Bind(20009, function (slot0)
	ShopData.AllShopUpdate(slot0.shop_item_list)
end)

slot1 = manager.net

slot1:Bind(20003, function (slot0)
	UpdateShopCfg(slot0.shop_item_cfg_list)
end)

slot1 = manager.net

slot1:Bind(20007, function (slot0)
	for slot4, slot5 in ipairs(slot0.shop_item_cfg_list) do
		UpdateShopCfg(slot5)
	end
end)

return {
	BuyItem = function (slot0, slot1, slot2)
		slot3, slot4 = nil

		if ShopCfg[slot0] then
			slot3 = ShopCfg[slot0]
			slot4 = true
		else
			slot3 = ExchangeCfg[slot0]
			slot4 = false
		end

		if not ShopTools.IsShopOpen(slot3.shop_id) then
			ShowTips("TIME_OVER")

			return
		end

		slot6 = 0

		if slot2 then
			slot6 = slot2
		else
			slot6 = slot3.cost

			if slot4 then
				slot7, slot8, slot9 = ShopTools.IsOnDiscountArea(slot0)

				if slot7 and slot9 then
					slot6 = slot3.cheap_cost
				end
			else
				slot7, slot8, slot9 = ExchangeTools.IsOnDiscountArea(slot0)

				if slot7 and slot9 then
					slot6 = slot3.cheap_cost
				end
			end
		end

		slot7 = slot6 * slot1
		slot8 = ItemCfg[slot3.cost_id].type
		slot9 = {}

		if slot3.cost_type == 2 then
			slot11 = math.min(slot7, CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND))

			table.insert(slot9, {
				id = CurrencyConst.CURRENCY_TYPE_DIAMOND,
				num = slot11
			})

			if slot7 - slot11 > 0 then
				table.insert(slot9, {
					id = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
					num = slot12
				})
			end

			if slot12 > 0 and CurrencyData:GetRechargeDiamond() < slot12 then
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
		else
			table.insert(slot9, {
				id = slot3.cost_id,
				num = slot7
			})

			if slot8 == ItemConst.ITEM_TYPE.CURRENCY then
				if CurrencyData:GetCurrencyNum(slot3.cost_id) < slot7 then
					if slot10 == CurrencyConst.CURRENCY_TYPE_GOLD then
						slot12 = false
						slot14 = ipairs
						slot16 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND] or {}

						for slot17, slot18 in slot14(slot16) do
							if ItemTools.getItemNum(slot18) > 0 then
								slot12 = true

								break
							end
						end

						if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] or slot12 then
							JumpTools.OpenPopUp("currencyBuyGold", nil, ViewConst.SYSTEM_ID.BUY_GOLD)

							return
						end
					elseif slot10 == CurrencyConst.CURRENCY_TYPE_DIAMOND then
						if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
							JumpTools.OpenPopUp("rechargeDiamondExchange", {
								getBaseNum = 1,
								useBaseNum = 1,
								useId = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
								getId = CurrencyConst.CURRENCY_TYPE_DIAMOND,
								defaultNum = slot7 - slot11
							}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)
						else
							ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
						end

						return
					end

					ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), GetI18NText(ItemCfg[slot10].name)))

					return
				end
			elseif slot8 == ItemConst.ITEM_TYPE.MATERIAL then
				slot12 = 0

				if MaterialData:GetMaterialList()[slot3.cost_id] then
					slot12 = slot11.num
				end

				if slot12 < slot7 then
					ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), GetI18NText(ItemCfg[slot10].name)))

					return
				end
			else
				print("其他大类未做处理")
			end
		end

		if ItemTools.IsItemExpiredByItemId(slot3.cost_id) then
			ShowTips("ERROR_ITEM_TIME_INVALID")

			return
		end

		return manager.net:SendWithLoadingNew(20012, {
			buy_id = slot0,
			shop_id = slot3.shop_id,
			buy_num = slot1,
			cost_items = slot9
		}, 20013, uv0.ShopItemUpdate)
	end,
	ShopItemUpdate = function (slot0, slot1)
		slot2 = nil

		if slot0.result == 0 then
			ShopData.ShopItemUpdate(slot1.buy_id, slot1.shop_id, slot1.buy_num)

			slot3, slot4 = nil

			if ShopCfg[slot1.buy_id] then
				slot3 = ShopCfg[slot1.buy_id]
				slot4 = ShopTools.GetPrice(slot1.buy_id)
			else
				slot3 = ExchangeCfg[slot1.buy_id]
				slot4 = ExchangeTools.GetPrice(slot1.buy_id)
			end

			slot5 = slot4 * slot1.buy_num
			slot6 = ItemCfg[slot3.cost_id].type

			if slot3.cost_type == 2 then
				if slot3.cost_id == CurrencyConst.CURRENCY_TYPE_DIAMOND then
					slot9 = math.min(CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND), slot5)
					slot10 = slot5 - slot9

					if slot9 > 0 then
						CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_DIAMOND, -slot9)
					end

					if slot10 > 0 then
						CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE, -slot10)
					end
				else
					error("error currencyId with cost type2 : " .. tostring(slot7))
				end
			elseif slot6 == ItemConst.ITEM_TYPE.CURRENCY then
				if slot3.cost_id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE then
					CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE, -slot5)
				else
					CurrencyAction.CurrencyModify(slot7, -slot5)
				end
			elseif slot6 == ItemConst.ITEM_TYPE.MATERIAL then
				MaterialAction.MaterialModify(slot3.cost_id, -slot5)
			elseif slot6 == ItemConst.ITEM_TYPE.HERO_PIECE then
				HeroAction.HeroPieceModify(ItemCfg[slot3.cost_id].hero_id, -slot5)
			end

			slot8 = slot3.give

			if ItemCfg[slot3.give_id].type == 5 and slot9.sub_type == 501 then
				slot10 = {}

				for slot14, slot15 in ipairs(slot9.param) do
					table.insert(slot10, {
						slot15[1],
						slot15[2] * slot1.buy_num * slot8
					})
				end

				slot2 = mergeReward(slot10)
			elseif slot9.type == 5 and slot9.sub_type == 505 then
				slot10 = {}

				for slot14, slot15 in ipairs(slot9.param[1]) do
					table.insert(slot10, {
						slot15[1],
						slot15[2] * slot1.buy_num * slot8
					})
				end

				slot2 = mergeReward(slot10)
			else
				getRewardData({
					{
						slot7,
						slot8 * slot1.buy_num
					}
				})
			end

			manager.notify:CallUpdateFunc(SHOP_BUY_CALLBACK, slot0.result, slot1.buy_id, slot1.shop_id, slot1.buy_num)

			if slot2 and #slot2 > 0 then
				getReward(slot2)
			else
				ShowTips("TRANSACTION_SUCCESS")
			end
		elseif slot0.result == 899 then
			ShowMessageBox({
				content = GetTips("EQUIP_NUM_MAX"),
				OkCallback = function ()
					JumpTools.GoToSystem("/bag", {
						type = "equip"
					}, ViewConst.SYSTEM_ID.BAG)
				end
			})
		elseif slot0.result == 406 then
			ShowTips("ITEM_INVALID")
		elseif TipsCfg[slot0.result] ~= nil then
			ShowTips(TipsCfg[slot0.result].desc)
		else
			ShowTips(GetTips(tostring(slot0.result)))
		end
	end,
	RefreshSingleShop = function (slot0, slot1)
		uv0.diamondRequire_ = slot1

		if CurrencyData:GetCurrencyMap()[CurrencyConst.CURRENCY_TYPE_DIAMOND].num < slot1 then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_DIAMOND")

			return
		end

		manager.net:SendWithLoadingNew(20014, {
			shop_id = slot0
		}, 20015, uv0.OnRefreshSingleShop)
	end,
	OnRefreshSingleShop = function (slot0, slot1)
		if slot0.result == 0 then
			CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_DIAMOND, -uv0.diamondRequire_)

			uv0.diamondRequire_ = nil
		end

		manager.notify:CallUpdateFunc(ON_SHOP_REFRESH_ONE_SHOP, slot0)
	end,
	RefreshAllShop = function ()
		manager.net:SendWithLoadingNew(20016, {
			nothing = 1
		}, 20017, uv0.OnRefreshAllShop)
	end,
	OnRefreshAllShop = function (slot0, slot1)
		manager.notify:Invoke(SHOP_REFRESH_ALL_SHOP, slot0)
	end,
	ResolveFragment = function ()
		manager.net:SendWithLoadingNew(14032, {
			nothing = 0
		}, 14033, uv0.OnResolveFragment)
	end,
	OnResolveFragment = function (slot0, slot1)
		manager.notify:CallUpdateFunc(ON_RESOLVE_FRAGMENT, slot0)
	end
}
