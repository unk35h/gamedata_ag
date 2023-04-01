slot0 = import("game.tools.HeroTools")

return function (slot0, slot1)
	if slot0 == nil then
		slot0 = {
			servant_uid = 0,
			chat_unread = 0,
			is_care = 2,
			exp = 0,
			unlock = 0,
			clear_times = 0,
			piece = 0,
			isWorking = 0,
			break_level = 0,
			weapon_info = 0,
			star = 1,
			level = 1,
			using_skin = 0,
			id = 0,
			skill = {},
			unlocked_astrolabe = {},
			using_astrolabe = {},
			equip = {},
			chat_history = {},
			clear_mission_list = {},
			unlocked_skin = {}
		}
	end

	function slot3(slot0)
		slot1 = uv0.data
		slot0.id = slot1.id
		slot0.exp = slot1.exp
		slot0.level = slot1.level
		slot0.phase = HeroStarCfg[slot1.star].phase
		slot0.star = HeroStarCfg[slot1.star].star
		slot0.piece = slot1.piece
		slot0.unlock = slot1.unlock
		slot0.skill = uv1.Format(slot1.skill, {
			"skill_id",
			"skill_level"
		})
		slot0.equip = uv1.Format(slot1.equip, {
			"pos",
			"equip_id"
		})
		slot0.clear_mission_list = cleanProtoTable(slot1.clear_mission_list)
		slot0.clear_times = slot1.clear_times or 0
		slot0.using_skin = slot1.using_skin
		slot0.unlocked_skin = cleanProtoTable(slot1.unlocked_skin)
		slot0.break_level = slot1.break_level
		slot0.weapon_info = {
			level = WeaponTools.ExpToLv(slot1.weapon_info.exp),
			exp = slot1.weapon_info.exp,
			breakthrough = slot1.weapon_info.breakthrough
		}
		slot0.servant_uid = tonumber(slot1.weapon_info.servant)
	end

	if ({
		[ACTIONS.HERO_INIT] = slot3,
		[ACTIONS.HERO_MODIFY] = slot3,
		[ACTIONS.HERO_EXP_ADD_SUCCESS] = function (slot0)
			slot0.level = uv0.data.level
			slot0.exp = uv0.data.exp
		end,
		[ACTIONS.HERO_STAR_UP_SUCCESS] = function (slot0)
			slot0.phase = slot0.phase + 1

			if HeroConst.PER_STAR_PHASE < slot0.phase then
				slot0.phase = 0
				slot0.star = slot0.star + 1
			end
		end,
		[ACTIONS.HERO_UNLOCK_SUCCESS] = function (slot0)
			slot0.unlock = 1
		end,
		[ACTIONS.HERO_SKILL_UP_SUCCESS] = function (slot0)
			for slot4, slot5 in immer.ipairs(slot0.skill) do
				if slot5.skill_id == uv0.data.skillId then
					if not uv0.data.num then
						uv0.data.num = 1
					end

					slot5.skill_level = slot5.skill_level + uv0.data.num

					break
				end
			end
		end,
		[ACTIONS.HERO_PIECE_MODIFY] = function (slot0)
			slot0.piece = slot0.piece + uv0.data.vary
		end,
		[ACTIONS.HERO_EQUIP_CHANGE] = function (slot0)
			for slot4, slot5 in immer.ipairs(slot0.equip) do
				if slot5.pos == uv0.data.pos then
					slot0.equip[slot4].equip_id = uv0.data.equipId

					break
				end
			end
		end,
		[ACTIONS.HERO_CHAT_INIT] = function (slot0)
			if uv0.data.is_care then
				slot0.is_care = uv0.data.is_care
			end

			if uv0.data.nick then
				slot0.nick = uv0.data.nick
			end

			slot1 = {}
			slot2 = 0

			for slot6, slot7 in ipairs(uv0.data.chat_history) do
				table.insert(slot1, {
					chat_id = slot7.chat_id,
					chat_cfg_id = slot7.chat_cfg_id,
					timestamp = slot7.timestamp,
					is_reward = slot7.is_reward
				})

				if slot7.is_reward == 2 then
					slot2 = slot2 + 1
				end
			end

			if slot1[#slot1] and AddressListChatCfg[slot4.chat_cfg_id] and #slot6.next ~= 0 then
				slot2 = slot2 + 1
			end

			slot0.chat_unread = slot2
			slot0.chat_history = slot1
		end,
		[ACTIONS.HERO_CHAT_MODIFY] = function (slot0)
			if uv0.data.is_care then
				slot0.is_care = uv0.data.is_care
			end

			if uv0.data.nick then
				slot0.nick = uv0.data.nick
			end

			slot1 = {}

			for slot5, slot6 in ipairs(uv0.data.chat_history) do
				immer.insert(slot0.chat_history, {
					chat_id = slot6.chat_id,
					chat_cfg_id = slot6.chat_cfg_id,
					timestamp = slot6.timestamp,
					is_reward = slot6.is_reward
				})

				slot8 = AddressListChatCfg[slot6.chat_cfg_id]

				if slot6.is_reward == 2 then
					slot0.chat_unread = slot0.chat_unread + 1
				end
			end
		end,
		[ACTIONS.HERO_GIFT_GET] = function (slot0)
			slot1 = 0

			for slot5, slot6 in immer.ipairs(slot0.chat_history) do
				if slot6.chat_id == uv0.data.chat_id then
					slot1 = slot5

					break
				end
			end

			slot0.chat_unread = slot0.chat_unread - 1
			slot0.chat_history[slot1].is_reward = 1
		end,
		[ACTIONS.HERO_CHAT_READ] = function (slot0)
			slot0.chat_unread = slot0.chat_unread - 1
		end,
		[ACTIONS.HERO_CARE_MODIFY] = function (slot0)
			slot0.is_care = uv0.data.is_care
		end,
		[ACTIONS.HERO_CLEAR_MISSION] = function (slot0)
			if not table.keyof(slot0.clear_mission_list, uv0.data.missionId) then
				immer.insert(slot0.clear_mission_list, uv0.data.missionId)
			end
		end,
		[ACTIONS.HERO_CLEAR_TIMES] = function (slot0)
			slot0.clear_times = uv0.data.clear_times
		end,
		[ACTIONS.HERO_NICK_MODIFY] = function (slot0)
			slot0.nick = uv0.data.nick
		end,
		[ACTIONS.HERO_SKIN_ADD] = function (slot0)
			immer.insert(slot0.unlocked_skin, uv0.data.skinId)
		end,
		[ACTIONS.SELECT_SKIN] = function (slot0)
			slot0.using_skin = uv0.data.skinId
		end,
		[ACTIONS.HERO_BREAK_SUCCESS] = function (slot0)
			slot0.break_level = uv0.data.breakLevel
		end,
		[ACTIONS.HERO_SERVANT_REPLACE] = function (slot0)
			slot0.servant_uid = uv0.data.servant_uid
		end,
		[ACTIONS.HERO_WEAPON_STR] = function (slot0)
			slot0.weapon_info.level = uv0.data.level
			slot0.weapon_info.exp = uv0.data.exp
		end,
		[ACTIONS.HERO_WEAPON_BREAK] = function (slot0)
			slot0.weapon_info.breakthrough = uv0.data.breakthrough
		end
	})[slot1.type] then
		return immer.produce(slot0, function (slot0)
			uv0[uv1.type](slot0)
		end)
	else
		return slot0
	end
end
