slot0 = require("cjson")
slot1 = {
	RefreshAllRedPoint = function ()
		uv0.UpdateFreeGiftRedPoint(uv1)
		uv0.UpdateFirstChargeRedPoint()
	end,
	StartTimer = function ()
		if uv0 == nil then
			uv0 = Timer.New(function ()
				uv0.UpdateFreeGiftRedPoint(uv1)
			end, 1, -1)
		end

		uv0:Start()
	end,
	StopTimer = function ()
		if uv0 then
			uv0:Stop()

			uv0 = nil
		end
	end
}
slot2 = {
	ShopConst.SHOP_ID.LIMIT_TIME,
	ShopConst.SHOP_ID.CYCLE,
	ShopConst.SHOP_ID.NEWBIE,
	ShopConst.SHOP_ID.DAILY,
	ShopConst.SHOP_ID.DATA_EXCHANGE
}
slot3, slot4, slot5 = nil
slot6 = nil

slot1.StartTimer()

slot7 = manager.net

slot7:Bind(34009, function (slot0)
	slot1 = slot0.order

	print(string.format("=======> pay result, channel = %s, platform = %s, create_timestamp = %s", tostring(slot1.channel), tostring(slot1.platform), tostring(slot1.create_timestamp)))

	if SDKTools.IsSDK() and (slot1.channel ~= uv0 or slot1.platform ~= uv1 or slot1.create_timestamp ~= uv2) then
		return
	end

	if uv3.payTimer_ ~= nil then
		uv3.payTimer_:Stop()

		uv3.payTimer_ = nil
	end

	uv3.ShowWaiting(false)

	slot2 = slot1.order_id
	slot3 = slot1.goods_id
	slot4 = slot1.num
	slot5 = slot1.value
	slot6 = slot1.sign
	slot7 = slot1.state
	slot8 = PaymentCfg[slot3]

	ShowTips(string.format(GetTips("PAY_SUCCESS"), slot8.name))
	RechargeData:RecordTotalRecharge(slot3)
	uv3.UpdateTotalRechargeRedPoint()

	if slot8.type == 1 then
		RechargeData:RecordRecharge(slot3)
	elseif slot8.type == 2 then
		RechargeData:SignToday()
	elseif slot8.type == 3 then
		PassportData:BuyedCard(slot8.id)
	end

	if slot0.reward and #slot0.reward > 0 then
		slot9 = {}

		for slot13, slot14 in ipairs(slot0.reward) do
			table.insert(slot9, {
				slot14.item_id,
				slot14.item_num
			})
		end

		getReward(mergeReward(slot9), nil, function ()
			manager.notify:Invoke(RECHARGE_SUCCESS, uv0.id)
		end)
	else
		manager.notify:Invoke(RECHARGE_SUCCESS, slot8.id)
	end

	if slot8.type == 1 then
		SendMessageManagerToSDK("purchase_crystal", {
			purchaseNum = slot4
		})
	elseif slot8.type == 3 then
		SendMessageManagerToSDK("passport_complete")
	elseif slot8.type == 4 then
		SendMessageManagerToSDK("purchase_complete_skin")
	end
end)

slot7 = manager.notify

slot7:RegistListener(RECHARGE_FAILED, function ()
	uv0.ShowWaiting(false)
end)

slot7 = manager.notify

slot7:RegistListener(PLAYER_LEVEL_UP, function ()
	uv0.RefreshAllRedPoint()
end)

slot7 = manager.notify

slot7:RegistListener(OPERATION_STOP_UPDATE, function ()
	uv0.RefreshAllRedPoint()
end)

slot7 = manager.notify

slot7:RegistListener(SHOP_LIST_UPDATE, function (slot0)
	if slot0 == 0 then
		uv0.RefreshAllRedPoint()
	elseif table.indexof(uv1, slot0) then
		uv0.UpdateFreeGiftRedPoint({
			slot0
		})
	end
end)

slot7 = manager.notify

slot7:RegistListener(SHOP_ITEM_UPDATE, function (slot0, slot1)
	if slot0 == 15 or slot0 == 16 or slot0 == 22 or slot0 == 23 or slot0 == 25 then
		uv0.RefreshAllRedPoint()
	end
end)

slot7 = 0
slot8 = manager.net

slot8:Bind(34007, function (slot0)
	RechargeData:InitTotalRechargeDataFromServer(slot0)
	SDKTools.SetRechargePublicAttribute()
	uv0.UpdateTotalRechargeRedPoint()

	uv1 = slot0.total_recharge_num
end)

slot8 = manager.net

slot8:Bind(34021, function (slot0)
	RechargeData:InitFirstChargeDataFromServer(slot0)
end)

slot8 = 0
slot9 = false
slot10 = manager.net

slot10:Bind(34023, function (slot0)
	SendMessageManagerToSDK("purchase_complete_montlycard")

	uv0 = slot0.monthly_card_num
	uv1 = true

	RechargeData:InitWithServerData(slot0)
	SDKTools.SetRechargePublicAttribute()
end)

function slot1.UpdateFirstChargeRedPoint()
	if not manager or not manager.redPoint then
		return
	end

	if RedPointData:GetIsRedPointOpen(RED_POINT_ID.RECHARGE) == true then
		CustomLog.Log(debug.traceback(string.format("isRead")))
	end

	manager.redPoint:setTip(RED_POINT_ID.RECHARGE, slot1 and 0 or 1)
end

function slot1.UpdateFreeGiftRedPoint(slot0)
	for slot4, slot5 in ipairs(slot0) do
		if not ShopData.GetShop(slot5) then
			return
		end

		slot8 = 0

		for slot12, slot13 in pairs(slot6.shopItemIDs) do
			slot14 = slot6[slot13]
			slot15 = getShopCfg(slot13)

			if ShopTools.GetPrice(slot13) == 0 and ShopTools.IsGoodCanDisplay(slot5, slot13) and ShopData.IsGoodUnlock(slot13) == 1 and not ShopData.IsSoldout(slot5, slot13) then
				slot8 = 1
			end
		end

		if OperationData:IsFunctionStoped(ShopListCfg[slot5].operation_stop_id) then
			slot8 = 0
		end

		if slot5 == ShopConst.SHOP_ID.CYCLE then
			manager.redPoint:setTip(RedPointConst.CYCLE_BONUS_FREE, slot8)
		elseif slot5 == ShopConst.SHOP_ID.LIMIT_TIME then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_BONUS_FREE, slot8)
		elseif slot5 == ShopConst.SHOP_ID.NEWBIE then
			manager.redPoint:setTip(RedPointConst.NEWBIE_BONUS_FREE, slot8)
		elseif slot5 == ShopConst.SHOP_ID.DAILY then
			manager.redPoint:setTip(RedPointConst.NORMAL_BONUS_FREE, slot8)
		elseif slot5 == ShopConst.SHOP_ID.DATA_EXCHANGE then
			manager.redPoint:setTip(RedPointConst.REGRESSION_SUPPLY_FREE, slot8)
		end
	end
end

function slot1.UpdateTotalRechargeRedPoint()
	manager.redPoint:setTip(RedPointConst.TOTAL_CHARGE_BONUS, RechargeData:HaveUngetTotalRechargeBonus() and 1 or 0)
end

function slot1.GetMonthCardBonus()
	manager.net:SendWithLoadingNew(34024, {}, 34025, uv0.OnGetMonthCardBonus)
end

function slot1.OnGetMonthCardBonus(slot0, slot1)
	if isSuccess(slot0.result) then
		slot2 = RechargeData

		slot2:SignToday()
		getReward({
			GameSetting.monthly_card_reward_daily.value
		}, nil, function ()
			manager.notify:CallUpdateFunc(MONTH_CARD_DAILY_REWARD)
		end)
		ActivityNewbieTools.SetMonthlyCardSign()
	end
end

function slot1.RequestGSPay(slot0, slot1, slot2, slot3, slot4)
	uv0.gsPayCallback_ = slot4
	slot5 = {
		id = slot0,
		number = slot1 or 1
	}

	if slot2 ~= nil then
		slot5.shop_id = slot2
	end

	if slot3 ~= nil then
		slot5.buy_id = slot3
	end

	manager.net:SendWithLoadingNew(34010, slot5, 34011, uv0.OnRequestGSPayCallback)
	uv0.ShowWaiting(true)
	SendMessageManagerToSDK("purchase_click")
end

function slot1.OnRequestGSPayCallback(slot0, slot1)
	if isSuccess(slot0.result) then
		slot2 = slot0.order

		print("extra_data = " .. slot2.extra_data)

		slot3 = slot2.order_id
		slot4 = slot2.goods_id
		slot5 = slot2.num
		slot6 = slot2.value
		slot7 = slot2.sign
		slot8 = slot2.state
		uv0 = slot2.channel
		uv1 = slot2.platform
		uv2 = slot2.create_timestamp

		print(string.format("=======> pay request, channel = %s, platform = %s, create_timestamp = %s", tostring(uv0), tostring(uv1), tostring(uv2)))

		slot9 = PaymentCfg[slot1.id]
		slot10 = {}
		slot11 = PlayerData:GetPlayerInfo()

		if GameToSDK.PLATFORM_ID == 1 then
			slot10 = {
				productId = slot9.product_id,
				price = slot6 * 100,
				count = slot5,
				outOrderNo = slot3,
				currency = slot9.currency_type,
				extraData = slot2.extra_data,
				orderSign = slot7,
				params = {
					gameRoleId = slot11.userID,
					gameRoleName = slot11.nick,
					gameRoleLevel = slot11.userLevel,
					gameServerId = _G.TMP_SERVER_ID,
					gameServerName = tostring(_G.TMP_SERVER_ID),
					gameServerCode = _G.TMP_SERVER_ID
				}
			}
		elseif GameToSDK.PLATFORM_ID == 0 then
			slot10 = {
				orderId = slot3,
				productId = slot9.product_id,
				productName = slot9.name,
				productDes = slot9.describe,
				price = slot6 * 100,
				count = slot5,
				currentNum = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_RMB),
				gameServerId = _G.TMP_SERVER_ID,
				gameServerName = tostring(_G.TMP_SERVER_ID),
				gameServerCode = _G.TMP_SERVER_ID,
				gameRoleId = slot11.userID,
				gameRoleName = slot11.nick,
				gameRoleLevel = slot11.userLevel,
				currency = slot9.currency_type,
				orderSign = slot7,
				extraData = slot2.extra_data
			}
		end

		GameToSDK.Pay(uv3.encode(slot10))
		uv4.ShowWaiting(true)

		if uv5 <= 0 then
			uv5 = uv5 + slot6

			SendMessageManagerToSDK("purchase_first_ys")
		end

		SendMessageManagerToSDK("purchase_complete")
		SendMessageManagerToSDK("purchase_ys", {
			value = slot6,
			order_id = slot3,
			currency_type = slot9.currency_type
		})
	else
		if TipsCfg[slot0.result] ~= nil then
			ShowTips(TipsCfg[slot0.result].desc)
		else
			ShowTips(GetTips(tostring(slot0.result)))
		end

		uv4.ShowWaiting(false)
	end

	if uv4.gsPayCallback_ ~= nil then
		uv4.gsPayCallback_(slot0)

		uv4.gsPayCallback_ = nil
	end
end

function slot1.GetTotalRechargeBonus(slot0)
	manager.net:SendWithLoadingNew(34012, {
		id = slot0
	}, 34013, uv0.OnGetTotalRechargeBonus)
end

function slot1.OnGetTotalRechargeBonus(slot0, slot1)
	if isSuccess(slot0.result) then
		RechargeData:MarkBonusGet(slot1.id)
		getReward(TotalRechargeCfg[slot1.id].reward)
		manager.notify:Invoke(GET_TOTAL_RECHARGE_BONUS, slot1.id)
		uv0.UpdateTotalRechargeRedPoint()
	end
end

function slot1.ShowWaiting(slot0, slot1)
	slot1 = slot1 or 180

	SetForceShowQuanquan(slot0)

	if slot0 then
		uv0.payTimer_ = TimeTools.StartAfterSeconds(slot1, function ()
			if uv0.payTimer_ ~= nil then
				uv0.payTimer_:Stop()

				uv0.payTimer_ = nil
			end

			SetForceShowQuanquan(false)
		end, {})
	elseif uv0.payTimer_ ~= nil then
		uv0.payTimer_:Stop()

		uv0.payTimer_ = nil
	end
end

return slot1
