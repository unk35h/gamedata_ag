slot0 = import("game.tools.LvTools")

return function (slot0, slot1)
	if slot0 == nil then
		slot0 = {
			userID = 1,
			remain_exp = 0,
			userLevel = 10,
			nick = "1",
			portrait = 1084,
			originalLevel = 1,
			is_changed_nick = 0,
			plot_progress = 0,
			hero_num = 0,
			poster_girl = 1084,
			register_timestamp = 0,
			timestamp = 0,
			sign = "",
			total_exp = 0,
			unlocked_portraits = {},
			all_tag_list = {},
			show_tag_list = {},
			heros = {},
			storylist = {},
			levelUpInfos = {}
		}
	end

	if ({
		[ACTIONS.PLAYER_INFO_INIT] = function (slot0)
			slot0.total_exp = uv0.data.total_exp
			slot0.userLevel, slot0.remain_exp = uv1.CheckExp(1, slot0.total_exp, "user_level_exp")
			slot0.nick = uv0.data.nick
			slot0.is_changed_nick = uv0.data.is_changed_nick

			if uv0.data.portrait and uv0.data.portrait ~= 0 and uv0.data.portrait ~= 1 then
				slot0.portrait = uv0.data.portrait
			else
				slot0.portrait = 1084
			end

			slot0.unlocked_portraits = cleanProtoTable(uv0.data.unlocked_portraits)
			slot0.hero_num = uv0.data.hero_num
			slot0.plot_progress = uv0.data.plot_progress
		end,
		[ACTIONS.USER_ID_INIT] = function (slot0)
			slot0.userID = uv0.data.userID
			slot0.register_timestamp = uv0.data.register_timestamp
		end,
		[ACTIONS.USER_TIMESTAMP_INIT] = function (slot0)
			slot0.timestamp = uv0.data.timestamp
		end,
		[ACTIONS.PLAYER_PORTRAIT_CHANGE] = function (slot0)
			slot0.portrait = uv0.data
		end,
		[ACTIONS.PLAYER_NICKNAME_CHANGE] = function (slot0)
			slot0.is_changed_nick = 1
			slot0.nick = uv0.data
		end,
		[ACTIONS.EXP_CHANGE] = function (slot0)
			slot0.total_exp = slot0.total_exp + uv0.data
			slot0.userLevel, slot0.remain_exp = uv1.CheckExp(1, slot0.total_exp, "user_level_exp")
		end,
		[ACTIONS.PLAYER_CARD_INIT] = function (slot0)
			slot0.sign = uv0.data.sign
			slot0.all_tag_list = cleanProtoTable(uv0.data.all_tag_list)
			slot0.show_tag_list = cleanProtoTable(uv0.data.show_tag_list)
			slot0.heros = cleanProtoTable(uv0.data.heros)

			if uv0.data.poster_girl and uv0.data.poster_girl ~= 0 then
				slot0.poster_girl = uv0.data.poster_girl
			else
				slot0.poster_girl = 1084
			end
		end,
		[ACTIONS.PLAYER_SIGN_CHANGE] = function (slot0)
			slot0.sign = uv0.data
		end,
		[ACTIONS.PLAYER_SHOW_HERO_CHANGE] = function (slot0)
			slot0.heros = cleanProtoTable(uv0.data)
		end,
		[ACTIONS.PLAYER_POSTER_GIRL_CHANGE] = function (slot0)
			slot0.poster_girl = uv0.data
		end,
		[ACTIONS.USER_STORY_INIT] = function (slot0)
			for slot4, slot5 in ipairs(uv0.data) do
				slot0.storylist[slot5] = true
			end
		end,
		[ACTIONS.USER_STORY_MODIFY] = function (slot0)
			slot0.storylist[uv0.data] = true
		end,
		[ACTIONS.PLAYER_ORIGINAL_LEVEL] = function (slot0)
			slot0.originalLevel = uv0.data.user_level
		end,
		[ACTIONS.PLAYER_LEVEL_UPDATE] = function (slot0)
			if not slot0.levelUpInfos then
				slot0.levelUpInfos = {}
			end

			immer.insert(slot0.levelUpInfos, {
				fromLevel = uv0.data.fromLevel,
				toLevel = uv0.data.toLevel
			})
		end,
		[ACTIONS.PLAYER_LEVELUP_FINISH] = function (slot0)
			if slot0.levelUpInfos then
				while immer.getn(slot0.levelUpInfos) > 0 do
					immer.remove(slot0.levelUpInfos, 1)
				end
			end
		end
	})[slot1.type] then
		return immer.produce(slot0, function (slot0)
			uv0[uv1.type](slot0)
		end)
	else
		return slot0
	end
end
