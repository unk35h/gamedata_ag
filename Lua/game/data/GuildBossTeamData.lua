slot0 = singletonClass("GuildBossTeamData")

function slot0.Init(slot0)
	slot0.singleTeam_ = {}
	slot0.heroTrialList_ = {}
	slot0.stageTeam_ = {}
	slot0.stageTeamTrial_ = {}
	slot0.serverTeam_ = {}
	slot0.trialActivityData_ = {}
end

function slot0.InitTeam(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot6.type
		slot0.singleTeam_[slot7] = {}
		slot0.heroTrialList_[slot7] = {}

		for slot11, slot12 in ipairs(slot6.hero_list) do
			if slot12.hero_type == 1 or slot12.hero_id == 0 then
				slot0.singleTeam_[slot7][slot11] = slot12.hero_id
				slot0.heroTrialList_[slot7][slot11] = 0
			else
				slot0.singleTeam_[slot7][slot11] = HeroStandardSystemCfg[slot12.hero_id].hero_id
				slot0.heroTrialList_[slot7][slot11] = slot12.hero_id
			end
		end

		for slot11 = 1, 3 do
			slot0.singleTeam_[slot7][slot11] = slot0.singleTeam_[slot7][slot11] or 0
			slot0.heroTrialList_[slot7][slot11] = slot0.heroTrialList_[slot7][slot11] or 0
		end
	end
end

function slot0.UpdateRoomData(slot0, slot1)
	slot0.roomID_ = slot1.room_id
	slot3 = {}

	for slot7 = 1, 3 do
		if slot1.player_list[slot7] then
			slot9 = {}

			for slot13, slot14 in ipairs(slot8.hero_list) do
				slot15 = slot14.hero_id
				slot16 = 0

				if slot14.hero_type == 2 then
					slot15 = HeroStandardSystemCfg[slot15].hero_id
					slot16 = slot14.hero_id
				end

				slot17 = {
					id = slot15,
					trialID = slot16,
					star = slot14.star,
					exp = slot14.exp,
					level = HeroTools.CheckExp(1, slot14.exp),
					equip_list = {},
					using_astrolabe = {},
					skill = {},
					break_level = slot14.break_level,
					weapon_info = {
						exp = slot14.weapon_info.exp,
						breakthrough = slot14.weapon_info.breakthrough
					}
				}

				if slot14.weapon_info.servant then
					slot17.servant = {
						id = slot14.weapon_info.servant.id,
						stage = slot14.weapon_info.servant.stage
					}
				else
					slot17.servant = {}
				end

				if slot14.equip_list then
					for slot21, slot22 in ipairs(slot14.equip_list) do
						slot23 = {}

						if slot22.enchant_slot_list then
							for slot27, slot28 in ipairs(slot22.enchant_slot_list) do
								slot29 = slot28.id
								slot31 = {}

								for slot35, slot36 in ipairs(slot28.effect_list) do
									table.insert(slot31, {
										id = slot36.id,
										num = slot36.level
									})
								end

								if #slot31 > 0 then
									slot23[slot27] = slot31
								end
							end
						end

						slot17.equip_list[slot21] = {
							equip_id = slot22.equip_id,
							prefab_id = slot22.prefab_id,
							exp = slot22.exp,
							now_break_level = slot22.now_break_level or 0,
							enchant = slot23,
							race = slot22.race
						}
					end
				end

				if slot14.astrolabe_list then
					for slot21, slot22 in ipairs(slot14.astrolabe_list) do
						slot17.using_astrolabe[slot21] = slot22
					end
				end

				if slot14.skill then
					for slot21, slot22 in ipairs(slot14.skill) do
						slot17.skill[slot21] = {
							skill_id = slot22.skill_id,
							skill_level = slot22.skill_level
						}
					end
				end

				table.insert(slot9, slot17)
			end

			slot3[slot7] = {
				playerID = slot8.player_id,
				nick = slot8.nick,
				level = slot8.level,
				channel = slot8.channel,
				server = slot8.server,
				is_ready = slot8.is_ready,
				is_master = slot8.is_master,
				heroList = slot9
			}
		end
	end

	slot0.serverTeam_ = {
		dest = slot1.dest,
		available = slot1.available,
		access = slot1.access,
		level = slot1.level,
		playerList = slot3
	}
end

function slot0.GetRoomID(slot0)
	return slot0.roomID_
end

function slot0.GetServerTeam(slot0)
	return slot0.serverTeam_
end

function slot0.SetSingleTeam(slot0, slot1, slot2, slot3)
	slot0.singleTeam_[slot1] = {}

	for slot7 = 1, 3 do
		slot0.singleTeam_[slot1][slot7] = slot2[slot7] or 0
	end

	slot0.heroTrialList_[slot1] = slot3
end

function slot0.GetSingleTeam(slot0, slot1)
	return clone(slot0.singleTeam_[slot1] or {
		0,
		0,
		0
	}), clone(slot0.heroTrialList_[slot1] or {
		0,
		0,
		0
	})
end

function slot0.SetStageTeam(slot0, slot1, slot2, slot3)
	slot0.stageTeam_[slot1] = slot2
	slot0.stageTeamTrial_[slot1] = slot3
end

function slot0.GetStageTeam(slot0, slot1)
	return clone(slot0.stageTeam_[slot1]), clone(slot0.stageTeamTrial_[slot1])
end

function slot0.UpdateHeroTrial(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.hero_trial_list) do
		slot0.trialActivityData_[slot6.activity_id] = {}

		for slot10, slot11 in ipairs(slot6.template_hero_list) do
			table.insert(slot0.trialActivityData_[slot6.activity_id], slot11)
		end
	end
end

function slot0.GetHeroTrial(slot0, slot1)
	return slot0.trialActivityData_[slot1]
end

return slot0
