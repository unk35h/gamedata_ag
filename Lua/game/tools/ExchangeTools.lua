return {
	FilterExchangeDataList = function (slot0, slot1)
		slot1 = slot1 or false
		slot2 = {}
		slot3 = {}
		slot4 = ExchangeCfg.get_id_list_by_shop_id[slot0] or {}

		for slot8, slot9 in pairs(slot4) do
			slot10 = ExchangeCfg[slot9]
			slot12 = true
			slot13 = true
			slot14 = true
			slot15 = true
			slot16 = false

			if ShopData.GetShop(slot0)[slot9] ~= nil and slot10.limit_num ~= nil and slot10.limit_num ~= -1 and slot10.limit_num - (slot11.buy_times or 0) <= 0 then
				slot16 = true
			end

			if #ExchangeData:GetNextGoods(slot9) > 0 and slot16 then
				slot13 = false
			end

			if slot10.pre_goods_id ~= nil and #slot10.pre_goods_id > 0 then
				for slot20, slot21 in ipairs(slot10.pre_goods_id) do
					slot22 = ExchangeCfg[slot21]

					if ShopData.GetShop(slot0)[slot21] ~= nil and slot22.limit_num ~= nil and slot22.limit_num ~= -1 and slot22.limit_num - (slot23.buy_times or 0) > 0 then
						slot12 = false

						break
					end
				end

				if #ExchangeData:GetNextGoods(slot9) == 0 and slot16 and not slot1 then
					slot14 = false
				end
			end

			slot17 = true
			slot18 = TimeMgr.GetInstance():GetServerTime()
			slot17 = #slot10.open_time < 2 and true or TimeMgr.GetInstance():parseTimeFromConfig(slot10.open_time) <= slot18 and true or false
			slot19 = true
			slot19 = #slot10.close_time < 2 and true or slot18 < TimeMgr.GetInstance():parseTimeFromConfig(slot10.close_time) and true or false
			slot15 = (not uv0.GetIsTakenDown(slot10) or false) and (slot10.limit_display == 1 or ShopData.IsGoodUnlock(slot10.goods_id) == 1)

			if slot12 and slot13 and slot14 and slot17 and slot19 and slot15 then
				table.insert(slot2, slot9)
			end
		end

		function slot8(slot0, slot1)
			if (ExchangeData:IsSoldout(getShopCfg(slot0).shop_id, slot0) and 1 or 0) ~= (ExchangeData:IsSoldout(getShopCfg(slot1).shop_id, slot1) and 1 or 0) then
				return slot4 < slot5
			end

			return ExchangeCfg[slot1].shop_sort < ExchangeCfg[slot0].shop_sort
		end

		table.sort(slot2, slot8)

		for slot8, slot9 in ipairs(slot2) do
			slot10 = ExchangeCfg[slot9]

			table.insert(slot3, {
				id = slot9,
				shopId = slot0,
				buyTime = ShopData.GetShop(slot0)[slot9] ~= nil and ShopData.GetShop(slot0)[slot9].buy_times or 0
			})
		end

		return slot3
	end,
	GetIsTakenDown = function (slot0)
		if slot0.taken_down == 0 then
			if ItemCfg[slot0.give_id] and slot1.type == ItemConst.ITEM_TYPE.HERO_PIECE and HeroTools.GetIsHide(slot1.hero_id) then
				return true
			end

			if slot1 and slot1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT and ServantTools.GetIsHide(slot1.id) then
				return true
			end

			if slot1 and slot1.type == ItemConst.ITEM_TYPE.EQUIP and EquipTools.GetIsHide(slot1.id) then
				return true
			end
		else
			return true
		end

		return false
	end,
	GetHave = function (slot0)
		if ItemCfg[ExchangeCfg[slot0].cost_id].type == ItemConst.ITEM_TYPE.CURRENCY then
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
		slot1 = ExchangeCfg[slot0]

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
	IsRMB = function (slot0)
		return ExchangeCfg[slot0].cost_type == 1
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
	GetDiscountLabel = function (slot0)
		slot1 = ExchangeCfg[slot0]
		slot2 = uv0.GetDiscount(slot0)

		if SettingData:GetSettingData().sound.text_language == "jp" or slot3.sound.text_language == "en" then
			return string.format("%s", GetTips("LABEL_DISCOUNT"))
		elseif slot3.sound.text_language == "kr" then
			return string.format("%d%%%s", 100 - slot2, GetTips("LABEL_DISCOUNT"))
		else
			return string.format("%.1f%s", slot2 / 10, GetTips("LABEL_DISCOUNT"))
		end
	end,
	GetDiscount = function (slot0)
		slot2 = nil

		return (ExchangeCfg[slot0].is_limit_time_discount ~= 1 or (not uv0.IsRMB(slot0) or math.ceil(100 * PaymentCfg[slot1.cheap_cost_id].cost / PaymentCfg[slot1.cost_id].cost)) and math.ceil(100 * slot1.cheap_cost / slot1.cost)) and (slot1.discount == 0 or slot1.discount) and 100
	end,
	GetOriPrice = function (slot0)
		slot2 = uv0.GetDiscount(slot0)

		if ExchangeCfg[slot0].is_limit_time_discount == 1 or slot2 == 100 then
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
		slot1 = ExchangeCfg[slot0]

		if uv0.GetDiscount(slot0) ~= 100 then
			if uv0.IsRMB(slot0) then
				return PaymentCfg[slot1.cheap_cost_id].cost
			else
				return slot1.cheap_cost
			end
		else
			return uv0.GetOriPrice(slot0)
		end
	end
}
