slot0 = singletonClass("ExchangeData")

function slot0.Init(slot0)
end

function slot0.GetNextGoods(slot0, slot1)
	if ExchangeCfg[slot1].next_goods_id ~= nil then
		return ExchangeCfg[slot1].next_goods_id or {}
	end

	return ExchangeCfg.get_id_list_by_pre_goods_id[slot1] or {}
end

function slot0.IsSoldout(slot0, slot1, slot2)
	slot4 = ExchangeCfg[slot2]

	if ShopData.GetShop(slot1)[slot2] ~= nil and slot4.limit_num ~= nil and slot4.limit_num ~= -1 and slot4.limit_num - (slot3.buy_times or 0) <= 0 then
		return true
	end

	return false
end

return slot0
