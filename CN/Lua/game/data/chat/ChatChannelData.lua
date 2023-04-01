slot0 = import(".ChatNormalData")
slot1 = singletonClass("ChatChannelData")

function slot1.Init(slot0)
	slot0.chatChannelList_ = {}
end

function slot1.GetContent(slot0, slot1)
	if slot0.chatChannelList_[slot1] == nil then
		slot0.chatChannelList_[slot1] = uv0.New(slot1)
	end

	return slot0.chatChannelList_[slot1]:GetContent()
end

function slot1.AddChat(slot0, slot1, slot2)
	if slot0.chatChannelList_[slot1] == nil then
		slot0.chatChannelList_[slot1] = uv0.New(slot1)
	end

	slot0.chatChannelList_[slot1]:AddChat(slot2)
end

function slot1.RemoveChatData(slot0, slot1)
	if slot0.chatChannelList_[slot1] == nil then
		slot0.chatChannelList_[slot1] = uv0.New(slot1)
	end

	slot0.chatChannelList_[slot1]:RemoveChatData()
end

function slot1.RemoveChatContent(slot0, slot1, slot2)
	if slot0.chatChannelList_[slot1] == nil then
		slot0.chatChannelList_[slot1] = uv0.New(slot1)
	end

	return slot0.chatChannelList_[slot1]:RemoveChatContent(slot2)
end

function slot1.InitCacheContent(slot0, slot1)
	if slot0.chatChannelList_[slot1] == nil then
		slot0.chatChannelList_[slot1] = uv0.New(slot1)
	end

	slot0.chatChannelList_[slot1]:InitCacheContent()
end

function slot1.GetCacheContent(slot0, slot1)
	if slot0.chatChannelList_[slot1] == nil then
		slot0.chatChannelList_[slot1] = uv0.New(slot1)
	end

	return slot0.chatChannelList_[slot1]:GetCacheContent()
end

function slot1.SaveRecordCnt(slot0, slot1, slot2)
	if slot0.chatChannelList_[slot1] == nil then
		slot0.chatChannelList_[slot1] = uv0.New(slot1)
	end

	slot0.chatChannelList_[slot1]:SaveRecordCnt(slot2)
end

function slot1.GetUnreadMsgCnt(slot0, slot1)
	if slot0.chatChannelList_[slot1] == nil then
		slot0.chatChannelList_[slot1] = uv0.New(slot1)
	end

	return slot0.chatChannelList_[slot1]:GetUnreadMsgCnt()
end

function slot1.GetSaveRecordList(slot0, slot1)
	if slot0.chatChannelList_[slot1] == nil then
		slot0.chatChannelList_[slot1] = uv0.New(slot1)
	end

	return slot0.chatChannelList_[slot1]:GetSaveRecordList()
end

function slot1.SetSaveRecordList(slot0, slot1, slot2)
	if slot0.chatChannelList_[slot1] == nil then
		slot0.chatChannelList_[slot1] = uv0.New(slot1)
	end

	slot0.chatChannelList_[slot1]:SetSaveRecordList(slot2)
end

function slot1.InitChannelContnent(slot0, slot1, slot2)
	if slot0.chatChannelList_[slot1] == nil then
		slot0.chatChannelList_[slot1] = uv0.New(slot1)
	end

	slot0.chatChannelList_[slot1]:InitChannelContnent(slot2)
end

return slot1
