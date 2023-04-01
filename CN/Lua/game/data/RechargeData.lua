slot0 = singletonClass("RechargeData")
slot1 = {
	is_sign = 0,
	monthly_card_timestamp = 0,
	monthly_card_num = 0
}
slot2 = {
	totalRechargeNum = 0,
	firstRechargeIdList = {},
	receiveTotalRechargeList = {}
}

function slot0.Init(slot0)
	uv0.monthly_card_num = 0
	uv0.monthly_card_timestamp = 0
	uv0.is_sign = 0
	uv1 = {
		totalRechargeNum = 0,
		firstRechargeIdList = {},
		receiveTotalRechargeList = {}
	}
end

function slot0.InitWithServerData(slot0, slot1)
	uv0.monthly_card_num = slot1.monthly_card_num
	uv0.monthly_card_timestamp = slot1.monthly_card_timestamp
	uv0.is_sign = slot1.is_sign
end

function slot0.InitTotalRechargeDataFromServer(slot0, slot1)
	uv0.totalRechargeNum = slot1.total_recharge_num
	uv0.receiveTotalRechargeList = slot1.receive_total_recharge_list
end

function slot0.InitFirstChargeDataFromServer(slot0, slot1)
	uv0.firstRechargeIdList = slot1.first_recharge_id_list
end

function slot0.IsSignToday(slot0)
	return uv0.is_sign == 1
end

function slot0.HaveMonthCard(slot0)
	return uv0.monthly_card_timestamp > 0 and TimeMgr.GetInstance():GetServerTime() < uv0.monthly_card_timestamp
end

function slot0.SignToday(slot0)
	uv0.is_sign = 1
end

function slot0.ResetSign(slot0)
	uv0.is_sign = 0
end

function slot0.GetCardNum(slot0)
	return uv0.monthly_card_num
end

function slot0.GetMonthCardDeadTime(slot0)
	return uv0.monthly_card_timestamp
end

function slot0.MarkBonusGet(slot0, slot1)
	if not table.indexof(uv0.receiveTotalRechargeList, slot1) then
		table.insert(uv0.receiveTotalRechargeList, slot1)
	end
end

function slot0.GetTotalRechargeNum(slot0)
	return uv0.totalRechargeNum
end

function slot0.HaveGetTotalRechargeBonus(slot0, slot1)
	if not table.indexof(uv0.receiveTotalRechargeList, slot1) then
		return false
	end

	return true
end

function slot0.HaveRecharged(slot0, slot1)
	if not table.indexof(uv0.firstRechargeIdList, slot1) then
		return false
	end

	return true
end

function slot0.RecordTotalRecharge(slot0, slot1)
	uv0.totalRechargeNum = uv0.totalRechargeNum + PaymentCfg[slot1].total_point

	manager.notify:Invoke(TOTAL_RECHARGE_UPDATE, slot1)
	SDKTools.SetRechargePublicAttribute()
	print("totalRechargeData.totalRechargeNum" .. tostring(uv0.totalRechargeNum))
	SendMessageManagerToSDK("charge_Total", {
		total = uv0.totalRechargeNum
	})
end

function slot0.RecordRecharge(slot0, slot1)
	if not table.indexof(uv0.firstRechargeIdList, slot1) then
		table.insert(uv0.firstRechargeIdList, slot1)
	end

	manager.notify:Invoke(RECHARGE_UPDATE, slot1)
end

function slot0.HaveUngetTotalRechargeBonus(slot0)
	for slot4, slot5 in ipairs(TotalRechargeCfg.all) do
		if TotalRechargeCfg[slot5].num <= uv0.totalRechargeNum and not slot0:HaveGetTotalRechargeBonus(slot5) then
			return true
		end
	end

	return false
end

function slot0.GetMonthCardLastDay(slot0)
	if math.floor((slot0:GetMonthCardDeadTime() - TimeMgr.GetInstance():GetServerTime()) / 86400) < 0 then
		slot2 = 0
	end

	return slot2
end

return slot0
