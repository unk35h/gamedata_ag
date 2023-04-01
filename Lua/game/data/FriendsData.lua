slot0 = singletonClass("FriendsData")
slot1 = {
	myFriendsList = {},
	newFriendsList = {},
	friendsRequestList = {},
	blackList = {}
}
slot2 = {}
slot3 = {}
slot4 = {
	get_id_list = {},
	equip_list = {}
}
slot5 = 100
slot6 = {}
slot7 = {
	myFriends = FriendsConst.FRIEND_TYPE.MY_FRIENDS,
	newFriends = FriendsConst.FRIEND_TYPE.NEW_FRIENDS,
	friendsRequest = FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS,
	blackList = FriendsConst.FRIEND_TYPE.BLACKLIST,
	search = FriendsConst.FRIEND_TYPE.SEARCH
}
slot8 = false

function slot0.Ctor(slot0)
end

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
end

function slot0.FriendsDataInit(slot0, slot1, slot2, slot3)
	uv0.myFriendsList = {}
	uv0.newFriendsList = {}
	uv0.friendsRequestList = {}
	uv0.blackList = {}
	uv1 = false

	for slot7, slot8 in ipairs(slot1) do
		if not uv0[slot8.user_id] or slot9.relationship ~= uv2.myFriends then
			uv0[slot8.user_id] = {
				icon_frame = 0,
				online_state = 0,
				lastChat = "",
				nick = "",
				ip = "",
				unReadMsgCnt = 0,
				sign = "",
				user_id = slot8.user_id,
				timestamp = slot8.timestamp,
				relationship = uv2.myFriends
			}
		end

		table.insert(uv0.myFriendsList, slot8.user_id)
		ChatTools.LoadFriendLocalChatCache(slot8.user_id)
	end

	for slot7, slot8 in ipairs(slot2) do
		if not uv0[slot8.user_id] or slot9.relationship ~= uv2.friendsRequest then
			uv0[slot8.user_id] = {
				icon_frame = 0,
				sign = "",
				nick = "",
				ip = "",
				user_id = slot8.user_id,
				timestamp = slot8.timestamp,
				relationship = uv2.friendsRequest
			}
		end

		table.insert(uv0.friendsRequestList, slot8.user_id)
	end

	for slot7, slot8 in ipairs(slot3) do
		if not uv0[slot8] or slot9.relationship ~= uv2.blackList then
			uv0[slot8] = {
				icon_frame = 0,
				sign = "",
				nick = "",
				ip = "",
				timestamp = 0,
				user_id = slot8,
				relationship = uv2.blackList
			}
		end

		table.insert(uv0.blackList, slot8)
	end
end

function slot0.MyFriendsRefresh(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7, slot8, slot9 = slot0:getChatInfo(slot6.user_id)
		uv0[slot6.user_id] = {
			user_id = slot6.user_id,
			online_state = slot6.online_state,
			icon = slot6.icon,
			icon_frame = slot6.icon_frame,
			nick = slot6.nick,
			sign = slot6.sign,
			timestamp = slot6.timestamp,
			ip = (slot6.ip_location == nil or slot6.ip_location == "") and GetTips("IP_UNKNOWN") or slot6.ip_location,
			relationship = uv1.myFriends,
			lastChat = slot7,
			lastChatTime = slot8,
			unReadMsgCnt = slot9,
			level = slot6.level
		}
	end

	uv2 = true
end

function slot0.FriendsRequestRefresh(slot0, slot1)
	uv0.friendsRequestList = {}

	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.user_id] = {
			user_id = slot6.user_id,
			timestamp = slot6.timestamp,
			icon = slot6.icon,
			icon_frame = slot6.icon_frame,
			nick = slot6.nick,
			sign = slot6.sign,
			ip = (slot6.ip_location == nil or slot6.ip_location == "") and GetTips("IP_UNKNOWN") or slot6.ip_location,
			relationship = uv1.friendsRequest
		}

		table.insert(uv0.friendsRequestList, slot6.user_id)
	end
end

function slot0.BlackListRefresh(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.user_id] = {
			user_id = slot6.user_id,
			icon = slot6.icon,
			icon_frame = slot6.icon_frame,
			nick = slot6.nick,
			sign = slot6.sign,
			timestamp = slot6.timestamp,
			ip = (slot6.ip_location == nil or slot6.ip_location == "") and GetTips("IP_UNKNOWN") or slot6.ip_location,
			relationship = uv1.blackList
		}
	end
end

function slot0.ChatInit(slot0)
	uv0 = {}

	for slot4, slot5 in ipairs(uv1.myFriendsList) do
		if ChatFriendData:GetLastMsgData(slot5) ~= nil then
			slot7 = slot6.content

			if slot6.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
				slot7 = string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(slot6.content)].name))
			end

			uv0[slot5] = {
				lastChat = slot7,
				lastChatTime = slot6.timestamp,
				unReadMsgCnt = ChatFriendData:GetUnreadMsgCnt(slot5)
			}
		end
	end
end

function slot0.getChatInfo(slot0, slot1)
	if uv0[slot1] ~= nil then
		return uv0[slot1].lastChat, uv0[slot1].lastChatTime, uv0[slot1].unReadMsgCnt
	end

	return "", nil, 0
end

function slot0.RequestToFriend(slot0, slot1)
	if uv0[1] and uv0[1].user_id == slot1 then
		uv0[1].isDeal = true
	end

	if uv1[slot1] ~= nil and uv1[slot1].relationship == uv2.newFriends then
		uv1[slot1].isDeal = true
	end
end

function slot0.DealRequest(slot0, slot1, slot2, slot3)
	if table.indexof(uv0.friendsRequestList, slot1) then
		table.remove(uv0.friendsRequestList, slot4)
	end

	if slot2 == 1 then
		uv0[slot1] = {
			lastChat = "",
			unReadMsgCnt = 0,
			user_id = slot3.user_id,
			online_state = slot3.online_state,
			icon = slot3.icon,
			icon_frame = slot3.icon_frame,
			nick = slot3.nick,
			sign = slot3.sign,
			timestamp = slot3.timestamp,
			ip = slot3.ip_location or GetTips("IP_UNKNOWN"),
			relationship = uv1.myFriends
		}

		table.insert(uv0.myFriendsList, slot1)
		SendMessageManagerToSDK("add_friend")
	else
		uv0[slot1] = nil
	end
end

function slot0.DelectFromMyFriendsList(slot0, slot1)
	if table.indexof(uv0.myFriendsList, slot1) then
		table.remove(uv0.myFriendsList, slot2)

		uv0[slot1] = nil
		uv1[slot1] = nil

		manager.notify:Invoke(CHAT_FRIEND_CLOSE_ITEM, slot1)
	end
end

function slot0.AddToBlacklist(slot0, slot1)
	slot0:DelectID(slot1.user_id)

	uv0[slot1.user_id] = {
		user_id = slot1.user_id,
		icon = slot1.icon,
		icon_frame = slot1.icon_frame,
		nick = slot1.nick,
		sign = slot1.sign,
		timestamp = slot1.timestamp,
		relationship = uv1.blackList
	}

	table.insert(uv0.blackList, slot1.user_id)
	ShowTips(string.format(GetTips("FRIEND_MOVE_TO_BLACLIST_NOTE"), uv0[slot1.user_id].nick))
end

function slot0.DelectFromBlackList(slot0, slot1, slot2)
	if table.indexof(uv0.blackList, slot1) then
		table.remove(uv0.blackList, slot3)

		if slot2 == 1 then
			ShowTips("FRIEND_APPLY_SEND")

			if uv1[1] and uv1[1].user_id == slot1 then
				uv1[1].isDeal = true
			end
		else
			ShowTips(string.format(GetTips("BLACKLIST_REMOVE_NOTE"), uv0[slot1].nick))
		end

		uv0[slot1] = nil
	end
end

function slot0.DelectFromNewFriendsList(slot0, slot1)
	if table.indexof(uv0.newFriendsList, slot1) then
		table.remove(uv0.newFriendsList, slot2)

		uv0[slot1] = nil
	end
end

function slot0.DelectFromFriendsRequestList(slot0, slot1)
	if table.indexof(uv0.friendsRequestList, slot1) then
		table.remove(uv0.friendsRequestList, slot2)

		uv0[slot1] = nil
	end
end

function slot0.SetSearchList(slot0, slot1)
	uv0 = {}

	if slot1 == nil then
		return
	end

	table.insert(uv0, {
		isDeal = false,
		user_id = slot1.user_id,
		online_state = slot1.online_state,
		icon = slot1.icon,
		icon_frame = slot1.icon_frame,
		nick = slot1.nick,
		sign = slot1.sign
	})
end

function slot0.DealRequestList(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		slot0:DelectID(slot7.user_id)

		uv0[slot7.user_id] = {
			lastChat = "",
			unReadMsgCnt = 0,
			user_id = slot7.user_id,
			online_state = slot7.online_state,
			icon = slot7.icon,
			nick = slot7.nick,
			sign = slot7.sign,
			timestamp = slot7.timestamp,
			relationship = uv1.myFriends
		}

		table.insert(uv0.myFriendsList, slot7.user_id)
		SendMessageManagerToSDK("add_friend")
	end

	if slot2 == 2 then
		uv0.friendsRequestList = {}
	else
		for slot6 = #uv0.friendsRequestList, 1, -1 do
			if uv0[uv0.friendsRequestList[slot6]].relationship == uv1.myFriends then
				table.remove(uv0.friendsRequestList, slot6)
			end
		end
	end
end

function slot0.RefreshMyFriendsList(slot0, slot1)
	slot0:DelectID(slot1.user_id)

	uv0[slot1.user_id] = {
		unReadMsgCnt = 0,
		lastChat = "",
		user_id = slot1.user_id,
		online_state = slot1.online_state,
		icon = slot1.icon,
		icon_frame = slot1.icon_frame,
		nick = slot1.nick,
		sign = slot1.sign,
		timestamp = slot1.timestamp,
		relationship = uv1.myFriends,
		level = slot1.level
	}

	table.insert(uv0.myFriendsList, slot1.user_id)
end

function slot0.RefreshNewFriendsList(slot0, slot1)
	for slot5, slot6 in ipairs(uv0.newFriendsList) do
		uv0[slot6] = nil
	end

	uv0.newFriendsList = {}

	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.user_id] = {
			isDeal = false,
			user_id = slot6.user_id,
			online_state = slot6.online_state,
			icon = slot6.icon,
			icon_frame = slot6.icon_frame,
			nick = slot6.nick,
			sign = slot6.sign,
			relationship = uv1.newFriends
		}

		table.insert(uv0.newFriendsList, slot6.user_id)
	end
end

function slot0.RefreshRecommend(slot0, slot1)
	uv0[slot1.user_id] = {
		isDeal = false,
		user_id = slot1.user_id,
		online_state = slot1.online_state,
		icon = slot1.icon,
		icon_frame = slot1.icon_frame,
		nick = slot1.nick,
		sign = slot1.sign,
		relationship = uv1.newFriends
	}

	table.insert(uv0.newFriendsList, slot1.user_id)
end

function slot0.RefreshFriendsRequestList(slot0, slot1)
	slot0:DelectID(slot1.user_id)

	uv0[slot1.user_id] = {
		user_id = slot1.user_id,
		timestamp = slot1.timestamp,
		icon = slot1.icon,
		icon_frame = slot1.icon_frame,
		nick = slot1.nick,
		sign = slot1.sign,
		relationship = uv1.friendsRequest
	}

	table.insert(uv0.friendsRequestList, slot1.user_id)
end

function slot0.DelectID(slot0, slot1)
	if uv0[slot1] then
		if uv0[slot1].relationship == uv1.myFriends then
			slot0:DelectFromMyFriendsList(slot1)
		elseif slot2 == uv1.newFriends then
			slot0:DelectFromNewFriendsList(slot1)
		elseif slot2 == uv1.friendsRequest then
			slot0:DelectFromFriendsRequestList(slot1)
		elseif slot2 == uv1.blackList then
			slot0:DelectFromBlackList(slot1)
		end
	end

	slot0:TryToRemoveRequest(slot1)
end

function slot0.IsCanBeFriend(slot0, slot1)
	if slot1 == tostring(PlayerData:GetPlayerInfo().userID) then
		ShowTips("CANNOT_ADD_SELF")

		return false
	elseif uv0[slot1] and uv0[slot1].relationship == uv1.myFriends then
		ShowTips("ERROR_FRIEND_EXIST_FRIEND")

		return false
	elseif GameSetting.user_friend_num_max.value[1] <= slot0:GetListLength(uv1.myFriends) then
		ShowTips("ERROR_FRIEND_NUM_LIMIT_ME")

		return false
	elseif uv0[slot1] and uv0[slot1].relationship == uv1.blackList then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ADD_BLACKLIST_FRIEND_COMFIRMATION"),
			OkCallback = function ()
				FriendsAction:TryToDelectFromBlackList(uv0, 1)
			end
		})

		return false
	end

	return true
end

function slot0.IsCanBeBlackList(slot0, slot1)
	if GameSetting.user_black_num_max.value[1] <= slot0:GetListLength(uv0.blackList) then
		ShowTips("FRIEND_MOVE_TO_BLACLIST_NOTE_LIMIT")

		return false
	elseif uv1[slot1] and uv1[slot1].relationship == uv0.blackList then
		ShowTips("ERROR_FRIEND_EXIST_BLACK_TARGET")

		return false
	end

	return true
end

function slot0.IsRequesting(slot0)
	slot1 = manager.time:GetServerTime()
	slot2 = 0

	for slot6, slot7 in ipairs(uv0.friendsRequestList) do
		if slot1 - (uv0[slot7].timestamp or 0) < 604800 then
			return true
		end
	end

	return false
end

function slot0.GetListLength(slot0, slot1)
	if slot1 == uv0.myFriends then
		return #uv1.myFriendsList
	elseif slot1 == uv0.newFriends then
		return #uv1.newFriendsList
	elseif slot1 == uv0.friendsRequest then
		return #uv1.friendsRequestList
	elseif slot1 == uv0.blackList then
		return #uv1.blackList
	else
		print("未确定列表类型")
	end
end

function slot0.GetInfoByID(slot0, slot1)
	if uv0[slot1] ~= nil then
		return uv0[slot1]
	end

	return false
end

function slot0.RefreshChat(slot0, slot1, slot2, slot3)
	if uv0[slot1] then
		uv0[slot1].lastChat = slot2
		uv0[slot1].lastChatTime = slot3
	else
		uv0[slot1] = {
			unReadMsgCnt = 0,
			lastChat = slot2,
			lastChatTime = slot3
		}
	end
end

function slot0.RefreshUnread(slot0, slot1, slot2)
	if uv0[slot1] then
		uv0[slot1].unReadMsgCnt = slot2
	else
		uv0[slot1] = {
			lastChat = "",
			unReadMsgCnt = slot2
		}
	end
end

function slot0.GetList(slot0, slot1)
	if slot1 == uv0.myFriends then
		return uv1.myFriendsList
	elseif slot1 == uv0.newFriends then
		return uv1.newFriendsList
	elseif slot1 == uv0.friendsRequest then
		slot2 = manager.time:GetServerTime()
		slot3 = {}

		for slot7, slot8 in ipairs(uv1.friendsRequestList) do
			if slot2 - uv1[slot8].timestamp > 604800 then
				uv1[slot8] = nil
			else
				table.insert(slot3, slot8)
			end
		end

		uv1.friendsRequestList = slot3

		return uv1.friendsRequestList
	elseif slot1 == uv0.blackList then
		return uv1.blackList
	else
		print("未确定列表类型")
	end
end

function slot0.GetFriendsOnLineCount(slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(uv0.myFriendsList) do
		if uv0[slot6].online_state == 0 then
			slot1 = slot1 + 1
		end
	end

	return slot1
end

function slot0.GetChatList(slot0)
	return uv0
end

function slot0.GetSearchList(slot0)
	return uv0
end

function slot0.GetFreshFlag(slot0)
	return uv0
end

function slot0.RefreshInfo(slot0, slot1)
	if uv0[slot1.user_id] then
		uv0[slot2].user_id = slot1.user_id
		uv0[slot2].nick = slot1.nick
		uv0[slot2].icon = slot1.icon
		uv0[slot2].icon_frame = slot1.icon_frame
		uv0[slot2].sign = slot1.sign
	end
end

function slot0.TryToAddRequest(slot0, slot1)
	if uv1 <= #uv0 then
		table.remove(uv0, 1)
		slot0:TryToAddRequest(slot1)
	else
		table.insert(uv0, slot1)
	end
end

function slot0.TryToRemoveRequest(slot0, slot1)
	if table.indexof(uv0, slot1) then
		table.remove(uv0, slot2)
	end
end

function slot0.IsInRequest(slot0, slot1)
	return table.indexof(uv0, slot1) ~= false
end

return slot0
