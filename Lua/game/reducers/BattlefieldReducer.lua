slot0 = import("game.const.FriendConst")
slot1 = import(".FriendReducer")

return function (slot0, slot1)
	if slot0 == nil then
		slot2 = getModule("battlefield")
		slot3 = {}

		for slot7 = 1, uv0.RECENT_MATE do
			table.insert(slot3, {
				online_state = false,
				user_id = tonumber(slot2["mateid" .. slot7]) or 0,
				nick = slot2["matenick" .. slot7] or "",
				icon = tonumber(slot2["mateicon" .. slot7]) or 1066,
				level = tonumber(slot2["matelevel" .. slot7]) or 1
			})
		end

		slot4 = {}
		slot0 = {
			port = 0,
			inBattle = false,
			recommendTime = 0,
			ip = "",
			multiple = 1,
			myRoom = 0,
			selectHeroInfo = 0,
			battleId = 0,
			selectIndex = 1,
			heros = {
				0,
				0,
				0
			},
			singleTeam = {
				tonumber(slot2.singleTeamHero1) or 1084,
				tonumber(slot2.singleTeamHero2) or 0,
				tonumber(slot2.singleTeamHero3) or 0
			},
			playerTeam = playerTeam,
			recommendData = {},
			battleData = {},
			recentMate = slot3
		}
	end

	if ({
		[ACTIONS.TEAM_ROOM_CHANGE] = function (slot0)
			slot0.myRoom = uv0.data.room_id
		end,
		[ACTIONS.TEAM_START] = function (slot0)
			slot0.ip = uv0.data.ip
			slot0.port = uv0.data.port
			slot0.battleId = uv0.data.id
			slot0.battleData[uv0.data.id] = 0
			slot0.inBattle = true
		end,
		[ACTIONS.TEAM_FINISH] = function (slot0)
			slot0.battleData[uv0.data.battle_id] = uv0.data.result
			slot0.inBattle = false
			slot1 = {}

			for slot5, slot6 in ipairs(uv0.data.star_list) do
				slot1[slot5] = {
					starID = slot6.star_id,
					isComplete = slot6.is_achieve
				}
			end

			slot2 = {}

			for slot6, slot7 in ipairs(uv0.data.all_drop_list) do
				slot8 = {}

				for slot12, slot13 in ipairs(slot7.gain_list) do
					slot8[slot12] = {
						id = slot13.id,
						num = slot13.num
					}
				end

				slot2[slot6] = {
					battleTimes = slot7.battle_times,
					rewardItems = slot8
				}
			end

			slot0.resultBattleID = uv0.data.dest
			slot0.resultCleanTimes = uv0.data.clear_times
			slot0.resultTargetTimes = uv0.data.target_times
			slot0.resultStarList = slot1
			slot0.resultAllDrop = slot2
		end,
		[ACTIONS.FRIEND_PLAYED] = function (slot0)
			slot0.recentMate = uv0.data
			slot1 = {}

			for slot5 = 1, uv1.RECENT_MATE do
				slot1["mateid" .. slot5] = uv0.data[slot5].user_id
				slot1["matenick" .. slot5] = uv0.data[slot5].nick
				slot1["mateicon" .. slot5] = uv0.data[slot5].icon
				slot1["matelevel" .. slot5] = uv0.data[slot5].level
			end
		end,
		[ACTIONS.FRIEND_PLAYED_ONLINE] = function (slot0)
			for slot4, slot5 in immer.ipairs(slot0.recentMate) do
				if uv0.data[slot5.user_id] then
					slot5.nick = slot6.nick
					slot5.level = slot6.level
					slot5.online_state = slot6.online_state
				else
					slot5.online_state = false
				end
			end

			slot1 = {}

			for slot5 = 1, uv1.RECENT_MATE do
				slot1["mateid" .. slot5] = slot0.recentMate[slot5].user_id
				slot1["matenick" .. slot5] = slot0.recentMate[slot5].nick
				slot1["mateicon" .. slot5] = slot0.recentMate[slot5].icon
				slot1["matelevel" .. slot5] = slot0.recentMate[slot5].level
			end
		end,
		[ACTIONS.SINGLE_TEAM_CHANGE] = function (slot0)
			slot1 = {}

			for slot5 = 1, 3 do
				slot6 = uv0.data.heroIdList[slot5] or 0
				slot0.singleTeam[slot5] = slot6
				slot1["singleTeamHero" .. slot5] = slot6
			end
		end,
		[ACTIONS.CHANGE_MULTIPLE] = function (slot0)
			slot0.multiple = uv0.data.multiple
		end,
		[ACTIONS.SECTION_SELECT_HERO] = function (slot0)
			slot0.selectHeroInfo = uv0.data.heroID
		end
	})[slot1.type] then
		return immer.produce(slot0, function (slot0)
			uv0[uv1.type](slot0)
		end)
	else
		return slot0
	end
end
