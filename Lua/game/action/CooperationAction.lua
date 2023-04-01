slot1 = manager.net

slot1:Bind(54101, function (slot0)
	CooperationData:InitRoomData(slot0.room_info)
	manager.notify:CallUpdateFunc(COOPERATION_ROOM_INIT)
end)

slot1 = manager.net

slot1:Bind(54103, function (slot0)
	CooperationData:UpdateRoomData(slot0.room_info)
	manager.notify:CallUpdateFunc(COOPERATION_ROOM_UPDATE)
end)

slot1 = manager.net

slot1:Bind(37099, function (slot0)
	slot1 = CooperationData:GetRoomData()
	slot2 = slot1.type
	slot3 = slot1.dest

	CooperationData:ClearRoomData()

	if whereami ~= "home" then
		return
	end

	CooperationTools.GotoCooperationEntry(slot2, slot3)

	slot4 = slot0.reason

	ShowTips("COOPERATION_LEAVE_ROOM")
end)

slot1 = manager.net

slot1:Bind(37101, function (slot0)
	CooperationData:InitInviteInfo(slot0)
	manager.notify:CallUpdateFunc(COOPERATION_INVIT_UPDATE)
end)

slot1 = manager.net

slot1:Bind(37103, function (slot0)
	CooperationData:AddInviteInfo(slot0)
	manager.notify:CallUpdateFunc(COOPERATION_INVIT_UPDATE)
end)

return {
	CreateRoom = function (slot0, slot1, slot2, slot3)
		manager.net:SendWithLoadingNew(37010, {
			dest = slot0,
			type = slot1,
			available = slot2,
			hero_list = slot3,
			battle_vs = LuaForUtil.GetBattleVersion()
		}, 37011, uv0.OnCreateRoomBack)
	end,
	OnCreateRoomBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ChatCooperationData:RemoveChatData()
			CooperationTools.GotoCooperation()
		else
			ShowTips(slot0.result)
		end
	end,
	JoinRoom = function (slot0, slot1)
		manager.net:SendWithLoadingNew(37012, {
			room_id = slot0,
			hero_list = slot1,
			battle_vs = LuaForUtil.GetBattleVersion()
		}, 37013, uv0.OnJoinRoomBack)
	end,
	OnJoinRoomBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ChatCooperationData:RemoveChatData()
			CooperationTools.GotoCooperation()
		else
			ShowTips(slot0.result)
		end
	end,
	QuickJoinRoom = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(37036, {
			dest = slot0,
			type = slot1,
			hero_list = slot2,
			battle_vs = LuaForUtil.GetBattleVersion()
		}, 37037, uv0.OnQuickJoinRoomBack)
	end,
	OnQuickJoinRoomBack = function (slot0)
		if isSuccess(slot0.result) then
			ChatCooperationData:RemoveChatData()
			CooperationTools.GotoCooperation()
		else
			ShowTips(slot0.result)
		end
	end,
	ChangeHero = function (slot0)
		manager.net:SendWithLoadingNew(37016, {
			hero_list = slot0
		}, 37017, uv0.OnChangeHeroBack)
	end,
	OnChangeHeroBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CooperationData:SetCooperationHero(slot1.hero_list[1])
			CooperationTools.GotoCooperation()
		else
			ShowTips(slot0.result)
		end
	end,
	LeaveRoom = function ()
		manager.net:SendWithLoadingNew(37018, {}, 37019, uv0.OnLeaveRoomBack)
	end,
	OnLeaveRoomBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	LeaveCooperationBattle = function (slot0)
		if CooperationData:GetRoomData() then
			slot2 = manager.net

			slot2:SendWithLoadingNew(37018, {}, 37019, function (slot0)
				uv0()
			end)
		else
			slot0()
		end
	end,
	KickOutRoom = function (slot0)
		manager.net:SendWithLoadingNew(37020, {
			uid = slot0
		}, 37021, uv0.OnKickOutRoomBack)
	end,
	OnKickOutRoomBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	ChangeRoomMaster = function (slot0)
		manager.net:SendWithLoadingNew(37022, {
			uid = slot0
		}, 37023, uv0.OnChangeRoomMasterBack)
	end,
	OnChangeRoomMasterBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	GetReady = function ()
		manager.net:SendWithLoadingNew(37024, {}, 37025, uv0.OnGetReadyBack)
	end,
	OnGetReadyBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	CancelReay = function ()
		manager.net:SendWithLoadingNew(37026, {}, 37027, uv0.OnCancelReadyBack)
	end,
	OnCancelReadyBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	ChangeRoomAvailable = function (slot0)
		manager.net:SendWithLoadingNew(37028, {
			available = slot0
		}, 37029, uv0.OnRoomAvailableBack)
	end,
	OnRoomAvailableBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	SendMsg = function (slot0, slot1, slot2)
		slot3 = manager.net

		slot3:SendWithLoadingNew(37030, {
			type = ChatConst.CHAT_CONTENT_TYPE.TEXT,
			content = slot0,
			shield_type = slot1 or ChatConst.VERIFY_STATUS.OBSERVE
		}, 37031, function (slot0)
			uv0(slot0)
		end)
	end,
	SendSticker = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(37030, {
			type = ChatConst.CHAT_CONTENT_TYPE.STICKER,
			content = tostring(slot0),
			shield_type = ChatConst.VERIFY_STATUS.PASS
		}, 37031, function (slot0)
			uv0(slot0)
		end)
	end,
	ThumbsUp = function (slot0)
		manager.net:SendWithLoadingNew(37034, {
			uid = slot0
		}, 37035, uv0.OnThumbsUpBack)
	end,
	OnThumbsUpBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	InvitePlayer = function (slot0, slot1)
		manager.net:SendWithLoadingNew(37110, {
			uid = slot0,
			type = slot1
		}, 37111, uv0.OnInvitePlayerBack)
	end,
	OnInvitePlayerBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CooperationData:SetHadInvited(slot1.uid, slot1.type)
			manager.notify:CallUpdateFunc(COOPERATION_INVIT_SUCCESS)
		else
			ShowTips(slot0.result)
		end
	end,
	DelectInvite = function (slot0)
		manager.net:SendWithLoadingNew(37112, {
			uid_list = slot0
		}, 37113, uv0.OnDelectInviteBack)
	end,
	OnDelectInviteBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			for slot5, slot6 in ipairs(slot1.uid_list) do
				CooperationData:RefuseInvite(slot6)
			end

			manager.notify:CallUpdateFunc(COOPERATION_INVIT_REFUSE)
		else
			ShowTips(slot0.result)
		end
	end,
	ClearInvite = function ()
		slot0 = {}

		if table.length(CooperationData:GetAllInviteList()) <= 0 then
			CooperationData:ClearInvite()
			manager.notify:CallUpdateFunc(COOPERATION_INVIT_CLEAR)

			return
		end

		for slot5, slot6 in pairs(slot1) do
			table.insert(slot0, slot6.uid)
		end

		manager.net:SendWithLoadingNew(37112, {
			uid_list = slot0
		}, 37113, uv0.OnClearInviteBack)
	end,
	OnClearInviteBack = function (slot0)
		if isSuccess(slot0.result) then
			CooperationData:ClearInvite()
			manager.notify:CallUpdateFunc(COOPERATION_INVIT_CLEAR)
		else
			ShowTips(slot0.result)
		end
	end,
	ReceiveInvite = function (slot0)
		manager.net:SendWithLoadingNew(37112, {
			uid_list = slot0
		}, 37113, uv0.OnReceiveInviteBack)
	end,
	OnReceiveInviteBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if CooperationData:GetInvite(slot1.uid_list[1]) then
				if slot3:IsOverdue() then
					ShowTips("COOPERATION_INVITE_OVERDUE")
				else
					CooperationAction.JoinRoom(slot3.room_id, {
						CooperationData:GetCooperationHero(slot3.dest)
					})
				end
			end

			manager.notify:CallUpdateFunc(COOPERATION_INVIT_CLEAR)
		else
			ShowTips(slot0.result)
		end
	end,
	SetInviteRestrict = function (slot0, slot1)
		manager.net:SendWithLoadingNew(37114, {
			type = slot0,
			op = slot1
		}, 37115, uv0.OnSetInvitRestrictBack)
	end,
	OnSetInvitRestrictBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CooperationData:SetInviteRestrict(slot1.type, slot1.op)
			manager.notify:CallUpdateFunc(COOPERATION_INVIT_RESTRICT_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryRecentVisit = function ()
		manager.net:SendWithLoadingNew(37116, {}, 37117, uv0.OnQueryRecentVisitBack)
	end,
	OnQueryRecentVisitBack = function (slot0)
		if isSuccess(slot0.result) then
			CooperationData:InitVisiteList(slot0)
			manager.notify:CallUpdateFunc(COOPERATION_RECENT_VISIT_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end
}
