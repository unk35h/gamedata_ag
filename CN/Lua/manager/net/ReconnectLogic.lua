slot0 = class("ReconnectLogic")
slot1 = import("game.const.LoginConst")
slot2 = import("game.tools.JumpTools")
slot0.reconnectRetryCount = 3
slot0.loginRetryCount = 0

function slot0.ReconnectError(slot0)
	_G.isLogining = false

	if slot0 == uv0.NEED_UPDATE then
		uv1.NeedToUpdate()

		return
	end

	slot1 = nil

	Timer.New(function ()
		manager.windowBar:ClearWhereTag()

		if LuaExchangeHelper.GetSceneIsHanding() then
			return
		end

		uv0:Stop()
		print("whereami", whereami)

		if whereami == "battle" or whereami == "battleResult" then
			gameContext:DestroyCurRoutes()

			gameContext.oldRoutes_ = {}
		end

		GameToSDK.UpUserEvent("{\"eventType\" : \"End\"}")
		manager.video:Dispose()
		manager.story:Dispose()
		manager.net:Disconnect()
		manager.net:ChatDisconnect()
		manager.messageBox:HideAll()
		manager.guide:OnLogout()
		ActivityAction.OnLogout()
		GuildActivityAction.OnLogout()
		BulletinData.OnLogout()

		if manager.ChessManager then
			manager.ChessManager:Dispose()

			manager.ChessManager = nil
		end

		SetForceShowQuanquan(false)
		manager.ui:UIEventEnabledByUI(true, false)
		ResetSceneDataForExcehange()
		_G.gameTimer:Dispose()

		if table.nums(gameContext.oldRoutes_) == 0 and not LuaExchangeHelper.GetSceneIsHanding() then
			DestroyLua()
			LuaExchangeHelper.GoToMain()
		end

		uv1.loginRetryCount = 0

		uv2.OpenPageUntilLoaded("/login")

		function slot1()
			ReduxFactory.GetInstance():ClearCacheViews()

			if uv0 then
				ShowMessageBox({
					isTop = true,
					title = GetTips("PROMPT"),
					content = GetTips(uv1.KICK_REASON[uv0] or "DATA_ERROR_TO_LOGIN"),
					OkCallback = function ()
					end,
					CancelCallback = function ()
						Quit()
					end
				})
			end

			manager.ui:SetUIDText("")
		end

		if LuaExchangeHelper.GetSceneIsHanding() then
			_G.OnLoadedCallBack_ = slot1
		else
			slot1()
		end
	end, 0.2, -1):Start()
end

function slot0.NeedToUpdate()
	ShowNeedUpdateWindow()
end

function slot0.CheckChatConnectStatusAndTryReconnect(slot0)
	if manager.net:GetChatTCPState() == "disconnected" then
		uv0.TryToReconnectChat(nil, , slot0)
	elseif slot1 == "connected" then
		slot0:resolve()
	else
		slot0:reject("unexpect tcp state:" .. slot1)
	end
end

function slot0.TryToReconnectChat(slot0, slot1, slot2)
	if slot1 then
		print("TryReconnect error ", slot0, tostring(slot1))

		if type(slot1) == "table" then
			print_r(slot1)
		end
	end

	if slot0 == "error" and slot1 == SocketError.ConnectionReset then
		ShowTips("CANNOT_CONNECT_CHAT")

		return
	end

	slot3 = ActionCreators.ChatReconnect()

	slot3:next(function (slot0)
		uv0:resolve()
	end, function (slot0, slot1)
		ShowTips("CANNOT_CONNECT_CHAT")
		uv0:reject("can not connect to chat server")
	end)
end

return slot0
