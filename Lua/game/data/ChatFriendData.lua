slot0 = singletonClass("ChatFriendData")
slot1 = require("cjson")

function slot0.Init(slot0)
	slot0.chatRecordData_ = getModule("chatFriend")
	slot0.chatSaveRecordList_ = {}
	slot0.readMsgID_ = {}
	slot0.historyTipsFlag_ = {}
	slot0.lockFriendID_ = 0
	slot0.chatRecordList_ = {}
	slot0.friendList_ = {}
	slot0.cacheHeroList_ = {}
	slot0.cacheContentList_ = {}
end

function slot0.InitReadMsgCnt(slot0, slot1)
	slot0.readMsgID_[slot1] = slot0.readMsgID_[slot1] or 0
end

function slot0.InitCacheChatList(slot0)
	for slot4, slot5 in pairs(slot0.chatRecordList_) do
		if slot0:GetUnreadMsgCnt(slot4) > 0 then
			slot0.friendList_[slot4] = {
				readSeek = 0,
				id = slot4,
				timestamp = slot5[#slot5].timestamp
			}

			table.insert(slot0.cacheHeroList_, slot4)
		end
	end

	table.sort(slot0.cacheHeroList_, function (slot0, slot1)
		return uv0.friendList_[slot1].timestamp < uv0.friendList_[slot0].timestamp
	end)
end

function slot0.AddCacheFriend(slot0, slot1)
	if table.keyof(slot0.cacheHeroList_, slot1) then
		return
	end

	table.insert(slot0.cacheHeroList_, 1, slot1)

	slot0.friendList_[slot1] = {
		reedSeek_ = 0,
		id = slot1,
		timestamp = manager.time:GetServerTime()
	}
end

function slot0.GetCacheHeroList(slot0)
	return slot0.cacheHeroList_
end

function slot0.GetFriendList(slot0, slot1)
	return slot0.friendList_[slot1]
end

function slot0.GetAllFriendContent(slot0)
	return slot0.chatRecordList_
end

function slot0.GetFriendContent(slot0, slot1)
	return slot0.chatRecordList_[slot1] or {}
end

function slot0.AddChat(slot0, slot1)
	slot3 = USER_ID == slot1.sender_uid and slot1.receive_uid or slot1.sender_uid
	slot0.chatRecordList_[slot3] = slot0.chatRecordList_[slot3] or {}

	if slot0:IsOldMsg(slot3, slot1.msg_id) then
		return
	end

	if slot0.lockFriendID_ == slot3 then
		slot0:UpdateCacheFriendContent(slot1)
	end

	slot4 = slot0:ParseChat(slot1)

	slot0:SaveRecord(slot4)
	table.insert(slot0.chatRecordList_[slot3], slot4)
	slot0:UpdateTimestamp(slot1)
end

function slot0.IsOldMsg(slot0, slot1, slot2)
	slot3 = slot0.chatRecordList_[slot1] and #slot0.chatRecordList_[slot1] or 0

	for slot7 = 0, 9 do
		if slot0.chatRecordList_[slot1][slot3 - slot7] and slot8.msgID == slot2 then
			return true
		end
	end

	return false
end

function slot0.DeleteInvalidContent(slot0, slot1, slot2)
	for slot6 = 1, slot2 do
		table.remove(slot0.chatRecordList_[slot1], 1)
	end
end

function slot0.ParseChat(slot0, slot1)
	return {
		recall = false,
		msgID = slot1.msg_id,
		friendID = USER_ID == slot1.sender_uid and slot1.receive_uid or slot1.sender_uid,
		senderID = slot1.sender_uid,
		timestamp = slot1.timestamp,
		contentType = slot1.type,
		content = slot1.content
	}
end

function slot0.UpdateTimestamp(slot0, slot1)
	slot3 = USER_ID == slot1.sender_uid and slot1.receive_uid or slot1.sender_uid

	table.removebyvalue(slot0.cacheHeroList_, slot3)
	table.insert(slot0.cacheHeroList_, 1, slot3)

	if slot0.friendList_[slot3] == nil then
		slot0.friendList_[slot3] = {
			reedSeek_ = 0,
			id = slot3,
			timestamp = slot1.timestamp
		}
	else
		slot0.friendList_[slot3].timestamp = slot1.timestamp
	end
end

function slot0.RemoveCacheHero(slot0, slot1)
	table.removebyvalue(slot0.cacheHeroList_, slot1)
end

function slot0.RemoveChatData(slot0, slot1)
	slot0.chatRecordList_[slot1] = {}
	slot0.cacheContentList_[slot1] = {}
	slot0.historyTipsFlag_[slot1] = false

	if slot0.lockFriendID_ == slot1 then
		slot0.lockFriendID_ = 0
	end

	slot0.readMsgID_[slot1] = 0

	saveData("chatFriend", "readMsgID_" .. slot1, 0)
	ChatTools.DeleteFriendChatCache(slot1)
end

function slot0.UpdateSeek(slot0, slot1)
	slot0.friendList_[slot1].readSeek = #slot0.chatRecordList_[slot1]
end

function slot0.LockFriendID(slot0, slot1)
	slot0.lockFriendID_ = slot1

	if slot1 ~= 0 then
		slot0:InitCacheFriendContent(slot1)
	end
end

function slot0.SaveRecord(slot0, slot1)
	slot0.chatSaveRecordList_[slot1.friendID] = slot0.chatSaveRecordList_[slot1.friendID] or {}

	table.insert(slot0.chatSaveRecordList_[slot1.friendID], slot1)
end

function slot0.SaveRecordCnt(slot0, slot1, slot2)
	if slot0.cacheContentList_[slot1][#slot0.cacheContentList_[slot1] - (slot2 or 0)] and (slot4.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or slot4.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER) then
		slot0.readMsgID_[slot1] = slot4.msgID

		saveData("chatFriend", "readMsgID_" .. slot1, slot4.msgID)
	end
end

function slot0.RemoveFriendChatContent(slot0, slot1, slot2)
	slot3 = 0

	if slot0.chatRecordList_[slot2] == nil then
		return slot3
	end

	for slot7, slot8 in ipairs(slot0.chatRecordList_[slot2]) do
		if slot8.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and slot8.msgID == slot1 then
			slot8.recall = true

			ChatTools.ResaveFriendChatCache(slot2)

			slot3 = slot7

			break
		end
	end

	if slot0.cacheContentList_[slot2] then
		for slot7, slot8 in ipairs(slot0.cacheContentList_[slot2]) do
			if slot8.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and slot8.msgID == slot1 then
				if slot0.cacheContentList_[slot2][slot7 + 1] == nil and slot0.cacheContentList_[slot2][slot7 - 1] and slot0.cacheContentList_[slot2][slot7 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS then
					table.remove(slot0.cacheContentList_[slot2], slot7)
					table.remove(slot0.cacheContentList_[slot2], slot7 - 1)

					slot0.historyTipsFlag_[slot2] = false

					break
				end

				table.remove(slot0.cacheContentList_[slot2], slot7)

				break
			end
		end
	end

	return slot3
end

function slot0.InitCacheFriendContent(slot0, slot1)
	slot2 = clone(slot0.chatRecordList_[slot1] or {})
	slot0.historyTipsFlag_[slot1] = false

	if slot0.readMsgID_ == 0 then
		slot0.historyTipsFlag_[slot1] = true
	end

	for slot6 = #slot2, 1, -1 do
		if slot0.readMsgID_[slot1] ~= 0 and slot2[slot6].msgID == slot0.readMsgID_[slot1] and slot2[slot6 + 1] then
			slot0.historyTipsFlag_[slot1] = true

			table.insert(slot2, slot6 + 1, {
				friendID = slot1,
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS
			})
		end

		if slot2[slot6].recall == true then
			table.remove(slot2, slot6)
		end
	end

	slot0.cacheContentList_[slot1] = slot2
end

function slot0.UpdateCacheFriendContent(slot0, slot1)
	if slot0.historyTipsFlag_[USER_ID == slot1.sender_uid and slot1.receive_uid or slot1.sender_uid] ~= true then
		if slot1.sender_uid ~= slot2 then
			table.insert(slot0.cacheContentList_[slot3], {
				friendID = slot3,
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS
			})
		end

		slot0.historyTipsFlag_[slot3] = true
	end

	table.insert(slot0.cacheContentList_[slot3], slot0:ParseChat(slot1))
end

function slot0.GetCacheContent(slot0, slot1)
	return slot0.cacheContentList_[slot1]
end

function slot0.GetUnreadMsgCnt(slot0, slot1)
	if slot0.chatRecordList_[slot1] then
		slot2 = 0

		for slot6 = #slot0.chatRecordList_[slot1], 1, -1 do
			if slot0.chatRecordList_[slot1][slot6].msgID == slot0.readMsgID_[slot1] then
				break
			end

			if slot0.chatRecordList_[slot1][slot6].recall == false then
				slot2 = slot2 + 1
			end
		end

		return slot2
	else
		return 0
	end
end

function slot0.GetLastMsgData(slot0, slot1)
	if slot0.chatRecordList_[slot1] then
		for slot5 = #slot0.chatRecordList_[slot1], 1, -1 do
			if slot0.chatRecordList_[slot1][slot5].recall == false then
				return slot0.chatRecordList_[slot1][slot5]
			end
		end
	end

	return {
		content = ""
	}
end

function slot0.GetSaveRecordList(slot0, slot1)
	return slot0.chatSaveRecordList_[slot1] or {}
end

function slot0.SetSaveRecordList(slot0, slot1, slot2)
	slot0.chatSaveRecordList_[slot1] = slot2
end

function slot0.InitFriendContnent(slot0, slot1, slot2)
	slot0.chatRecordList_[slot1] = {}

	for slot6, slot7 in ipairs(slot2) do
		table.insert(slot0.chatRecordList_[slot1], slot7)
	end

	slot0:InitCacheChatList()

	slot0.readMsgID_[slot1] = slot0.chatRecordData_["readMsgID_" .. slot1] or 0
end

return slot0
