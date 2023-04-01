return {
	GetServantMap = function ()
		slot0 = {}

		for slot5, slot6 in pairs(HeroData:GetHeroList()) do
			if slot6.servant_uid ~= 0 then
				slot0[slot6.servant_uid] = slot5
			end
		end

		return slot0
	end,
	GetServantLimited = function (slot0, slot1)
		slot2 = HeroData:GetHeroList()
		slot3 = {}
		slot4 = {}
		slot5 = WeaponServantData:GetWeaponServantList()

		if slot1 then
			for slot9, slot10 in pairs(slot2) do
				slot4[slot10.servant_uid] = 1
			end
		end

		if slot0 then
			for slot9, slot10 in pairs(slot5) do
				if slot10.locked == 0 and not slot4[slot9] then
					table.insert(slot3, slot10)
				end
			end
		else
			for slot9, slot10 in pairs(slot5) do
				table.insert(slot3, slot10)
			end
		end

		return slot3
	end,
	GetServantByIDLimited = function (slot0, slot1, slot2, slot3)
		slot4 = HeroData:GetHeroList()
		slot5 = {}
		slot6 = {}
		slot7 = WeaponServantData:GetServantSByID(slot0)

		if slot2 then
			for slot11, slot12 in pairs(slot4) do
				slot6[slot12.servant_uid] = 1
			end
		end

		if slot1 then
			for slot11, slot12 in pairs(slot7) do
				if WeaponServantData:GetServantDataByUID(slot11).locked == 0 and not slot6[slot11] and slot11 ~= slot3 then
					table.insert(slot5, slot11)
				end
			end
		else
			for slot11, slot12 in pairs(slot7) do
				table.insert(slot5, slot11)
			end
		end

		return slot5
	end,
	ServantBreakCost = function (slot0, slot1)
		if GameSetting.weapon_promote_max.value[slot0] < slot1 then
			print("已超过最大突破次数")

			return false
		end

		return GameSetting.weapon_servant_gold_cost.value[slot0][slot1]
	end,
	ServantBreakMaterialCost = function (slot0, slot1)
		if uv0.GetServantSpecHero(slot0) then
			return GameSetting.weapon_promote_cost_exclusive.value
		else
			return GameSetting.weapon_promote_cost.value[slot1 - 3]
		end
	end,
	GetServantEffect = function (slot0, slot1, slot2, slot3)
		slot6 = uv0.GetServantSpecHero(slot0)

		if WeaponServantCfg[slot0].effect[1] == 0 then
			return WeaponServantCfg[slot0].effect_desc
		elseif slot2 == true then
			slot7 = WeaponEffectCfg[slot5]

			if slot3 then
				if slot3.isForeign then
					slot9 = HeroData:GetModulePowersByHeroIDAndLevel(slot6, ForeignInfoData:GetForeignModuleLevelByHeroID(slot6))

					if slot7.simple_strength_description[1] and table.indexof(slot9, slot7.simple_strength_description[1]) then
						return slot7.simple_strength_description[2]
					else
						return slot7.simple_description
					end
				else
					return slot7.simple_description
				end
			else
				slot8 = HeroData:GetModulePowersByHeroID(slot6)

				if slot7.simple_strength_description[1] and table.indexof(slot8, slot7.simple_strength_description[1]) then
					return slot7.simple_strength_description[2]
				else
					return slot7.simple_description
				end
			end
		else
			slot7 = WeaponEffectCfg[slot5].description[1]

			if slot3 then
				if slot3.isForeign then
					slot9 = HeroData:GetModulePowersByHeroIDAndLevel(slot6, ForeignInfoData:GetForeignModuleLevelByHeroID(slot6))

					if WeaponEffectCfg[slot5].strengthen_description[1] and table.indexof(slot9, WeaponEffectCfg[slot5].strengthen_description[1]) then
						slot7 = WeaponEffectCfg[slot5].strengthen_description[2]
					end
				end
			else
				slot8 = HeroData:GetModulePowersByHeroID(slot6)

				if WeaponEffectCfg[slot5].strengthen_description[1] and table.indexof(slot8, WeaponEffectCfg[slot5].strengthen_description[1]) then
					slot7 = WeaponEffectCfg[slot5].strengthen_description[2]
				end
			end

			return GetCfgDescription(slot7, slot1)
		end
	end,
	GetServantSpecHero = function (slot0)
		slot2 = nil

		if WeaponServantCfg[slot0].effect[1] > 0 then
			slot2 = WeaponEffectCfg[slot1].spec_char[1]
		end

		return slot2
	end,
	GetSleepyServantByServant = function (slot0)
		if uv0.GetServantSpecHero(slot0) then
			for slot6, slot7 in ipairs(WeaponServantCfg.get_id_list_by_race[WeaponServantCfg[slot0].race]) do
				if WeaponServantCfg[slot7].type == 3 then
					return slot7
				end
			end
		end

		return false
	end,
	GetSleepyServantNum = function (slot0)
		if not WeaponServantCfg.get_id_list_by_race[slot0] then
			error("错误的race:" .. slot0)
		end

		slot1 = nil

		for slot5, slot6 in ipairs(WeaponServantCfg.get_id_list_by_race[slot0]) do
			if WeaponServantCfg[slot6].type == 3 then
				slot1 = slot6
			end
		end

		return table.length(WeaponServantData:GetServantSByID(slot1))
	end,
	GetServantDecomposeRewardItem = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			slot8 = GameSetting.weapon_servant_break_cost_return.value[WeaponServantCfg[slot6.id].starlevel]
			slot1[slot8[1][1]] = (slot1[slot8[1][1]] or 0) + slot8[1][2]
		end

		return slot1
	end,
	GetIsHide = function (slot0)
		return HideInfoData:GetWeaponServantHideList()[slot0] or false
	end
}
