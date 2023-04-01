return {
	GetTotalAddAttribute = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(slot0) do
			if slot6.astrolabe_id ~= 0 then
				for slot11, slot12 in ipairs(HeroAstrolabeCfg[slot6.astrolabe_id].ability) do
					if slot1[slot12[1]] == nil then
						slot1[slot12[1]] = slot12[2]
					else
						slot1[slot12[1]] = slot1[slot12[1]] + slot12[2]
					end
				end
			end
		end

		return slot1
	end,
	GetTotalEffect = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			table.insert(slot1, slot6)
		end

		return slot1
	end,
	GetAcitveEffect = function (slot0, slot1)
		if slot1 and slot1.isPreview then
			return {}
		end

		slot2 = {}

		for slot6, slot7 in ipairs(slot0) do
			if slot7 ~= 0 then
				if slot2[HeroAstrolabeCfg[slot7].hero_astrolabe_suit_id] == nil then
					slot2[slot9] = {
						num = 1,
						id = slot9
					}
				else
					slot2[slot9].num = slot2[slot9].num + 1
				end
			end
		end

		slot3 = {}

		for slot7, slot8 in pairs(slot2) do
			table.insert(slot3, slot8)
		end

		return slot3
	end,
	GetHeroAstrolabeS = function (slot0, slot1)
		slot2 = {}
		slot3 = slot1 and slot1.isPreview == true
		slot4 = slot1 and slot1.isPolyhedron
		slot8 = slot0.id

		for slot8, slot9 in ipairs(HeroCfg[slot8].astrolabe) do
			slot10 = {
				suitId = slot9,
				astrolabe = {}
			}

			for slot14, slot15 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot9]) do
				if not slot3 then
					table.insert(slot10.astrolabe, {
						id = slot15,
						heroId = slot0.id,
						isUnlock = uv0.GetIsUnlock(slot0.unlocked_astrolabe, slot15),
						isEquiped = uv0.GetIsEquiped(slot0.using_astrolabe, slot15),
						posX = slot8,
						posY = slot14
					})
				else
					table.insert(slot10.astrolabe, {
						isUnlock = true,
						isEquiped = false,
						id = slot15,
						heroId = slot0.id,
						posX = slot8,
						posY = slot14
					})
				end
			end

			table.insert(slot2, slot10)
		end

		return slot2
	end,
	GetLastIsUnlock = function (slot0, slot1)
		if HeroAstrolabeCfg[slot0].pos == 1 then
			return true
		else
			return uv0.GetIsUnlock(HeroData:GetHeroData(slot1).unlocked_astrolabe, slot0 - 1)
		end

		return false
	end,
	GetLastIsEquiped = function (slot0, slot1)
		if HeroAstrolabeCfg[slot0].pos == 1 then
			return true
		else
			return uv0.GetIsEquiped(HeroData:GetHeroData(slot1).using_astrolabe, slot0 - 1)
		end

		return false
	end,
	GetNextIsEquiped = function (slot0, slot1)
		if HeroAstrolabeCfg[slot0].pos == 3 then
			return false
		else
			return uv0.GetIsEquiped(HeroData:GetHeroData(slot1).using_astrolabe, slot0 + 1)
		end

		return false
	end,
	GetIsUnlock = function (slot0, slot1)
		for slot5, slot6 in pairs(slot0) do
			if slot6 == slot1 then
				return true
			end
		end

		return false
	end,
	GetIsEquiped = function (slot0, slot1)
		for slot5, slot6 in pairs(slot0) do
			if slot6 == slot1 then
				return true
			end
		end

		return false
	end,
	GetIsHaveCanUnlock = function (slot0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_ASTROLABE) then
			return false
		end

		slot6 = HeroData:GetHeroData(slot0).id

		for slot6, slot7 in ipairs(HeroCfg[slot6].astrolabe) do
			for slot11, slot12 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot7]) do
				if not uv0.GetIsUnlock(slot2.unlocked_astrolabe, slot12) and uv0.GetIsCanUnlock(slot12, slot0) then
					return true
				end
			end
		end

		return false
	end,
	GetIsCanUnlock = function (slot0, slot1)
		if uv0.GetIsUnlock(HeroData:GetHeroData(slot1).unlocked_astrolabe, slot0) then
			return false
		end

		slot3 = MaterialData:GetMaterialList()

		if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD) < HeroAstrolabeCfg[slot0].unlock[1][2] then
			return false
		end

		if not uv0.GetLastIsUnlock(slot0, slot1) then
			return false
		end

		return IsConditionAchieved(slot5.unlock_condition, {
			heroId = slot1
		})
	end,
	GetAstrolabeModuleDes = function (slot0, slot1)
		slot3 = GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_3")
		slot4 = nil

		for slot8, slot9 in pairs(AstrolabeEffectCfg[getAstrolabeID(slot0, slot1)].equip_orange_desc) do
			if slot9[1] == slot1 and slot9[3] == slot0 then
				slot4 = slot9[2]
			end
		end

		return string.format(slot3, HeroAstrolabeCfg[slot2].suit_name, HeroAstrolabeCfg[slot2].name, GetCfgDescription(slot4, 1))
	end
}
