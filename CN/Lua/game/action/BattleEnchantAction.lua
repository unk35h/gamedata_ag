slot1 = manager.net

slot1:Bind(42001, function (slot0)
	BattleEnchantAction.InitEnchantment(slot0)
end)

return {
	CONST = {
		FREE = 1,
		BUY = 2
	},
	InitEnchantment = function (slot0)
		BattleEnchantmentData:InitEnchantment(slot0)
		manager.notify:CallUpdateFunc(ENCHANTMENT_INIT, slot0)
	end,
	EnchantmentInit = function ()
		manager.net:Push(42002, {})
	end,
	EnchantmentRefresh = function (slot0, slot1)
		uv0.cost = slot1

		manager.net:SendWithLoadingNew(42004, {
			refresh_type = slot0
		}, 42005, uv0.OnEnchantmentRefresh)
	end,
	OnEnchantmentRefresh = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if slot1.refresh_type == 1 then
				BattleEnchantmentData:EnchantmentFreeRefresh(slot0)
			elseif slot1.refresh_type == 2 then
				BattleEnchantmentData:EnchantmentBuyRefresh(slot0)
				CurrencyAction.CurrencyModify(uv0.cost[1], -uv0.cost[2])
			end

			manager.notify:CallUpdateFunc(ENCHANTMENT_REFRESH, slot0, slot1)
		else
			ShowTips(slot0.result)
			uv0.EnchantmentInit()
		end
	end,
	SetSelectLevel = function (slot0)
		BattleEnchantmentData:SetSelectLevel(slot0)
	end,
	GetSelectLevel = function ()
		return BattleEnchantmentData:GetData().selectLevel
	end,
	checkMaxLevel = function ()
	end
}
