slot0 = class("StreamConnection")
slot1 = false

function slot2(...)
	if uv0 then
		print(...)
	end
end

slot3 = {
	CONNECTED = "connected",
	DISCONNECTED = "disconnected",
	CONNECTING = "connecting",
	NONE = "none"
}
slot4 = 20
slot5 = 5
slot6 = 10
slot7 = 90
slot8 = 5
slot9 = 10

function slot0.Ctor(slot0, slot1)
	slot0.connectType_ = slot1

	slot0:Reset()
end

function slot0.Reset(slot0)
	slot0.netStatus = uv0.NONE
	slot0.reconnectTryTime_ = 0
	slot0.errorHandlingTime_ = 0
	slot0.packetList_ = {}
	slot0.sendingPacketCount = {}
	slot0.connection_ = nil
	slot0.notifies_ = slot0.notifies_ or {}
	slot0.idx_ = 1
	slot0.serverIdx_ = 0
	slot0.syncSendQueue_ = {}
	slot0.syncSendNoQueueTmp_ = {}
	slot0.waitCallbacks_ = {}
	slot0.OnConnectedHandler_ = handler(slot0, slot0.OnConnectedHandler)
	slot0.OnDisconnectedHandler_ = handler(slot0, slot0.OnDisconnectedHandler)
	slot0.OnReceiveHandler_ = handler(slot0, slot0.OnReceiveHandler)
	slot0.OnSocketError_ = handler(slot0, slot0.OnSocketError)
	slot0.isPauseSendPacket_ = false

	print("===============================connection reset=========================================")
end

function slot0.Connect(slot0, slot1, slot2, slot3)
	if slot0.netStatus ~= uv0.CONNECTING and slot0.netStatus ~= uv0.CONNECTED then
		slot0.netStatus = uv0.CONNECTING
		slot0.peerAddr_ = slot1
		slot0.peerPort_ = slot2
		slot0.onConnectExternal_ = slot3
		slot0.connection_ = YSTcpConnection.New(slot0.peerAddr_, slot0.peerPort_)

		slot0.connection_.onConnected:AddListener(slot0.OnConnectedHandler_)
		slot0.connection_.onDisconnected:AddListener(slot0.OnDisconnectedHandler_)
		slot0.connection_:Connect()

		if slot0.frameTimer_ then
			slot0.frameTimer_:Stop()

			slot0.frameTimer_ = nil
		end

		slot5 = 0
		slot0.frameTimer_ = FrameTimer.New(function ()
			if uv0.netStatus == uv1.CONNECTED or uv0.netStatus == uv1.CONNECTING then
				uv0.connection_:AsyncUpdate()
			end

			uv0:AddCallBackTime()

			uv2 = uv2 + 1

			if uv3 < uv2 then
				uv0:AutoReconnect()

				uv2 = 0
			end
		end, 1, -1)

		slot0.frameTimer_:Start()
	end
end

function slot0.OnConnectedHandler(slot0, slot1)
	if slot1 == SocketError.Success then
		slot0.netStatus = uv0.CONNECTED

		print("<color=#00ff00>TCP</color> Network connected")
		slot0.connection_.onData:AddListener(slot0.OnReceiveHandler_)
		slot0.connection_.onError:AddListener(slot0.OnSocketError_)

		slot0.reconnectTryTime_ = 0
		slot0.errorHandlingTime_ = 0

		slot0:StartHeartBeat()
	else
		print("<color=#ff0000>TCP</color> Network connect fail", tostring(slot1))

		slot0.netStatus = uv0.DISCONNECTED
	end

	if slot0.onConnectExternal_ then
		slot0.onConnectExternal_(slot1)
	end

	slot0.onConnectExternal_ = nil

	slot0:SendNoQueuePacket()
end

function slot0.StartHeartBeat(slot0)
	if slot0.heartBeatTimer_ == nil and slot0.netStatus == uv0.CONNECTED then
		slot0.heartBeatTimer_ = Timer.New(function ()
			uv0:SendAsync(10050, {
				need_request = 1
			})
		end, uv1, -1)

		slot0.heartBeatTimer_:Start()
	end
end

function slot0.StopHeartBeat(slot0)
	if slot0.heartBeatTimer_ then
		slot0.heartBeatTimer_:Stop()

		slot0.heartBeatTimer_ = nil
	end
end

function slot0.AddCallBackTime(slot0)
	slot1 = false

	for slot5, slot6 in pairs(slot0.waitCallbacks_) do
		slot6.waitTime = slot6.waitTime + Time.deltaTime

		if uv0 < slot6.waitTime then
			print("TimeOut ... ", slot5)

			slot1 = true
		end
	end

	if slot1 and slot0.timeOutFunc_ ~= nil then
		slot0:timeOutFunc_(slot0.connectType_)
	end
end

function slot0.GetIsNeedShowQuanQuan(slot0)
	if uv0 < slot0.reconnectTryTime_ then
		return false
	end

	return slot0.netStatus == uv1.CONNECTING or table.nums(slot0.waitCallbacks_) > 0 or #slot0.syncSendQueue_ > 0
end

function slot0.GetSendingPacketNum(slot0)
	return table.nums(slot0.packetList_)
end

function slot0.CheckConnectStatus(slot0)
	if slot0.netStatus == uv0.DISCONNECTED then
		slot0.reconnectTryTime_ = 0

		slot0:AutoReconnect()
	end
end

function slot0.Disconnect(slot0)
	slot0.syncSendQueue_ = {}
	slot0.waitCallbacks_ = {}
	slot0.syncSendNoQueueTmp_ = {}
	slot0.packetList_ = {}
	slot0.sendingPacketCount = {}

	if slot0.connection_ then
		slot0.connection_:Disconnect()
	end
end

function slot0.OnDisconnectedHandler(slot0, slot1)
	if slot0.netStatus == uv0.DISCONNECTED or slot0.netStatus == uv0.NONE then
		return
	end

	slot0.netStatus = uv0.DISCONNECTED

	if slot0.frameTimer_ then
		slot0.frameTimer_:Stop()

		slot0.frameTimer_ = nil
	end

	slot0:StopHeartBeat()

	if slot0.waitCallbacks_ then
		if slot1 and table.nums(slot0.waitCallbacks_) > 0 and slot0.errorHandlingFunc_ then
			slot0:errorHandlingFunc_(slot0.connectType_, 0, slot1)
		end

		slot0.waitCallbacks_ = {}
	end

	slot0.connection_:Dispose()
	print("<color=#ff0000>TCP</color> Network disconnect by peer")
end

function slot0.RegistReconnectFunc(slot0, slot1)
	slot0.reconnectFunc_ = slot1
end

function slot0.RegistTimeOutFunc(slot0, slot1)
	slot0.timeOutFunc_ = slot1
end

function slot0.RegistErrorHandlingFunc(slot0, slot1)
	slot0.errorHandlingFunc_ = slot1
end

function slot0.ResetReconnectTime(slot0)
	slot0.reconnectTryTime_ = 0
end

function slot0.AutoReconnect(slot0)
	if slot0.netStatus == uv0.DISCONNECTED and (#slot0.syncSendQueue_ > 0 or table.nums(slot0.waitCallbacks_) > 0 or #slot0.syncSendNoQueueTmp_ > 0) then
		if slot0.reconnectTryTime_ < uv1 then
			slot0.reconnectTryTime_ = slot0.reconnectTryTime_ + 1

			if slot0.reconnectFunc_ then
				slot0.reconnectFunc_()
			else
				slot0:Reconnect()
			end
		elseif slot0.reconnectTryTime_ == uv1 then
			slot0.reconnectTryTime_ = slot0.reconnectTryTime_ + 1

			if slot0.errorHandlingFunc_ then
				slot0.errorHandlingTime_ = slot0.errorHandlingTime_ + 1

				slot0:errorHandlingFunc_(slot0.connectType_, slot0.errorHandlingTime_)
			end
		end
	end
end

function slot0.Reconnect(slot0, slot1)
	print("===================reconnect=========================")

	if slot0.netStatus == uv0.DISCONNECTED then
		slot0:Connect(slot0.peerAddr_, slot0.peerPort_, slot1)
	else
		print("reconnect faile: status: " + slot0.netStatus)
	end
end

function slot0.OnReceiveHandler(slot0, slot1)
	if slot1.Cmd ~= 10051 then
		print(string.format("Network received protocol %d, %d, currentIndex %d", slot1.Cmd, slot1.Index, slot0.serverIdx_), slot1.ServerIndex)
	end

	slot2 = slot1.Cmd
	slot0.packetList_[slot2] = nil
	slot0.sendingPacketCount[slot2] = 0
	slot3 = Protocol.Unpack(slot2, slot1:getLuaStringBuffer())

	if slot1.ServerIndex > 0 then
		slot0.serverIdx_ = slot1.ServerIndex
	end

	if slot0.notifies_[slot2] then
		for slot7, slot8 in ipairs(slot0.notifies_[slot2]) do
			uv0("notify", slot2, slot8)
			slot8(slot3)
		end
	end

	if slot0.waitCallbacks_[slot2 .. "_" .. slot1.Index] then
		uv0("sync notify", slot4)

		if slot5[slot4].callback then
			slot5[slot4].callback(slot3, slot5[slot4].data)
		end

		slot0.lastDelayTime_ = slot5[slot4].waitTime
		slot5[slot4] = nil
	elseif slot5[slot2] then
		uv0("sync notify", slot2)

		if slot5[slot2].callback then
			slot5[slot2].callback(slot3, slot5[slot2].data)
		end

		slot0.lastDelayTime_ = slot5[slot2].waitTime
		slot5[slot2] = nil
	else
		uv0("can not find callback function!!!!", slot2, slot4)
	end
end

function slot0.OnSocketError(slot0, slot1)
	print("<color=#ff0000>TCP</color> Network error: " .. tostring(slot1))

	if slot0.errorHandlingFunc_ then
		slot0:errorHandlingFunc_(slot0.connectType_, slot0.errorHandlingTime_, tostring(slot1))
	end

	slot0:OnDisconnectedHandler()
end

function slot0.SendSyncImplOneByOne(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if slot0.packetList_[slot3] then
		print("正在发送中.... 丢弃！！！！！！！！！", slot1)

		slot0.sendingPacketCount[slot3] = (slot0.sendingPacketCount[slot3] or 0) + 1

		if uv0 < slot0.sendingPacketCount[slot3] or uv1 < #slot0.syncSendQueue_ then
			print("堆积过多的包，进行重连操作", slot1)

			if slot0.timeOutFunc_ ~= nil then
				slot0:timeOutFunc_(slot0.connectType_)
			end
		end

		return
	end

	slot0.packetList_[slot3] = true

	slot0:EnQueuePacket(slot1, slot2, slot3, slot4, slot5, slot6, slot7)

	if slot0.netStatus == uv2.CONNECTED then
		slot0:StartSendPacket()
	else
		slot0:CheckConnectStatus()
	end
end

function slot0.SendSyncNoEnqueueImpl(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if slot0.netStatus == uv0.CONNECTED then
		slot0:SendSyncImpl(slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	else
		table.insert(slot0.syncSendNoQueueTmp_, {
			slot1,
			slot2,
			slot3,
			slot4,
			slot5,
			slot6,
			slot7
		})
		slot0:CheckConnectStatus()
	end
end

function slot0.SendSyncImpl(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	uv0("SendSync", slot1, slot2, slot3, slot4, slot5, slot6, slot7)

	slot8 = nil
	slot0.waitCallbacks_[slot5 and slot3 .. "_" .. slot0.idx_ or slot3] = {
		waitTime = 0,
		callback = slot4,
		data = slot2
	}

	if slot5 then
		slot0:SendBuildProtocol(slot0.idx_, slot0.serverIdx_, slot1, slot2)

		slot0.idx_ = slot0.idx_ + 1
	else
		slot0:SendBuildProtocol(0, slot0.serverIdx_, slot1, slot2)
	end
end

function slot0.SendBuildProtocol(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot3 == 10050 and _G.PrintAllOpen_ then
		-- Nothing
	end

	Protocol.BuildProtocolMessage(Protocol.GetProtocolWithName("cs_" .. slot3):GetMessage(), slot4)

	if slot3 ~= 10050 or _G.PrintAllOpen_ then
		print("index", slot1, slot2, slot3, slot0.connectType_)
	end

	if slot0.connection_ then
		slot0.connection_:Send(Protocol.Pack(slot1, slot2, slot6:GetId(), slot7, slot5))
	end
end

function slot0.EnQueuePacket(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	table.insert(slot0.syncSendQueue_, {
		slot1,
		slot2,
		slot3,
		slot4,
		slot5,
		slot6,
		slot7
	})
end

function slot0.OnSendComplete(slot0)
	slot1 = table.remove(slot0.syncSendQueue_, 1)

	slot0:StartSendPacket()
end

function slot0.StartSendPacket(slot0)
	if #slot0.syncSendQueue_ > 0 and not slot0.isPauseSendPacket_ then
		slot0:SendSyncImpl(unpack(slot0.syncSendQueue_[1]))
		slot0:OnSendComplete()
	end
end

function slot0.SendNoQueuePacket(slot0)
	for slot4 = 1, #slot0.syncSendNoQueueTmp_ do
		slot0:SendSyncImpl(unpack(slot0.syncSendNoQueueTmp_[slot4]))
	end

	slot0.syncSendNoQueueTmp_ = {}
end

function slot0.SetIsPauseSendPacket(slot0, slot1)
	slot0.isPauseSendPacket_ = slot1

	if not slot1 then
		slot0:StartSendPacket()
	end
end

function slot0.SendAsync(slot0, ...)
	if slot0.netStatus == uv0.CONNECTED then
		slot0:SendBuildProtocol(0, slot0.serverIdx_, ...)
	end
end

function slot0.SendSync(slot0, ...)
	slot0:SendSyncImplOneByOne(...)
end

function slot0.SendSyncNoEnqueue(slot0, ...)
	slot0:SendSyncNoEnqueueImpl(...)
end

function slot0.RegistPushWaiting(slot0, slot1, slot2)
	slot0.waitCallbacks_[slot1] = {
		waitTime = 0,
		callback = slot2
	}

	slot0:CheckConnectStatus()
end

function slot0.Bind(slot0, slot1, slot2)
	if not slot0.notifies_[slot1] then
		slot0.notifies_[slot1] = {}
	end

	if not table.indexof(slot0.notifies_[slot1], slot2) then
		uv0("Bind", slot1, slot2)
		table.insert(slot0.notifies_[slot1], slot2)
	else
		print("sc_" .. slot1 .. " StreamConnection:Bind twice.")
	end
end

function slot0.UnBind(slot0, slot1, slot2)
	if slot0.notifies_[slot1] then
		if slot2 == nil then
			uv0("UnBind", slot1, "all")

			slot0.notifies_[slot1] = nil
		else
			for slot7 = #slot0.notifies_[slot1], 1 do
				if slot3[slot7] == slot2 then
					uv0("UnBind", slot1, slot2)
					table.remove(slot3, slot7)

					break
				end
			end
		end
	end
end

function slot0.GetDelayTime(slot0)
	return slot0.lastDelayTime_ or 0
end

function slot0.GetMachineState(slot0)
	return slot0.netStatus
end

function slot0.GetConnectHostAndPort(slot0)
	return slot0.peerAddr_, slot0.peerPort_
end

return slot0
