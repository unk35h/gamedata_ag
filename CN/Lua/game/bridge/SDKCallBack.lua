slot0 = require("cjson")
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = {}

function OnGameSdkCallback(slot0)
	slot1 = uv0.decode(slot0) or {}
	slot2 = slot1.callbackType

	print("OnGameSdkCallback messageType", slot2, slot1.code)

	slot3 = uv1[slot2]
	uv1[slot2] = nil

	if slot2 == "Login" then
		_G.LOGIN_TYPE = slot1.channelLoginType
		_G.APP_ID = slot1.appId
		_G.YONGSHI_ID = slot1.id
		_G.B_SDK_ID = slot1.b_sdk_appid
		_G.CHANNEL_UDID = slot1.channelUdid
		_G.CHANNEL_USERID = slot1.channelUserId

		SDKTools.SetPublicAttribute({
			channel_id = slot1.channelId,
			yongshi_id = slot1.id
		})

		uv2 = slot1
		_G.CPUINFO = tostring(UnityEngine.SystemInfo.processorType .. "-" .. tostring(UnityEngine.SystemInfo.processorFrequency) .. "-" .. tostring(UnityEngine.SystemInfo.processorCount))
		_G.TMP_ACCOUNT_ID = tostring(uv2.id)
		slot4 = "Not Reachable"

		if Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
			slot4 = "WIFI"
		elseif Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork then
			slot4 = "4G/5G"
		end

		_G.NETTYPE = slot4

		SendMessageManagerToSDK("SDKLoginSuccess")

		if gameContext:GetOpenPageHandler("login") then
			slot5.SetSDKId(slot5)
		end
	elseif slot2 == "Inited" then
		SDKInited()
	elseif slot2 == "ReLogin" then
		SDKTools.SetSignOutAttribute()
		ReconnectLogic.ReconnectError()

		uv2 = nil
	elseif slot2 == "Exit" then
		Quit()
	elseif slot2 == "AntiAddiction" then
		AntiAddiction(slot1)
	elseif slot2 == "ShowQuitConfirm" then
		ShowQuitConfirm()
	elseif slot2 == "GetBulletin" then
		GetBulletin(slot1)
	elseif slot2 == "DeviceInfoGet" then
		DeviceInfoGet(slot1)
	elseif slot2 == "UpdateInfoGet" then
		UpdateInfoGet(slot1.info1, slot1.info2)
	elseif slot2 == "NeedGameUserInfo" then
		NeedGameUserInfo()
	elseif slot2 == "ReceivePushNotification" then
		ReceivePushNotification(slot1.message)
	elseif slot2 == "MarketCommentsNoSupport" then
		MarketCommentsNoSupport(slot1)
	elseif slot2 == "ChannelLoginInfoGet" then
		ChannelLoginInfoGet(slot1)
	elseif slot2 == "payResult" then
		manager.notify:Invoke(RECHARGE_SDK_SUCCESS)
	elseif slot2 == "payFailed" then
		slot4 = slot1.errorMsg or ""

		ShowTips(slot4)
		print(string.format("充值失败， errorMsg = %s", slot4))
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_stop = gameContext.routes_[#gameContext.routes_]
		})
		manager.notify:Invoke(RECHARGE_FAILED, slot4)
	elseif slot2 == "LoginFailed" then
		_G.clickCDing_ = false
		_G.isLogining = false
		slot4 = slot1.message or ""

		ShowTips(slot4)
		print(string.format("Login Failed, messager = %s", slot4))

		uv2 = nil

		SendMessageManagerToSDK("SDKLoginFailed")
	elseif slot2 == "CustomerServiceUnreadMsg" then
		slot4 = slot1.num or 0

		print(string.format("CustomerServiceUnreadMsg, callbackInfo.num = %s", tostring(slot4)))
		manager.redPoint:setTip(RedPointConst.CUSTOMER_SERVICE_UNREAD, slot4 == 0 and 0 or 1)
	elseif slot2 == "iosWillPopupPay" then
		manager.notify:Invoke(RECHARGE_WILL_POPUP)
	elseif slot2 == "shareCallback" then
		slot4 = slot1.code

		manager.notify:Invoke(SHARE_CALLBACK, slot4)

		if slot4 == 0 then
			ShowTips("SHARE_SUCCESS")
		elseif slot4 == 2 then
			ShowTips("SHARE_CANCEL")
		else
			ShowTips(GetTips("SHARE_FAIL"))
		end
	elseif slot2 == "GetAgeTipCallback" then
		if (slot1.tip or "") ~= nil and slot4 ~= "" then
			manager.notify:Invoke(AGE_TIP_CALLBACK, slot4)
		end
	elseif slot2 == "getPlatformData" then
		manager.notify:Invoke(GET_PLATFORM_DATA_CALLBACK, slot1)
	end

	if slot3 then
		if uv3[slot2] then
			uv3[slot2](slot1)

			uv3[slot2] = nil
		end

		if uv4 and uv4[slot2] and #uv4[slot2] > 0 then
			slot4 = table.remove(uv4[slot2], 1)

			SendMessageToSDKWithCallBack(slot4.sendString, slot4.waitTag, slot4.callBack)
		end
	end
end

function SDKInited()
	GameToSDK.IsSDKInited = true
end

function GetBulletin(slot0)
	_G.bulletinInfo = slot0
	_G.bulletinInfoGetted = true
end

slot5 = false

function EvokeGateWayLogin()
	if uv0 and uv0.token then
		if not uv1 then
			uv1 = true

			LuaForUtil.GetIsMaintainByGMSDK(function (slot0, slot1)
				uv0 = false

				if _G.isLogining then
					return
				end

				if slot0 then
					ShowMessageBox({
						ButtonType = "SingleBtn",
						isTop = true,
						content = string.isNullOrEmpty(slot1) and GetTips("SERVER_MAINTENANCE") or slot1,
						OkCallback = function ()
						end
					})
				else
					print("唤起网关登录")
					GateWayLogin(uv1)
				end
			end)
		end

		return true
	else
		return false
	end
end

function GateWayLogin(slot0)
	SendMessageToSDKWithCallBack("{\"messageType\" : \"GetChannelLoginInfo\"}", "ChannelLoginInfoGet", function ()
		print("sdk登录信息返回")

		if _G.ChannelLoginInfo.code == 0 then
			CheckVersion(function ()
				print(string.format("请求网关登录: id = %s, token = %s, channelId = %s, appId = %s", uv0.id, uv0.token, uv0.channelId, uv0.appId))
				LoginAction.GateWayLogin(uv0.id, uv0.token, uv0.channelId, uv0.appId)
			end)
		end
	end)
end

slot6 = false

function ShowQuitConfirm()
	if uv0 then
		return
	end

	uv0 = true

	ShowMessageBox({
		isTop = true,
		content = GetTips("TIP_QUIT_GAME"),
		OkCallback = function ()
			uv0 = false

			Quit()
		end,
		CancelCallback = function ()
			uv0 = false
		end,
		MaskCallback = function ()
			uv0 = false
		end
	})
end

function AntiAddiction(slot0)
	ShowMessageBox({
		isTop = true,
		ButtonType = "SingleBtn",
		content = slot0.sdkTip ~= nil and slot0.sdkTip or GetTips("ANTIADDICTION_ONLINE_TIME_LIMIT"),
		OkCallback = function ()
			ReconnectLogic.ReconnectError()
		end,
		CancelCallback = function ()
		end
	})
end

function DeviceInfoGet(slot0)
	_G.deviceInfo = slot0

	for slot4, slot5 in pairs(slot0) do
		print(string.format("deviceInfo.%s = %s", slot4, slot5))
	end
end

function MarketCommentsNoSupport()
	OperationAction.OpenOperationUrl("OFFICIAL_DISCUSS_URL", {
		gameAppId = _G.ChannelLoginInfo.channelAppId,
		token = _G.ChannelLoginInfo.channelToken
	})
end

function ChannelLoginInfoGet(slot0)
	_G.ChannelLoginInfo = slot0
end

function NeedGameUserInfo()
	slot0 = PlayerData:GetPlayerInfo()
	slot1 = _G.TMP_ACCOUNT_ID
	slot2 = slot0.nick
	slot3 = slot0.userID

	if slot0.userID == 1 then
		return
	end

	SendMessageToSDK(string.format("{\"messageType\" : \"SendGameUserInfo\", \"accountId\" : \"%s\",\"nickName\" : \"%s\" , \"uId\" : \"%d\", \"maxChapterLevel\" : \"%s\", \"createTime\" : \"%s\", \"userLv\" : \"%d\", \"maxChallengeLv\" : \"%s\", \"channel\" : \"%s\", \"rechargeNum\" : \"%s\", \"region\" : \"%s\", \"mixId\" : \"%s\", \"maxTower\" : \"%s\", \"serverId\" : %d, \"currency\" : %d }", slot1, slot2, slot3, BattleChapterStageCfg[BattleInstance.GetCurrentBattleId()].name, manager.time:STimeDescS(slot0.register_timestamp, "!%Y/%m/%d %H:%M"), slot0.userLevel, BattleTowerStageCfg[TowerData:GetTowerMaxId()] and BattleTowerStageCfg[slot7].name or "", tostring(_G.CHANNEL_MASTER_ID), tostring(RechargeData:GetTotalRechargeNum()), "暂无区组", tostring(_G.YONGSHI_ID), tostring(TowerData:GetTowerMaxId()), _G.TMP_SERVER_ID, CurrencyData:GetRechargeDiamond()))
	GameToSDK.UpUserInfo(PlayerTools.PackUserData("UpdateData"))
end

function ReceivePushNotification(slot0)
	ShowTips(slot0)
end

function SendMessageToSDK(slot0)
	GameToSDK.SendMessage(slot0)
end

function SendMessageToSDKWithCallBack(slot0, slot1, slot2)
	if uv0[slot1] then
		if uv1[slot1] == nil then
			uv1[slot1] = {}
		end

		table.insert(uv1[slot1], {
			sendString = slot0,
			waitTag = slot1,
			callBack = slot2
		})

		return
	end

	print("SendMessageToSDKWithCallBack", slot0, slot1)
	GameToSDK.SendMessage(slot0)

	if GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV then
		slot2()

		return
	end

	uv0[slot1] = true
	uv2[slot1] = slot2
end

function ReceiveSavePhotoMessage(slot0, slot1)
	if slot0 then
		ShowTips("SAVE_PHOTO_SUCCESS")
	else
		ShowTips("SAVE_PHOTO_FAIL")
	end
end
