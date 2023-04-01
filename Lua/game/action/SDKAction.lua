slot0 = require("cjson")
JUDGE_MESSAGE_TYPE = {
	PLAYER_SIGN = 2,
	GUILD_SHARE = 12,
	PLAYER_NAME = 1,
	CHAT_FRIEND = 8,
	GUILD_NOTICE = 4,
	GUILD_NAME_LOGIN = 10,
	GUILD_NOTICE_LOGIN = 11,
	GUILD_NAME = 3,
	CHAT_GUILD = 6,
	GUILD_ACTIVITY = 13,
	PLAYER_SIGN_LOGIN = 9,
	CHAT_WORLD = 7,
	DORM_TEMPLATE = 14,
	PLAYER_NAME_LOGIN = 5
}

return {
	JudgePlayerInfo = function ()
		slot0 = PlayerData:GetPlayerInfo()

		uv0.JudgeKeyAndPush(slot0.nick, JUDGE_MESSAGE_TYPE.PLAYER_NAME_LOGIN)
		uv0.JudgeKeyAndPush(slot0.sign, JUDGE_MESSAGE_TYPE.PLAYER_SIGN_LOGIN)

		if GuildData:GetGuildInfo() and slot1.id and slot1.id ~= 0 then
			uv0.JudgeKeyAndPush(slot1.name, JUDGE_MESSAGE_TYPE.GUILD_NAME_LOGIN)
			uv0.JudgeKeyAndPush(slot1.notice, JUDGE_MESSAGE_TYPE.GUILD_NOTICE_LOGIN)
		end
	end,
	JudgeKeyAndPush = function (slot0, slot1)
		WordVerifyBySDK(slot0, function (slot0, slot1)
		end, slot1)
	end,
	SendMessageToSDK = function (slot0, slot1)
		slot2 = {}
		slot3 = uv0.encode(slot1)

		table.insert(slot2, {
			event_name = slot0,
			attribute_json = slot3
		})
		print(string.format("sendMessageToSDK(GS), eventId = %s, message = %s", slot0, slot3))
		manager.net:Push(38014, {
			log_list = slot2
		})
	end
}
