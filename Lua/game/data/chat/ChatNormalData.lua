slot0 = class("ChatNormalData")

function slot0.Ctor(slot0, slot1)
	slot0.chatType_ = slot1
	slot0.chatRecordData_ = getModule("chatGuild" .. slot1)
	slot0.chatSaveRecordList_ = {}
	slot0.chatRecordList_ = {}
	slot0.readMsgID_ = 0
	slot0.historyTipsFlag_ = false
	slot0.cacheContentList_ = {}
end

function slot0.GetContent(slot0)
	return slot0.chatRecordList_
end

function slot0.AddChat(slot0, slot1)
	if slot0:IsOldMsg(slot1.msg_id) then
		return
	end

	slot2 = slot0:ParseChat(slot1)

	slot0:SaveRecord(slot2)
	table.insert(slot0.chatRecordList_, slot2)
	slot0:UpdateCacheContent(slot1)
end

function slot0.IsOldMsg(slot0, slot1)
	slot2 = slot0.chatRecordList_ and #slot0.chatRecordList_ or 0

	for slot6 = 0, 9 do
		if slot0.chatRecordList_[slot2 - slot6] and slot7.msgID == slot1 then
			return true
		end
	end

	return false
end

function slot0.ParseChat(slot0, slot1)
	return {
		recall = false,
		msgID = slot1.msg_id,
		id = slot1.sender_uid,
		nick = slot1.nick,
		icon = slot1.icon,
		iconFrame = slot1.icon_frame,
		timestamp = slot1.timestamp,
		contentType = slot1.type,
		content = slot1.content,
		ip = slot1.ip_location or GetTips("IP_UNKNOWN")
	}
end

function slot0.RemoveChatData(slot0)
	slot0.chatRecordList_ = {}
	slot0.cacheContentList_ = {}
	slot0.historyTipsFlag_ = false
	slot0.readMsgID_ = 0

	saveData("chatGuild" .. slot0.chatType_, "readMsgID", 0)
	ChatTools.DeleteChannelChatCache(slot0.chatType_)
end

function slot0.SaveRecord(slot0, slot1)
	slot0.chatSaveRecordList_ = slot0.chatSaveRecordList_ or {}

	table.insert(slot0.chatSaveRecordList_, slot1)
end

function slot0.SaveRecordCnt(slot0, slot1)
	if slot0.cacheContentList_[#slot0.cacheContentList_ - (slot1 or 0)] and (slot3.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or slot3.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER) then
		slot0.readMsgID_ = slot3.msgID
		slot4 = #slot0.chatSaveRecordList_

		for slot8 = #slot0.chatSaveRecordList_, 1, -1 do
			if slot0.chatSaveRecordList_[slot8] and slot0.chatSaveRecordList_[slot8].msgID == slot3.msgID then
				slot4 = slot8

				break
			end
		end

		slot5 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

		for slot9 = slot4 + 1, #slot0.chatSaveRecordList_ do
			if slot0.chatSaveRecordList_[slot9] and table.keyof(slot5, slot10.id) then
				slot0.readMsgID_ = slot0.chatSaveRecordList_[slot9].msgID
			else
				break
			end
		end

		saveData("chatGuild" .. slot0.chatType_, "readMsgID_" .. slot0.chatType_, slot3.msgID)
	end
end

function slot0.RemoveChatContent(slot0, slot1)
	slot2 = 0

	if slot0.chatRecordList_ == nil then
		return slot2
	end

	for slot6, slot7 in ipairs(slot0.chatRecordList_) do
		if slot7.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and slot7.msgID == slot1 then
			slot7.recall = true

			ChatTools.ResaveChannelChatCache(slot0.chatType_)

			slot2 = slot6

			break
		end
	end

	for slot6 = #slot0.cacheContentList_, 1, -1 do
		if slot0.cacheContentList_[slot6].contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and slot7.msgID == slot1 then
			if slot0.cacheContentList_[slot6 + 1] == nil then
				table.remove(slot0.cacheContentList_, slot6)

				if slot0.cacheContentList_[slot6 - 1] then
					if slot0.cacheContentList_[slot6 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS or slot0.cacheContentList_[slot6 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
						table.remove(slot0.cacheContentList_, slot6 - 1)

						if cacheContentList_[slot6 - 2].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS then
							table.remove(slot0.cacheContentList_, slot6 - 2)
						end
					end

					slot0.historyTipsFlag_ = false
				end

				break
			end

			table.remove(slot0.cacheContentList_, slot6)

			break
		end
	end

	return slot2
end

function slot0.InitCacheContent(slot0)
	slot1 = clone(slot0.chatRecordList_ or {})
	slot0.historyTipsFlag_ = false

	if slot0.readMsgID_ == 0 then
		slot0.historyTipsFlag_ = true
	end

	slot2 = 0

	for slot6 = #slot1, 1, -1 do
		if slot1[slot6].recall == true then
			table.remove(slot1, slot6)
		end
	end

	slot0.cacheContentList_ = {}
	slot3 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	for slot7, slot8 in ipairs(slot1) do
		if slot7 == 1 or ChatConst.MESSAGE_SPACE < slot8.timestamp - slot1[slot7 - 1].timestamp then
			slot9 = {
				timestamp = slot8.timestamp,
				contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
			}

			if not table.keyof(slot3, slot8.id) then
				table.insert(slot0.cacheContentList_, slot9)
			end
		end

		if not table.keyof(slot3, slot8.id) then
			table.insert(slot0.cacheContentList_, slot8)
		end

		if slot0.readMsgID_ ~= 0 and slot1[slot7].msgID == slot0.readMsgID_ and slot1[slot7 + 1] and not table.keyof(slot3, slot1[slot7 + 1].id) then
			slot0.historyTipsFlag_ = true

			table.insert(slot0.cacheContentList_, {
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS,
				timestamp = slot1[slot7].timestamp
			})

			slot2 = #slot0.cacheContentList_
		end
	end

	return slot2 ~= 0 and slot2 or #slot0.cacheContentList_
end

function slot0.UpdateCacheContent(slot0, slot1)
	slot2 = USER_ID

	if table.keyof(FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST), slot1.sender_uid) then
		return
	end

	if slot0.historyTipsFlag_ ~= true then
		if slot1.sender_uid ~= slot2 then
			table.insert(slot0.cacheContentList_, {
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS,
				timestamp = slot1.timestamp
			})
		end

		slot0.historyTipsFlag_ = true
	end

	if #slot0.cacheContentList_ <= 0 or ChatConst.MESSAGE_SPACE < slot1.timestamp - slot0.cacheContentList_[#slot0.cacheContentList_].timestamp then
		table.insert(slot0.cacheContentList_, {
			timestamp = slot1.timestamp,
			contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
		})
	end

	table.insert(slot0.cacheContentList_, slot0:ParseChat(slot1))
end

function slot0.GetCacheContent(slot0)
	return slot0.cacheContentList_
end

function slot0.GetUnreadMsgCnt(slot0)
	if slot0.chatRecordList_ then
		slot1 = 0

		for slot5 = #slot0.chatRecordList_, 1, -1 do
			if slot0.chatRecordList_[slot5].msgID == slot0.readMsgID_ then
				break
			end

			if slot0.chatRecordList_[slot5].recall == false then
				slot1 = slot1 + 1
			end
		end

		return slot1
	else
		return 0
	end
end

function slot0.GetLastMsgData(slot0)
	if slot0.chatRecordList_ then
		for slot4 = #slot0.chatRecordList_, 1, -1 do
			if slot0.chatRecordList_[slot4].recall == false then
				return slot0.chatRecordList_[slot4]
			end
		end
	end

	return {
		content = ""
	}
end

function slot0.GetSaveRecordList(slot0)
	return slot0.chatSaveRecordList_ or {}
end

function slot0.SetSaveRecordList(slot0, slot1)
	slot0.chatSaveRecordList_ = slot1
end

function slot0.InitChannelContnent(slot0, slot1)
	slot0.chatRecordList_ = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.chatRecordList_, slot6)
	end

	slot0:InitCacheContent()

	slot0.readMsgID_ = slot0.chatRecordData_["readMsgID_" .. slot0.chatType_] or 0
end

return slot0
