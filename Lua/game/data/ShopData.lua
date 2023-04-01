slot0 = singletonClass("ShopData")
slot1 = {}
slot2 = {}

function slot0.Init()
	uv0 = {}
	uv1 = {}
end

function slot0.GetNextGoods(slot0)
	if ShopCfg[slot0].next_goods_id ~= nil and #ShopCfg[slot0].next_goods_id > 0 then
		return ShopCfg[slot0].next_goods_id
	end

	return ShopCfg.get_id_list_by_pre_goods_id[slot0] or {}
end

function slot0.ShopItemUpdate(slot0, slot1, slot2)
	if not uv0[slot1][slot0] then
		slot4[slot3] = {}
	end

	if not slot4[slot3].buy_times then
		slot4[slot3].buy_times = 0
	end

	slot4[slot3].buy_times = slot4[slot3].buy_times + (slot2 or 1)

	manager.notify:Invoke(SHOP_ITEM_UPDATE, slot1, slot3)
end

function slot0.SingleShopUpdate(slot0)
	if not uv0[slot0.shop_id] then
		return
	end

	slot1.shopID = slot0.shop_id
	slot2 = {}

	for slot6, slot7 in ipairs(slot0.goods_list) do
		slot8 = slot7.goods_id
		slot1[slot8] = slot7

		table.insert(slot2, slot8)
	end

	for slot6, slot7 in ipairs(slot1.shopItemIDs) do
		if not table.keyof(slot2, slot7) then
			slot1[slot7] = nil
		end
	end

	slot1.shopItemIDs = slot2
	slot1.refreshCount = slot0.refresh_times

	manager.notify:Invoke(SHOP_LIST_UPDATE, slot1.shopID)
end

function slot0.AllShopUpdate(slot0)
	uv0 = {}

	for slot4, slot5 in ipairs(slot0) do
		if ExchangeCfg.get_id_list_by_shop_id[slot5.shop_id] then
			uv1[slot6] = {
				shopItemIDs = {},
				refreshCount = 0
			}

			for slot10, slot11 in ipairs(ExchangeCfg.get_id_list_by_shop_id[slot6]) do
				uv1[slot6][slot11] = {}

				for slot15, slot16 in ipairs(slot5.goods_list) do
					if slot16.goods_id == slot11 then
						uv1[slot6][slot11] = slot16

						break
					end
				end

				table.insert(uv1[slot6].shopItemIDs, slot11)
			end

			table.insert(uv0, slot6)
		elseif ShopListCfg[slot6] then
			uv1[slot6] = {
				shopItemIDs = {},
				refreshCount = slot5.refresh_times
			}

			for slot10, slot11 in ipairs(slot5.goods_list) do
				slot12 = slot11.goods_id
				uv1[slot6][slot12] = slot11

				table.insert(uv1[slot6].shopItemIDs, slot12)
			end

			table.insert(uv0, slot6)
		end
	end

	manager.notify:Invoke(SHOP_LIST_UPDATE, 0)
end

function slot0.GetShop(slot0)
	return uv0[slot0]
end

function slot0.IsGoodOutOfDate(slot0)
	slot2 = TimeMgr.GetInstance():GetServerTime()
	slot3 = false
	slot4 = false
	slot3 = (#getShopCfg(slot0).close_time <= 0 or TimeMgr.GetInstance():parseTimeFromConfig(slot1.close_time) <= slot2 and true or false) and false

	if (#slot1.open_time <= 0 or slot2 < TimeMgr.GetInstance():parseTimeFromConfig(slot1.open_time) and true or false) and false or slot3 then
		return true
	end

	return false
end

function slot0.IsSoldout(slot0, slot1)
	slot3 = ShopCfg[slot1]

	if ShopData.GetShop(slot0)[slot1] ~= nil and slot3.limit_num ~= nil and slot3.limit_num ~= -1 and slot3.limit_num - (slot2.buy_times or 0) <= 0 then
		return true
	end

	return false
end

function slot0.IsGoodUnlock(slot0)
	if #getShopCfg(slot0).level_limit > 0 then
		for slot5, slot6 in ipairs(slot1.level_limit) do
			slot7, slot8 = nil

			if slot6.type then
				slot7 = slot6.type
				slot8 = slot6.num
			else
				slot7 = slot6[1]
				slot8 = slot6[2]
			end

			if slot7 == 1 then
				if PlayerData:GetPlayerInfo().userLevel < slot8 then
					return 0
				end
			elseif slot7 == 2 then
				if PassportData:GetLevel() < slot8 then
					return 0
				end
			elseif slot7 == 3 then
				if not isOpenMission(slot8) then
					return 0
				end

				if BattleStageData:GetStageData()[slot8].clear_times <= 0 then
					return 0
				end
			elseif slot7 == 4 and HeroData:GetHeroList()[slot8].unlock ~= 1 then
				return 0
			end
		end
	end

	return 1
end

function slot0.Is(slot0)
end

return slot0
