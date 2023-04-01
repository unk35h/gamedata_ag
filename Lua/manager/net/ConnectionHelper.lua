slot1 = 3
slot2 = 202001
slot3 = 202002
slot4 = 202003
slot5 = 202005
slot6 = 202006

return {
	OnTimeOut = function (slot0, slot1)
		print("connection", slot0, slot1)

		if slot1 ~= "game" then
			return
		end

		slot0.Disconnect(slot0)
		uv0.ShowReturnToLoginTip()
	end,
	OnWaitServerReturn = function (slot0)
	end,
	OnErrorHandling = function (slot0, slot1, slot2, slot3)
		print("OnErrorHandling", slot0, slot1, slot2, slot3)

		if slot1 ~= "game" then
			return
		end

		if slot3 ~= nil and (slot3 == "ConnectionReset" or slot3 == "DisconnectByServer" or slot3 == "ConnectionAborted") and uv0.DealWithNetError(slot0, slot1, slot2, slot3) then
			return
		end

		if slot2 < uv1 then
			if whereami ~= "battle" and whereami ~= "battleResult" then
				slot0.ResetReconnectTime(slot0)

				return
			end

			ShowMessageBox({
				isTop = true,
				ButtonType = "SingleBtn",
				content = GetTips("CANNOT_CONNECT_CHECK"),
				OkCallback = function ()
					uv0:ResetReconnectTime()
				end,
				CancelCallback = function ()
				end
			})
		elseif slot2 == uv1 then
			uv0.ShowReturnToLoginTip()
		end
	end,
	DealWithNetError = function (slot0, slot1, slot2, slot3)
		if slot3 == "ConnectionReset" or slot3 == "DisconnectByServer" or slot3 == "ConnectionAborted" then
			print("connection:GetSendingPacketNum()", slot0.GetSendingPacketNum(slot0))

			if slot0.GetSendingPacketNum(slot0) > 0 then
				uv0.ShowReturnToLoginTip()

				return true
			end
		end

		return false
	end,
	OnBattleServerConnectError = function (slot0, slot1)
		if slot0 == uv0 then
			if slot1 < uv1 then
				ShowMessageBox({
					isTop = true,
					ButtonType = "SingleBtn",
					content = GetTips("CANNOT_CONNECT_BATTLE"),
					OkCallback = function ()
						TryToStartBattle()
					end,
					CancelCallback = function ()
					end
				})
			elseif slot1 == uv1 then
				uv2.ShowReturnToLoginTip()
			end
		else
			uv2.ShowReturnToLoginTip()
		end
	end,
	IsDealWithError = false,
	GetIsDealWithError = function ()
		return uv0.IsDealWithError
	end,
	ShowReturnToLoginTip = function (slot0)
		manager.net:Disconnect()
		ActivityAction.OnLogout()
		BulletinData.OnLogout()
		SetForceShowQuanquan(false)

		uv0.IsDealWithError = true

		ShowMessageBox({
			isTop = true,
			ButtonType = "SingleBtn",
			content = GetTips(LoginConst.KICK_REASON[slot0] or "CANNOT_CONNECT_QUIT"),
			OkCallback = function ()
				_G.BATTLE_SERVER_ERROR_TIME = 0
				uv0.IsDealWithError = false

				ReconnectLogic.ReconnectError()
			end,
			CancelCallback = function ()
			end
		})
	end
}
