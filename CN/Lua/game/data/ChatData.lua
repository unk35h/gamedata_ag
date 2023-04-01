slot0 = singletonClass("ChatData")

function slot0.Init(slot0)
	slot0.worldChannelNum_ = 0
	slot0.worldChannelData_ = {}
	slot0.worldChannelTempData_ = {}
	slot0.channelTimestamp_ = 0
	slot0.sendTextTimestamp_ = {
		0
	}
	slot0.stickerTimestamp_ = 0
	slot0.mutedData_ = {
		mutedContent = "",
		mutedTimestamp = 0
	}
	slot0.isShowMutedTips_ = false
	slot0.reportCnt_ = 0
end

function slot0.UpdateMutedLevel(slot0, slot1)
	if slot1.ban_timestamp < slot0.mutedData_.mutedTimestamp then
		slot0.isShowMutedTips_ = false
	end

	slot0.mutedData_.mutedContent = slot1.mute_reason
	slot0.mutedData_.mutedTimestamp = slot1.ban_timestamp
end

function slot0.GetMutedData(slot0)
	return slot0.mutedData_
end

function slot0.IsMuted(slot0)
	return manager.time:GetServerTime() < slot0.mutedData_.mutedTimestamp
end

function slot0.SetShowMutedTips(slot0, slot1)
	slot0.isShowMutedTips_ = slot1
end

function slot0.GetShowMutedTips(slot0)
	return slot0.isShowMutedTips_
end

function slot0.SetWorldChannelNum(slot0, slot1)
	slot0.worldChannelNum_ = slot1
	slot2 = {
		timestamp = manager.time:GetServerTime(),
		contentType = ChatConst.CHAT_CONTENT_TYPE.CHANNEL,
		content = slot1
	}

	table.insert(slot0.worldChannelData_, slot2)
	table.insert(slot0.worldChannelTempData_, slot2)
end

function slot0.GetWorldChannelNum(slot0)
	return slot0.worldChannelNum_
end

function slot0.GetWorldChatData(slot0)
	return slot0.worldChannelTempData_ or {}
end

function slot0.ResetWorldTempData(slot0, slot1)
	slot0.worldChannelTempData_ = slot1
end

function slot0.GetWorldOriginChatData(slot0)
	return slot0.worldChannelData_
end

function slot0.AddWorldChat(slot0, slot1, slot2)
	slot0.worldChannelData_ = slot0.worldChannelData_ or {}

	if #slot0.worldChannelData_ <= 0 or slot3 > 0 and ChatConst.MESSAGE_SPACE < manager.time:GetServerTime() - slot0.worldChannelData_[slot3].timestamp or slot0.worldChannelData_[slot3].contentType == ChatConst.CHAT_CONTENT_TYPE.CHANNEL then
		slot4 = {
			timestamp = slot1.timestamp,
			contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
		}

		table.insert(slot0.worldChannelData_, slot4)
		table.insert(slot0.worldChannelTempData_, slot4)
	end

	table.insert(slot0.worldChannelData_, slot0:ParseMsg(slot1))

	if not slot2 then
		table.insert(slot0.worldChannelTempData_, slot4)
	end
end

function slot0.RemoveWorldChat(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.worldChannelData_) do
		if slot6.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and slot6.msgID == slot1 then
			if slot0.worldChannelData_[slot5 + 1] == nil and slot0.worldChannelData_[slot5 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
				table.remove(slot0.worldChannelData_, slot5)
				table.remove(slot0.worldChannelData_, slot5 - 1)

				break
			end

			table.remove(slot0.worldChannelData_, slot5)

			break
		end
	end

	for slot5, slot6 in ipairs(slot0.worldChannelTempData_) do
		if slot6.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and slot6.msgID == slot1 then
			if slot0.worldChannelTempData_[slot5 + 1] and slot0.worldChannelTempData_[slot5 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
				table.remove(slot0.worldChannelTempData_, slot5)
				table.remove(slot0.worldChannelTempData_, slot5 - 1)

				break
			end

			table.remove(slot0.worldChannelTempData_, slot5)

			break
		end
	end
end

function slot0.ParseMsg(slot0, slot1)
	return {
		id = slot1.sender_uid,
		msgID = slot1.msg_id,
		nick = slot1.nick,
		icon = slot1.icon,
		iconFrame = slot1.icon_frame,
		timestamp = slot1.timestamp,
		contentType = slot1.type,
		content = slot1.content,
		roomID = slot1.room_id,
		ip = slot1.ip_location or GetTips("IP_UNKNOWN")
	}
end

function slot0.SetSendTextTimestamp(slot0)
	if #slot0.sendTextTimestamp_ >= 3 then
		table.remove(slot0.sendTextTimestamp_, 1)
	end

	table.insert(slot0.sendTextTimestamp_, manager.time:GetServerTime())
end

function slot0.GetSendTextTimestamp(slot0)
	return slot0.sendTextTimestamp_[1]
end

function slot0.SetSendStickerTimestamp(slot0)
	slot0.stickerTimestamp_ = manager.time:GetServerTime()
end

function slot0.GetSendStickerTimestamp(slot0)
	return slot0.stickerTimestamp_
end

function slot0.SetChannelTimestamp(slot0)
	slot0.channelTimestamp_ = manager.time:GetServerTime()
end

function slot0.GetChannelTimestamp(slot0)
	return slot0.channelTimestamp_
end

function slot0.InitReportCnt(slot0, slot1)
	slot0.reportCnt_ = slot1
end

function slot0.AddReportCnt(slot0)
	slot0.reportCnt_ = slot0.reportCnt_ + 1
end

function slot0.GetReportCnt(slot0)
	return slot0.reportCnt_
end

return slot0
