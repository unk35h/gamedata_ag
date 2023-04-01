return {
	GetMainUIName = function (slot0)
		if ActivityConst.SUMMER_SKIN_EXCHANGE == slot0 then
			return "UI/SummerUI/SummerSkinTrialObtainUI"
		else
			return "UI/SummerUI/SummerSkinTrialObtainUI"
		end
	end,
	IsCanExchange = function (slot0)
		if ActivityData:GetActivityData(slot0) and slot1.IsActivitying(slot1) then
			if SkinExchangeData:GetState(slot0) == 1 then
				return false, GetTips("ERROR_CLUB_REWARD_ALREADY_SIGN")
			end
		else
			return false, GetTips("SOLO_NOT_OPEN")
		end

		slot2 = true
		slot4, slot5, slot6 = nil
		slot7 = ""

		for slot11, slot12 in ipairs(ActivitySkinExchangeCfg[slot0].cost) do
			if CurrencyData:GetCurrencyByID(slot12[1]).num < slot12[2] then
				slot2 = false
				slot7 = string.format(GetTips("CURRENCY_NO_ENOUGH"), GetI18NText(ItemCfg[slot4].name))

				break
			end
		end

		return slot2, slot7
	end
}
