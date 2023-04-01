slot0 = class("NetManager")
slot1 = require("manager/net/ReconnectLogic")

function slot0.Ctor(slot0)
	slot0.gateWayConnection_ = StreamConnection.New("gateway")
	slot0.tcpConnection_ = StreamConnection.New("game")
	slot0.chatTcpConnection_ = StreamConnection.New("chat")
	slot0.connectionS_ = {
		gateway = slot0.gateWayConnection_,
		game = slot0.tcpConnection_,
		chat = slot0.chatTcpConnection_
	}

	slot0.tcpConnection_:RegistReconnectFunc(LoginAction.Reconnect)
	slot0.tcpConnection_:RegistErrorHandlingFunc(ConnectionHelper.OnErrorHandling)
	slot0.tcpConnection_:RegistTimeOutFunc(ConnectionHelper.OnTimeOut)

	slot0.frameTimer_ = FrameTimer.New(function ()
		slot0 = false

		for slot4, slot5 in pairs(uv0.connectionS_) do
			slot0 = slot0 or slot5:GetIsNeedShowQuanQuan()
		end

		ShowQuanquan(slot0)
	end, 1, -1)

	slot0.frameTimer_:Start()
end

function slot0.ChatConnect(slot0, slot1, slot2)
	return deferred.new(function (slot0)
		slot1 = uv0.chatTcpConnection_

		slot1:Connect(uv1, uv2, function (slot0)
			if slot0 == SocketError.Success then
				print(string.format("[<color=#00ff00>TCP</color>]connect to <color=#FFDE00FF>%s:%d</color> <color=#00ff00>%s</color>", uv0, uv1, tostring(slot0)))
				print("success")
				uv2:resolve("connect success")
			else
				print(string.format("[<color=#00ff00>TCP</color>]connect to <color=#FFDE00FF>%s:%d</color> <color=#ff0000>%s</color>", uv0, uv1, tostring(slot0)))
				uv2:reject("connect fail")
			end
		end, function (slot0, slot1)
			uv0:reject("connect fail")
		end)
	end)
end

function slot0.ChatReconnect(slot0)
	return deferred.new(function (slot0)
		slot1 = uv0.chatTcpConnection_

		slot1:Reconnect(function (slot0)
			uv0:resolve(slot0)
		end)
	end)
end

function slot0.ChatBind(slot0, slot1, slot2)
	slot0.chatTcpConnection_:Bind(slot1, slot2)
end

function slot0.ChatUnBind(slot0, slot1, slot2)
	slot0.chatTcpConnection_:UnBind(slot1, slot2)
end

function slot0.ChatSendWithLoading(slot0, slot1, slot2, slot3)
	slot4 = true
	slot5 = true
	slot6 = true
	slot7 = deferred.new(function (slot0)
		uv0.CheckChatConnectStatusAndTryReconnect(slot0)
	end)

	return slot7:next(function ()
		slot1 = uv0.chatTcpConnection_

		slot1:SendSync(uv1, uv2, uv3, function (slot0)
			uv0:resolve(slot0)
		end, uv4, uv5, uv6)

		return deferred.new()
	end, function (slot0)
		slot1 = deferred.new()

		slot1:reject(slot0)
		print("reconnect fail", slot0)

		return slot1
	end)
end

function slot0.ChatSendSyncNoEnqueue(slot0, slot1, slot2, slot3, slot4, slot5)
	slot4 = defaultValue(slot4, true)
	slot5 = defaultValue(slot5, true)
	slot6 = false

	return deferred.new(function (slot0)
		slot1 = uv0.chatTcpConnection_

		slot1:SendSyncNoEnqueue(uv1, uv2, uv3, function (slot0)
			uv0:resolve(slot0)
		end, uv4, uv5, uv6, function (slot0)
			uv0:reject(slot0)
		end)
	end)
end

function slot0.ChatPush(slot0, slot1, slot2)
	slot0.chatTcpConnection_:SendAsync(slot1, slot2, true)
end

function slot0.ChatAutoDequeueOn(slot0)
end

function slot0.ChatDisconnect(slot0)
	slot0.chatTcpConnection_:Disconnect()
end

function slot0.GetChatTCPState(slot0)
	return slot0.chatTcpConnection_:GetMachineState()
end

function slot0.Connect(slot0, slot1, slot2, slot3)
	if not slot0.tcpConnection_ then
		slot0.tcpConnection_ = StreamConnection.New()
	end

	slot0.tcpConnection_:Connect(slot1, slot2, slot3)
end

function slot0.GetConnectHostAndPort(slot0, slot1)
	if slot0.connectionS_[slot1 or "game"] then
		return slot0.connectionS_[slot1]:GetConnectHostAndPort()
	end

	return slot0.tcpConnection_:GetConnectHostAndPort()
end

function slot0.Reconnect(slot0, slot1)
	slot0.tcpConnection_:Reconnect(slot1)
end

function slot0.Disconnect(slot0)
	slot0.tcpConnection_:Disconnect()
end

function slot0.AutoDequeueOn(slot0)
	slot0.tcpConnection_:StartSendPacket()
end

function slot0.SetIsPauseSendPacket(slot0, slot1)
	slot0.tcpConnection_:SetIsPauseSendPacket(slot1)
end

function slot0.SendSyncNoEnqueue(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.tcpConnection_:SendSyncNoEnqueue(slot1, slot2, slot3, slot4, defaultValue(slot5, true), defaultValue(slot6, true))
end

function slot0.Push(slot0, slot1, slot2)
	slot0.tcpConnection_:SendAsync(slot1, slot2, true)
end

function slot0.Send(slot0, slot1, slot2, slot3)
	slot4 = true
	slot5 = true
	slot6 = true

	return deferred.new(function (slot0)
		slot1 = uv0.tcpConnection_

		slot1:SendSync(uv1, uv2, uv3, function (slot0)
			uv0:resolve(slot0)
		end, uv4, uv5, uv6)
	end)
end

function slot0.SendWithLoading(slot0, slot1, slot2, slot3)
	slot4 = true
	slot5 = true
	slot6 = true

	return deferred.new(function (slot0)
		slot1 = uv0.tcpConnection_

		slot1:SendSync(uv1, uv2, uv3, function (slot0)
			uv0:resolve(slot0)
		end, uv4, uv5, uv6)
	end)
end

function slot0.SendWithLoadingNew(slot0, slot1, slot2, slot3, slot4)
	slot0.tcpConnection_:SendSync(slot1, slot2, slot3, slot4, true, true)
end

function slot0.RegistPushWaiting(slot0, slot1, slot2)
	slot0.tcpConnection_:RegistPushWaiting(slot1, slot2)
end

function slot0.Bind(slot0, slot1, slot2)
	slot0.tcpConnection_:Bind(slot1, slot2)
end

function slot0.UnBind(slot0, slot1, slot2)
	slot0.tcpConnection_:UnBind(slot1, slot2)
end

function slot0.GetTCPState(slot0, slot1)
	if slot0.connectionS_[slot1 or "game"] then
		return slot0.connectionS_[slot1]:GetMachineState()
	end

	return slot0.tcpConnection_:GetMachineState()
end

function slot0.GetDelayTime(slot0)
	return slot0.tcpConnection_:GetDelayTime()
end

function slot0.GateWayConnect(slot0, slot1, slot2, slot3)
	if not slot0.gateWayConnection_ then
		slot0.gateWayConnection_ = StreamConnection.New()
	end

	slot0.gateWayConnection_:Connect(slot1, slot2, slot3)
end

function slot0.GateWayReconnect(slot0, slot1)
	slot0.gateWayConnection_:Reconnect(slot1)
end

function slot0.GateWaySend(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.gateWayConnection_:SendSyncNoEnqueue(slot1, slot2, slot3, slot4, defaultValue(slot5, true), defaultValue(slot6, true))
end

return slot0
