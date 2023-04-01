return {
	GetFoodSprite = function (slot0)
		return getSpriteWithoutAtlas(DormConst.CANTEEN_FOOD_PATH .. BackHomeCanteenFoodCfg[slot0].icon)
	end,
	GetCanteenSkillSprite = function (slot0)
		return getSpriteViaConfig("DormHeroSkill", BackHomeHeroSkillCfg[slot0].icon)
	end,
	GetCookCfgIDByType = function (slot0, slot1)
		slot2 = {}

		for slot6, slot7 in ipairs(BackHomeFurniture.all) do
			if BackHomeFurniture[slot7].type == slot1 then
				table.insert(slot2, slot7)
			end
		end

		return slot2
	end,
	CheckHeroConcertTag = function (slot0, slot1, slot2, slot3)
		if slot2 == 1 then
			if slot3 == CharactorParamCfg[slot1].RangeType then
				return true
			end
		elseif slot2 == 2 then
			if slot3 == HeroCfg[slot1].race then
				return true
			end
		elseif slot2 == 3 then
			if slot3 == HeroCfg[slot1].ATK_attribute[1] then
				return true
			end
		elseif slot2 == 4 and slot3 == HeroCfg[slot1].mechanism_type[1] then
			return true
		end

		return false
	end,
	CheckCanteenJobCanOpen = function (slot0)
		for slot5, slot6 in pairs(DormData:GetCanteenJobList()) do
			if not slot6.heroID then
				return false
			end

			slot9 = GameSetting.dorm_canteen_work_fatigue.value[1] / 100

			if DormData:GetHeroFatigue(slot6.heroID) < slot9 - slot9 % 0.1 then
				return false
			end
		end

		return true
	end,
	CheckFoodUnLock = function (slot0, slot1)
		if BackHomeCanteenFoodCfg[slot1].unlock ~= 0 then
			return slot0.CheckConditionAccord(slot0, slot2)
		end

		return true
	end,
	GetFoodUnLockLevel = function (slot0, slot1)
		if BackHomeCanteenFoodCfg[slot1].unlock ~= 0 then
			return ConditionCfg[slot2].params[2]
		else
			return 0
		end
	end,
	CheckConditionAccord = function (slot0, slot1)
		if ConditionCfg[slot1] then
			if slot2.type == CanteenConst.UnLockCon.CookLevel then
				if CanteenData:GetFurnitureLevel(slot2.params[1]) < slot2.params[2] then
					return false
				end

				return true
			elseif slot3 == CanteenConst.UnLockCon.TotleIncome then
				if CanteenData:GetCurEarning() < slot2.params[1] then
					return false
				end

				return true
			elseif slot3 == CanteenConst.UnLockCon.FoodProficiency then
				if CanteenData:GetFoodProficiency(slot2.params[1]) < slot2.params[1] then
					return false
				end

				return true
			elseif slot3 == CanteenConst.UnLockCon.FoodComplateNum then
				if CanteenData:GetFoodCookNum(slot2.params[1]) < slot2.params[2] then
					return false
				end

				return true
			elseif slot3 == CanteenConst.UnLockCon.FoodTypeComplateNum then
				if CanteenData:GetFoodTypeCookNum(slot2.params[1]) < slot2.params[2] then
					return false
				end

				return true
			elseif slot3 == CanteenConst.UnLockCon.RoomunLockNum then
				if DormitoryData:GetUnlockRoomNum() < slot2.params[1] then
					return false
				end

				return true
			end
		else
			print("不存在该解锁条件")
		end
	end,
	GetEIDByCookType = function (slot0, slot1)
		slot2 = nil

		for slot6, slot7 in ipairs(BackHomeFurniture.all) do
			if BackHomeFurniture[slot7].type == slot1 then
				for slot11, slot12 in ipairs(BackHomeCanteenFurnitureIDCfg.all) do
					if BackHomeCanteenFurnitureIDCfg[slot12].type_id == slot7 then
						slot2 = slot12
					end
				end
			end
		end

		if not slot2 then
			print("未找到厨具的EID")
		end

		return slot2
	end,
	GetCanteenEIDByFurCfgID = function (slot0, slot1)
		for slot5, slot6 in ipairs(BackHomeCanteenFurnitureIDCfg.all) do
			if BackHomeCanteenFurnitureIDCfg[slot6].type_id == slot1 then
				return slot6
			end
		end
	end,
	CheckFurCanLevelUp = function (slot0, slot1)
		if not BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[slot1].type_id].condition[CanteenData:GetFurnitureLevel(slot1) + 1] then
			return false
		end

		for slot8, slot9 in ipairs(slot4) do
			if ConditionCfg[slot9] and not CanteenTools:CheckConditionAccord(slot9) then
				return false
			end
		end

		if not BackHomeCanteenFurnitureCfg[slot2].cost_material[slot3 + 1] then
			return true
		end

		for slot9, slot10 in ipairs(slot5) do
			if CurrencyData:GetCurrencyNum(slot10[1]) < slot10[2] then
				return false
			end
		end

		return true
	end,
	CheckAllFurCanLevelUp = function (slot0)
		for slot5, slot6 in ipairs(BackHomeCanteenFurnitureIDCfg.all) do
			if slot0.CheckFurCanLevelUp(slot0, slot6) then
				return true
			end
		end

		return false
	end,
	GetJobNameByIndex = function (slot0, slot1)
		if slot1 == 1 then
			return GetTips("DORM_CANTEEN_COOK")
		elseif slot1 == 2 then
			return GetTips("DORM_CANTEEN_WAITER")
		elseif slot1 == 3 then
			return GetTips("DORM_CANTEEN_CASHIER")
		end
	end,
	GetConditionDes = function (slot0, slot1)
		if ConditionCfg[slot1] then
			if slot2.type == CanteenConst.UnLockCon.CookLevel then
				return string.format(slot2.desc, slot0.GetCookCfgNameByEid(slot0, slot2.params[1]), slot2.params[2])
			elseif slot3 == CanteenConst.UnLockCon.TotleIncome then
				return string.format(slot2.desc, CanteenData:GetCurEarning())
			elseif slot3 == CanteenConst.UnLockCon.FoodProficiency then
				slot4 = slot2.params[1]

				return string.format(slot2.desc, BackHomeCanteenFoodCfg[slot4].name, CanteenData:GetFoodProficiency(slot4))
			elseif slot3 == CanteenConst.UnLockCon.FoodComplateNum then
				slot4 = slot2.params[1]

				return string.format(slot2.desc, BackHomeCanteenFoodCfg[slot4].name, CanteenData:GetFoodCookNum(slot4))
			elseif slot3 == CanteenConst.UnLockCon.FoodTypeComplateNum then
				slot4 = slot2.params[1]

				return string.format(slot2.desc, slot0:GetCookCfgName(slot4), CanteenData:GetFoodTypeCookNum(slot4))
			elseif slot3 == CanteenConst.UnLockCon.RoomunLockNum then
				return slot2.desc
			end
		else
			print("不存在该解锁条件")
		end
	end,
	GetCookCfgName = function (slot0, slot1)
		for slot6, slot7 in ipairs(GameDisplayCfg.canteen_cooker_list.value) do
			if slot7[1] == slot1 then
				return slot7[2]
			end
		end
	end,
	GetCookCfgNameByEid = function (slot0, slot1)
		if BackHomeCanteenFurnitureIDCfg[slot1] then
			if BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[slot1].type_id].name then
				return slot3
			else
				print("未找到家具名字")
			end
		end
	end,
	GetJobName = function (slot0, slot1)
		if slot1 == 1 then
			return GetTips("DORM_CANTEEN_COOK")
		elseif slot1 == 2 then
			return GetTips("DORM_CANTEEN_WAITER")
		elseif slot1 == 3 then
			return GetTips("DORM_CANTEEN_CASHIER")
		end
	end,
	GetFurEidByType = function (slot0, slot1)
		for slot5, slot6 in ipairs(BackHomeFurniture.all) do
			if BackHomeFurniture[slot6].type == slot1 then
				for slot10, slot11 in ipairs(BackHomeCanteenFurnitureIDCfg.all) do
					if BackHomeCanteenFurnitureIDCfg[slot11].type_id == slot6 then
						return slot11
					end
				end
			end
		end
	end,
	AnyJobAvailable = function (slot0)
		for slot5, slot6 in pairs(DormData:GetCanteenJobList()) do
			if slot6.heroID == nil then
				return true
			end
		end

		return false
	end,
	AutoModeReadyForBusiness = function (slot0)
		return DormConst.ORDER_FOOD_AUTO_NUM <= #CanteenData:GetCanOrderFoodList() and slot0:CheckCanteenJobCanOpen()
	end
}
