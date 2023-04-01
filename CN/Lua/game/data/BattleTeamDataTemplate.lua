BattleTeamPlayerTemplate = class("BattleTeamHeroTemplate")

function BattleTeamPlayerTemplate.Ctor(slot0, slot1)
	slot0.playerID = tonumber(slot1.player_id)
	slot2 = slot1.player_battle_info
	slot0.nick = slot2.nick
	slot0.level = slot2.level
	slot0.channel = slot2.channel
	slot0.server = slot2.server
	slot0.heroList = {}

	for slot6, slot7 in ipairs(slot2.hero_list) do
		slot8 = slot7.hero_id
		slot9 = slot7.skin
		slot10 = 0

		if slot7.hero_type == 2 then
			slot8 = HeroStandardSystemCfg[slot8].hero_id
			slot10 = slot7.hero_id
		end

		slot11 = {
			id = slot8,
			skin = slot9,
			trialID = slot10,
			star = slot7.star,
			exp = slot7.exp,
			level = HeroTools.CheckExp(1, slot7.exp),
			equip_list = {},
			using_astrolabe = {},
			skill = {},
			break_level = slot7.break_level,
			weapon_info = {
				exp = slot7.weapon_info.exp,
				breakthrough = slot7.weapon_info.breakthrough
			},
			transition = {},
			weapon_module_level = slot7.hero_weapon_module_level,
			dormLevel = slot7.dorm_level
		}

		if slot7.weapon_info.servant then
			slot11.servant = {
				id = slot7.weapon_info.servant.id,
				stage = slot7.weapon_info.servant.stage
			}
		else
			slot11.servant = {}
		end

		if slot7.equip_list then
			for slot15, slot16 in ipairs(slot7.equip_list) do
				slot17 = {}

				if slot16.enchant_slot_list then
					for slot21, slot22 in ipairs(slot16.enchant_slot_list) do
						slot23 = slot22.id
						slot25 = {}

						for slot29, slot30 in ipairs(slot22.effect_list) do
							table.insert(slot25, {
								id = slot30.id,
								num = slot30.level
							})
						end

						if #slot25 > 0 then
							slot17[slot21] = slot25
						end
					end
				end

				slot11.equip_list[slot15] = {
					equip_id = slot16.equip_id,
					prefab_id = slot16.prefab_id,
					exp = slot16.exp,
					now_break_level = slot16.now_break_level or 0,
					enchant = slot17,
					race = slot16.race
				}
			end
		end

		if slot7.astrolabe_list then
			for slot15, slot16 in ipairs(slot7.astrolabe_list) do
				slot11.using_astrolabe[slot15] = slot16
			end
		end

		if slot7.skill then
			for slot15, slot16 in ipairs(slot7.skill) do
				slot11.skill[slot15] = {
					skill_id = slot16.skill_id,
					skill_level = slot16.skill_level
				}
			end
		end

		if slot7.hero_slot_exclusive_skill_list then
			for slot15, slot16 in ipairs(slot7.hero_slot_exclusive_skill_list) do
				slot11.transition[slot16.slot_id] = cleanProtoTable(slot16.skill_list, {
					"skill_id",
					"skill_level"
				})
			end
		end

		table.insert(slot0.heroList, slot11)
	end

	slot0.UpdateRoomData(slot0, slot1.player_room_info)
end

function BattleTeamPlayerTemplate.UpdateRoomData(slot0, slot1)
	slot0.is_ready = slot1.is_ready
	slot0.is_master = slot1.is_master
	slot0.be_liked_uids = {}

	for slot5, slot6 in ipairs(slot1.be_liked_uids) do
		table.insert(slot0.be_liked_uids, slot6)
	end
end
