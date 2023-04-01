slot0 = singletonClass("HeroData")
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = true
slot5 = 0
slot6 = {}
slot7 = {}
slot8 = {}
slot9 = {}

function slot0.InitHero(slot0, slot1, slot2)
	uv0 = {}
	uv1 = {}
	uv2 = {}

	slot0:ResetSortValue()

	slot3 = {}
	slot4 = {}

	for slot8, slot9 in ipairs(slot2) do
		slot4[slot9.id] = slot9.num
	end

	for slot8, slot9 in ipairs(slot1) do
		slot3[slot9.id] = {
			id = slot9.id,
			exp = slot9.exp,
			level = slot9.level,
			star = slot9.star,
			piece = slot4[slot9.id] or 0,
			unlock = slot9.unlock,
			skill = cleanProtoTable(slot9.skill, {
				"skill_id",
				"skill_level"
			}),
			unlocked_astrolabe = cleanProtoTable(slot9.unlocked_astrolabe),
			using_astrolabe = cleanProtoTable(slot9.using_astrolabe),
			equip = cleanProtoTable(slot9.equip, {
				"pos",
				"equip_id"
			}),
			clear_mission_list = cleanProtoTable(slot9.clear_mission_list),
			clear_times = slot9.clear_times or 0,
			using_skin = slot9.using_skin,
			unlocked_skin = cleanProtoTable(slot9.unlocked_skin),
			break_level = slot9.break_level,
			weapon_info = {
				level = WeaponTools.ExpToLv(slot9.weapon_info.exp),
				exp = slot9.weapon_info.exp,
				breakthrough = slot9.weapon_info.breakthrough
			},
			transition = slot0:GetTransition(slot9.exclusive_skill_list or {}),
			servant_uid = tonumber(slot9.weapon_info.servant),
			moduleLevel = slot9.weapon_module_info.weapon_module_level,
			moduleAssignment = slot9.weapon_module_info.weapon_module_assignment
		}
	end

	slot5 = {
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

	for slot9, slot10 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		slot11 = HeroCfg[slot10]

		if slot3[slot10] then
			uv0[slot10] = slot3[slot10]
		else
			slot12 = {}

			for slot16, slot17 in ipairs(slot11.skills) do
				table.insert(slot12, {
					skill_level = 1,
					skill_id = slot17
				})
			end

			uv0[slot10] = {
				servant_uid = 0,
				exp = 0,
				clear_times = 0,
				break_level = 0,
				unlock = 0,
				level = 1,
				moduleLevel = 0,
				moduleAssignment = 0,
				using_skin = 0,
				id = slot10,
				star = slot11.unlock_star,
				piece = slot4[slot10] or 0,
				skill = slot12,
				unlocked_astrolabe = {},
				using_astrolabe = {},
				equip = deepClone(slot5),
				clear_mission_list = {},
				unlocked_skin = {},
				weapon_info = {
					exp = 0,
					breakthrough = 0,
					level = 1
				},
				transition = {}
			}
		end

		for slot15, slot16 in ipairs(uv0[slot10].equip) do
			if slot16.equip_id ~= 0 then
				uv1[slot16.equip_id] = slot10
			end
		end
	end

	manager.notify:Invoke(HERO_DATA_INIT)
end

function slot0.ModifyHero(slot0, slot1)
	slot2 = uv0[slot1.id]
	slot2.id = slot1.id
	slot2.exp = slot1.exp
	slot2.level = slot1.level
	slot2.star = slot1.star
	slot2.unlock = slot1.unlock
	slot2.skill = cleanProtoTable(slot1.skill, {
		"skill_id",
		"skill_level"
	})
	slot2.unlocked_astrolabe = cleanProtoTable(slot1.unlocked_astrolabe)
	slot2.using_astrolabe = cleanProtoTable(slot1.using_astrolabe)
	slot2.equip = cleanProtoTable(slot1.equip, {
		"pos",
		"equip_id"
	})
	slot2.clear_mission_list = cleanProtoTable(slot1.clear_mission_list)
	slot2.clear_times = slot1.clear_times or 0
	slot2.using_skin = slot1.using_skin
	slot2.unlocked_skin = cleanProtoTable(slot1.unlocked_skin)
	slot2.break_level = slot1.break_level
	slot2.weapon_info = {
		level = WeaponTools.ExpToLv(slot1.weapon_info.exp),
		exp = slot1.weapon_info.exp,
		breakthrough = slot1.weapon_info.breakthrough
	}
	slot2.transition = slot0:GetTransition(slot1.exclusive_skill_list or {})
	slot2.servant_uid = tonumber(slot1.weapon_info.servant)
	slot2.moduleLevel = slot1.weapon_module_info.weapon_module_level
	slot2.moduleAssignment = slot1.weapon_module_info.weapon_module_assignment

	manager.notify:Invoke(HERO_DATA_MODIFY, slot2.id)
end

function slot0.ModifyHeroPiece(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.id].piece = slot6.num
	end

	manager.notify:Invoke(HERO_DATA_INIT)
end

function slot0.HeroPieceModify(slot0, slot1, slot2)
	slot3 = uv0[slot1]
	slot3.piece = slot3.piece + slot2

	manager.notify:Invoke(HERO_PIECE_MODIFY, slot1)
end

function slot0.AddHeroExpSuccess(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetHeroData(slot1)
	slot4.level = slot2
	slot4.exp = slot3

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.BreakSuccess(slot0, slot1, slot2)
	slot0:GetHeroData(slot1).break_level = slot2

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.UnlockHeroSuccess(slot0, slot1)
	slot0:GetHeroData(slot1).unlock = 1

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
	manager.notify:Invoke(HERO_UNLOCK_SUCCESS, slot1)
end

function slot0.HeroClearTimesModify(slot0, slot1, slot2)
	if slot0:GetHeroData(slot1) == nil then
		return
	end

	slot3.clear_times = (slot3.clear_times or 0) + slot2
end

function slot0.EquipSwap(slot0, slot1, slot2, slot3)
	if slot1 ~= 0 then
		slot5 = uv1[slot1].equip[slot3].equip_id

		if uv0[slot2] and slot4 ~= 0 then
			uv1[slot4].equip[slot3].equip_id = slot5

			if slot5 and slot5 ~= 0 then
				uv0[slot5] = slot4
			end
		else
			uv0[slot5] = nil
		end

		uv1[slot1].equip[slot3].equip_id = slot2

		if slot2 ~= 0 then
			uv0[slot2] = slot1
		end

		manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
	end
end

function slot0.EquipUnloadAll(slot0, slot1)
	for slot6, slot7 in ipairs(uv0[slot1].equip) do
		if slot7.equip_id ~= 0 then
			uv1[slot7.equip_id] = nil
			slot7.equip_id = 0
		end
	end

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.AstrolabeUnlock(slot0, slot1, slot2)
	if not table.keyof(uv0[slot1].unlocked_astrolabe, slot2) then
		table.insert(slot3, slot2)
	end
end

function slot0.AstrolabeEquip(slot0, slot1, slot2)
	if not table.keyof(uv0[slot1].using_astrolabe, slot2) then
		table.insert(slot3, slot2)
	end

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.AstrolabeEquipAll(slot0, slot1, slot2)
	uv0[slot1].using_astrolabe = deepClone(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot2])

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.AstrolabeUnload(slot0, slot1, slot2)
	if table.keyof(uv0[slot1].using_astrolabe, slot2) then
		table.remove(slot3, slot4)
		uv1:AstrolabeUnload(slot1, slot2 + 1)
		manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
	end
end

function slot0.AstrolabeUnloadAll(slot0, slot1)
	uv0[slot1].using_astrolabe = {}

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.WeaponStr(slot0, slot1, slot2, slot3)
	uv0[slot1].weapon_info.level = slot2
	uv0[slot1].weapon_info.exp = slot3

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.WeaponBreak(slot0, slot1, slot2)
	uv0[slot1].weapon_info.breakthrough = slot2

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.ServantReplace(slot0, slot1, slot2)
	uv0[slot1].servant_uid = slot2

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.HeroSkillUpgrade(slot0, slot1, slot2, slot3)
	for slot8, slot9 in ipairs(slot0:GetHeroData(slot1).skill) do
		if slot9.skill_id == slot2 then
			slot9.skill_level = slot9.skill_level + (slot3 or 1)

			break
		end
	end
end

function slot0.HeroStarUp(slot0, slot1)
	slot2 = slot0:GetHeroData(slot1)
	slot3 = HeroStarCfg[slot2.star]
	slot6, slot7 = HeroTools.GetNextStarAndPhase(slot3.star, slot3.phase)
	slot2.star = HeroTools.GetStarCfgId(slot6, slot7)

	manager.notify:Invoke(HERO_DATA_MODIFY, slot1)
end

function slot0.SelectSkin(slot0, slot1, slot2)
	slot0:GetHeroData(slot1).using_skin = slot2
end

function slot0.GetHeroListExcept(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0) do
		if not table.indexof(slot1, slot6) then
			slot2[slot6] = slot7
		end
	end

	return slot2
end

function slot0.GetHeroList(slot0)
	return uv0
end

function slot0.GetHeroData(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetEquipMap(slot0)
	return uv0
end

function slot0.GetHeroOmegaNeedPiece(slot0, slot1)
	slot3 = HeroCfg[slot1]
	slot4 = 0

	if HeroData:GetHeroData(slot1).unlock == 1 then
		for slot12 = table.keyof(HeroStarCfg.all, HeroTools.GetStarCfgId(HeroStarCfg[slot2.star].star, HeroStarCfg[slot2.star].phase)), #HeroStarCfg.all do
			slot4 = slot4 + HeroStarCfg[HeroStarCfg.all[slot12]].star_up
		end

		return math.max(0, slot4 - slot2.piece)
	else
		slot6 = GameSetting.unlock_hero_need.value[slot3.rare]

		for slot10 = 1, #HeroStarCfg.all do
			slot4 = slot4 + HeroStarCfg[HeroStarCfg.all[slot10]].star_up
		end

		return slot6 + slot4
	end
end

function slot0.GetHeroNum(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(uv0) do
		if slot6.unlock == 1 then
			slot1 = slot1 + 1
		end
	end

	return slot1
end

function slot0.GetUnlockHeros(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if slot6.unlock == 1 then
			table.insert(slot1, slot6.id)
		end
	end

	return slot1
end

function slot0.InitFavorite(slot0, slot1)
	uv0 = slot1 or {}
end

function slot0.IsFavorite(slot0, slot1)
	return table.indexof(uv0, slot1)
end

function slot0.SetFavoriteHeroOn(slot0, slot1)
	if not table.indexof(uv0, slot1) then
		table.insert(uv0, slot1)
	end
end

function slot0.SetFavoriteHeroOff(slot0, slot1)
	if table.indexof(uv0, slot1) then
		table.remove(uv0, slot2)
	end
end

function slot0.SaveSortValue(slot0, slot1, slot2, slot3, slot4, slot5)
	uv0 = slot1 == nil and true or slot1
	uv1 = slot2 or 0
	uv2 = slot3 or {}
	uv3 = slot4 or {}
	uv4 = slot5 or {}
end

function slot0.SaveSortType(slot0, slot1)
	uv0 = slot1 or 0
end

function slot0.GetSortValue(slot0)
	return uv0, uv1, uv2, uv3, uv4
end

function slot0.ResetSortValue(slot0)
	uv0 = true
	uv1 = 0
	uv2 = {}
	uv3 = {}
	uv4 = {}
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

function slot0.ImproveTransitionGiftPt(slot0, slot1)
	if slot0:GetHeroTransitionSkillBySlotID(slot1.hero_id, slot1.slot_id) then
		slot2.talent_points = slot2.talent_points + slot1.lv_up_num
	else
		table.insert(uv0[slot1.hero_id].transition, {
			slot_id = slot1.slot_id,
			skill_list = {},
			talent_points = slot1.lv_up_num
		})
	end
end

function slot0.ModifyTransitionSkill(slot0, slot1)
	if slot0:GetHeroTransitionSkillBySlotID(slot1.hero_id, slot1.slot_id) then
		slot2.skill_list = cleanProtoTable(slot1.skill_list)

		manager.notify:Invoke(HERO_TRANSITION_CHANGE, {
			heroId = slot1.hero_id
		})
	end
end

function slot0.GetHeroTransitionSkillBySlotID(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(uv0[slot1].transition) do
		if slot8.slot_id == slot2 then
			return slot8
		end
	end

	return false
end

function slot0.GetCurModuleLevel(slot0, slot1)
	return uv0[slot1] and uv0[slot1].moduleLevel or 0
end

function slot0.GetModuleMaxLevel(slot0, slot1)
	return #WeaponModuleCfg[slot1].cost
end

function slot0.ModuleLevelUp(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].moduleLevel = uv0[slot1].moduleLevel + 1
	end
end

function slot0.GetModuleAssignmentIsFinish(slot0, slot1)
	if uv0[slot1] then
		if uv0[slot1].moduleAssignment > 0 then
			return true
		else
			return false
		end
	end

	return false
end

function slot0.GetModulePowersByHeroID(slot0, slot1)
	slot2 = {}
	slot3 = slot0:GetCurModuleLevel(slot1)

	if WeaponModuleCfg[slot1] then
		for slot8 = 1, slot3 do
			for slot13, slot14 in pairs(slot4.skill[slot8]) do
				table.insert(slot2, slot14)
			end
		end
	end

	return slot2
end

function slot0.GetAllModulePowersByHeroID(slot0, slot1)
	slot2 = {}
	slot3 = slot0:GetModuleMaxLevel(slot1)

	if WeaponModuleCfg[slot1] then
		for slot8 = 1, slot3 do
			for slot13, slot14 in pairs(slot4.skill[slot8]) do
				table.insert(slot2, slot14)
			end
		end
	end

	return slot2
end

function slot0.GetCurModuleEffectListByType(slot0, slot1, slot2)
	slot4 = {}

	for slot8, slot9 in pairs(slot0:GetModulePowersByHeroID(slot1)) do
		if WeaponModuleEffectCfg[slot9].type == slot2 then
			table.insert(slot4, slot9)
		end
	end

	if slot4[1] then
		return slot4
	else
		return nil
	end
end

function slot0.GetLockModuleEffectListByType(slot0, slot1, slot2)
	slot4 = {}

	for slot8, slot9 in pairs(WeaponModuleCfg[slot1].skill[1]) do
		if WeaponModuleEffectCfg[slot9].type == slot2 then
			table.insert(slot4, slot9)
		end
	end

	if slot4[1] then
		return slot4
	else
		return nil
	end
end

function slot0.GetModulePowersByHeroIDAndLevel(slot0, slot1, slot2)
	slot3 = {}

	if WeaponModuleCfg[slot1] then
		for slot8 = 1, slot2 do
			for slot13, slot14 in pairs(slot4.skill[slot8]) do
				table.insert(slot3, slot14)
			end
		end
	end

	return slot3
end

return slot0
