slot0 = manager.net

slot0:Bind(15007, function (slot0)
	CurrencyAction.CurrencyBuyTimes(slot0.left_time_coin, slot0.left_time_fatigue)
end)

slot0 = manager.net

slot0:Bind(15009, function (slot0)
	CurrencyAction.CurrencyInit(slot0.currency_list, slot0.last_fatigue_recover_time)
end)

return {
	CurrencyBuyTimes = function (slot0, slot1)
		CurrencyData:CurrencyBuyTimes(slot0, slot1)
	end,
	CurrencyInit = function (slot0, slot1)
		for slot5, slot6 in ipairs(slot0) do
			if slot6.id == CurrencyConst.CURRENCY_TYPE_ACHIEVEMENT_POINT then
				AchievementData:InitAchievementPoint(slot6.num)
			end
		end

		CurrencyData:CurrencyInit(slot0, slot1)
	end,
	CurrencyModify = function (slot0, slot1, slot2)
		if slot0 == CurrencyConst.CURRENCY_TYPE_ACHIEVEMENT_POINT then
			AchievementData:AddAchievementPoint(slot1)
		elseif slot0 == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE then
			if slot1 < 0 then
				CurrencyData:CostRechargeDiamond(math.abs(slot1))
			else
				CurrencyData:CurrencyModify(slot0, slot1, slot2)
			end
		else
			CurrencyData:CurrencyModify(slot0, slot1, slot2)
		end
	end,
	BuyCoin = function ()
		manager.net:SendWithLoadingNew(15012, {
			id = 2
		}, 15013, uv0.OnBuyCoin)
	end,
	OnBuyCoin = function (slot0, slot1)
		manager.notify:CallUpdateFunc(ON_BUY_COIN, slot0, slot1)
	end,
	BuyFatigue = function ()
		manager.net:SendWithLoadingNew(15016, {
			num = 1
		}, 15017, uv0.OnBuyFatigue)
	end,
	OnBuyFatigue = function (slot0, slot1)
		manager.notify:CallUpdateFunc(ON_BUY_FATIGUE, slot0, slot1)
		SendMessageManagerToSDK("purchase_swigs", {
			buyFatigueNum = slot1.num
		})
	end,
	BuyDiamond = function (slot0)
		manager.net:SendWithLoadingNew(15020, {
			num = slot0
		}, 15021, uv0.OnBuyDiamond)
	end,
	OnBuyDiamond = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE, -slot1.num)
			CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_DIAMOND, slot1.num)
			manager.notify:CallUpdateFunc(ON_BUY_DIAMOND, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	VitalityFull = function (slot0)
		CurrencyData:VitalityFull(slot0)
	end
}
