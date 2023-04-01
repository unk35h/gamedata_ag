slot0 = require("cjson")
slot2 = "EVENT_SIGN_IN"
slot3 = "EVENT_SIGN_OUT"

return {
	IsSDK = function ()
		return GameToSDK.CURRENT_SDK_ID ~= SDK_PLATFORM.DEV
	end,
	ToJsonFormat = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			slot1[slot5] = slot6
		end

		return uv0.encode(slot1)
	end,
	SendPaymentMessageToSDK = function (slot0, slot1)
		uv0.SendMessageToSDK(slot0, slot1)

		uv0.paying = true
	end,
	OnMainHomeViewTop = function ()
		if uv0.paying then
			uv0.paying = false

			uv0.SendMessageToSDK("payment_touch", {
				payment_return = gameContext.routes_[#gameContext.routes_]
			})
		end
	end,
	SendMessageToSDK = function (slot0, slot1)
		SDKAction.SendMessageToSDK(slot0, slot1)
	end,
	SetPublicAttribute = function (slot0)
		slot1 = {
			messageType = "SetPublicAttribute"
		}

		for slot5, slot6 in pairs(slot0) do
			slot1[slot5] = slot6
		end

		SendMessageToSDK(uv0.encode(slot1))
	end,
	SetDefaultPublicAttribute = function ()
		slot0 = PlayerData:GetPlayerInfo()
		slot1 = _G.deviceInfo or {}
		slot2 = {
			messageType = "SetPublicAttribute",
			user_name = slot0.nick,
			level = slot0.userLevel,
			client_vs = tostring(LuaForUtil.GetClientVersion()),
			pay_money = RechargeData:GetTotalRechargeNum() * 100,
			insider_state = RechargeData:GetMonthCardLastDay(),
			total_flower = CurrencyData:GetRechargeDiamond(),
			free_flower = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE),
			dundun = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY),
			gold_coin = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD),
			diamond = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND),
			resource_vs = LuaForUtil.GetResourceVersion()
		}

		if GameToSDK.PLATFORM_ID == 1 then
			slot2.idfa = tostring(slot1.idfa)
			slot2.ios_flower = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_IOS)
		else
			slot2.oaid = tostring(slot1.oaid)
			slot2.mac = tostring(slot1.mac)
			slot2.imei = tostring(slot1.imei)
			slot2.android_flower = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_NOT_IOS)
		end

		SendMessageToSDK(uv0.encode(slot2))
	end,
	SetCurrencyPublicAttribute = function (slot0)
		slot1 = {
			messageType = "SetPublicAttribute"
		}

		if slot0 == CurrencyConst.CURRENCY_TYPE_VITALITY then
			slot1.dundun = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		elseif slot0 == CurrencyConst.CURRENCY_TYPE_GOLD then
			slot1.gold_coin = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD)
		elseif slot0 == CurrencyConst.CURRENCY_TYPE_DIAMOND then
			slot1.diamond = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)
		elseif slot0 == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE then
			slot1.free_flower = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE)
			slot1.total_flower = slot1.free_flower + CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_IOS) + CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_NOT_IOS)
			slot1.ios_flower = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_IOS)
			slot1.android_flower = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_NOT_IOS)
		end

		SendMessageToSDK(uv0.encode(slot1))
	end,
	SetRechargePublicAttribute = function ()
		SendMessageToSDK(uv0.encode({
			messageType = "SetPublicAttribute",
			pay_money = RechargeData:GetTotalRechargeNum() * 100,
			insider_state = RechargeData:GetMonthCardLastDay()
		}))
	end,
	SetSignInAttribute = function ()
		if uv0.GetIsOverSea() then
			return
		end

		SendMessageToSDK(uv2.encode({
			messageType = "SubmitEvent",
			eventId = uv1,
			KEY_USER_ID = PlayerData:GetPlayerInfo().userID
		}))
	end,
	SetSignOutAttribute = function ()
		if uv0.GetIsOverSea() then
			return
		end

		SendMessageToSDK(uv2.encode({
			messageType = "SubmitEvent",
			eventId = uv1,
			KEY_USER_ID = PlayerData:GetPlayerInfo().userID
		}))
	end,
	SetBaseAttribute = function (slot0)
		if not uv0.GetIsOverSea() then
			return
		end

		slot2 = {
			messageType = "SubmitEvent",
			eventId = slot0
		}

		for slot6, slot7 in pairs({
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime()
		}) do
			slot2[slot6] = slot7
		end

		SendMessageToSDK(uv1.encode(slot2))
	end,
	SetParamsAttribute = function (slot0, slot1)
		if not uv0.GetIsOverSea() then
			return
		end

		slot2 = {
			messageType = "SubmitEvent",
			eventId = slot0
		}

		if slot1 then
			for slot6, slot7 in pairs(slot1) do
				slot2[slot6] = slot7
			end
		end

		SendMessageToSDK(uv1.encode(slot2))
	end,
	ShareWithCallback = function (slot0, slot1)
		uv0.shareCallback_ = slot1

		SendMessageToSDKWithCallBack(uv1.encode({
			messageType = "Share",
			url = slot0.url,
			title = slot0.title,
			content = slot0.content,
			imagePath = slot0.imagePath,
			imageUrl = slot0.imageUrl
		}), "shareCallback", function (slot0)
			if slot0 == nil then
				uv0(uv1.platform, {
					code = {
						result = 1
					}
				})

				return
			end

			uv0(slot0.platform, slot0)
		end)
	end,
	ShareWithPlatformCallback = function (slot0, slot1)
		uv0.shareCallback_ = slot1

		SendMessageToSDKWithCallBack(uv1.encode({
			messageType = "ShareWithPlatform",
			platform = slot0.platform,
			url = slot0.url,
			title = slot0.title,
			content = slot0.content,
			imagePath = slot0.imagePath,
			imageUrl = slot0.imageUrl
		}), "shareCallback", function (slot0)
			if slot0 == nil then
				uv0(uv1.platform, {
					code = {
						result = 1
					}
				})

				return
			end

			uv0(slot0.platform, slot0)
		end)
	end,
	PlatformStrToId = function (slot0)
		return ({
			SinaWeibo = 4,
			QZone = 2,
			Wechat = 3,
			WechatMoments = 5,
			QQ = 1
		})[slot0]
	end,
	GetIsArea = function (slot0)
		return GameToSDK.CURRENT_SERVER and GameToSDK.CURRENT_SERVER ~= "" and GameToSDK.CURRENT_SERVER ~= slot0
	end,
	GetIsOverSea = function ()
		return GameToSDK.CURRENT_SERVER and GameToSDK.CURRENT_SERVER ~= "" and GameToSDK.CURRENT_SERVER ~= "zh_cn"
	end,
	GetIsJapan = function ()
		return GameToSDK.CURRENT_SERVER and GameToSDK.CURRENT_SERVER ~= "" and GameToSDK.CURRENT_SERVER == "jp"
	end,
	GetIsEnglish = function ()
		return GameToSDK.CURRENT_SERVER and GameToSDK.CURRENT_SERVER ~= "" and GameToSDK.CURRENT_SERVER == "en"
	end,
	GetIsInputServer = function (slot0)
		return GameToSDK.CURRENT_SERVER and GameToSDK.CURRENT_SERVER ~= "" and GameToSDK.CURRENT_SERVER == slot0
	end,
	GetIsKorea = function ()
		return GameToSDK.CURRENT_SERVER and GameToSDK.CURRENT_SERVER ~= "" and GameToSDK.CURRENT_SERVER == "kr"
	end,
	GetIsThisServer = function (slot0)
		return GameToSDK.CURRENT_SERVER and GameToSDK.CURRENT_SERVER ~= "" and table.indexof(slot0, GameToSDK.CURRENT_SERVER)
	end
}
