slot1 = manager.net

slot1:Bind(27005, function (slot0)
	if slot0.room_id == ChatData:GetWorldChannelNum() then
		return
	end

	ChatData:SetWorldChannelNum(slot0.room_id)
	manager.notify:Invoke(CHAT_NEW_CHANNEL)
end)

slot1 = manager.net

slot1:Bind(27009, function (slot0)
	ChatData:UpdateMutedLevel(slot0)
end)

slot1 = manager.net

slot1:Bind(27007, function (slot0)
	slot1 = false
	slot2 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	for slot6, slot7 in ipairs(slot0.chat_msg_list) do
		slot8 = table.keyof(slot2, slot7.sender_uid)

		ChatData:AddWorldChat(slot7, slot8)

		if not slot8 then
			slot1 = true
		end
	end

	if slot1 then
		manager.notify:Invoke(CHAT_NEW_MESSAGE)
	end
end)

slot1 = manager.net

slot1:Bind(27019, function (slot0)
	for slot4, slot5 in ipairs(slot0.remove_msg_list) do
		if slot5.channel_type == ChatConst.CHAT_CHANNEL_WORLD then
			uv0.RemoveWorldChat(slot5.msg_id)
		elseif slot5.channel_type == ChatConst.CHAT_CHANNEL_FRIEND then
			uv0.RemoveFriendChat(slot5.msg_id, slot5.sender_uid == USER_ID and slot5.channel_id or slot5.sender_uid)
		elseif slot5.channel_type == ChatConst.CHAT_CHANNEL_GUILD then
			uv0.RemoveGuildChat(slot5.msg_id)
		elseif slot5.channel_type == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY then
			uv0.RemoveChannelChat(slot5.channel_type, slot5.msg_id)
		end
	end
end)

slot1 = manager.net

slot1:Bind(27023, function (slot0)
	if #slot0.msg <= 0 then
		return
	end

	slot1 = {}

	for slot5, slot6 in ipairs(slot0.msg) do
		ChatGuildData:AddChat(slot6)
		table.insert(slot1, slot6.msg_id)
	end

	slot2 = slot0.msg[#slot0.msg]
	slot3 = slot2.content

	if slot2.type == ChatConst.CHAT_CONTENT_TYPE.STICKER then
		slot3 = string.format("[%s]", ChatStickerCfg[tonumber(slot2.content)].name)
	end

	ChatTools.SaveGuildChatCache(GuildData:GetGuildInfo().id or 0)
	manager.notify:Invoke(CHAT_GUILD_NEW_MESSAGE)
	manager.net:Push(19036, {
		channel = ChatConst.CHAT_CHANNEL_GUILD,
		msg_id_list = slot1
	})
end)

slot1 = manager.net

slot1:Bind(19039, function (slot0)
	slot1 = {}
	slot2 = USER_ID
	slot3 = {}

	for slot7, slot8 in ipairs(slot0.friend_msg_list) do
		ChatFriendData:AddChat(slot8)

		slot9 = slot8.content

		if slot8.type == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			slot9 = string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(slot8.content)].name))
		end

		if not table.keyof(slot3, slot2 == slot8.sender_uid and slot8.receive_uid or slot8.sender_uid) then
			table.insert(slot3, slot10)
		end

		FriendsAction:RefreshChat(slot10, slot9, slot8.timestamp)
		FriendsAction:RefreshUnread(slot10, ChatFriendData:GetUnreadMsgCnt(slot10))
		manager.notify:Invoke(CHAT_FRIEND_NEW_MESSAGE, slot10)
		table.insert(slot1, slot8.msg_id)
	end

	ChatTools.SaveFriendsCache(slot3)
	manager.net:Push(19036, {
		channel = ChatConst.CHAT_CHANNEL_FRIEND,
		msg_id_list = slot1
	})
end)

slot1 = manager.net

slot1:Bind(27033, function (slot0)
	if #slot0.msg <= 0 then
		return
	end

	slot1 = {}
	slot2 = slot0.channel_type

	for slot6, slot7 in ipairs(slot0.msg) do
		ChatChannelData:AddChat(slot2, slot7)
		table.insert(slot1, slot7.msg_id)
	end

	slot3 = slot0.msg[#slot0.msg]
	slot4 = slot3.content

	if slot3.type == ChatConst.CHAT_CONTENT_TYPE.STICKER then
		slot4 = string.format("[%s]", ChatStickerCfg[tonumber(slot3.content)].name)
	end

	manager.notify:Invoke(CHAT_NEW_MESSAGE)
	manager.net:Push(19036, {
		channel = slot2,
		msg_id_list = slot1
	})
	ChatTools.SaveChannelChatCache(slot2)
end)

slot1 = manager.net

slot1:Bind(37033, function (slot0)
	ChatCooperationData:AddChat(slot0.msg)
	manager.notify:Invoke(CHAT_COOPERATION_NEW_MESSAGE)
end)

slot1 = manager.net

slot1:Bind(12039, function (slot0)
	ChatStickerData:InitData(slot0)
end)

return {
	RemoveWorldChatAction = function (slot0, slot1, slot2, slot3)
		slot4 = manager.net

		slot4:SendWithLoadingNew(27016, {
			msg_id = slot0,
			sender_uid = slot1,
			channel_type = slot2,
			channel_id = slot3
		}, 27017, function (slot0)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)
			end
		end)
	end,
	RemoveWorldChat = function (slot0)
		ChatData:RemoveWorldChat(slot0)
		manager.notify:Invoke(CHAT_WORLD_RESET)
	end,
	RemoveFriendChatAction = function (slot0, slot1, slot2)
		slot3 = manager.net

		slot3:SendWithLoadingNew(27016, {
			msg_id = slot0,
			sender_uid = slot1,
			channel_type = ChatConst.CHAT_CHANNEL_FRIEND,
			channel_id = slot2
		}, 27017, function (slot0)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)
			end
		end)
	end,
	RemoveFriendChat = function (slot0, slot1)
		if ChatFriendData:RemoveFriendChatContent(slot0, slot1) == 0 then
			return
		end

		if slot2 == #ChatFriendData:GetFriendContent(slot1) then
			slot3 = ChatFriendData:GetLastMsgData(slot1)

			FriendsAction:RefreshChat(slot1, slot3.content, slot3.timestamp)
		end

		FriendsAction:RefreshUnread(slot1, ChatFriendData:GetUnreadMsgCnt(slot1))
		manager.notify:Invoke(CHAT_FRIEND_CHAT_RESET, slot1)
	end,
	RemoveGuildChat = function (slot0)
		if ChatGuildData:RemoveGuildChatContent(slot0) == 0 then
			return
		end

		manager.notify:Invoke(CHAT_GUILD_RESET)
	end,
	RemoveChannelChat = function (slot0, slot1)
		ChatChannelData:RemoveChatContent(slot0, slot1)
		manager.notify:Invoke(CHAT_WORLD_RESET)
	end,
	SetWorldChannelNum = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(27010, {
			room_id = slot0
		}, 27011, function (slot0)
			uv0(slot0.result)
		end)
	end,
	EnterChatUI = function (slot0)
		if manager.net:GetTCPState("game") ~= "connected" then
			return
		end

		slot2 = manager.net

		slot2:SendWithLoadingNew(27012, {
			operation = slot0
		}, 27013, function (slot0)
		end)
	end,
	SendMsg = function (slot0, slot1, slot2)
		if manager.time:GetServerTime() - ChatData:GetSendTextTimestamp() < 10 then
			ShowTips("SEND_MESSAGE_FREQUENTLY")

			return
		end

		if string.sub(slot0, 1, 2) == "$ " then
			manager.net:SendWithLoadingNew(27100, {
				content = slot0
			}, 27101, PrintResult)
		else
			slot3 = manager.net

			slot3:SendWithLoadingNew(27014, {
				type = ChatConst.CHAT_CONTENT_TYPE.TEXT,
				content = slot0,
				shield_type = slot1 or ChatConst.VERIFY_STATUS.OBSERVE
			}, 27015, function (slot0)
				uv0(slot0)
			end)
		end
	end,
	SendSticker = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(27014, {
			type = ChatConst.CHAT_CONTENT_TYPE.STICKER,
			content = tostring(slot0),
			shield_type = ChatConst.VERIFY_STATUS.PASS
		}, 27015, function (slot0)
			uv0(slot0)
		end)
	end,
	RefreshWorldChatData = function ()
		slot0 = {}
		slot1 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)
		slot4 = ChatData
		slot6 = slot4

		for slot5, slot6 in pairs(slot4.GetWorldOriginChatData(slot6)) do
			if slot6.contentType ~= ChatConst.CHAT_CONTENT_TYPE.TEXT and slot6.contentType ~= ChatConst.CHAT_CONTENT_TYPE.STICKER or not table.keyof(slot1, slot6.id) then
				table.insert(slot0, slot6)
			end
		end

		ChatData:ResetWorldTempData(slot0)
		manager.notify:Invoke(CHAT_WORLD_RESET)
		manager.notify:Invoke(CHAT_GUILD_RESET)
		manager.notify:Invoke(CHAT_COOPERATION_RESET)
	end,
	SendGuildMsg = function (slot0, slot1, slot2)
		slot3 = manager.net

		slot3:SendWithLoadingNew(27020, {
			type = ChatConst.CHAT_CONTENT_TYPE.TEXT,
			content = slot0,
			shield_type = slot1 or ChatConst.VERIFY_STATUS.OBSERVE
		}, 27021, function (slot0)
			uv0(slot0)
		end)
	end,
	SendGuildSticker = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(27020, {
			type = ChatConst.CHAT_CONTENT_TYPE.STICKER,
			content = tostring(slot0),
			shield_type = ChatConst.VERIFY_STATUS.PASS
		}, 27021, function (slot0)
			uv0(slot0)
		end)
	end,
	GuildChatInitData = function ()
		if GuildData:GetGuildInfo().id == nil or slot0.id ~= getData("guildInfo", "guildID") then
			ChatGuildData:RemoveChatData()
		end

		if slot0.id then
			ChatTools.LoadGuildLocalChatCache(slot0.id)
			ChatTools.DeleteGuildChatRecord(slot0.id)
		end
	end,
	SendGuildRecruitMsg = function (slot0, slot1, slot2)
		print("功能未实现")
		slot2({
			result = 0
		})
	end,
	SendGuildRecruitSticker = function (slot0, slot1)
		print("功能未实现")
		slot1({
			result = 0
		})
	end,
	SendFriendMsg = function (slot0, slot1, slot2, slot3)
		slot4 = manager.net

		slot4:SendWithLoadingNew(19034, {
			receive_uid = slot0,
			type = ChatConst.CHAT_CONTENT_TYPE.TEXT,
			content = slot1,
			shield_type = slot2
		}, 19035, function (slot0)
			uv0(slot0)
		end)
	end,
	SendFriendSticker = function (slot0, slot1, slot2)
		slot3 = manager.net

		slot3:SendWithLoadingNew(19034, {
			receive_uid = slot0,
			type = ChatConst.CHAT_CONTENT_TYPE.STICKER,
			content = tostring(slot1),
			shield_type = ChatConst.VERIFY_STATUS.PASS
		}, 19035, function (slot0)
			uv0(slot0)
		end)
	end,
	FriendChatInitData = function ()
		for slot4, slot5 in pairs(FriendsData:GetList(FriendsConst.FRIEND_TYPE.MY_FRIENDS)) do
			ChatFriendData:InitReadMsgCnt(slot5)
			ChatTools.DeleteFriendChatRecord(slot5)
		end

		slot1 = {}
		slot4 = ChatFriendData
		slot6 = slot4

		for slot5, slot6 in pairs(slot4.GetAllFriendContent(slot6)) do
			if table.keyof(slot0, slot5) then
				uv0.DeleteInvalidChat(slot5)
			else
				table.insert(slot1, slot5)
			end
		end

		for slot5, slot6 in ipairs(slot1) do
			uv0.DeleteFriendChat(slot6)
		end
	end,
	DeleteFriendChat = function (slot0)
		ChatFriendData:RemoveCacheHero(slot0)
		ChatFriendData:RemoveChatData(slot0)
	end,
	DeleteInvalidChat = function (slot0)
		slot2 = FriendsData:GetInfoByID(slot0).timestamp
		slot4 = 0

		for slot8 = #ChatFriendData:GetFriendContent(slot0), 1, -1 do
			if slot3[slot8].timestamp < slot2 then
				slot4 = slot8

				break
			end
		end

		ChatFriendData:DeleteInvalidContent(slot0, slot4)
	end,
	ChatReportMsg = function (slot0, slot1, slot2, slot3)
		slot4 = manager.net

		slot4:SendWithLoadingNew(57002, {
			msg_uid = slot0,
			report_type = slot1,
			report_note = slot2
		}, 57003, function (slot0)
			uv0(slot0)
		end)
	end,
	ChatReportUser = function (slot0, slot1, slot2, slot3)
		slot4 = manager.net

		slot4:SendWithLoadingNew(57004, {
			reported_user_id = slot0,
			report_type = slot1,
			report_note = slot2
		}, 57005, function (slot0)
			uv0(slot0)
		end)
	end,
	RequireGuildShareInfo = function ()
		slot0 = manager.net
		slot5 = ChatGuildRecruitData

		slot0:SendWithLoadingNew(27402, {
			timestamp = slot5:GetLastTimestamp()
		}, 27403, function (slot0)
			slot1 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

			if isSuccess(slot0.result) then
				for slot5, slot6 in ipairs(slot0.msg_list) do
					if slot6.club_base_info.id ~= nil then
						if slot6.club_base_info.id ~= 0 then
							ChatGuildRecruitData:AddChatRecord(slot6)
							GuildData:SetCacheGuildInfo(slot6.club_base_info)
						end
					end
				end

				ChatGuildRecruitData:SortMsg(slot1)

				if #slot0.msg_list > 0 then
					manager.notify:Invoke(CHAT_NEW_MESSAGE)
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	SendChatNormalMsg = function (slot0, slot1, slot2, slot3)
		slot4 = manager.net

		slot4:SendWithLoadingNew(27030, {
			channel_type = slot0,
			type = ChatConst.CHAT_CONTENT_TYPE.TEXT,
			content = slot1,
			shield_type = slot2 or ChatConst.VERIFY_STATUS.OBSERVE
		}, 27031, function (slot0)
			uv0(slot0)
		end)
	end,
	SendChatNormalSticker = function (slot0, slot1, slot2)
		slot3 = manager.net

		slot3:SendWithLoadingNew(27030, {
			channel_type = slot0,
			type = ChatConst.CHAT_CONTENT_TYPE.STICKER,
			content = tostring(slot1),
			shield_type = ChatConst.VERIFY_STATUS.PASS
		}, 27031, function (slot0)
			uv0(slot0)
		end)
	end,
	LoadChannelChatData = function ()
		if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) then
			ChatTools.LoadLocalChatCache(ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY)
			ChatTools.DeleteChannelChatRecord(ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY)
		end
	end,
	SendCooperationdMsg = function (slot0, slot1, slot2)
		slot3 = manager.net

		slot3:SendWithLoadingNew(37030, {
			type = ChatConst.CHAT_CONTENT_TYPE.TEXT,
			content = slot0,
			shield_type = slot1 or ChatConst.VERIFY_STATUS.OBSERVE
		}, 37031, function (slot0)
			uv0(slot0)
		end)
	end,
	SendCooperationSticker = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(37030, {
			type = ChatConst.CHAT_CONTENT_TYPE.STICKER,
			content = tostring(slot0),
			shield_type = ChatConst.VERIFY_STATUS.PASS
		}, 37031, function (slot0)
			uv0(slot0)
		end)
	end,
	CooperationChatInitData = function ()
		ChatCooperationData:RemoveChatData()
	end,
	SaveCustomSticker = function (slot0)
		slot1 = ChatStickerData
		slot2 = manager.net

		slot2:SendWithLoadingNew(12036, {
			emoticon_id_list = slot1:GetCustomStickerUIList()
		}, 12037, function (slot0)
			if isSuccess(slot0.result) then
				ChatStickerData:SaveData()
			end

			uv0(slot0)
		end)
	end
}
