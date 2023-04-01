slot0 = singletonClass("CurrencyData")
slot1 = 0
slot2 = 0
slot3 = 0
slot4 = false
slot5 = 0
slot6 = {}

function slot0.Init(slot0)
	uv0 = 0
	uv1 = 0
	uv2 = 0
	uv3 = false
	uv4 = 0
	uv5 = {}
	slot4 = ItemConst.ITEM_TYPE.CURRENCY

	for slot4, slot5 in ipairs(ItemCfg.get_id_list_by_type[slot4]) do
		uv5[slot5] = {
			num = 0,
			id = slot5
		}
	end

	manager.notify:Invoke(CURRENCY_UPDATE, 0)
end

function slot0.CurrencyBuyTimes(slot0, slot1, slot2)
	uv0 = slot1
	uv1 = slot2

	manager.notify:Invoke(CURRENCY_BUY_TIME_UPDATE, 0)
end

function slot0.CurrencyInit(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		uv0[slot7.id] = {
			id = slot7.id,
			num = slot7.num
		}

		manager.notify:Invoke(CURRENCY_UPDATE, slot7.id)

		if slot7.id == CurrencyConst.CURRENCY_TYPE_VITALITY and slot7.num <= GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max - GameSetting.push_notification_fatigue_threshold.value[1] then
			slot0:SetFatigueCallFlag(1)
		end
	end

	uv1 = slot2

	SDKTools.SetDefaultPublicAttribute()

	if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].currency_merge == 1 then
		uv0[CurrencyConst.GetPlatformDiamondId()].num = uv0[CurrencyConst.GetPlatformDiamondId()].num + uv0[CurrencyConst.GetOtherPlatformDiamondId()].num
	end
end

function slot0.CurrencyModify(slot0, slot1, slot2, slot3)
	if slot1 == CurrencyConst.GetOtherPlatformDiamondId() and AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].currency_merge == 1 then
		slot1 = CurrencyConst.GetPlatformDiamondId()
	end

	uv0[slot1].num = uv0[slot1].num + slot2

	if slot1 == CurrencyConst.CURRENCY_TYPE_VITALITY and ItemCfg[CurrencyConst.CURRENCY_TYPE_VITALITY].max < uv0[slot1].num then
		uv0[slot1].num = ItemCfg[CurrencyConst.CURRENCY_TYPE_VITALITY].max
	end

	if slot3 and slot1 == CurrencyConst.CURRENCY_TYPE_VITALITY then
		-- Nothing
	end

	manager.notify:Invoke(CURRENCY_UPDATE, slot1)

	if slot1 == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE or slot1 == CurrencyConst.GetPlatformDiamondId() then
		SDKTools.SetCurrencyPublicAttribute(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE)
	elseif slot1 == CurrencyConst.CURRENCY_TYPE_VITALITY then
		SDKTools.SetCurrencyPublicAttribute(slot1)
	elseif slot1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		SDKTools.SetCurrencyPublicAttribute(slot1)
	elseif slot1 == CurrencyConst.CURRENCY_TYPE_DIAMOND then
		SDKTools.SetCurrencyPublicAttribute(slot1)
	end

	if slot1 == CurrencyConst.CURRENCY_TYPE_NEW_RETURN_COIN then
		if slot2 > 0 then
			RegressionAction.SetAccumulateCurrency(slot2)
		end
	elseif slot1 == CurrencyConst.CURRENCY_TYPE_SHIFTING_EXP then
		PolyhedronAction.RefreshPolicyRedPoint()
	end
end

function slot0.CostRechargeDiamond(slot0, slot1)
	slot2 = math.min(slot1, slot0:GetCurrencyMap()[CurrencyConst.GetPlatformDiamondId()].num)

	slot0:CurrencyModify(CurrencyConst.GetPlatformDiamondId(), -slot2)

	if math.max(0, slot1 - slot2) > 0 then
		slot0:CurrencyModify(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE, -slot3)
	end
end

function slot0.GetCurrencyMap(slot0)
	return uv0
end

function slot0.GetCurrencyByID(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetGoldBuyTimes(slot0)
	return uv0
end

function slot0.GetFatigueBuyTimes(slot0)
	return uv0
end

function slot0.GetLastFatigueRecoverTime(slot0)
	return uv0
end

function slot0.GetVitalityFull(slot0)
	return uv0
end

function slot0.VitalityFull(slot0, slot1)
	uv0 = slot1
end

function slot0.GetRechargeDiamond(slot0)
	if CurrencyData:GetCurrencyMap() == nil then
		return 0
	end

	return slot0:GetCurrencyMap()[CurrencyConst.GetPlatformDiamondId()].num + slot0:GetCurrencyMap()[CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE].num
end

function slot0.GetCurrencyNum(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE then
		return slot0:GetRechargeDiamond()
	end

	if CurrencyData:GetCurrencyMap()[slot1] == nil then
		CurrencyData:GetCurrencyMap()[slot1] = {
			num = 0,
			id = slot1
		}

		return 0
	end

	return CurrencyData:GetCurrencyMap()[slot1].num
end

function slot0.SetFatigueCallFlag(slot0, slot1)
	uv0 = slot1
end

function slot0.GetFatigueCallFlag(slot0)
	return uv0
end

function slot0.IsRechargeDiamond(slot0, slot1)
	return slot1 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE.item_id or slot1 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_IOS.item_id or slot1 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_NOT_IOS.item_id
end

return slot0
