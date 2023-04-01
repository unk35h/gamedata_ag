return {
	WeaponAtk = function (slot0, slot1)
		slot2 = GameSetting.weapon_fixed_attributes.value[slot1 + 1]

		return slot2[1] + slot2[2] * (slot0 - 1)
	end,
	ExpToLv = function (slot0)
		slot1, slot2 = nil
		slot3 = 0

		for slot8 = HeroConst.WEAPON_LV_MAX, 1, -1 do
			if GameLevelSetting[slot8].weapon_lv_exp_sum <= slot0 then
				slot1 = slot8
				slot2 = slot0 - slot3

				break
			end
		end

		return slot1, slot2
	end,
	CurMaxExp = function (slot0)
		slot1 = nil

		return GameLevelSetting[GameSetting.weapon_exp_limit.value[slot0 + 1]].weapon_lv_exp_sum
	end,
	AddWeaponExp = function (slot0, slot1, slot2)
		slot3 = 0
		slot4 = 0
		slot5 = 0
		slot6 = false

		if uv0.CurMaxExp(slot1) <= slot0 + slot2 then
			slot5 = slot8 - slot7
			slot8 = slot7
			slot6 = true
		end

		slot9, slot10 = WeaponTools.ExpToLv(slot8)

		return slot10, slot9, slot5, slot6
	end,
	BreakMaterial = function (slot0)
		if slot0 >= 4 then
			return 0, {}
		end

		if not GameSetting.weapon_break_cost.value[slot0 + 1] then
			print()
		end

		slot3 = 1
		slot4 = {}

		if EquipMaterialCfg[slot1].item_list[1][1] == 2 then
			slot3 = slot2[1][2]
		end

		for slot8 = 2, #slot2 do
			slot4[slot8 - 1] = deepClone(slot2[slot8])
		end

		return slot3, slot4
	end,
	CalWeaponAttribute = function (slot0, slot1, slot2)
		slot3 = {}
		slot4 = uv0.ExpToLv(slot1.exp)
		slot5 = GameSetting.weapon_fixed_attributes.value[slot1.breakthrough + 1]
		slot6 = 1

		if slot2 and slot2.id and slot2.id ~= 0 and WeaponServantCfg[slot2.id] then
			slot6 = slot7.attrib_addition * 0.01 + 1
			slot3[slot7.attribute[1]] = slot7.attribute[2]
		end

		slot3[1] = (slot5[1] + slot5[2] * (slot4 - 1)) * slot6 + (slot3[1] or 0)
		slot7 = 0
		slot8 = HeroCfg[slot0].weapon_break_attribute[slot1.breakthrough + 1]
		slot3[slot8[1]] = slot8[2] + (slot3[slot8[1]] or 0)

		return slot3
	end,
	GetWeaponModuleDes = function (slot0)
		slot1 = getSkillIDOrServantID(slot0)

		return string.format(GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_4"), ItemCfg[slot1].name, GetCfgDescription(WeaponEffectCfg[WeaponServantCfg[slot1].effect[1]].strengthen_description[2], 1))
	end
}
