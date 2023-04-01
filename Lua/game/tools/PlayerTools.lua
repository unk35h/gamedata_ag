slot1 = import("game.const.HeroConst")
slot2 = import("game.tools.BattleInstance")

return {
	SortShowHero = function (slot0, slot1, slot2)
		slot3 = {}
		slot4 = {}

		for slot8, slot9 in pairs(slot0) do
			if type(slot9) == "table" then
				slot10 = HeroCfg[slot8]
				slot3[slot8] = slot8 + (slot9.level or slot9.hero_level) * 10000 + (slot9.star or slot9.hero_star) * 10000000

				if table.keyof(slot1, slot8) then
					slot3[slot8] = slot11 + 100000000 * (4 - slot11)
				end

				if slot1[slot2] == slot8 then
					slot3[slot8] = slot3[slot8] + 1000000000
				end

				if slot9.hero_unlock == 1 or slot9.unlock == 1 then
					table.insert(slot4, slot8)
				end
			end
		end

		table.sort(slot4, function (slot0, slot1)
			return uv0[slot1] < uv0[slot0]
		end)

		return slot4
	end,
	PackUserData = function (slot0)
		slot1 = PlayerData:GetPlayerInfo()

		if CurrencyData:GetCurrencyMap() == nil or table.nums(CurrencyData:GetCurrencyMap()) == 0 or slot1 == nil then
			return "{}"
		end

		return string.format("{\"dataType\" : \"%s\",\"money\" : %d,\"createTime\" : %d,\"roleId\" : %d,\"roleName\" : \"%s\",\"level\" : %d,\"serverId\" : %d,\"chapter\" : %d}", slot0, CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND), slot1.register_timestamp, slot1.userID, slot1.nick, slot1.userLevel, _G.TMP_SERVER_ID, uv0.GetCurrentBattleId())
	end
}
