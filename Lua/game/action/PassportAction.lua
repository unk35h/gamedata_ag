slot1 = manager.net

slot1:Bind(34031, function (slot0)
	PassportData:InitWithServerData(slot0)
	uv0.UpdateBonusRedPoint()
	TaskAction:UpdatePassportTaskRedTip()
end)

slot1 = manager.notify

slot1:RegistListener(PLAYER_LEVEL_UP, function ()
	uv0.UpdateBonusRedPoint()
	TaskAction:UpdatePassportTaskRedTip()
end)

slot1 = manager.notify

slot1:RegistListener(CURRENCY_UPDATE, function (slot0)
	if slot0 == CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP then
		uv0.UpdateBonusRedPoint()
	end
end)

slot1 = nil

return {
	UpdateBonusRedPoint = function ()
		manager.redPoint:setTip(RedPointConst.PASSPORT_BONUS, #PassportData:GetCanGetBonusList() > 0 and (PassportData:IsOpen() and PassportData:IsUnlock()) and 1 or 0)
	end,
	RequestPassportData = function ()
		manager.net:SendWithLoadingNew(34030, {}, 34031, uv0.OnPassportData)
	end,
	OnPassportData = function (slot0, slot1)
		PassportData:InitWithServerData(slot0)
		uv0.UpdateBonusRedPoint()

		if PassportData:GetPayLevel() <= 0 then
			for slot6, slot7 in pairs(gameContext:GetAllOpenPage()) do
				if slot7.__cname == "PassportMainView" then
					gameContext:Go("/home")
					ShowTips("BATTLEPASS_EXPIRED")

					break
				end
			end
		end

		TaskAction:UpdatePassportTaskRedTip()
	end,
	RequestGetBonus = function (slot0, slot1)
		manager.net:SendWithLoadingNew(34032, {
			id = slot0,
			is_pay = slot1
		}, 34033, uv0.OnGetBonus)
	end,
	OnGetBonus = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = slot1.id
			slot3 = slot1.is_pay
			slot4 = BattlePassCfg[slot2]
			slot5 = {}

			if PassportData:GetReceiveInfo(slot2) == nil then
				for slot11, slot12 in pairs(slot4.reward_free) do
					table.insert(slot5, slot12)
				end
			end

			if (slot6 == nil or #slot6 == 1 and slot6[1].isPay == 0) and slot3 > 0 then
				for slot11, slot12 in pairs(slot4.reward_pay) do
					table.insert(slot5, slot12)
				end
			end

			getReward(sortReward(mergeReward(slot5)))
			PassportData:GetBonusSuccess(slot1.id, slot1.is_pay)
			uv0.UpdateBonusRedPoint()
		end
	end,
	BuyLevel = function (slot0)
		manager.net:SendWithLoadingNew(34036, {
			num = slot0
		}, 34037, uv0.OnBuyLevel)
	end,
	OnBuyLevel = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = PassportData:GetLevel()
			slot3 = 0

			for slot7 = slot2 + 1, slot2 + slot1.num do
				slot3 = slot3 + GameLevelSetting[slot7].battlepass_level_exp
			end

			CurrencyData:CurrencyModify(CurrencyConst.CURRENCY_TYPE_DIAMOND, -GameSetting.battlepass_level_price.value[2] * slot1.num)
			CurrencyData:CurrencyModify(CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP, slot3)
			manager.notify:CallUpdateFunc(PASSPORT_ONBUYLEVEL)
			ShowTips("TRANSACTION_SUCCESS")
			uv0.UpdateBonusRedPoint()
		end
	end,
	OneKeyGet = function (slot0)
		uv0 = slot0

		manager.net:SendWithLoadingNew(34034, {}, 34035, uv1.OnOneKeyGet)
	end,
	OnOneKeyGet = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PassportData:MarkAllBonusGet()

			uv0 = mergeReward(uv0)

			getReward(uv0)
			uv1.UpdateBonusRedPoint()
		elseif TipsCfg[slot0.result] ~= nil then
			ShowTips(TipsCfg[slot0.result].desc)
		else
			ShowTips(GetTips(tostring(slot0.result)))
		end

		uv0 = nil
	end
}
