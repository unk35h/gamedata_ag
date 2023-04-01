return {
	TryToUseItem = function (slot0)
		slot1 = {
			use_item_list = slot0
		}
		slot2 = true

		for slot6, slot7 in pairs(slot0) do
			if ItemTools.IsItemExpired({
				id = slot7.item_id,
				time_valid = slot7.time_valid
			}) then
				slot2 = false

				break
			end
		end

		if slot2 then
			manager.net:SendWithLoadingNew(17012, slot1, 17013, uv0.OnTryToUseItem)
		else
			ShowTips("ERROR_ITEM_TIME_INVALID")
		end
	end,
	OnTryToUseItem = function (slot0, slot1)
		manager.notify:CallUpdateFunc(ON_TRY_TO_USE_ITEM, slot0, slot1)
	end
}
