slot0 = import(".ShopReducer")

return function (slot0, slot1)
	if slot0 == nil then
		slot0 = {
			shopIDs = {}
		}
	end

	slot2 = {
		[ACTIONS.SHOP_ITEM_UPDATE] = function (slot0)
			slot1 = uv0.data.shopId
			slot0[slot1] = uv1(slot0[slot1], uv0)
		end,
		[ACTIONS.SINGLE_SHOP_UPDATE] = function (slot0)
			slot1 = uv0.data.shop_id
			slot0[slot1] = uv1(slot0[slot1], uv0)
		end
	}

	if slot1.type == ACTIONS.ALL_SHOP_UPDATE then
		slot3 = {
			shopIDs = {}
		}
		slot4 = {}

		for slot8, slot9 in ipairs(slot1.data) do
			if ExchangeCfg.get_id_list_by_shop_id[slot9.shop_id] then
				slot3[slot10] = {
					shopItemIDs = {},
					refreshCount = 0
				}

				for slot14, slot15 in ipairs(ExchangeCfg.get_id_list_by_shop_id[slot10]) do
					slot3[slot10][slot15] = 0

					table.insert(slot3[slot10].shopItemIDs, slot15)
				end

				table.insert(slot3.shopIDs, slot10)
			elseif ShopListCfg[slot10] then
				slot3[slot10] = {
					shopItemIDs = {},
					refreshCount = slot9.refresh_times
				}

				for slot14, slot15 in ipairs(slot9.goods_list) do
					slot16 = slot15.goods_id
					slot3[slot10][slot16] = slot15.buy_times

					table.insert(slot3[slot10].shopItemIDs, slot16)
				end

				table.insert(slot3.shopIDs, slot10)
			end
		end

		return slot3
	elseif slot2[slot1.type] then
		return immer.produce(slot0, function (slot0)
			uv0[uv1.type](slot0)
		end)
	else
		return slot0
	end
end
