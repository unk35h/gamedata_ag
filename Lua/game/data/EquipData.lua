EquipStruct = class("EquipStruct")

function EquipStruct.Ctor(slot0, slot1, slot2)
	slot0.equip_id = slot1
	slot0.prefab_id = slot2
	slot0.exp = 0
	slot0.is_lock = false
	slot0.now_break_level = 0
	slot0.enchant = {}
	slot0.enchant_preview = {}
	slot0.race = 0
	slot0.race_preview = 0
	slot0.equipConfig = EquipCfg[slot0.prefab_id]
	slot0.star = slot0.equipConfig and slot0.equipConfig.starlevel or 0
end

function EquipStruct.ParseServerData(slot0, slot1)
	slot0.equip_id = slot1.equip_id
	slot0.prefab_id = slot1.prefab_id
	slot0.exp = slot1.exp
	slot0.is_lock = slot1.is_lock
	slot0.now_break_level = slot1.now_break_level
	slot0.enchant = {}
	slot0.enchant_preview = {}

	for slot5, slot6 in ipairs(slot1.enchant_slot_list) do
		slot7 = slot6.id
		slot8 = {}

		for slot12, slot13 in ipairs(slot6.effect_list) do
			table.insert(slot8, {
				id = slot13.id,
				num = slot13.level
			})
		end

		slot9 = {}

		for slot13, slot14 in ipairs(slot6.preview_list) do
			slot15 = {}

			for slot19, slot20 in ipairs(slot14.effect_list) do
				table.insert(slot15, {
					id = slot20.id,
					num = slot20.level
				})
			end

			table.insert(slot9, slot15)
		end

		slot0.enchant[slot7] = slot8
		slot0.enchant_preview[slot7] = slot9
	end

	slot0.race = slot1.race
	slot0.race_preview = slot1.race_preview
	slot0.equipConfig = EquipCfg[slot0.prefab_id]
	slot0.star = slot0.equipConfig and slot0.equipConfig.starlevel or 0
end

function EquipStruct.GetBreakCostReturn(slot0)
	slot3 = {}

	if (GameSetting.equip_break_cost_return and GameSetting.equip_break_cost_return.value or {})[slot0.equipConfig.starlevel] ~= nil then
		for slot7 = 1, slot0.now_break_level do
			if slot2[slot7] ~= nil then
				slot10 = pairs
				slot12 = EquipMaterialCfg[slot8].item_list or {}

				for slot13, slot14 in slot10(slot12) do
					if slot14[1] ~= 2 then
						table.insert(slot3, slot14)
					end
				end
			end
		end
	end

	if slot0.equipConfig.starlevel > 2 and GameSetting.equip_resolve_num and GameSetting.equip_resolve_num.value[slot4 - 2] then
		table.insert(slot3, slot5)
	end

	return slot3
end

function EquipStruct.GetLevel(slot0)
	slot1 = slot0.exp or 0
	slot3 = "exp_sum_" .. slot0.equipConfig.starlevel

	for slot7 = 2, slot0:GetMaxLv() do
		if slot1 < EquipExpCfg[slot7][slot3] then
			return slot7 - 1
		end
	end

	return slot2
end

function EquipStruct.GetMaxLv(slot0)
	return slot0.equipConfig.max_level[slot0.now_break_level + 1]
end

function EquipStruct.GetPos(slot0)
	return slot0.equipConfig and slot0.equipConfig.pos or 0
end

function EquipStruct.GetSuit(slot0)
	return slot0.equipConfig and slot0.equipConfig.suit or 0
end

function EquipStruct.GetBaseSkill(slot0)
	slot1 = {}
	slot2 = {}

	for slot7 = 1, #slot0.equipConfig.effect do
		slot9 = slot3.effect_unlock_level[slot7] or 0

		if slot3.effect[slot7][1] then
			table.insert(slot1, {
				id = slot8[1],
				num = slot8[2],
				unlockLevel = slot9
			})
		end
	end

	return slot1
end

function EquipStruct.GetTotalSkill(slot0)
	slot5 = slot0.GetBaseSkill

	table.insertto({}, slot5(slot0))

	for slot5, slot6 in pairs(slot0.enchant) do
		table.insertto(slot1, slot6)
	end

	return slot1
end

function EquipStruct.ContainSkill(slot0, slot1)
	for slot6, slot7 in pairs(slot0:GetBaseSkill()) do
		if slot7.id == slot1 then
			return true
		end
	end

	for slot6, slot7 in pairs(slot0.enchant) do
		for slot11, slot12 in pairs(slot7) do
			if slot12.id == slot1 then
				return true
			end
		end
	end

	return false
end

function EquipStruct.GetSkillLevel(slot0, slot1)
	slot2 = 0
	slot3 = slot0:GetLevel()
	slot5 = EquipCfg[slot0.prefab_id].slot_open_level or {}

	for slot10, slot11 in pairs(slot0:GetBaseSkill()) do
		if slot11.id == slot1 and slot5[slot10] and slot5[slot10] <= slot3 then
			slot2 = slot2 + slot11.num
		end
	end

	for slot10, slot11 in pairs(slot0.enchant) do
		for slot15, slot16 in pairs(slot11) do
			if slot16.id == slot1 then
				slot2 = slot2 + slot16.num
			end
		end
	end

	return slot2
end

function EquipStruct.GetUpgradeCost(slot0)
	if not EquipMaterialCfg[slot0.equipConfig.break_cost[slot0.now_break_level + 1]] then
		return {}
	end

	slot4 = 0
	slot5 = {}

	for slot9, slot10 in pairs(slot3.item_list) do
		if slot10[1] == 2 then
			slot4 = slot10[2]
		else
			table.insert(slot5, slot10)
		end
	end

	return {
		item_list = slot5,
		money = slot4
	}
end

function EquipStruct.GetEnchantCount(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.enchant) do
		if #slot6 > 0 then
			slot1 = slot1 + 1
		end
	end

	return slot1
end

slot0 = singletonClass("EquipData")
slot1 = {}
slot2 = {}
slot3 = false
slot4 = {}
slot5 = {}
slot6 = 1
slot7 = 0
slot8 = 0
slot9 = 0
slot10 = 1

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = false
	uv3 = {}
	uv4 = {}
	uv5 = 1
end

function slot0.EquipInit(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = EquipStruct.New(slot6.equip_id, slot6.prefab_id)

		slot7:ParseServerData(slot6)

		uv0[slot6.equip_id] = slot7
		uv1[slot8] = uv1[EquipCfg[slot6.prefab_id].suit] or {}
		uv1[slot8][slot6.equip_id] = true
		uv2[slot6.prefab_id] = uv2[slot6.prefab_id] and uv2[slot6.prefab_id] + 1 or 1
	end

	slot0:ResetEquipSort()
	manager.notify:Invoke(EQUIP_LIST_UPDATE)
end

function slot0.ApplyEquipStrengthSuccess(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot1
	uv0[slot5].exp = uv0[slot5].exp + slot4

	slot0:DeleteEquip(slot2)
	slot0:ResetEquipSort()
end

function slot0.ApplyLockEquipSuccess(slot0, slot1, slot2)
	uv0[slot1].is_lock = slot2
end

function slot0.ApplyUpgradeEquipSuccess(slot0, slot1)
	slot2 = slot1
	slot4 = EquipCfg[uv0[slot2].prefab_id]
	uv0[slot2].now_break_level = uv0[slot2].now_break_level + 1
	uv0[slot2].exp = EquipExpCfg[slot4.max_level[uv0[slot2].now_break_level + 1]]["exp_sum_" .. slot4.starlevel]

	slot0:ResetEquipSort()
end

function slot0.DeleteEquip(slot0, slot1)
	slot2 = false

	for slot6, slot7 in pairs(slot1) do
		slot2 = true
		uv1[slot9] = uv1[EquipCfg[uv0[slot6].prefab_id].suit] or {}
		uv1[slot9][slot6] = nil
		uv0[slot6] = nil
		uv2[slot8] = uv2[slot8] - 1

		for slot13, slot14 in pairs(uv3) do
			for slot18, slot19 in pairs(slot14) do
				if slot6 == slot19.equip_id then
					table.remove(slot14, slot18)

					break
				end
			end
		end
	end

	if slot2 then
		uv4 = false
	end

	manager.notify:Invoke(EQUIP_LIST_UPDATE)
end

function slot0.EquipBagFull(slot0, slot1)
	uv0 = slot1
end

function slot0.AddPreEnchant(slot0, slot1, slot2, slot3)
	if uv0[slot1] and slot4.enchant_preview[slot2] then
		slot6 = {}

		for slot10, slot11 in ipairs(slot3.effect_list) do
			table.insert(slot6, {
				id = slot11.id,
				num = slot11.level
			})
		end

		table.insert(slot4.enchant_preview[slot2], slot6)
	end
end

function slot0.ConfirmEnchant(slot0, slot1, slot2, slot3, slot4)
	if uv0[slot1] and slot5.enchant_preview[slot2] then
		slot6 = table.remove(slot5.enchant_preview[slot2], slot4)

		if slot3 and slot6 then
			slot5.enchant[slot2] = slot6
		end
	end
end

function slot0.GiveUpAllEnchant(slot0, slot1, slot2)
	if uv0[slot1] and slot3.enchant_preview[slot2] then
		slot3.enchant_preview[slot2] = {}
	end
end

function slot0.SetPreRace(slot0, slot1, slot2)
	if uv0[slot1] then
		uv0[slot1].race_preview = slot2
	end
end

function slot0.ConfirmRace(slot0, slot1, slot2)
	if uv0[slot1] then
		if slot2 then
			uv0[slot1].race = uv0[slot1].race_preview
		end

		uv0[slot1].race_preview = 0

		slot0:ResetEquipSort()
	end
end

function slot0.GetEquipList(slot0)
	return uv0
end

function slot0.GetEquipData(slot0, slot1)
	if uv0[slot1] then
		return slot2
	else
		print("error: Equip cant find with id ", slot1)

		return nil
	end
end

function slot0.GetEquipBagFull(slot0)
	return uv0
end

function slot0.GetEquipListBySort(slot0, slot1, slot2)
	if uv0[slot1 .. slot2] then
		return uv0[slot3]
	end

	uv0[slot3] = EquipTools.EquipSort(uv1, slot1, slot2)

	return uv0[slot3]
end

function slot0.GetEquipListComplex(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = slot0:GetEquipListBySort(slot1, slot2)
	slot3 = slot3 or 0
	slot4 = slot4 or 0
	slot5 = slot5 or 0
	slot7 = {}

	for slot11, slot12 in ipairs(slot6) do
		if (EquipCfg[slot12.prefab_id].pos == slot3 or slot3 == 0) and (slot13.suit == slot4 or slot4 == 0 or type(slot4) == "table" and table.indexof(slot4, slot13.suit) or slot4 == EquipConst.EX_EQUIP_SUIT_ID and EquipConst.EX_EQUIP_SUIT_ID <= slot13.suit) and (slot5 == 0 or slot12:ContainSkill(slot5)) then
			table.insert(slot7, slot12.equip_id)
		end
	end

	return slot7
end

function slot0.ResetEquipSort(slot0)
	uv0 = {}
end

function slot0.GetEnchantMaterial(slot0)
	slot1 = GameSetting.equip_enchant_cost and GameSetting.equip_enchant_cost.value or {}
	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		slot8 = EquipMaterialCfg[slot7] or {}
		slot9 = 0
		slot10 = 0
		slot11 = 0

		for slot15, slot16 in pairs(slot8.item_list) do
			if slot16[1] == 2 then
				slot11 = slot16[2]
			else
				slot9 = slot16[1]
				slot10 = slot16[2]
			end
		end

		table.insert(slot2, {
			id = slot9,
			number = slot10,
			money = slot11
		})
	end

	return slot2
end

function slot0.GetLockEnchantMaterial(slot0)
	slot1 = GameSetting.equip_enchant_lock_cost and GameSetting.equip_enchant_lock_cost.value or {}
	slot2 = slot0:GetEnchantMaterial()
	slot3 = {}

	for slot7, slot8 in pairs(slot1) do
		slot9 = EquipMaterialCfg[slot8] or {}
		slot10 = 0
		slot11 = 0
		slot12 = 0

		for slot16, slot17 in pairs(slot9.item_list) do
			if slot17[1] == 2 then
				slot12 = slot17[2]
			else
				slot10 = slot17[1]
				slot11 = slot17[2]
			end
		end

		for slot16, slot17 in ipairs(slot2) do
			if slot17.id == slot10 then
				slot2[slot16].number = slot11
				slot2[slot16].money = slot12
				slot3[slot16] = true
			end
		end
	end

	return slot2, slot3
end

function slot0.GetRaceMaterial(slot0, slot1)
	slot2 = nil
	slot3 = EquipMaterialCfg
	slot4 = (slot1 == 1 and (GameSetting.equip_reset_cost and GameSetting.equip_reset_cost.value or {}) or GameSetting.equip_hero_reset_cost and GameSetting.equip_hero_reset_cost.value or {})[1] or 0
	slot4 = 0
	slot5 = 0
	slot6 = 0

	for slot10, slot11 in pairs(slot3[slot4].item_list) do
		if slot11[1] == 2 then
			slot6 = slot11[2]
		else
			slot4 = slot11[1]
			slot5 = slot11[2]
		end
	end

	return {
		id = slot4,
		number = slot5,
		money = slot6
	}
end

function slot0.GetEquipCnt(slot0, slot1)
	return uv0[slot1] and uv0[slot1] or 0
end

function slot0.GetSelectEnchantMaterialIndex(slot0)
	return uv0
end

function slot0.SetSelectEnchantMaterialIndex(slot0, slot1)
	uv0 = slot1
end

function slot0.SetEnchatLockIndex(slot0, slot1, slot2, slot3)
	uv0 = slot1
	uv1 = slot2
	uv2 = slot3
end

function slot0.GetIsSetLockView(slot0, slot1, slot2)
	if uv0 == slot1 and uv1 == slot2 then
		return uv2
	end

	return false
end

function slot0.GetRaceIndex(slot0)
	return uv0
end

function slot0.SetRaceIndex(slot0, slot1)
	uv0 = slot1
end

function slot0.GetInheritCost(slot0, slot1)
	slot2 = GameSetting.equip_inherit_cost and GameSetting.equip_inherit_cost.value or {}
	slot3 = {}
	slot4 = 0

	if EquipSuitCfg[slot1] ~= nil then
		slot6 = nil
		slot6 = (EquipSuitCfg[slot1].inherit_cost_type ~= 1 or EquipMaterialCfg[slot2[1] or 0]) and EquipMaterialCfg[slot2[2] or 0]

		for slot10, slot11 in pairs(slot6.item_list) do
			slot12 = {}

			if slot11[1] == 2 then
				slot4 = slot11[2]
			else
				slot12.id = slot11[1]
				slot12.number = slot11[2]
				slot3[#slot3 + 1] = slot12
			end
		end
	end

	return slot3, slot4
end

return slot0
