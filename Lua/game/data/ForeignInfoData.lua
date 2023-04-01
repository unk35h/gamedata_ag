slot0 = singletonClass("ForeignInfoData")
slot1 = {
	get_id_list = {},
	equip_list = {}
}

function slot0.SetForeignHeroInfo(slot0, slot1)
	uv0 = {
		get_id_list = {},
		equip_list = {}
	}

	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.hero_id] = {
			piece = 0,
			clear_times = 0,
			unlock = 1,
			id = slot6.hero_id,
			exp = slot6.exp,
			level = slot6.level,
			star = slot6.star,
			skill = cleanProtoTable(slot6.skill_list, {
				"skill_id",
				"skill_level"
			}),
			unlocked_astrolabe = cleanProtoTable(slot6.unlock_astrolabe),
			using_astrolabe = cleanProtoTable(slot6.using_astrolabe),
			using_hero_chip = cleanProtoTable(slot6.using_hero_chip),
			equip = slot0:DealHeroEquip(slot6.hero_id, slot6.equip_list),
			clear_mission_list = {},
			using_skin = slot6.using_skin,
			unlocked_skin = {},
			break_level = slot6.break_level,
			weapon_info = {
				level = WeaponTools.ExpToLv(slot6.weapon.exp),
				exp = slot6.weapon.exp,
				breakthrough = slot6.weapon.breakthrough
			},
			transition = slot0:GetTransition(slot6.exclusive_skill_list or {}),
			servant_uid = tonumber(slot6.weapon.servant_id),
			servant_stage = tonumber(slot6.weapon.servant_stage),
			moduleLevel = slot6.weapon_module_level,
			dormLevel = slot6.dorm_level
		}

		table.insert(uv0.get_id_list, slot6.hero_id)
	end
end

function slot0.DealHeroEquip(slot0, slot1, slot2)
	uv0.equip_list[slot1] = {}
	slot3 = {
		{
			pos = 1,
			equip_id = 0
		},
		{
			pos = 2,
			equip_id = 0
		},
		{
			pos = 3,
			equip_id = 0
		},
		{
			pos = 4,
			equip_id = 0
		},
		{
			pos = 5,
			equip_id = 0
		},
		{
			pos = 6,
			equip_id = 0
		}
	}

	for slot7, slot8 in ipairs(slot2) do
		slot9 = slot8.equip_id
		slot10 = EquipCfg[slot9].pos
		slot3[slot10].equip_id = slot9
		slot11 = {
			race_preview = 0,
			is_lock = true,
			equip_id = slot7,
			prefab_id = slot9,
			exp = slot8.exp,
			hero_id = slot1,
			now_break_level = slot8.now_break_level,
			enchant_slot_list = slot0:DealEnchantInfo(slot8.enchant_slot_list),
			race = slot8.race
		}
		slot12 = EquipStruct.New(slot11.equip_id, slot11.prefab_id)

		slot12:ParseServerData(slot11)

		uv0.equip_list[slot1][slot10] = slot12
	end

	return slot3
end

function slot0.DealEnchantInfo(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot2[slot7.id] = {
			id = slot7.id,
			effect_list = cleanProtoTable(slot7.effect_list, {
				"id",
				"level"
			}),
			preview_list = {}
		}
	end

	return slot2
end

function slot0.CountActiveSuit(slot0, slot1)
	slot2 = {}

	for slot6 = 1, 6 do
		if slot0:GetEquipInfo(slot1, slot6) then
			if slot2[EquipCfg[slot7.prefab_id].suit] then
				slot2[slot8.suit].num = slot2[slot8.suit].num + 1
				slot2[slot8.suit].pos[slot8.pos] = true
			else
				slot2[slot8.suit] = {
					num = 1,
					id = slot8.suit,
					pos = {
						[slot8.pos] = true
					}
				}
			end
		end
	end

	slot3 = {}

	for slot7, slot8 in pairs(slot2) do
		table.insert(slot3, slot8)
	end

	return slot3
end

function slot0.GetHeroList(slot0)
	return uv0.get_id_list or {}
end

function slot0.GetHeroNO(slot0, slot1)
	return table.indexof(uv0.get_id_list, slot1)
end

function slot0.GetHeroInfo(slot0, slot1)
	slot2 = {}

	if uv0[slot1] then
		slot2 = uv0[slot1]
		slot2.servant = {
			id = slot2.servant_uid,
			stage = slot2.servant_stage
		}
	end

	return slot2
end

function slot0.HeroUsingSkinInfo(slot0, slot1)
	return SkinCfg[slot0:GetHeroInfo(slot1).using_skin == 0 and slot2.id or slot2.using_skin]
end

function slot0.GetHeroSkillInfo(slot0, slot1, slot2)
	slot3 = {}

	for slot8, slot9 in ipairs(slot0:GetHeroInfo(slot1).skill) do
		slot3[slot9.skill_id] = slot9.skill_level
	end

	slot5 = {}

	for slot9, slot10 in ipairs(HeroCfg[slot1].skills) do
		slot11 = HeroTools.GetHeroSkillAddLevel(slot4, slot10, slot2)

		if SkillTools.GetIsDodgeSkill(slot10) then
			slot11 = 0
		end

		table.insert(slot5, {
			isCanUp = false,
			id = slot10,
			heroId = slot1,
			lv = slot3[slot10],
			addSkillLv = slot11
		})
	end

	return slot5
end

function slot0.GetEquipInfo(slot0, slot1, slot2)
	return uv0.equip_list[slot1][slot2]
end

function slot0.GetBattlePower(slot0, slot1)
	slot2 = slot0:GetHeroInfo(slot1)
	slot3 = {}

	for slot7 = 1, 6 do
		if uv0.equip_list[slot1][slot7] then
			table.insert(slot3, uv0.equip_list[slot1][slot7])
		end
	end

	slot4 = clone(slot2)

	if slot2.servant_uid ~= 0 then
		slot4.servant = {
			id = slot4.servant_uid,
			stage = slot4.servant_stage
		}
	else
		slot4.servant = nil
	end

	slot5 = HeroTools.GetHeroEquipSkillAddLevel(slot2) == 1

	return calcBattlePower(slot4, slot3)
end

function slot0.GetHeroWeaponInfo(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].weapon_info
	end
end

function slot0.GetHeroServantInfo(slot0, slot1)
	slot2 = {}

	if slot0:GetHeroInfo(slot1).servant_uid ~= 0 then
		return {
			uid = 0,
			locked = true,
			id = slot3.servant_uid,
			stage = slot3.servant_stage
		}
	else
		return nil
	end
end

function slot0.CalHeroEquipAttribute(slot0, slot1)
	slot2 = {
		0,
		0,
		0,
		0,
		0
	}

	for slot6 = 1, 6 do
		if uv0.equip_list[slot1][slot6] then
			slot12 = slot7

			for slot11, slot12 in pairs(EquipTools.CountEquipAttribute(slot12, false, slot1)) do
				if slot2[slot11] == nil then
					slot2[slot11] = 0
				end

				slot2[slot11] = slot2[slot11] + slot12
			end
		end
	end

	return slot2
end

function slot0.GetEquipList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0.equip_list[slot1]) do
		table.insert(slot2, slot7)
	end

	return slot2
end

function slot0.GetTransition(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot2[slot6] = {
			slot_id = slot7.slot_id,
			skill_list = cleanProtoTable(slot7.skill_list, {
				"skill_id",
				"skill_level"
			}),
			talent_points = slot7.talent_points
		}
	end

	return slot2
end

function slot0.GetTransitionAddLevel(slot0, slot1, slot2)
	slot3 = slot0:GetHeroInfo(slot1)

	if not table.indexof(HeroCfg[slot1].skills, slot2) then
		return 0
	end

	slot6 = HeroTools.GetHeroEquipSkillAddLevel(slot3)
	slot7 = 0
	slot8 = 0
	slot9 = GameSetting.exclusive_skill_level_up_type.value
	slot10 = uv0.equip_list[slot1]
	slot12 = slot3.equip

	for slot16, slot17 in ipairs(slot3.transition) do
		if slot12[slot17.slot_id].equip_id ~= 0 and GameSetting.exclusive_open_need.value[1] <= slot10[slot18]:GetLevel() then
			for slot25, slot26 in ipairs(slot17.skill_list) do
				slot27 = slot26.skill_id

				for slot31, slot32 in ipairs(slot9) do
					if slot27 == slot32[1] and slot32[2] == slot5 then
						slot8 = slot8 + slot26.skill_level
						slot7 = slot27
					end
				end
			end
		end
	end

	if slot7 ~= 0 then
		slot13 = EquipSkillCfg[slot7]

		return slot13.upgrade / slot13.percent * (slot8 + slot6)
	end

	return 0
end

function slot0.GetForeignModuleLevelByHeroID(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].moduleLevel
	end

	return 0
end

return slot0
