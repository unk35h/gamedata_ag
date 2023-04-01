slot1 = import("bit")

return {
	GetAllSuits = function ()
		slot0 = {}

		for slot4, slot5 in pairs(EquipSuitCfg.get_id_list_by_suit) do
			table.insert(slot0, slot4)
		end

		return slot0
	end,
	GetEquipNum = function ()
		slot0 = 0

		for slot5, slot6 in pairs(EquipData:GetEquipList()) do
			slot0 = slot0 + 1
		end

		return slot0
	end,
	GetEquipListByPrefabId = function (slot0)
		slot1 = {}

		for slot6, slot7 in pairs(EquipData:GetEquipList()) do
			if slot7.prefab_id == slot0 then
				table.insert(slot1, slot7)
			end
		end

		return slot1
	end,
	GetEquipListByEquipid = function (slot0)
		slot1 = {}

		for slot6, slot7 in pairs(EquipData:GetEquipList()) do
			if EquipCfg[slot7.prefab_id].pos == EquipCfg[slot0].pos and slot9.suit == slot8.suit and slot9.starlevel == slot8.starlevel then
				table.insert(slot1, slot7)
			end
		end

		return slot1
	end,
	GetHaveSuitList = function (slot0)
		slot2 = {}
		slot3 = HideInfoData:GetEquipSuitHideList()

		for slot7, slot8 in pairs(EquipData:GetEquipList()) do
			if not slot3[EquipCfg[slot8.prefab_id].suit] then
				slot2[slot9.suit] = true
			end
		end

		slot4 = {}

		for slot8, slot9 in pairs(slot2) do
			table.insert(slot4, tonumber(slot8))
		end

		if slot0 then
			for slot8, slot9 in ipairs(EquipSuitCfg.all) do
				if not slot2[slot9] and not slot3[slot9] then
					table.insert(slot4, slot9)
				end
			end
		end

		return slot4, slot2
	end,
	GetIsHaveExEquip = function ()
		for slot4, slot5 in pairs(EquipData:GetEquipList()) do
			if EquipConst.EX_EQUIP_SUIT_ID <= EquipCfg[slot5.prefab_id].suit then
				return true
			end
		end

		return false
	end,
	IsHaveEquip = function (slot0)
		slot1 = EquipData:GetEquipList()
		slot2 = {}
		slot3 = {}

		for slot7, slot8 in ipairs(slot0) do
			slot3[slot8] = false
		end

		for slot7, slot8 in pairs(slot1) do
			if table.indexof(slot0, slot8.prefab_id) then
				slot3[slot8.prefab_id] = true
			end
		end

		return slot3
	end,
	GetFreeEquipByEquipId = function (slot0, slot1)
		slot2 = HeroTools.GetEquipMap(HeroData:GetHeroList())
		slot3 = {}
		slot4 = {}
		slot5 = false
		slot6 = false
		slot9 = EquipData
		slot11 = slot9

		for slot10, slot11 in pairs(slot9.GetEquipList(slot11)) do
			slot12 = slot11.prefab_id
			slot13 = slot11.equip_id
			slot14 = false
			slot15 = nil

			for slot19, slot20 in ipairs(slot0) do
				if EquipTools.IsSameEquip(slot20, slot12) then
					slot14 = true
					slot15 = slot20

					break
				end
			end

			if slot14 then
				if not slot4[slot15] then
					slot4[slot15] = {}
				end

				table.insert(slot4[slot15], slot11)

				slot6 = true

				if slot2[slot13] == nil or slot2[slot13] == slot1 then
					if not slot3[slot15] then
						slot3[slot15] = {}
					end

					table.insert(slot3[slot15], slot11)

					slot5 = true
				end
			end
		end

		return slot3, slot4, slot5, slot6, slot2
	end,
	IsSameEquip = function (slot0, slot1)
		if EquipCfg[slot0].pos == EquipCfg[slot1].pos and slot2.starlevel == slot3.starlevel and slot2.suit == slot3.suit then
			return true
		end

		return false
	end,
	GetHaveSkillList = function (slot0)
		slot2 = {}

		for slot6, slot7 in pairs(EquipData:GetEquipList()) do
			for slot12, slot13 in ipairs(EquipCfg[slot7.prefab_id].effect) do
				if slot13[1] then
					slot2[slot13[1]] = true
				end
			end

			for slot12, slot13 in pairs(slot7.enchant) do
				for slot17, slot18 in ipairs(slot13) do
					if slot18 and slot18.id then
						slot2[slot18.id] = true
					end
				end
			end
		end

		slot3 = {}

		for slot7, slot8 in pairs(slot2) do
			table.insert(slot3, tonumber(slot7))
		end

		if slot0 then
			slot7 = EquipConst.EQUIP_ATTRIBUTE_TYPE.ENCHANT

			for slot7, slot8 in ipairs(EquipSkillCfg.get_id_list_by_skill_type[slot7]) do
				if not slot2[slot8] then
					table.insert(slot3, slot8)
				end
			end
		end

		return slot3
	end,
	GetHeroEquipSuitPos = function (slot0, slot1, slot2)
		slot3 = {}
		slot4 = 0

		if slot0 and slot0 ~= 0 then
			slot6 = EquipData:GetEquipList()

			for slot10, slot11 in pairs(HeroData:GetHeroList()[slot0].equip) do
				if slot11.equip_id and slot12 ~= 0 and EquipCfg[slot6[slot12].prefab_id].suit == slot1 then
					slot3[slot14.pos] = true
					slot4 = slot4 + 1
				end
			end
		elseif slot2 then
			slot3[slot2] = true
			slot4 = slot4 + 1
		end

		return slot3, slot4
	end,
	GetEquipedHeroId = function (slot0)
		for slot5, slot6 in pairs(HeroData:GetHeroList()) do
			for slot10, slot11 in pairs(slot6.equip) do
				if slot11.equip_id == slot0 then
					return slot5
				end
			end
		end

		return 0
	end,
	CountActiveSuit = function (slot0, slot1)
		slot2 = EquipData:GetEquipList()
		slot3 = slot1 and slot1.isPolyhedron
		slot4 = {}

		for slot8, slot9 in pairs(slot0) do
			if slot9.equip_id ~= 0 then
				slot10 = nil

				if slot4[EquipCfg[(not slot3 or slot9.prefab_id) and slot2[slot9.equip_id].prefab_id].suit] then
					slot4[slot11.suit].num = slot4[slot11.suit].num + 1
					slot4[slot11.suit].pos[slot9.pos] = true
				else
					slot4[slot11.suit] = {
						num = 1,
						id = slot11.suit,
						pos = {
							[slot9.pos] = true
						}
					}
				end
			end
		end

		slot5 = {}

		for slot9, slot10 in pairs(slot4) do
			table.insert(slot5, slot10)
		end

		return slot5
	end,
	GetSuitNeedNum = function (slot0, slot1)
		if EquipSuitCfg[slot0].need < 3 or not slot1 then
			return slot2.need
		else
			return slot2.need - 1
		end
	end,
	CountHeroTotalSkill = function (slot0, slot1)
		slot2 = {}

		for slot6, slot7 in pairs(slot0) do
			if slot7.equip_id and slot7.equip_id ~= 0 then
				slot9 = uv0.CountEquipLevel(slot7)

				for slot13 = 1, #EquipCfg[slot7.prefab_id].effect do
					if slot8.effect[slot13] and slot8.effect_unlock_level[slot13] <= slot9 then
						slot2[slot15] = (slot2[slot14[1]] or 0) + slot14[2]
					end
				end

				for slot13, slot14 in pairs(slot7.enchant) do
					for slot18, slot19 in ipairs(slot14) do
						if slot19 and slot19.id then
							slot2[slot20] = (slot2[slot19.id] or 0) + slot19.num
						end
					end
				end
			end
		end

		slot3 = HeroTools.GetHeroEquipSkillAddLevel(slot1)

		for slot7, slot8 in pairs(slot2) do
			slot2[slot7] = slot8 + slot3
		end

		for slot7, slot8 in pairs(slot2) do
			if EquipSkillCfg[slot7].lvmax < slot8 then
				slot2[slot7] = slot9.lvmax
			end
		end

		if slot3 > 0 then
			return slot2, true
		else
			return slot2, false
		end
	end,
	CountEquipAttribute = function (slot0, slot1, slot2)
		slot3 = {}
		slot4 = EquipCfg[slot0.prefab_id]
		slot5 = uv0.CountEquipLevel(slot0)
		slot6 = slot0.now_break_level + 1
		slot7 = false
		slot8 = false

		if slot2 and slot0.race ~= 0 then
			if slot0.race == HeroCfg[slot2].race then
				slot7 = true
			end

			if slot0.race == slot2 then
				slot8 = true
			end
		end

		for slot13, slot14 in pairs(slot4.fixed_attributes[slot6]) do
			slot3[slot14[1]] = slot14[2] + slot14[3] * (slot5 - 1)

			if slot7 then
				slot3[slot15] = slot3[slot15] * 1.2
			end

			if slot8 then
				slot3[slot15] = slot3[slot15] * GameSetting.equip_hero_strengthen_num.value[1]
			end
		end

		if slot1 then
			for slot13 = 1, #slot4.effect do
				if slot4.effect[slot13] and slot4.effect_unlock_level[slot13] <= slot5 then
					slot15 = EquipSkillCfg[slot14[1]]
					slot3[slot17] = (slot3[slot15.attribute] or 0) + slot15.upgrade * slot14[2]
				end
			end

			if slot0.enchant then
				for slot13, slot14 in pairs(slot0.enchant) do
					for slot18, slot19 in ipairs(slot14) do
						if slot19 and slot19.id then
							slot20 = EquipSkillCfg[slot19.id]
							slot3[slot22] = (slot3[slot20.attribute] or 0) + slot20.upgrade * slot19.num
						end
					end
				end
			end
		end

		return slot3
	end,
	CountEquipMaxLv = function (slot0)
		return EquipCfg[slot0.prefab_id].max_level[slot0.now_break_level + 1]
	end,
	CountEquipLevel = function (slot0)
		slot1 = slot0.exp or 0
		slot4 = "exp" .. EquipCfg[slot0.prefab_id].starlevel

		for slot8 = 1, uv0.CountEquipMaxLv(slot0) - 1 do
			if slot1 < EquipExpCfg[slot8][slot4] then
				return slot8
			end

			slot1 = slot1 - slot9
		end

		return slot2
	end,
	CountSingleEquipAttribute = function (slot0, slot1)
		slot3 = uv0.CountEquipLevel(slot0)

		for slot9, slot10 in ipairs(EquipCfg[slot0.prefab_id].fixed_attributes[slot0.now_break_level + 1]) do
			if slot10[1] == slot1 then
				return slot10[2] + slot10[3] * (slot3 - 1)
			end
		end

		return 0
	end,
	GetConstructVirtualEquips = function (slot0)
		slot1 = {}

		for slot6, slot7 in ipairs(HeroStandardSystemCfg[slot0].equip_list) do
			slot8 = EquipCfg[slot7]
			slot9 = EquipStruct.New(0, slot7)
			slot9.equip_id = 1
			slot9.prefab_id = slot7
			slot9.exp = EquipExpCfg[slot2.equip_lv]["exp_sum_" .. slot8.starlevel]
			slot9.race = slot8.race
			slot9.now_break_level = slot2.break_lv - 1
			slot9.enchant = {}
			slot10 = ipairs
			slot12 = slot2.equip_pool_list[slot6] or {}

			for slot13, slot14 in slot10(slot12) do
				for slot18, slot19 in ipairs(EquipSkillPoolCfg[slot14].skill_id) do
					table.insert(slot9.enchant, {
						{
							id = slot19[1],
							num = slot19[2]
						}
					})
				end
			end

			table.insert(slot1, slot9)
		end

		return slot1
	end,
	CalHeroVirtualEquipAttribute = function (slot0, slot1, slot2)
		slot3 = {
			0,
			0,
			0,
			0
		}

		for slot7, slot8 in pairs(slot0) do
			slot13 = slot8

			for slot12, slot13 in pairs(uv0.CountEquipAttribute(slot13, false, slot1.id)) do
				if slot3[slot12] == nil then
					slot3[slot12] = 0
				end

				slot3[slot12] = slot3[slot12] + slot13
			end
		end

		if not slot2 then
			for slot8, slot9 in pairs(uv0.CountHeroTotalSkill(slot0, slot1)) do
				slot10 = EquipSkillCfg[slot8]
				slot3[slot12] = (slot3[slot10.attribute] or 0) + slot10.upgrade * slot9
			end
		end

		return slot3
	end,
	CalHeroEquipAttribute = function (slot0, slot1)
		slot2 = {
			0,
			0,
			0,
			0,
			0
		}
		slot3 = EquipData:GetEquipList()

		for slot7, slot8 in ipairs(slot0) do
			if slot3[slot8.equip_id] then
				slot14 = slot9

				for slot13, slot14 in pairs(uv0.CountEquipAttribute(slot14, false, slot1)) do
					if slot2[slot13] == nil then
						slot2[slot13] = 0
					end

					slot2[slot13] = slot2[slot13] + slot14
				end
			end
		end

		return slot2
	end,
	GetHeroEquipS = function (slot0)
		slot2 = {}

		for slot6, slot7 in pairs(HeroData:GetHeroList()[slot0].equip) do
			slot2[slot7.pos] = EquipData:GetEquipList()[slot7.equip_id]
		end

		return slot2
	end,
	GetEffectS = function (slot0, slot1)
		slot2 = {}
		slot3 = false

		if slot1 then
			slot3 = HeroTools.GetIsSuitNumCut(slot1)
		end

		slot4 = {}

		for slot8, slot9 in pairs(slot0) do
			if slot4[EquipCfg[slot9.prefab_id].suit] == nil then
				slot4[slot11] = 0
			end

			slot4[slot11] = slot4[slot11] + 1
		end

		for slot8, slot9 in pairs(slot4) do
			for slot14, slot15 in ipairs(EquipSuitCfg.get_id_list_by_suit[slot8]) do
				slot16 = EquipSuitCfg[slot15]

				if uv0.GetSuitNeedNum(slot15, slot3) <= slot9 and slot16.suit_effect then
					for slot21, slot22 in pairs(slot16.suit_effect) do
						slot2[slot22] = true
					end
				end
			end
		end

		return slot2
	end,
	GetDecomposeRewardItem = function (slot0)
		slot1 = {}
		slot2 = {}

		for slot6, slot7 in pairs(slot0) do
			slot9 = (slot7.equip_info.exp * 0.8 or 0) + uv0.CountBreakExp(slot7) + GameSetting.base_exp_equip_star.value[EquipCfg[slot7.id].starlevel]
			slot10 = GameSetting.equip_exp_props_id_list.value

			for slot15 = 1, #{
				slot10[3],
				slot10[2],
				slot10[1]
			} do
				if ItemCfg[slot11[slot15]].param[1] <= slot9 then
					slot18 = math.floor(slot9 / slot17)
					slot1[slot16] = (slot1[slot16] or 0) + slot18
					slot9 = slot9 - slot17 * slot18
				end
			end

			for slot17, slot18 in pairs(EquipData:GetEquipData(slot6):GetBreakCostReturn()) do
				slot19 = slot18[1] or 0
				slot1[slot19] = (slot1[slot19] or 0) + (slot18[2] or 0)
			end
		end

		for slot6, slot7 in pairs(slot1) do
			if slot7 > 0 then
				table.insert(slot2, {
					id = slot6,
					number = slot7
				})
			end
		end

		return slot2
	end,
	CountNeedExp = function (slot0, slot1, slot2)
		slot3 = 0
		slot5 = "exp" .. EquipCfg[slot0.prefab_id].starlevel

		for slot9 = 1, slot1 - 1 do
			slot3 = slot3 + EquipExpCfg[slot9][slot5]
		end

		return slot3
	end,
	GetLockedEquipS = function ()
		slot0 = {}

		for slot5, slot6 in pairs(EquipData:GetEquipList()) do
			if slot6.is_lock and slot6.is_lock == 1 then
				table.insert(slot0, slot6.equip_id)
			end
		end

		return slot0
	end,
	GetHeroUsedEquipS = function ()
		slot0 = {}

		for slot5, slot6 in pairs(HeroData:GetHeroList()) do
			if slot6.equip then
				for slot10, slot11 in pairs(slot6.equip) do
					if slot11.equip_id ~= 0 then
						table.insert(slot0, slot11.equip_id)
					end
				end
			end
		end

		return slot0
	end,
	GetSuitEquipNum = function (slot0, slot1, slot2)
		slot4 = 0

		for slot8, slot9 in pairs(EquipData:GetEquipList()) do
			if slot0 == 0 then
				if (not slot1 or not table.keyof(slot1, slot9.equip_id)) and (not slot2 or EquipCfg[slot9.prefab_id].pos == slot2 or slot2 == 0) then
					slot4 = slot4 + 1
				end
			elseif EquipCfg[slot9.prefab_id].suit == slot0 and (not slot1 or not table.keyof(slot1, slot9.equip_id)) and (not slot2 or EquipCfg[slot9.prefab_id].pos == slot2 or slot2 == 0) then
				slot4 = slot4 + 1
			end
		end

		return slot4
	end,
	GetEquipSkillNum = function (slot0, slot1, slot2)
		slot4 = 0

		for slot8, slot9 in pairs(EquipData:GetEquipList()) do
			slot11 = false

			for slot15, slot16 in ipairs(EquipCfg[slot9.prefab_id].effect) do
				if slot16 and slot16[1] and slot16[1] == slot0 then
					slot11 = true

					break
				end
			end

			if not slot11 then
				for slot15, slot16 in pairs(slot9.enchant) do
					for slot20, slot21 in ipairs(slot16) do
						if slot21 and slot21.id and slot21.id == slot0 then
							slot11 = true

							break
						end
					end
				end
			end

			if (slot0 == 0 or slot11) and (not slot1 or not table.keyof(slot1, v.equip_id)) and (not slot2 or slot10.pos == slot2 or slot2 == 0) then
				slot4 = slot4 + 1
			end
		end

		return slot4
	end,
	GetEquipInfoById = function (slot0)
		return EquipData:GetEquipList()[slot0]
	end,
	CountAddExp = function (slot0, slot1)
		slot2 = 0

		for slot6, slot7 in pairs(slot0) do
			slot2 = slot2 + ItemCfg[slot6].param[1] * slot7
		end

		for slot6, slot7 in pairs(slot1) do
			slot2 = slot2 + (slot7.equip_info.exp * 0.8 or 0) + uv0.CountBreakExp(slot7) + GameSetting.base_exp_equip_star.value[EquipCfg[slot7.id].starlevel]
		end

		return slot2
	end,
	CountBreakExp = function (slot0)
		return 0
	end,
	QuickSelectList = function (slot0, slot1)
		slot2 = MaterialData:GetMaterialList()
		slot3 = EquipData:GetEquipList()
		slot4 = {}
		slot8 = ItemConst.ITEM_TYPE.MATERIAL

		for slot8, slot9 in ipairs(ItemCfg.get_id_list_by_type[slot8]) do
			slot11 = ItemCfg[slot9]

			if slot2[slot9] and slot11.sub_type == MaterialConst.MATERIAL_TYPE.EQUIP_LEVEL_UP and slot10.num > 0 then
				table.insert(slot4, {
					id = slot9,
					add = slot11.param[1],
					num = slot2[slot9].num
				})
			end
		end

		slot6 = {}
		slot7 = {}
		slot8 = slot0 - 0
		slot9 = #slot4

		while slot8 > 0 and slot9 > 0 do
			if slot4[slot9].add < slot8 then
				slot5 = slot5 + math.min(math.floor(slot8 / slot4[slot9].add), slot4[slot9].num) * slot4[slot9].add
				slot6[slot4[slot9].id] = (slot6[slot4[slot9].id] or 0) + slot10
				slot4[slot9].num = slot4[slot9].num - slot10

				if slot4[slot9].num == 0 then
					slot9 = slot9 - 1
				end
			elseif uv0.CountRestAddExp(slot4, slot9 - 1) < slot8 then
				slot6[slot4[slot9].id] = (slot6[slot4[slot9].id] or 0) + 1
				slot4[slot9].num = slot4[slot9].num - 1
				slot8 = slot0 - (slot5 + 1 * slot4[slot9].add)

				break
			else
				slot9 = slot9 - 1
			end

			slot8 = slot0 - slot5
		end

		if slot8 > 0 then
			slot11 = HeroTools.GetEquipMap(HeroData:GetHeroList())
			slot12 = ProposalData:GetEquipMap()

			for slot17 = 1, #EquipData:GetEquipListComplex(ItemConst.SORT_TYPE.UP, EquipConst.EQUIP_SORT.RARE) do
				slot19 = slot3[slot10[slot17]]

				if slot0 - slot5 <= 0 then
					break
				end

				slot20 = EquipCfg[slot19.prefab_id]

				if slot11[slot10[slot17]] == nil and slot19.exp == 0 and slot19.now_break_level == 0 and slot19.star < 5 and not slot19.is_lock and not slot12[slot19.equip_id] and not table.indexof(slot1, slot19.equip_id) then
					slot7[slot10[slot17]] = {
						isEquiped = false,
						number = 1,
						type = ItemConst.ITEM_TYPE.EQUIP,
						id = slot19.prefab_id,
						equip_id = slot19.equip_id,
						equip_info = slot19,
						equip_star = getItemStar(slot19.prefab_id),
						equip_lv = uv0.CountEquipLevel(slot19)
					}
					slot5 = slot5 + GameSetting.base_exp_equip_star.value[slot19.star]
				end
			end
		end

		return slot6, slot7
	end,
	CountRestAddExp = function (slot0, slot1)
		slot2 = 0

		for slot6 = slot1, 1, -1 do
			slot2 = slot2 + slot0[slot6].add * slot0[slot6].num
		end

		return slot2
	end,
	QuickMaterialList = function (slot0, slot1)
		slot2 = {}
		slot3 = {}
		slot4 = 0

		for slot8, slot9 in ipairs(slot1) do
			if slot0 - slot4 > 0 then
				slot11 = ItemCfg[slot9.id].param[1]
				slot12 = math.min(math.ceil(slot10 / slot11), slot9.num)
				slot2[slot9.id] = slot12
				slot3[slot8] = slot12
				slot4 = slot4 + slot12 * slot11
			else
				slot3[slot8] = 0
			end
		end

		return slot2, slot3
	end,
	QuickEquipList = function (slot0, slot1, slot2)
		slot3 = {}
		slot4 = 0

		for slot8, slot9 in ipairs(slot1) do
			slot11 = uv0.GetEquipInfoById(slot9)
			slot12 = EquipCfg[equip.prefab_id].starlevel

			if slot0 - slot4 > 0 and slot12 <= slot2 then
				slot3[slot9] = slot11
				slot4 = slot4 + slot11.exp + GameSetting.base_exp_equip_star.value[slot12]
			end
		end

		return slot3
	end,
	GetEquipSuitEffect = function (slot0)
		slot1 = {}
		slot1 = deepClone(EquipSuitCfg.get_id_list_by_suit[EquipCfg[slot0.prefab_id].suit])

		table.sort(slot1, function (slot0, slot1)
			return EquipSuitCfg[slot0].need < EquipSuitCfg[slot1].need
		end)

		return slot1
	end,
	CountSuitEffect = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			slot1[slot7] = 1 + (slot1[EquipCfg[slot6.prefab_id].suit] or 0)
		end

		slot2 = {}

		for slot6, slot7 in pairs(slot1) do
			for slot12, slot13 in ipairs(EquipSuitCfg.get_id_list_by_suit[slot6]) do
				if EquipSuitCfg[slot13].need <= slot7 then
					table.insert(slot2, slot13)
				end
			end
		end

		return slot2
	end,
	Filt = function (slot0, slot1)
		for slot6, slot7 in pairs(deepClone(slot0)) do
			if not slot1[EquipCfg[slot7.prefab_id].pos] then
				slot2[slot6] = nil
			end
		end

		return slot2
	end,
	MutiFilt = function (slot0, slot1)
		for slot6, slot7 in pairs(deepClone(slot0)) do
			for slot11, slot12 in pairs(slot1) do
				if not slot12[EquipCfg[slot7.prefab_id][slot11]] then
					slot2[slot6] = nil
				end
			end
		end

		return slot2
	end,
	FiltByPos = function (slot0, slot1)
		for slot6, slot7 in pairs(deepClone(slot0)) do
			if not slot1[EquipCfg[slot7.prefab_id].pos] then
				slot2[slot6] = nil
			end
		end

		return slot2
	end,
	FiltBySuit = function (slot0, slot1)
		for slot6, slot7 in pairs(deepClone(slot0)) do
			if not slot1[EquipCfg[slot7.prefab_id].suit] then
				slot2[slot6] = nil
			end
		end

		return slot2
	end,
	EquipSort = function (slot0, slot1, slot2)
		slot3 = {}

		for slot7, slot8 in pairs(slot0) do
			table.insert(slot3, slot8)
		end

		slot5 = slot1 or 0

		function slot6(slot0, slot1)
			if uv0 == ItemConst.SORT_TYPE.DOWN then
				return slot1 < slot0
			else
				return slot0 < slot1
			end
		end

		if (slot2 or 0) == EquipConst.EQUIP_SORT.LEVEL then
			table.sort(slot3, function (slot0, slot1)
				if slot0.GetLevel(slot0) ~= slot1.GetLevel(slot1) then
					return uv0(slot0.GetLevel(slot0), slot1.GetLevel(slot1))
				elseif slot0.now_break_level ~= slot1.now_break_level then
					return uv0(slot0.now_break_level, slot1.now_break_level)
				elseif slot0.star ~= slot1.star then
					return uv0(slot0.star, slot1.star)
				elseif slot0.GetSuit(slot0) ~= slot1.GetSuit(slot1) then
					return slot0:GetSuit() < slot1:GetSuit()
				elseif slot0.prefab_id and slot1.prefab_id and slot0.prefab_id ~= slot1.prefab_id then
					return slot0.prefab_id < slot1.prefab_id
				elseif slot0.equip_id ~= slot1.equip_id then
					return uv0(slot0.equip_id, slot1.equip_id)
				end

				return false
			end)
		elseif slot4 == EquipConst.EQUIP_SORT.RARE then
			table.sort(slot3, function (slot0, slot1)
				if slot0.star ~= slot1.star then
					return uv0(slot0.star, slot1.star)
				elseif slot0.GetLevel(slot0) ~= slot1.GetLevel(slot1) then
					return uv0(slot0.GetLevel(slot0), slot1.GetLevel(slot1))
				elseif slot0.now_break_level ~= slot1.now_break_level then
					return uv0(slot0.now_break_level, slot1.now_break_level)
				elseif slot0.GetSuit(slot0) ~= slot1.GetSuit(slot1) then
					return slot0:GetSuit() < slot1:GetSuit()
				elseif slot0.prefab_id and slot1.prefab_id and slot0.prefab_id ~= slot1.prefab_id then
					return slot0.prefab_id < slot1.prefab_id
				elseif slot0.equip_id ~= slot1.equip_id then
					return uv0(slot0.equip_id, slot1.equip_id)
				end

				return false
			end)
		else
			table.sort(slot3, function (slot0, slot1)
				if slot0.equip_id ~= slot1.equip_id then
					return uv0(slot0.equip_id, slot1.equip_id)
				end

				return false
			end)
			print("EquipSort Fucntion cant find current sort Type")
		end

		return slot3
	end,
	GetEffectDesc = function (slot0)
		if not EquipEffectCfg[slot0] then
			print("装备效果 id" .. slot0 .. "没有配置")
		end

		if slot1.desc and slot1.desc ~= "" then
			return GetCfgDescription(slot1.desc[1], 1)
		end

		return ""
	end,
	GetEffectDescOld = function (slot0)
		if slot0 == nil then
			return ""
		end

		slot1 = EquipEffectCfg[slot0]
		slot2 = slot1.desc
		slot3 = {}
		slot7 = "@{.-}"

		for slot7 in string.gmatch(slot1.desc, slot7) do
			slot10 = string.split(string.sub(slot7, 3, -2), "_")
			slot3[#slot3 + 1] = 0 + tonumber(EquipEffectCfg[tonumber(slot10[1])].param[tonumber(slot10[2])])
		end

		for slot7 = 1, #slot3 do
			slot2 = string.gsub(slot2, "@{.-}", slot3[slot7], 1)
		end

		return slot2
	end,
	GetSkillDesc = function (slot0, slot1, slot2)
		slot3 = EquipSkillCfg[slot0]
		slot4 = HeroCfg[slot2]
		slot5 = ""
		slot6 = GameSetting.exclusive_skill_cd_type.value
		slot7 = GameSetting.exclusive_skill_level_up_type.value
		slot8 = GameSetting.exclusive_skill_damage_type.value

		if not false then
			for slot13, slot14 in ipairs(slot6) do
				if slot0 == slot14[1] then
					slot9 = slot14[2]
				end
			end
		end

		if not slot9 then
			for slot13, slot14 in ipairs(slot7) do
				if slot0 == slot14[1] then
					slot9 = slot14[2]
				end
			end
		end

		if not slot9 then
			for slot13, slot14 in ipairs(slot8) do
				if slot0 == slot14[1] then
					slot9 = slot14[2]
				end
			end
		end

		if slot9 then
			slot5 = HeroSkillCfg[slot4.skills[slot9]].name
		end

		slot10 = ""

		return string.format(slot3.desc, (slot1 ~= 0 or EquipTools.Calculate(slot3.upgrade / slot3.percent * 1, slot0)) and (slot1 < slot3.lvmax and EquipTools.Calculate(slot3.upgrade / slot3.percent * slot1, slot0) .. string.format(GetTips("EQUIP_HERO_SKILL_NEXT_LEVEL"), EquipTools.Calculate(slot3.upgrade / slot3.percent * (slot1 + 1), slot0)) or EquipTools.Calculate(slot3.upgrade / slot3.percent * slot1, slot0)))
	end,
	GetSkillDescWithoutNext = function (slot0, slot1, slot2)
		slot3 = EquipSkillCfg[slot0]
		slot4 = HeroCfg[slot2]
		slot5 = ""
		slot6 = GameSetting.exclusive_skill_cd_type.value
		slot7 = GameSetting.exclusive_skill_level_up_type.value
		slot8 = GameSetting.exclusive_skill_damage_type.value

		if not false then
			for slot13, slot14 in ipairs(slot6) do
				if slot0 == slot14[1] then
					slot9 = slot14[2]
				end
			end
		end

		if not slot9 then
			for slot13, slot14 in ipairs(slot7) do
				if slot0 == slot14[1] then
					slot9 = slot14[2]
				end
			end
		end

		if not slot9 then
			for slot13, slot14 in ipairs(slot8) do
				if slot0 == slot14[1] then
					slot9 = slot14[2]
				end
			end
		end

		if slot9 then
			slot5 = HeroSkillCfg[slot4.skills[slot9]].name
		end

		slot10 = ""

		return string.format(slot3.desc, (slot1 ~= 0 or EquipTools.Calculate(slot3.upgrade / slot3.percent * 1, slot0)) and EquipTools.Calculate(slot3.upgrade / slot3.percent * slot1, slot0))
	end,
	Calculate = function (slot0, slot1)
		if table.indexof(GameDisplayCfg.equip_hero_skill_int.value, slot1) then
			return slot0
		else
			return string.format("%.1f%%", slot0)
		end
	end,
	GetIsHide = function (slot0)
		hideList = HideInfoData:GetEquipSuitHideList()

		return hideList[EquipCfg[slot0].suit] or false
	end,
	GetSuitTotalNum = function ()
		slot0 = HideInfoData:GetEquipSuitHideList()
		slot1 = 0

		for slot5, slot6 in ipairs(EquipSuitCfg.all) do
			if not slot0[slot6] then
				slot1 = slot1 + 1
			end
		end

		return slot1
	end
}
