slot0 = singletonClass("DormSkillData")
slot1 = nil

function slot0.Init(slot0)
	uv0 = {}

	for slot4 = 1, 20 do
		uv0[slot4] = {}
	end

	slot0:UpdataAllHeroSkill()
	slot0:UpdataAllFurSkill()
end

function slot0.CheckSkillIsOpen(slot0, slot1, slot2, slot3)
	if uv0 then
		slot4 = BackHomeHeroSkillCfg[slot2]
		slot5 = slot4.type

		if not slot4.condition or #slot6 == 0 then
			return true
		end

		if slot3 == DormEnum.EntityType.Character then
			if slot6 and #slot6 > 0 then
				if slot6[1] == 1 then
					if DormData:GetHeroTemplateInfo(slot1).jobType ~= slot6[2] then
						return false
					end
				elseif slot6[1] == 2 then
					if not DormData:GetHeroTemplateInfo(slot1):GetCurRoomID() then
						return false
					end

					if BackHomeCfg[slot7].type ~= slot6[2] then
						return false
					end
				end
			end
		elseif slot3 == DormEnum.EntityType.Furniture then
			return true
		end

		return true
	end
end

function slot0.CheckSkillIsRun(slot0, slot1, slot2, slot3)
	if uv0 then
		if uv0[BackHomeHeroSkillCfg[slot2].type] then
			for slot8, slot9 in ipairs(uv0[slot4]) do
				if slot9.type == slot3 and slot9.id == slot1 and slot9.skillID == slot2 then
					return true
				end
			end
		end

		return false
	end
end

function slot0.AddSkillComponent(slot0, slot1, slot2, slot3)
	if not uv0[BackHomeHeroSkillCfg[slot2].type] then
		uv0[slot4] = {}
	end

	table.insert(uv0[slot4], {
		type = slot3,
		id = slot1,
		skillID = slot2
	})
end

function slot0.DisposeSkillComponent(slot0, slot1, slot2, slot3)
	for slot8 = 1, #uv0[BackHomeHeroSkillCfg[slot2].type] do
		if uv0[slot4][slot8] and slot9.type == slot3 and slot9.id == slot1 and slot9.skillID == slot2 then
			table.remove(uv0[slot4], slot8)
		end
	end
end

slot2 = nil

function slot0.GetCanSignFoodNum(slot0)
	return uv0
end

function slot0.CalCanSignFoodNum(slot0)
	slot1 = GameSetting.dorm_canteen_sell_default.value[1]
	slot3 = 0

	for slot7, slot8 in pairs(CanteenData:GetFurInfoList()) do
		slot9 = slot8.level

		if BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[slot7].type_id] then
			slot3 = slot3 + BackHomeCanteenFurnitureCfg[slot10].canteen_sell_max[slot9]
		end
	end

	uv0 = slot1 + slot3
end

slot3 = nil

function slot0.GetInComeStorageMax(slot0)
	if uv0 then
		return uv0
	else
		print("存储上限不存在")
	end
end

function slot0.CalInComeStorageMaxNum(slot0)
	slot1 = GameSetting.dorm_canteen_storage_default.value[1]
	slot3 = 0

	for slot7, slot8 in pairs(CanteenData:GetFurInfoList()) do
		slot9 = slot8.level

		if BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[slot7].type_id] then
			slot3 = slot3 + BackHomeCanteenFurnitureCfg[slot10].canteen_storage_max[slot9]
		end
	end

	uv0 = slot1 + slot3
end

function slot0.GetSkillEffect(slot0, slot1, slot2, slot3, slot4)
	slot5 = uv0[slot1]

	if slot1 == CanteenConst.HeroSkillType.FoodCostQucik or slot1 == CanteenConst.HeroSkillType.FoodCostRise then
		slot6 = 0

		if slot5 and #slot5 > 0 then
			for slot10, slot11 in ipairs(slot5) do
				if slot4 == BackHomeHeroSkillCfg[slot11.skillID].param[1] then
					slot6 = slot6 + BackHomeHeroSkillCfg[slot12].param[2]
				end
			end
		end

		return slot6
	elseif slot1 == CanteenConst.HeroSkillType.FatigueRecuse then
		slot6 = 100

		if slot5 and #slot5 > 0 then
			for slot10, slot11 in ipairs(slot5) do
				if slot2 == slot11.id then
					slot6 = slot6 - BackHomeHeroSkillCfg[slot11.skillID].param[1]
				end
			end
		end

		return slot6
	elseif slot1 == CanteenConst.HeroSkillType.PopularRise then
		slot6 = 0

		if slot5 and #slot5 > 0 then
			for slot10, slot11 in ipairs(slot5) do
				slot6 = slot6 + BackHomeHeroSkillCfg[slot11.skillID].param[1]
			end
		end

		return slot6
	elseif slot1 == CanteenConst.HeroSkillType.FatigueRecoverSelfFast then
		slot6 = 0

		if slot5 and #slot5 > 0 then
			for slot10, slot11 in ipairs(slot5) do
				if slot2 == slot11.id then
					slot6 = slot6 + BackHomeHeroSkillCfg[slot11.skillID].param[1]
				end
			end
		end

		return slot6
	elseif slot1 == CanteenConst.HeroSkillType.FatigueRecoverAllFast then
		slot6 = 0

		if slot5 and #slot5 > 0 then
			for slot10, slot11 in ipairs(slot5) do
				slot6 = slot6 + BackHomeHeroSkillCfg[slot11.skillID].param[1]
			end
		end

		return slot6
	elseif slot1 == CanteenConst.HeroSkillType.EntrustFatigueSelfReduce then
		slot6 = 100

		if slot5 and #slot5 > 0 then
			for slot10, slot11 in ipairs(slot5) do
				if slot2 == slot11.id then
					slot6 = slot6 - BackHomeHeroSkillCfg[slot11.skillID].param[1]
				end
			end
		end

		return slot6
	elseif slot1 == CanteenConst.HeroSkillType.EntrustExternSucceedAdd then
		slot6 = 0

		if slot5 and #slot5 > 0 then
			for slot10, slot11 in ipairs(slot5) do
				if slot2 == slot11.id then
					slot6 = slot6 + BackHomeHeroSkillCfg[slot11.skillID].param[1]
				end
			end
		end

		return slot6
	elseif slot1 == CanteenConst.HeroSkillType.EntrustExternAwardAdd then
		slot7 = CanteenData:GetEntrustAwardCacheByPos(slot3).hero_list
		slot8 = 100

		if slot5 and #slot5 > 0 then
			for slot12, slot13 in ipairs(slot5) do
				for slot17, slot18 in ipairs(slot7) do
					if slot18 == slot13.id then
						slot8 = slot8 + BackHomeHeroSkillCfg[slot13.skillID].param[1]
					end
				end
			end
		end

		return slot8
	elseif slot1 == CanteenConst.HeroSkillType.EntrustTotalFatigueReduce then
		slot6 = 0

		if slot5 and #slot5 > 0 then
			for slot10, slot11 in ipairs(slot5) do
				if slot2 == slot11.id then
					slot6 = slot6 + BackHomeHeroSkillCfg[slot11.skillID].param[1]
				end
			end
		end

		return slot6
	else
		print("未找到对应类型技能")
	end
end

function slot0.UpdataAllHeroSkill(slot0)
	if DormData:GetHeroInfoList() then
		for slot5, slot6 in pairs(slot1) do
			slot6:DisposeRunSkill()
			slot6:OpenHeroSkill()
		end
	end
end

function slot0.UpdataAllFurSkill(slot0)
	if CanteenData:GetFurInfoList() then
		for slot5, slot6 in pairs(slot1) do
			for slot14, slot15 in ipairs(BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[slot5].type_id].skill[slot6.level]) do
				if slot0:CheckSkillIsOpen(slot5, slot15, DormEnum.EntityType.Furniture) and not slot0:CheckSkillIsRun(slot5, slot15, DormEnum.EntityType.Furniture) then
					slot0:AddSkillComponent(slot5, slot15, DormEnum.EntityType.Furniture)
				end
			end
		end
	end
end

function slot0.GetSkillDesc(slot0, slot1)
	slot3 = ""
	slot4 = slot0:GetSkillEffectDesc(slot1)

	if BackHomeHeroSkillCfg[slot1].condition[1] == 1 then
		slot3 = string.format(slot2.desc, CanteenTools:GetJobName(slot2.condition[2]))
	elseif slot2.condition[1] == 2 then
		slot3 = string.format(slot2.desc, GetTips("DORM_LOBBY_NAME"))
	elseif slot2.condition[1] == 3 then
		slot3 = string.format(slot2.desc, GetTips("DORM_CANTEEN_TASK_NAME"))
	end

	return slot3 .. slot4
end

function slot0.GetSkillEffectDesc(slot0, slot1)
	slot2 = ""
	slot3 = BackHomeHeroSkillCfg[slot1]
	slot4 = slot3.type

	return (not slot3.param[2] or string.format(BackHomeHeroSkillDescCfg[slot4].desc, DormEnum.FoodType[slot3.param[1]], slot3.param[2])) and string.format(BackHomeHeroSkillDescCfg[slot4].desc, slot3.param[1])
end

function slot0.Dispose(slot0)
	uv0 = nil
end

return slot0
