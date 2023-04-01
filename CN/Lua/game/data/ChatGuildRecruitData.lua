slot0 = singletonClass("ChatGuildRecruitData")

function slot0.Init(slot0)
	slot0.guildRecruitData_ = {}
	slot0.unsortRecruitData_ = {}
	slot0.guildRecruitTempData_ = {}
	slot0.requireGuildList_ = {}
	slot0.lastTimestamp_ = 0
end

function slot0.GetLastTimestamp(slot0)
	return slot0.lastTimestamp_
end

function slot0.GetChatData(slot0)
	return slot0.guildRecruitTempData_ or {}
end

function slot0.GetOriginChatData(slot0)
	return slot0.guildRecruitData_
end

function slot0.AddChatRecord(slot0, slot1)
	table.insert(slot0.unsortRecruitData_, slot0:ParseMsg(slot1))
end

function slot0.SortMsg(slot0, slot1)
	function slot5(slot0, slot1)
		return slot0.timestamp < slot1.timestamp
	end

	table.sort(slot0.unsortRecruitData_, slot5)

	for slot5, slot6 in ipairs(slot0.unsortRecruitData_) do
		slot0:AddChatMsg(slot6, table.keyof(slot1, slot6.id))

		if slot5 == #slot0.unsortRecruitData_ then
			slot0.lastTimestamp_ = slot6.timestamp
		end
	end

	if #slot0.unsortRecruitData_ <= 0 then
		slot0.lastTimestamp_ = manager.time:GetServerTime()
	end

	slot0.unsortRecruitData_ = {}
end

function slot0.InitCacheContent(slot0)
	slot1 = clone
	slot3 = slot0.guildRecruitData_ or {}
	slot0.guildRecruitTempData_ = {}
	slot2 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	for slot6, slot7 in ipairs(slot1(slot3)) do
		if slot6 == 1 or ChatConst.MESSAGE_SPACE < slot7.timestamp - slot1[slot6 - 1].timestamp then
			slot8 = {
				timestamp = slot7.timestamp,
				contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
			}

			if not table.keyof(slot2, slot7.id) then
				table.insert(slot0.guildRecruitTempData_, slot8)
			end
		end

		if not table.keyof(slot2, slot7.id) then
			table.insert(slot0.guildRecruitTempData_, slot7)
		end
	end
end

function slot0.AddChatMsg(slot0, slot1, slot2)
	slot0.guildRecruitData_ = slot0.guildRecruitData_ or {}

	table.insert(slot0.guildRecruitData_, slot1)

	if not slot2 then
		for slot6, slot7 in ipairs(slot0.guildRecruitTempData_) do
			if slot7.guildID == slot1.guildID then
				table.remove(slot0.guildRecruitTempData_, slot6)

				if slot0.guildRecruitTempData_[slot6 - 1] and slot0.guildRecruitTempData_[slot6 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP and slot0.guildRecruitTempData_[slot6] and slot0.guildRecruitTempData_[slot6].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
					table.remove(slot0.guildRecruitTempData_, slot6 - 1)

					break
				end

				if slot6 == #slot0.guildRecruitTempData_ + 1 then
					table.remove(slot0.guildRecruitTempData_, slot6 - 1)
				end

				break
			end
		end

		if #slot0.guildRecruitTempData_ <= 0 or ChatConst.MESSAGE_SPACE < slot1.timestamp - slot0.guildRecruitTempData_[slot3 - 1].timestamp then
			table.insert(slot0.guildRecruitTempData_, {
				timestamp = slot1.timestamp,
				contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
			})
		end

		table.insert(slot0.guildRecruitTempData_, slot1)
	end
end

function slot0.RemoveChatRecord(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.guildRecruitData_) do
		if slot6.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and slot6.msgID == slot1 then
			if slot0.guildRecruitData_[slot5 + 1] == nil and slot0.guildRecruitData_[slot5 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
				table.remove(slot0.guildRecruitData_, slot5)
				table.remove(slot0.guildRecruitData_, slot5 - 1)

				break
			end

			table.remove(slot0.guildRecruitData_, slot5)

			break
		end
	end

	for slot5, slot6 in ipairs(slot0.guildRecruitTempData_) do
		if slot6.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and slot6.msgID == slot1 then
			if slot0.guildRecruitTempData_[slot5 + 1] and slot0.guildRecruitTempData_[slot5 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
				table.remove(slot0.guildRecruitTempData_, slot5)
				table.remove(slot0.guildRecruitTempData_, slot5 - 1)

				break
			end

			table.remove(slot0.guildRecruitTempData_, slot5)

			break
		end
	end
end

function slot0.ParseMsg(slot0, slot1)
	return {
		id = slot1.sender_uid,
		msgID = slot1.club_base_info.id,
		nick = slot1.sender_nick,
		icon = slot1.sender_icon,
		iconFrame = slot1.sender_frame,
		timestamp = slot1.send_timestamp,
		contentType = ChatConst.CHAT_CONTENT_TYPE.GUILD_RECRUIT,
		content = slot1.recommend,
		guildID = slot1.club_base_info.id,
		ip = slot1.ip or GetTips("IP_UNKNOWN")
	}
end

function slot0.AddRequireGuild(slot0, slot1)
	if not table.keyof(slot0.requireGuildList_, slot1) then
		table.insert(slot0.requireGuildList_, slot1)
	end
end

function slot0.GetRequireGuild(slot0)
	return slot0.requireGuildList_
end

function slot0.RemoveRequireData(slot0)
	slot0.requireGuildList_ = {}
end

return slot0
