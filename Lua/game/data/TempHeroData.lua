slot0 = singletonClass("TempHeroData")
slot1 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.GetHeroData(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1]
	end

	slot2 = HeroStandardSystemCfg[slot1]
	slot3 = SkinCfg[slot2.hero_id].hero
	uv0[slot1] = {
		unlock = 1,
		clear_times = 0,
		piece = 0,
		tempID = slot2.id,
		id = slot3,
		exp = LvTools.LevelToExp(slot2.hero_lv, "hero_level_exp1"),
		level = slot2.hero_lv,
		star = slot2.star_lv,
		skill = slot0:GetSkillTable(slot3, slot2.skill_lv),
		unlocked_astrolabe = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot2.astrolabe_suit_id] or {},
		using_astrolabe = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot2.astrolabe_suit_id] or {},
		equip = slot0:GetEquipTable(slot2.equip_list),
		equip_list = EquipTools.GetConstructVirtualEquips(slot2.id),
		clear_mission_list = {},
		using_skin = slot2.skin_id,
		unlocked_skin = {},
		break_level = slot2.hero_break,
		weapon_info = {
			level = slot2.weapon_level,
			exp = GameLevelSetting[slot2.weapon_level].weapon_lv_exp_sum,
			breakthrough = slot2.weapon_break
		},
		transition = {},
		servant_uid = slot2.weapon_key,
		servant_info = {
			id = slot2.weapon_key,
			stage = slot2.weapon_stage
		}
	}

	return uv0[slot1]
end

function slot0.GetSkillTable(slot0, slot1, slot2)
	slot3 = {}

	for slot8, slot9 in ipairs(HeroCfg[slot1].skills) do
		slot3[slot8] = {
			skill_id = slot9,
			skill_level = slot2
		}

		if slot9 == HeroCfg[slot1].avoid[1] then
			slot3[slot8].skill_level = 1
		end
	end

	return slot3
end

function slot0.GetEquipTable(slot0, slot1)
	slot2 = {}

	for slot6 = 1, 6 do
		slot2[slot6] = {
			pos = slot6,
			equip_id = slot1[slot6] and slot1[slot6] or 0
		}
	end

	return slot2
end

function slot0.GetTempHeroList(slot0, slot1)
	slot2, slot3 = nil
	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		if HeroStandardSystemCfg[slot9] then
			table.insert(slot4, SkinCfg[slot2.hero_id].hero)
		end
	end

	return slot4
end

function slot0.GetHeroDataByHeroID(slot0, slot1, slot2)
	slot3 = nil

	for slot7, slot8 in ipairs(slot1) do
		if slot0:GetHeroData(slot8).id == slot2 then
			return slot3
		end
	end

	return {}
end

function slot0.GetBattlePower(slot0, slot1, slot2)
	slot3 = {}
	slot4 = slot0:GetHeroData(slot1.tempID)

	for slot8, slot9 in ipairs(slot1.equip_list) do
		if slot9.equip_id ~= 0 then
			table.insert(slot3, slot4.equip_list[slot8])
		end
	end

	slot5 = clone(slot1)

	if slot1.servant_uid ~= 0 then
		slot5.servant = clone(slot1.servant_info)
	else
		slot5.servant = nil
	end

	slot6 = HeroTools.GetHeroEquipSkillAddLevel(slot1) == 1

	return calcBattlePower(slot5, slot3, slot4.tempID, slot2)
end

function slot0.HeroUsingSkinInfo(slot0, slot1, slot2)
	return SkinCfg[slot0:GetHeroDataByHeroID(slot1, slot2).using_skin == 0 and slot3.id or slot3.using_skin]
end

function slot0.GetHeroSkillInfo(slot0, slot1, slot2, slot3)
	slot4 = {}

	for slot10, slot11 in ipairs(slot0:GetHeroDataByHeroID(slot1, slot2).skill) do
		slot4[slot11.skill_id] = slot11.skill_level
	end

	slot7 = {}

	for slot11, slot12 in ipairs(HeroCfg[slot2].skills) do
		slot13 = HeroTools.GetHeroSkillAddLevel(slot5, slot12, slot3)

		if SkillTools.GetIsDodgeSkill(slot12) then
			slot13 = 0
		end

		table.insert(slot7, {
			isCanUp = false,
			id = slot12,
			heroId = slot2,
			lv = slot4[slot12],
			addSkillLv = slot13
		})
	end

	return slot7
end

function slot0.GetHeroWeaponInfo(slot0, slot1, slot2)
	return slot0:GetHeroDataByHeroID(slot1, slot2).weapon_info
end

function slot0.GetHeroServantInfo(slot0, slot1, slot2)
	slot3 = {}

	if slot0:GetHeroDataByHeroID(slot1, slot2).servant_uid ~= 0 then
		return {
			uid = 0,
			locked = true,
			id = slot4.servant_info.id,
			stage = slot4.servant_info.stage
		}
	end

	return nil
end

function slot0.GetEquipInfo(slot0, slot1, slot2, slot3)
	return slot0:GetHeroDataByHeroID(slot1, slot2).equip_list[slot3]
end

function slot0.CalHeroEquipAttribute(slot0, slot1, slot2)
	slot3 = {
		0,
		0,
		0,
		0,
		0
	}
	slot8 = slot2
	slot4 = slot0:GetHeroDataByHeroID(slot1, slot8)

	for slot8 = 1, 6 do
		if slot4.equip_list[slot8] then
			slot14 = slot9

			for slot13, slot14 in pairs(EquipTools.CountEquipAttribute(slot14, false, slot2)) do
				if slot3[slot13] == nil then
					slot3[slot13] = 0
				end

				slot3[slot13] = slot3[slot13] + slot14
			end
		end
	end

	return slot3
end

function slot0.CountActiveSuit(slot0, slot1, slot2)
	slot3 = {}

	for slot7 = 1, 6 do
		if slot0:GetEquipInfo(slot1, slot2, slot7) then
			if slot3[EquipCfg[slot8.prefab_id].suit] then
				slot3[slot9.suit].num = slot3[slot9.suit].num + 1
				slot3[slot9.suit].pos[slot9.pos] = true
			else
				slot3[slot9.suit] = {
					num = 1,
					id = slot9.suit,
					pos = {
						[slot9.pos] = true
					}
				}
			end
		end
	end

	slot4 = {}

	for slot8, slot9 in pairs(slot3) do
		table.insert(slot4, slot9)
	end

	return slot4
end

return slot0
