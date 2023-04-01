slot1 = import("game.const.HeroConst")

return {
	GetAstrolabeDesc = function (slot0, slot1, slot2)
		if not AstrolabeEffectCfg[slot0] then
			print("id" .. slot0 .. "没有配置")
		end

		if slot3 and slot3.desc and type(slot3.desc) == "table" then
			slot4 = slot3.desc[1]
			slot5 = uv0.GetServantId(slot1, slot2)
			slot6 = {}

			if slot2 then
				if slot2.isForeign then
					slot6 = HeroData:GetModulePowersByHeroIDAndLevel(slot1, ForeignInfoData:GetForeignModuleLevelByHeroID(slot1))
				end
			else
				slot6 = HeroData:GetModulePowersByHeroID(slot1)
			end

			slot7 = false

			if slot3.equip_orange_desc and type(slot3.equip_orange_desc) == "table" then
				for slot11, slot12 in ipairs(slot3.equip_orange_desc) do
					if slot12[1] > 0 and slot12[3] > 0 and slot12[1] == slot5 and table.indexof(slot6, slot12[3]) then
						slot4 = slot12[2]
						slot7 = true
					end
				end

				if not slot7 then
					for slot11, slot12 in ipairs(slot3.equip_orange_desc) do
						if slot12[1] > 0 and slot12[3] == 0 and slot12[1] == slot5 then
							slot4 = slot12[2]
							slot7 = true
						end
					end

					if not slot7 then
						for slot11, slot12 in ipairs(slot3.equip_orange_desc) do
							if slot12[1] == 0 and slot12[3] > 0 and table.indexof(slot6, slot12[3]) then
								slot4 = slot12[2]
								slot7 = true
							end
						end
					end
				end
			end

			return GetCfgDescription(slot4, 1)
		end

		return ""
	end,
	GetAstrolabeDescByServant = function (slot0, slot1)
		if not AstrolabeEffectCfg[slot0] then
			print("id" .. slot0 .. "没有配置")
		end

		if slot2 and slot2.desc and type(slot2.desc) == "table" then
			if not slot2.desc[1] then
				print("id" .. slot0 .. "等级溢出" .. 1)

				return ""
			end

			slot3 = slot2.desc[1]

			if slot1 ~= 0 and slot2.equip_orange_desc and type(slot2.equip_orange_desc) == "table" then
				for slot7, slot8 in ipairs(slot2.equip_orange_desc) do
					if slot8[1] == slot1 then
						slot3 = slot8[2]
					end
				end
			end

			return GetCfgDescription(slot3, 1)
		end

		return ""
	end,
	GetSkillDesc = function (slot0, slot1, slot2, slot3)
		if not HeroSkillCfg[slot0] then
			print("技能 id" .. slot0 .. "没有配置")
		end

		slot1 = slot1 or 1
		slot5 = ""

		if slot4 and slot4.desc and type(slot4.desc) == "table" then
			slot6 = slot4.desc[1]

			if slot3 then
				if slot3.isForeign then
					slot8 = HeroData:GetModulePowersByHeroIDAndLevel(uv0.GetHeroIDBySkillID(slot0), ForeignInfoData:GetForeignModuleLevelByHeroID(uv0.GetHeroIDBySkillID(slot0)))

					if slot4.strengthen_desc and slot4.strengthen_desc[1] and table.indexof(slot8, slot4.strengthen_desc[1]) then
						slot6 = slot4.strengthen_desc[2]
					end
				end
			else
				slot7 = HeroData:GetModulePowersByHeroID(uv0.GetHeroIDBySkillID(slot0))

				if slot4.strengthen_desc and slot4.strengthen_desc[1] and table.indexof(slot7, slot4.strengthen_desc[1]) then
					slot6 = slot4.strengthen_desc[2]
				end
			end

			slot5 = GetCfgDescription(slot6, slot1)
		end

		if slot2 then
			return string.gsub(slot5, "%(.-%)", "")
		end

		return slot5
	end,
	GetHeroIDBySkillID = function (slot0)
		slot1 = nil

		while slot0 > 9999 do
			slot0 = slot0 / 10
		end

		return math.modf(slot0)
	end,
	GetIsDodgeSkill = function (slot0)
		return slot0 % 1000 == 305
	end,
	GetIsPassiveSkill = function (slot0)
		return slot0 % 1000 == 999
	end,
	GetIsMelee = function (slot0)
		return slot0 % 1000 < 200
	end,
	GetMainHeroId = function (slot0)
		return math.floor(slot0 / 1000)
	end,
	GetSkillIdIndex = function (slot0)
		return table.indexof(HeroCfg[uv0.GetMainHeroId(slot0)].skills, slot0)
	end,
	GetIsCanUp = function (slot0, slot1)
		if uv0.GetIsPassiveSkill(slot0) or slot1 == uv1.MAX_SKILL_LEVEL or uv0.GetIsDodgeSkill(slot0) then
			return false
		end

		slot2 = uv0.GetMainHeroId(slot0)

		if HeroData:GetHeroData(slot2).break_level < SkillCfg[slot1]["skill_limit" .. table.indexof(HeroCfg[slot2].skills, slot0)] then
			return false
		end

		if MaterialData:GetMaterialList()[SkillCfg[slot1]["skill_cost" .. slot5][1][1]] then
			if slot8[slot7[1]].num < slot7[2] then
				return false
			end
		else
			return false
		end

		return true
	end,
	GetSkillUpCostNum = function (slot0, slot1, slot2)
		slot3 = SkillTools.GetSkillIdIndex(slot0)
		slot4 = {}

		for slot8 = 1, slot2 do
			slot9 = SkillCfg[slot1 + slot8 - 1]["skill_cost" .. slot3][1]
			slot4[slot9[1]] = (slot4[slot9[1]] or 0) + slot9[2]
		end

		return slot4
	end,
	GetRealSkillId = function (slot0, slot1, slot2)
		slot3 = HeroCfg[slot0]
		slot4 = nil

		if slot2 then
			if slot2.isForeign then
				slot4 = ForeignInfoData:GetHeroInfo(slot0)
			elseif slot2.isTemp then
				slot4 = TempHeroData:GetHeroDataByHeroID(slot2.tempHeroList, slot0)
			elseif slot2.isPreview then
				slot4 = HeroData:GetHeroData(slot0)
			elseif slot2.isPolyhedron then
				slot4 = PolyhedronData:GetPolyhedronHeroData(slot0)
			end
		else
			slot4 = HeroData:GetHeroData(slot0)
		end

		slot5 = slot1
		slot6 = 0
		slot7 = nil

		if slot2 then
			if slot2.isForeign then
				slot7 = ForeignInfoData:GetHeroServantInfo(slot0)
			elseif slot2.isTemp then
				slot7 = TempHeroData:GetHeroServantInfo(slot2.tempHeroList, slot0)
			elseif slot2.isPreview then
				-- Nothing
			elseif slot2.isPolyhedron then
				slot7 = slot4.servant
			end
		else
			slot7 = WeaponServantData:GetServantDataByUID(slot4.servant_uid)
		end

		if slot7 then
			slot6 = slot7.id
		end

		for slot11, slot12 in pairs(slot3.equip_orange_skill) do
			if slot12[1] == slot1 and slot6 == slot12[2] then
				slot5 = slot12[3]
			end
		end

		for slot11, slot12 in pairs(slot3.astrolabe_skill) do
			if slot12[1] == slot1 then
				for slot16, slot17 in pairs(slot4.using_astrolabe) do
					if slot12[2] == slot17 then
						slot5 = slot12[3]
					end
				end
			end
		end

		return slot5
	end,
	GetServantId = function (slot0, slot1)
		slot2 = 0
		slot3, slot4 = nil

		if slot1 then
			if slot1.isForeign then
				slot3 = ForeignInfoData:GetHeroInfo(slot0)
				slot4 = ForeignInfoData:GetHeroServantInfo(slot0)
			elseif slot1.isTemp then
				slot3 = TempHeroData:GetHeroDataByHeroID(slot1.tempHeroList, slot0)
				slot4 = TempHeroData:GetHeroServantInfo(slot1.tempHeroList, slot0)
			elseif slot1.isPreview then
				return 0
			end
		else
			slot4 = WeaponServantData:GetServantDataByUID(HeroData:GetHeroData(slot0).servant_uid)
		end

		if slot4 then
			slot2 = slot4.id
		end

		return slot2
	end,
	GetRealSkillIdByWeaponServantId = function (slot0, slot1, slot2)
		slot4 = slot2

		for slot8, slot9 in pairs(HeroCfg[slot0].equip_orange_skill) do
			if slot9[1] == slot2 and slot1 == slot9[2] then
				slot4 = slot9[3]
			end
		end

		return slot4
	end,
	GetAttr = function (slot0)
		slot2 = nil

		return PublicAttrCfg[slot0[1]].name, (PublicAttrCfg[slot0[1]].percent ~= 1 or string.format("%.2f%%", slot0[2] / 10)) and string.format("%d", slot0[2]), getSprite("Atlas/Common", PublicAttrCfg[slot0[1]].icon)
	end,
	GetSkillModuleDes = function (slot0)
		slot2 = GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_2")
		slot4 = nil

		for slot8, slot9 in pairs(HeroCfg[uv0.GetHeroIDBySkillID(getSkillIDOrServantID(slot0))].skills) do
			if slot9 == slot1 then
				slot4 = HeroCfg[slot3].skill_subhead[slot8]

				break
			end
		end

		return string.format(slot2, slot4, HeroSkillCfg[slot1].name, uv0.GetSkillRate(HeroSkillCfg[slot1].desc[1]), uv0.GetSkillRate(HeroSkillCfg[slot1].strengthen_desc[2]))
	end,
	GetServantSkillModuleDes = function (slot0)
		slot2 = GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_2")
		slot3 = uv0.GetHeroIDBySkillID(getSkillIDOrServantID(slot0))
		slot4 = HeroCfg[slot3].equip_orange_skill[1][1]
		slot5 = nil

		for slot9, slot10 in pairs(HeroCfg[slot3].skills) do
			if slot10 == slot4 then
				slot5 = HeroCfg[slot3].skill_subhead[slot9]

				break
			end
		end

		return string.format(slot2, slot5, HeroSkillCfg[slot1].name, uv0.GetSkillRate(HeroSkillCfg[slot1].desc[1]), uv0.GetSkillRate(HeroSkillCfg[slot1].strengthen_desc[2]))
	end,
	GetSkillRate = function (slot0)
		slot1 = nil

		for slot5, slot6 in pairs(DescriptionCfg[slot0].param[1]) do
			if string.find(slot6, "下一级") then
				slot1 = (slot1 ~= nil or string.gsub(slot6, "%(.-%)", "")) and string.gsub(slot6, "%(.-%)", "") .. "/" .. string.gsub(slot6, "%(.-%)", "")
			end
		end

		return slot1
	end,
	CanUseComboSkill = function (slot0, slot1)
		if slot0 == 0 then
			return true
		end

		for slot6, slot7 in ipairs(ComboSkillCfg[slot0].cooperate_role_ids) do
			if not table.keyof(slot1, slot7) then
				return false
			end
		end

		return true
	end
}
