slot1 = require("cjson")

return {
	defaultDirectory = Application.persistentDataPath,
	LoadFriendLocalChatCache = function (slot0)
		slot3 = {}

		for slot7 = 0, FileStreamMgr.inst:ReadlAllLine(uv0.GetFriendChatFile(slot0)).Count - 1 do
			table.insert(slot3, uv1.decode(slot2[slot7]))
		end

		ChatFriendData:InitFriendContnent(slot0, slot3)
	end,
	GetFriendChatFile = function (slot0)
		return string.format("%s/chat/%s/friend/%s.txt", uv0.defaultDirectory, PlayerData:GetPlayerInfo().userID, slot0)
	end,
	SaveFriendsCache = function (slot0)
		for slot4, slot5 in ipairs(slot0) do
			uv0.SaveFriendChatCache(slot5)
		end
	end,
	SaveFriendChatCache = function (slot0)
		slot2 = uv0.GetFriendChatFile(slot0)
		slot3 = {}

		for slot7, slot8 in ipairs(ChatFriendData:GetSaveRecordList(slot0)) do
			table.insert(slot3, uv1.encode(slot8))
		end

		FileStreamMgr.inst:AppendLines(slot2, slot3)
		ChatFriendData:SetSaveRecordList(slot0, {})
	end,
	ResaveFriendChatCache = function (slot0)
		slot2 = uv0.GetFriendChatFile(slot0)
		slot4 = GameSetting.chat_length_max.value[1]
		slot5 = {}

		for slot9 = #ChatFriendData:GetFriendContent(slot0), 1, -1 do
			table.insert(slot5, 1, uv1.encode(slot1[slot9]))

			if slot4 < #slot5 then
				break
			end
		end

		FileStreamMgr.inst:AppendLines(slot2, slot5, false)
	end,
	DeleteFriendChatCache = function (slot0)
		FileStreamMgr.inst:DeleteFile(uv0.GetFriendChatFile(slot0))
	end,
	DeleteFriendChatRecord = function (slot0)
		if GameSetting.chat_length_max.value[1] + 20 < #ChatFriendData:GetFriendContent(slot0) then
			uv0.ResaveFriendChatCache(slot0)
		end
	end,
	LoadGuildLocalChatCache = function (slot0)
		slot3 = {}

		for slot7 = 0, FileStreamMgr.inst:ReadlAllLine(uv0.GetGuildChatFile(slot0)).Count - 1 do
			table.insert(slot3, uv1.decode(slot2[slot7]))
		end

		ChatGuildData:InitGuildContnent(slot3)
	end,
	GetGuildChatFile = function (slot0)
		return string.format("%s/chat/%s/guild/%s.txt", uv0.defaultDirectory, PlayerData:GetPlayerInfo().userID, slot0)
	end,
	SaveGuildChatCache = function (slot0)
		slot2 = uv0.GetGuildChatFile(slot0)
		slot3 = {}

		for slot7, slot8 in ipairs(ChatGuildData:GetSaveRecordList()) do
			table.insert(slot3, uv1.encode(slot8))
		end

		FileStreamMgr.inst:AppendLines(slot2, slot3)
		ChatGuildData:SetSaveRecordList({})
	end,
	ResaveGuildChatCache = function ()
		if GuildData:GetGuildInfo().id == nil then
			return
		end

		slot2 = uv0.GetGuildChatFile(slot0)
		slot4 = GameSetting.chat_length_max.value[1]
		slot5 = {}

		for slot9 = #ChatGuildData:GetContent(), 1, -1 do
			table.insert(slot5, 1, uv1.encode(slot1[slot9]))

			if slot4 < #slot5 then
				break
			end
		end

		FileStreamMgr.inst:AppendLines(slot2, slot5, false)
	end,
	DeleteGuildChatCache = function ()
		FileStreamMgr.inst:DeleteDirectory(string.format("%s/chat/%s/guild", uv0.defaultDirectory, PlayerData:GetPlayerInfo().userID))
	end,
	DeleteGuildChatRecord = function (slot0)
		if GameSetting.chat_length_max.value[1] + 20 < #ChatGuildData:GetContent() then
			uv0.ResaveGuildChatCache(slot0)
		end
	end,
	LoadLocalChatCache = function (slot0)
		slot3 = {}

		for slot7 = 0, FileStreamMgr.inst:ReadlAllLine(uv0.GetChannelChatFile(slot0)).Count - 1 do
			table.insert(slot3, uv1.decode(slot2[slot7]))
		end

		ChatChannelData:InitChannelContnent(slot0, slot3)
	end,
	GetChannelChatFile = function (slot0)
		return string.format("%s/chat/%s/channel/%s.txt", uv0.defaultDirectory, PlayerData:GetPlayerInfo().userID, slot0)
	end,
	SaveChannelChatCache = function (slot0)
		slot2 = uv0.GetChannelChatFile(slot0)
		slot3 = {}

		for slot7, slot8 in ipairs(ChatChannelData:GetSaveRecordList(slot0)) do
			table.insert(slot3, uv1.encode(slot8))
		end

		FileStreamMgr.inst:AppendLines(slot2, slot3)
		ChatChannelData:SetSaveRecordList(slot0, {})
	end,
	ResaveChannelChatCache = function (slot0)
		slot2 = uv0.GetChannelChatFile(slot0)
		slot4 = GameSetting.chat_length_max.value[1]
		slot5 = {}

		for slot9 = #ChatChannelData:GetContent(slot0), 1, -1 do
			table.insert(slot5, 1, uv1.encode(slot1[slot9]))

			if slot4 < #slot5 then
				break
			end
		end

		FileStreamMgr.inst:AppendLines(slot2, slot5, false)
	end,
	DeleteChannelChatCache = function (slot0)
		FileStreamMgr.inst:DeleteFile(uv0.GetChannelChatFile(slot0))
	end,
	DeleteChannelChatRecord = function (slot0)
		if GameSetting.chat_length_max.value[1] + 20 < #ChatChannelData:GetContent(slot0) then
			uv0.ResaveChannelChatCache(slot0)
		end
	end
}
