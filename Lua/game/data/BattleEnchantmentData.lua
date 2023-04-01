slot0 = singletonClass("EnchantmentStageData")
slot1 = {
	freeRefreshTimes = 0,
	allRefreshedTimes = 0,
	selectLevel = 0,
	enchantmentBattleList = {}
}

function slot0.Init(slot0)
	uv0 = {
		freeRefreshTimes = 0,
		allRefreshedTimes = 0,
		selectLevel = 0,
		enchantmentBattleList = {}
	}
end

function slot0.GetData(slot0)
	return uv0
end

function slot0.InitEnchantment(slot0, slot1)
	uv0.freeRefreshTimes = slot1.free_refreshed_times
	uv0.allRefreshedTimes = slot1.all_buy_refreshed_times

	for slot5, slot6 in ipairs(slot1.enchantment_battle_list) do
		uv0.enchantmentBattleList[slot5] = slot6
	end
end

function slot0.EnchantmentFreeRefresh(slot0, slot1)
	uv0.freeRefreshTimes = uv0.freeRefreshTimes <= 0 and 0 or uv0.freeRefreshTimes - 1

	for slot5, slot6 in ipairs(slot1.enchantment_battle_list) do
		uv0.enchantmentBattleList[slot5] = slot6
	end
end

function slot0.EnchantmentBuyRefresh(slot0, slot1)
	uv0.allRefreshedTimes = uv0.allRefreshedTimes + 1

	for slot5, slot6 in ipairs(slot1.enchantment_battle_list) do
		uv0.enchantmentBattleList[slot5] = slot6
	end
end

function slot0.SetSelectLevel(slot0, slot1)
	uv0.selectLevel = slot1
end

return slot0
