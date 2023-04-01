return {
	CHAT_CHANNEL_GUILD_RECRUIT = 4,
	MAX_CHAT_RECORD_COUNT = 50,
	CHAT_CHANNEL_GUILD_ACTIVITY = 6,
	MESSAGE_SPACE = 300,
	CHAT_CHANNEL_COOPERATION = 5,
	CHAT_CHANNEL_GUILD = 3,
	CHAT_CHANNEL_FRIEND = 2,
	CHAT_CHANNEL_WORLD = 1,
	CHAT_CONTENT_TYPE = {
		TEXT = 1,
		GUILD_RECRUIT = 5,
		HISTORY_TIPS = 4,
		STICKER = 2,
		CHANNEL = 0,
		TIMESTAMP = 3
	},
	CHAT_REPORT_TYPE = {
		USER = 2,
		CONTENT = 1
	},
	CHAT_REPORT_REASON = {
		{
			0,
			2001,
			2002,
			2003,
			2004,
			2005
		},
		{
			0,
			1001,
			1002
		}
	},
	CHAT_REASON_INDEX = {
		[0] = "REPORT_REASON_NULL",
		[2001.0] = "REPORT_REASON_POLITICS",
		[2003.0] = "REPORT_REASON_ABUSE",
		[2004.0] = "REPORT_REASON_SEX",
		[2002.0] = "REPORT_REASON_AD",
		[2005.0] = "REPORT_REASON_OTHER",
		[1001.0] = "REPORT_REASON_NICK",
		[1002.0] = "REPORT_REASON_SIGNATURE"
	},
	VERIFY_STATUS = {
		OBSERVE = 1,
		ERROR = 3,
		NO_PASS = 2,
		PASS = 0
	}
}