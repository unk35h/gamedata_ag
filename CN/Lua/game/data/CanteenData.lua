slot0 = import("game.dorm.DormEnum")
slot1 = singletonClass("CanteenData")
slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10, slot11, slot12, slot13, slot14, slot15 = nil
slot16 = DormConst.CANTEEN_ID
slot17, slot18 = nil

function slot1.Ctor(slot0)
	slot0.eventListener = EventListener.New()
end

function slot1.RegisterEvent(slot0)
	slot0.eventListener:Register(CANTEEN_DISPATCH_REWARD_SUCCESS, handler(slot0, slot0.CacheEntrustAward))
end

function slot1.RemoveEvent(slot0)
	slot0.eventListener:RemoveAll()
end

function slot1.UpdataTimer(slot0)
	if slot0.updateEntrustTimer == nil then
		slot0.updateEntrustTimer = Timer.New(handler(slot0, slot0.UpdataEntrustData), 1, -1)
	end

	slot0.updateEntrustTimer:Start()
end

function slot1.InitCanteenInfo(slot0, slot1)
	uv0 = {}
	uv1 = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot6.id

		for slot11, slot12 in ipairs(slot6.entrust) do
			slot13 = {
				pos = slot12.pos,
				id = slot12.id,
				hero_list = {}
			}

			for slot17, slot18 in ipairs(slot12.hero_list) do
				table.insert(slot13.hero_list, slot18)
			end

			slot13.tags = {}

			for slot17, slot18 in ipairs(slot12.tags) do
				table.insert(slot13.tags, {
					type = slot18.type,
					tag = slot18.tag
				})
			end

			slot13.num_max = slot12.num_max
			slot13.refresh_times = slot12.refresh_times
			slot13.start_time = slot12.start_time
			uv0[slot12.pos] = slot13
		end

		for slot12 = 1, #GameSetting.dorm_canteen_task_unlock.value do
			if not uv0[slot12] then
				uv0[slot12] = {
					id = -1,
					pos = slot12
				}
			end
		end

		uv1[slot7] = {}

		for slot12, slot13 in ipairs(slot6.signature_dish) do
			uv1[slot7][slot13.food_id] = {
				sellNum = slot13.sell_num,
				soldNum = slot13.sold_num,
				soldIncome = slot13.sell_earnings
			}
		end

		DormData:InitCanteenHeroState(slot6.careers)
	end
end

function slot1.InitCanteenMapData(slot0, slot1)
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = {}
	uv4 = {}
	uv5 = {}

	for slot5, slot6 in ipairs(slot1.canteens) do
		slot7 = slot6.id
		slot8 = BackHomeCfg[slot6.id]

		for slot12, slot13 in ipairs(slot6.entrust) do
			slot14 = {
				pos = slot13.pos,
				id = slot13.id,
				hero_list = {}
			}

			for slot18, slot19 in ipairs(slot13.hero_list) do
				table.insert(slot14.hero_list, slot19)
			end

			slot14.tags = {}

			for slot18, slot19 in ipairs(slot13.tags) do
				table.insert(slot14.tags, {
					type = slot19.type,
					tag = slot19.tag
				})
			end

			slot14.num_max = slot13.num_max
			slot14.refresh_times = slot13.refresh_times
			slot14.start_time = slot13.start_time
			uv4[slot13.pos] = slot14
		end

		for slot13 = 1, #GameSetting.dorm_canteen_task_unlock.value do
			if not uv4[slot13] then
				uv4[slot13] = {
					id = -1,
					pos = slot13
				}
			end
		end

		uv5[slot7] = {}

		for slot13, slot14 in ipairs(slot6.signature_dish) do
			uv5[slot7][slot14.food_id] = {
				sellNum = slot14.sell_num,
				soldNum = slot14.sold_num,
				soldIncome = slot14.sell_earnings
			}
		end

		DormData:InitCanteenHeroState(slot6.careers)

		uv1[slot7] = {
			totalEar = slot6.accruing_earnings or 0,
			earnings = slot6.business.earnings or 0,
			last_earnings_update_time = slot6.business.last_earnings_update_time or manager.time:GetServerTime(),
			last_receive_earnings_time = slot6.business.last_receive_earnings_time or manager.time:GetServerTime()
		}
		uv3[slot7] = {}
		uv3[slot7] = {
			eventID = slot6.special_event.event_id,
			startTime = slot6.special_event.start_time
		}
		uv0[slot6.id] = {
			roomInfo = RoomInfo.New()
		}
		uv0[slot6.id].roomInfo.id = slot6.id
		uv0[slot6.id].roomInfo.sceneName = slot8.scene
		uv0[slot6.id].roomInfo.furnitureInfoS = {}
		uv2[slot7] = {
			Popularity = {
				dynamicNum = slot6.attractive.dynamic or 0,
				updataTime = slot6.attractive.dynamic_update_time
			}
		}
	end

	slot0:InitExtendCanteenInfo()

	uv6 = manager.time:GetServerTime()

	SDKTools.SendMessageToSDK("backhome_dorm_opt", {
		backhome_type = 1,
		opt_time = -1
	})
end

function slot1.InitExtendCanteenInfo(slot0)
	uv0 = uv1.RestaurantMode.Close
	uv2 = {}
	uv3 = {
		manualGenCusNum = 0,
		manualSerCusNum = 0,
		ManualTotalIncome = 0,
		manualSettlementList = {}
	}
	uv4 = false

	slot0:RegisterEvent()
	slot0:UpdataEntrustData()
	slot0:RefreshCanOrderFoodList()
	slot0:InitPopularity(uv5[uv6])
	DormSkillData:Init()
end

function slot1.GetCanteenSceneData(slot0)
	if uv0[uv1] then
		return uv0[uv1]
	end
end

function slot1.PushFoodToSignList(slot0, slot1, slot2)
	if uv0[uv1] then
		uv0[uv1][slot1] = {}
		uv0[uv1][slot1] = {
			soldNum = 0,
			sellNum = slot2
		}
	end
end

function slot1.RemoveChooseFoodList(slot0, slot1)
	if uv0[uv1] then
		if uv0[uv1][slot1] then
			uv0[uv1][slot1] = nil
		else
			print("食物数据未找到")
		end
	end
end

function slot1.GetChooseFoodList(slot0)
	slot1 = {}

	if uv0[uv1] then
		slot5 = uv1

		for slot5, slot6 in pairs(uv0[slot5]) do
			table.insert(slot1, slot5)
		end
	end

	return slot1
end

function slot1.GetSignFoodInfo(slot0, slot1)
	if uv0[uv1][slot1] then
		return uv0[uv1][slot1]
	end

	print("未找到对应招牌菜信息")
end

function slot1.ReviseSignFoodInfo(slot0, slot1)
	if uv0[uv1][slot1.food_id] then
		uv0[uv1][slot1.food_id] = {}
	end

	uv0[uv1][slot1.food_id].sellNum = slot1.sell_num
	uv0[uv1][slot1.food_id].soldNum = slot1.sold_num
	uv0[uv1][slot1.food_id].soldIncome = slot1.sell_earnings

	if slot1.sell_num == slot1.sold_num then
		slot0:RefreshCanOrderFoodList()
	end
end

function slot1.CheckIsSignFood(slot0, slot1)
	slot5 = uv1

	for slot5, slot6 in pairs(uv0[slot5]) do
		if slot1 == slot5 then
			return true
		end
	end

	return false
end

function slot1.InitFurnitureLevel(slot0, slot1)
	uv0 = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			uv0[slot6.uid] = {
				level = slot6.level or 1,
				cfgID = BackHomeCanteenFurnitureIDCfg[slot6.uid].type_id,
				stringEid = BackHomeCanteenFurnitureIDCfg[slot6.uid].type_id,
				unLock = BackHomeCanteenFurnitureIDCfg[slot6.uid].unLock
			}
		end
	end

	DormSkillData:CalInComeStorageMaxNum()
	DormSkillData:CalCanSignFoodNum()
end

function slot1.GetFurnitureLevel(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].level
	else
		return 0
	end
end

function slot1.FurLevelUpCallBack(slot0, slot1)
	if not uv0[slot1] then
		uv0[slot1] = {
			level = 0
		}
	end

	for slot7, slot8 in ipairs(BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[slot1].type_id].cost_material[uv0[slot1].level + 1]) do
		CurrencyData:CurrencyModify(slot8[1], -slot8[2])
	end

	if BackHomeCanteenFurnitureCfg[slot2].skill[uv0[slot1].level] then
		for slot8, slot9 in ipairs(slot4) do
			if DormSkillData:CheckSkillIsRun(slot1, slot9, uv1.EntityType.Furniture) then
				DormSkillData:DisposeSkillComponent(slot1, slot9, uv1.EntityType.Furniture)
			end
		end
	end

	uv0[slot1].level = uv0[slot1].level + 1

	if BackHomeCanteenFurnitureCfg[slot2].skill[uv0[slot1].level] then
		for slot9, slot10 in ipairs(slot5) do
			if DormSkillData:CheckSkillIsOpen(slot1, slot10, uv1.EntityType.Furniture) then
				DormSkillData:AddSkillComponent(slot1, slot10, uv1.EntityType.Furniture)
			end
		end
	end
end

function slot1.GetFurInfoList(slot0)
	if uv0 then
		return uv0
	else
		print("家具信息不存在")
	end
end

function slot1.RefreshAutoAwardInfo(slot0, slot1)
	if not uv0 then
		uv0 = {
			[uv1] = {}
		}
	end

	uv0[uv1].earnings = slot1.earnings
	uv0[uv1].last_earnings_update_time = slot1.last_earnings_update_time
end

function slot1.InitCanteenIngredient(slot0, slot1)
	uv0 = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			uv0[slot6.id] = slot6.num
		end
	end
end

function slot1.GetCateenIngredient(slot0)
	if uv0 then
		return uv0
	end
end

function slot1.ReduceFoodIngredients(slot0, slot1, slot2)
	uv0[slot1] = uv0[slot1] - slot2

	if uv0[slot1] < 0 then
		uv0[slot1] = 0

		print("食材减少数量不正确")
	end

	CanteenData:OnIngredientChange()
end

function slot1.AddFoodIngredients(slot0, slot1, slot2, slot3)
	if not uv0[slot1] then
		uv0[slot1] = 0
	end

	if slot2 then
		uv0[slot1] = uv0[slot1] + slot2
	end

	if slot3 then
		uv0[slot1] = uv0[slot1] + slot3
	end

	CanteenData:OnIngredientChange()
end

function slot1.GetHadIngredientNum(slot0, slot1)
	return uv0[slot1] or 0
end

function slot1.GetCateenIngredientNum(slot0, slot1)
	slot2 = 0

	if uv0[slot1] then
		slot2 = uv0[slot1]
		slot6 = uv2

		for slot6, slot7 in pairs(uv1[slot6]) do
			for slot12, slot13 in ipairs(BackHomeCanteenFoodCfg[slot6].ingredient_list) do
				if slot13[1] == slot1 then
					slot2 = slot2 - (slot7.sellNum - slot7.soldNum) * slot13[2]
				end
			end
		end
	end

	if slot2 < 0 then
		slot2 = 0
	end

	return slot2
end

function slot1.NoEntrustDispatched()
	for slot3, slot4 in pairs(uv0) do
		if uv1:IsEntrustStarted(slot4) then
			return false
		end
	end

	return true
end

function slot1.AnyEntrustFinished()
	for slot3, slot4 in pairs(uv0) do
		if uv1:IsEntrustStarted(slot4) and DormTools:CalcEntrustLastTime(slot4) == 0 then
			return true
		end
	end

	return false
end

function slot1.IsEntrustStarted(slot0, slot1)
	return slot1.id ~= -1 and slot1.start_time and slot1.start_time > 0
end

function slot1.SetCanteenState(slot0, slot1)
	if slot1 == uv0 then
		return
	end

	if slot1 == uv1.RestaurantMode.RestaurantManual then
		CanteenAction:ChangeCanteenMode(uv2, slot1)
	else
		slot0:ChangeCanteenStateSusscee(slot1)
	end
end

function slot1.UnUsualExitManualMode(slot0)
	CanteenAction:ChangeCanteenMode(uv0, uv1.RestaurantMode.RestaurantAuto)
end

function slot1.ChangeCanteenStateSusscee(slot0, slot1)
	slot2 = uv0
	uv0 = slot1

	if slot1 == uv1.RestaurantMode.RestaurantAuto then
		if slot2 == uv1.RestaurantMode.Start or uv2 == false then
			manager.notify:Invoke(DORM_RESTAURANT_START_AUTO)

			uv2 = true

			CanteenData:SwitchCanteenBgm(uv1.RestaurantMode.RestaurantAuto)
		end

		if slot2 == uv1.RestaurantMode.RestaurantManual then
			manager.notify:Invoke(DORM_RESTAURANT_START_AUTO)

			uv2 = true

			CharacterBubbleManager:Dispose()
			CanteenData:FinManualSettlementList()
			DormLuaBridge.ChangeRoomState(false)
			CanteenData:SwitchCanteenBgm(uv1.RestaurantMode.RestaurantAuto)
		end
	elseif slot1 == uv1.RestaurantMode.RestaurantManual then
		manager.notify:Invoke(DORM_RESTAURANT_START_MANUAL)
		JumpTools.OpenPageByJump("dormPlayerControlView")
		CanteenData:SwitchCanteenBgm(uv1.RestaurantMode.RestaurantManual)
		DormLuaBridge.ChangeRoomState(true)
	end

	manager.notify:Invoke(DORM_REFRESH_RESTAURANT_STATUS_EVENT, slot1, slot2)
end

function slot1.GetCanteenState(slot0)
	return uv0
end

function slot1.EntrustEndDeductFatigue(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot8 = 0

		if uv0[slot6].hero_list then
			for slot12, slot13 in ipairs(slot7) do
				slot8 = slot8 + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustTotalFatigueReduce, slot13)
			end

			if slot8 > 100 then
				slot8 = 100
			end
		end

		slot0:DeductFatigue(slot7, math.ceil(BackHomeCanteenTaskCfg[uv0[slot6].id].cost * (100 - slot8) / 100))
	end
end

function slot1.DeductFatigue(slot0, slot1, slot2)
	slot3 = math.floor(slot2 / #slot1)
	slot4 = slot2 % #slot1
	slot8 = {
		ascend = true,
		map = slot9
	}

	function slot9(slot0)
		return DormData:GetHeroFatigue(slot0)
	end

	CommonTools.UniversalSortEx(slot1, slot8)

	for slot8, slot9 in ipairs(slot1) do
		if DormData:GetHeroFatigue(slot9) < slot3 then
			slot4 = slot4 + slot3 - slot10

			DormData:SetHeroFatigue(slot9, 0)
		else
			slot11 = slot10 - slot3

			if slot4 > 0 then
				if slot4 <= slot11 then
					DormData:SetHeroFatigue(slot9, slot11 - slot4)

					slot4 = 0
				else
					slot4 = slot4 - slot11

					DormData:SetHeroFatigue(slot9, 0)
				end
			else
				DormData:SetHeroFatigue(slot9, slot11)
			end
		end

		DormData:GetHeroTemplateInfo(slot9):BackToDorm()
	end
end

function slot1.AddFatigue(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		DormData:GetHeroTemplateInfo(slot7):CalFatigue(slot2)
	end
end

function slot1.GetCurEarning(slot0)
	return uv0[uv1].totalEar
end

function slot1.CalculateCanteenLevelUP(slot0, slot1, slot2)
	slot3 = {}

	for slot7 = slot1, slot2 - 1 do
		for slot11, slot12 in ipairs(BackHomeFestivalCanteenLevel[slot7].gift) do
			if slot3[slot12[1]] == nil then
				slot3[slot12[1]] = 0
			end

			slot3[slot12[1]] = slot3[slot12[1]] + slot12[2]
		end
	end

	slot4 = {}

	for slot8, slot9 in pairs(slot3) do
		table.insert(slot4, {
			slot8,
			slot9
		})
	end

	return slot4
end

function slot1.RecordCookFood(slot0, slot1, slot2)
	slot3 = CanteenAIFunction:GetEntityData(slot2)
	slot4 = slot3.cfgID
	slot5 = slot3.quality

	if uv0.manualSettlementList[slot1] == nil then
		uv0.manualSettlementList[slot1] = {}
	end

	uv0.manualSettlementList[slot1].food_id = slot4
	uv0.manualSettlementList[slot1].quality = slot5
	uv0.manualSettlementList[slot1].guest_uid = 0
	uv0.manualSettlementList[slot1].guest_id = 0
	uv0.manualSettlementList[slot1].special_event = 0
	uv0.manualSettlementList[slot1].evaluate = 0

	if not uv1 then
		uv1 = {}
	end

	if not uv1[slot4] then
		uv1[slot4] = 0
	end

	uv1[slot4] = uv1[slot4] + 1

	slot0:RefreshCanOrderFoodList()
end

function slot1.RecordFoodDelivery(slot0, slot1, slot2, slot3)
	if uv0.manualSettlementList[slot1] == nil then
		uv0.manualSettlementList[slot1] = {}
	end

	uv0.manualSettlementList[slot1].guest_uid = slot2
	uv0.manualSettlementList[slot1].guest_id = slot3
end

function slot1.RecordFoodQuality(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		uv0.manualSettlementList[CanteenAIFunction:GetFoodManualIndex(slot7)].evaluate = slot2
	end
end

function slot1.GetSignFoodCanCookNum(slot0, slot1)
	if not uv0 then
		uv0 = {}
	end

	if uv1[uv2][slot1].sellNum - uv1[uv2][slot1].soldNum - (uv0[slot1] or 0) < 0 then
		print("计算数量错误")

		slot4 = 0
	end

	return slot4
end

function slot1.RecordManualGenCustomerNum(slot0, slot1)
	uv0.manualGenCusNum = uv0.manualGenCusNum + slot1
end

function slot1.GetGenCusNum(slot0)
	return uv0.manualGenCusNum
end

function slot1.RecordManualSerCustomerNum(slot0, slot1)
	uv0.manualSerCusNum = uv0.manualSerCusNum + slot1
end

function slot1.GetSerCustomerNum(slot0)
	return uv0.manualSerCusNum
end

function slot1.GetManualSettlementList(slot0)
	return uv0.manualSettlementList
end

function slot1.FinManualSettlementList(slot0)
	CanteenAction:CanteenManualSettlement(uv0, uv1.manualSettlementList)
end

function slot1.MostPopFoodIdAndNum(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0.manualSettlementList) do
		slot1[slot7] = slot1[slot6.food_id] or 0
		slot1[slot7] = slot1[slot7] + 1
	end

	slot2 = 0
	slot3 = nil

	for slot7, slot8 in pairs(slot1) do
		if slot2 < slot8 then
			slot3 = slot7
			slot2 = slot8
		end
	end

	slot4 = nil

	if slot3 then
		return BackHomeCanteenFoodCfg[slot3].name, slot2
	end

	return "", -1
end

function slot1.AddTotalIncome(slot0, slot1, slot2)
	if slot2 == nil then
		error("评级为空")
	end

	slot3 = 0

	for slot7, slot8 in ipairs(slot1) do
		slot3 = slot3 + BackHomeCanteenFoodCfg[CanteenAIFunction:GetEntityData(slot8).cfgID].sell
	end

	uv0.ManualTotalIncome = uv0.ManualTotalIncome + slot3 * GameSetting.canteen_customer_evaluation.value[slot2][2] / 100
end

function slot1.ManualConsumeMaterial(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0.manualSettlementList) do
		if slot6 then
			for slot12, slot13 in ipairs(BackHomeCanteenFoodCfg[slot6.food_id].ingredient_list) do
				slot1[slot13[1]] = slot1[slot13[1]] or 0
				slot1[slot13[1]] = slot1[slot13[1]] + slot13[2]
			end
		end
	end

	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		table.insert(slot2, {
			slot6,
			slot7
		})
	end

	return slot2
end

function slot1.CalculateRemainPopularity(slot0)
	return math.floor(uv0[uv1].manualNum * GameSetting.canteen_hot_hold.value[1] / 100)
end

function slot1.GetTotalIncome(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0.manualSettlementList) do
		if not slot1[BackHomeCanteenFoodCfg[slot6.food_id].cook_type] then
			slot1[slot8] = 0
		end

		slot1[slot8] = slot1[slot8] + BackHomeCanteenFoodCfg[slot7].sell * GameSetting.canteen_customer_evaluation.value[slot6.quality][2] / 100
	end

	slot2 = 0

	for slot6, slot7 in pairs(slot1) do
		slot2 = slot2 + (DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FoodCostRise, nil, , slot6) + 100) / 100 * slot7
	end

	uv0.ManualTotalIncome = math.floor(slot2)

	return uv0.ManualTotalIncome
end

function slot1.ClearManualData(slot0)
	slot1 = slot0:GetTotalIncome()

	for slot6, slot7 in pairs(slot0:ManualConsumeMaterial()) do
		uv0[slot7[1]] = uv0[slot7[1]] - slot7[2]

		if uv0[slot7[1]] < 0 then
			uv0[slot7[1]] = 0

			print("剩余食材数量错误")
		end
	end

	uv1[uv2].dynamicNum = uv1[uv2].dynamicNum + slot0:CalculateRemainPopularity()

	if uv1[uv2].dynamicNum < 0 then
		uv1[uv2].dynamicNum = 0
	end

	if uv3 then
		for slot6, slot7 in pairs(uv3) do
			uv4[uv2][slot6].soldNum = uv4[uv2][slot6].soldNum + slot7
			uv4[uv2][slot6].soldIncome = uv4[uv2][slot6].soldIncome + slot0:GetFoodUnitCost(slot6) * slot7
		end
	end

	slot0:ReceiveCurPenEarSuccess(slot1, uv5.RestaurantMode.RestaurantManual)
	slot0:ClearManualPopular()
end

function slot1.ClearAllManualData(slot0)
	uv0 = {
		manualGenCusNum = 0,
		manualSerCusNum = 0,
		ManualTotalIncome = 0,
		manualSettlementList = {}
	}
	uv1 = nil

	manager.notify:Invoke(CANTEEN_MANUAL_FINISH)
end

function slot1.InitPopularity(slot0, slot1)
	slot2 = 0
	slot3 = GameSetting.canteen_hot_reduce.value[1]

	if slot1.Popularity.updataTime == 0 or not slot1.Popularity.updataTime then
		slot1.Popularity.updataTime = manager.time:GetServerTime()
	end

	slot4 = manager.time:GetServerTime() - slot1.Popularity.updataTime
	slot6 = slot4 % GameSetting.canteen_hot_reduce.value[2]
	slot1.Popularity.updataTime = slot1.Popularity.updataTime + math.modf(slot4 / GameSetting.canteen_hot_reduce.value[2]) * slot3

	if slot1.Popularity.dynamicNum > 0 then
		slot2 = math.max(0, slot1.Popularity.dynamicNum - slot5 * slot3)
	end

	slot1.buffList = {}
	slot1.hightPopularityNum = 0
	slot1.dynamicNum = slot2
	slot1.basePopualrityNum = 0
	slot1.remainTime = slot6
	slot1.manualNum = 0

	if slot0.startHotTimer == nil then
		slot0.startHotTimer = Timer.New(function ()
			uv0.UpdataDynmicPopularity()

			uv0.updataHotTimer = Timer.New(handler(uv0, uv0.UpdataDynmicPopularity), GameSetting.canteen_hot_reduce.value[2], -1)

			uv0.updataHotTimer:Start()
		end, uv0[uv1].remainTime, 1)
	end

	slot0.startHotTimer:Start()
end

function slot1.GetPopularInfo(slot0)
	return uv0[uv1]
end

function slot1.ClearManualPopular(slot0)
	uv0[uv1].manualNum = 0

	manager.notify:Invoke(DORM_REFRESH_POPULAR_EVENT)
end

function slot1.GetPopularityNum(slot0)
	uv0[uv1].basePopualrityNum = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.PopularRise)

	return uv0[uv1].dynamicNum + uv0[uv1].basePopualrityNum + uv0[uv1].manualNum
end

function slot1.GetHighPopularityNum(slot0)
	return uv0[uv1].hightPopularityNum
end

function slot1.AddPopularityNum(slot0, slot1)
	uv0[uv1].manualNum = uv0[uv1].manualNum + GameSetting.canteen_hot_increase.value[slot1][2]
	slot3 = uv0[uv1].dynamicNum + uv0[uv1].basePopualrityNum

	if uv0[uv1].manualNum + uv0[uv1].dynamicNum < 0 then
		if uv0[uv1].dynamicNum == 0 then
			uv0[uv1].manualNum = 0
		else
			uv0[uv1].manualNum = -uv0[uv1].dynamicNum
		end
	end

	if uv0[uv1].hightPopularityNum < slot3 + uv0[uv1].manualNum then
		uv0[uv1].hightPopularityNum = slot3 + uv0[uv1].manualNum
	end

	manager.notify:Invoke(DORM_REFRESH_POPULAR_EVENT)
end

function slot1.UpdataDynmicPopularity(slot0)
	uv0[uv1].dynamicNum = math.max(uv0[uv1].dynamicNum - GameSetting.canteen_hot_reduce.value[1], 0)
	uv0[uv1].Popularity.updataTime = manager.time:GetServerTime()

	manager.notify:Invoke(DORM_REFRESH_POPULAR_EVENT)
end

function slot1.GetEntrustList(slot0)
	return uv0
end

function slot1.GetEntrustByPos(slot0, slot1)
	return uv0[slot1]
end

function slot1.RefreshSingleEntrust(slot0, slot1)
	if slot1 then
		uv0[slot1.pos] = slot1
	end
end

function slot1.GetEntrustLastTime(slot0, slot1)
	if uv0[slot1] and uv1:IsEntrustStarted(slot2) then
		return DormTools:CalcEntrustLastTime(slot2)
	end
end

function slot1.UpdataEntrustData(slot0)
	slot1 = false

	for slot5, slot6 in pairs(uv0) do
		if slot6.hero_list and #slot6.hero_list > 0 then
			slot0:GetEntrustLastTime(slot5)

			if slot6.lastTime == 0 then
				slot1 = true
			end
		end
	end

	slot0:Notify(RedPointConst.CANTEEN_DISPATCH_FINISHED, slot1)
end

function slot1.CheckHasTimeOverEntrust(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if slot6.id > 0 and #slot6.hero_list > 0 and slot6.lastTime == 0 then
			table.insert(slot1, slot5)
		end
	end

	return slot1
end

slot19 = nil

function slot1.GetDispatchCharacterList(slot0)
	if not uv0 then
		uv0 = {}
	end

	return uv0
end

function slot1.ClearDispatchCharacterList(slot0)
	uv0 = {}
end

slot20 = nil

function slot1.SetCurDispatchTask(slot0, slot1, slot2)
	if not uv0 then
		uv0 = {}
	end

	uv0.id = slot1
	uv0.pos = slot2
end

function slot1.SetDispatchCharacterList(slot0, slot1)
	slot2 = BackHomeCanteenTaskCfg[uv0.id].need[2]

	if not uv1 then
		uv1 = {}
	end

	if slot2 >= #uv1 then
		table.insert(uv1, slot1)
	else
		error("选人列表已满")
	end
end

function slot1.RemoveDispatchCharacterList(slot0, slot1)
	if uv0 then
		for slot5 = 1, #uv0 do
			if uv0[slot5] == slot1 then
				table.remove(uv0, slot5)

				return
			end
		end

		error("没找到需要去处的选择角色")
	end
end

function slot1.CheckDispatchCharacterList(slot0, slot1)
	if uv0 then
		for slot5, slot6 in ipairs(uv0) do
			if slot6 == slot1 then
				return true
			end
		end

		return false
	end
end

function slot1.CheckDispatchCharacterArchiveList(slot0, slot1)
	slot2 = HeroRecordCfg.get_id_list_by_hero_id[slot1][1]

	if uv0 then
		for slot6, slot7 in ipairs(uv0) do
			if HeroRecordCfg.get_id_list_by_hero_id[slot7][1] == slot2 then
				return true
			end
		end

		return false
	end
end

function slot1.ConfirmEntrustList(slot0)
	CanteenAction:SendTaskDispatchInfo(DormData:GetCurrectSceneID(), uv0.pos, uv1)
end

function slot1.CancelEntrust(slot0, slot1)
	CanteenAction:SendTaskDispatchInfo(DormData:GetCurrectSceneID(), slot1, nil)
end

function slot1.ConfirmEntrustListCallBack(slot0, slot1)
	if slot1.hero_list ~= nil then
		for slot5, slot6 in ipairs(slot1.hero_list) do
			table.insert(uv0[slot1.pos].hero_list, slot6)

			slot7 = DormData:GetHeroTemplateInfo(slot6)

			slot7:SetCurHeroID(slot6)
			slot7:GoToCanteen()
		end

		uv0[slot1.pos].start_time = manager.time:GetServerTime()
	else
		slot5 = slot1.pos

		for slot5, slot6 in ipairs(uv0[slot5].hero_list) do
			slot7 = DormData:GetHeroTemplateInfo(slot6)

			slot7:SetCurHeroID(slot6)
			slot7:BackToDorm()
		end

		uv0[slot1.pos].hero_list = {}
		uv0[slot1.pos].start_time = nil
	end

	manager.notify:Invoke(CANTEEN_DISPATCH_ENTRUST_SUCCESS, slot1.pos)

	uv1 = {}
	uv2 = {}
end

function slot1.CheckHasChooseEntrustCharacter(slot0, slot1)
	slot2 = HeroRecordCfg.get_id_list_by_hero_id[slot1][1]

	for slot6, slot7 in pairs(uv0) do
		if slot7.hero_list then
			for slot11, slot12 in ipairs(slot7.hero_list) do
				if slot2 == HeroRecordCfg.get_id_list_by_hero_id[slot12][1] then
					return true
				end
			end
		end
	end

	return false
end

function slot1.GetCurDispatchTask(slot0)
	return uv0
end

function slot1.CalculateEntrustSuccess(slot0)
	if #uv0 == 0 then
		return 0
	end

	slot1 = uv1[uv2.pos].tags
	slot2 = 0

	for slot6, slot7 in ipairs(uv0) do
		slot2 = slot2 + slot0:CalHeroMatchNum(slot7, slot1)
	end

	slot3 = BackHomeCanteenTaskCfg[uv2.id].base_success
	slot4 = slot2 * BackHomeCanteenTaskCfg[uv2.id].tag_success

	for slot8, slot9 in ipairs(uv0) do
		slot4 = slot4 + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustExternSucceedAdd, slot9)
	end

	if slot3 + slot4 > 100 then
		slot5 = 100
	end

	return slot5
end

function slot1.CalHeroMatchNum(slot0, slot1, slot2)
	slot3 = 0

	for slot7, slot8 in ipairs(slot2) do
		if slot8.type == 1 then
			if CharactorParamCfg[slot1].RangeType == slot8.tag then
				slot3 = slot3 + 1
			end
		elseif slot9 == 2 then
			if HeroCfg[slot1].race == slot8.tag then
				slot3 = slot3 + 1
			end
		elseif slot9 == 3 then
			if HeroCfg[slot1].ATK_attribute[1] == slot8.tag then
				slot3 = slot3 + 1
			end
		elseif slot9 == 4 and HeroCfg[slot1].mechanism_type[1] == slot8.tag then
			slot3 = slot3 + 1
		end
	end

	return slot3
end

function slot1.RemoveCurEntrustCharacterList(slot0)
	uv0 = {}
end

function slot1.RefreshEntrustData(slot0, slot1)
	if DormConst.DISPATCH_REFRESH_TIME <= uv0[slot1].refresh_times then
		return
	end

	CanteenAction:RefreshEntrust(DormData:GetCurrectSceneID(), slot1)
end

function slot1.ReceiveEntrustAward(slot0, slot1)
	CanteenAction:ReceiveEntrustAward(DormData:GetCurrectSceneID(), slot1)
end

function slot1.CacheEntrustAward(slot0, slot1, slot2)
	if not uv0 then
		uv0 = {}
	end

	for slot6, slot7 in ipairs(slot2) do
		slot9 = uv1[slot7.pos]
		slot9.extra_reward = slot7.extra_reward

		table.insert(uv0, slot9)
	end

	manager.notify:Invoke(CANTEEN_DISPATCH_REWARD_VIEW)
	slot0:ConsumeNotification(RedPointConst.CANTEEN_DISPATCH_FINISHED)
end

function slot1.GetEntrustAwardCache(slot0)
	return uv0
end

function slot1.GetEntrustAwardCacheByPos(slot0, slot1)
	for slot5, slot6 in ipairs(uv0) do
		if slot6.pos == slot1 then
			return slot6
		end
	end
end

function slot1.ClearCacheEntrustAward(slot0)
	uv0 = nil
end

slot21 = nil

function slot1.CookFoodComplete(slot0, slot1, slot2, slot3, slot4, slot5)
	CanteenAIFunction:GetEntityData(slot3).curCooking = {
		cfgID = slot4,
		taste = slot5,
		quality = slot2
	}

	if not uv0 then
		uv0 = {}
	end

	if not uv0[slot4] then
		uv0[slot4] = 0
	end

	uv0[slot4] = uv0[slot4] + 1
end

slot1.COOK_FOOD_CANCELED = false

function slot1.CookFoodCanceled(slot0, slot1, slot2)
	CanteenAIFunction:GetEntityData(slot2).curCooking = slot0.COOK_FOOD_CANCELED
end

function slot1.InitFoodProficiency(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.id] = slot0:InitFoodData(slot6.id)
		uv0[slot6.id].proficiency = slot6.proficiency
		uv0[slot6.id].hasCookNum = slot6.num
	end

	for slot5, slot6 in ipairs(BackHomeCanteenFoodCfg.all) do
		if not uv0[slot6] then
			uv0[slot6] = slot0:InitFoodData(slot6)
		end
	end
end

function slot1.GetFoodInfo(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1]
	else
		uv0[slot1] = slot0:InitFoodData(slot1)
	end

	print("未找到食物详情")
end

function slot1.InitFoodData(slot0, slot1)
	return {
		incomeRate = 100,
		consumptionRate = 100,
		hasCookNum = 0,
		proficiency = 0,
		foodCfgID = slot1,
		foodType = BackHomeCanteenFoodCfg[slot1].cook_type,
		buffList = {}
	}
end

function slot1.GetFoodProficiencyList(slot0)
	return uv0
end

function slot1.GetFoodProficiencyByType(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0) do
		if slot7.foodType == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot1.GetFoodProficiency(slot0, slot1)
	if not uv0[slot1] then
		uv0[slot1] = slot0:InitFoodData(slot1)
	end

	return uv0[slot1].proficiency
end

function slot1.GetFoodCookNum(slot0, slot1)
	if not uv0[slot1] then
		uv0[slot1] = slot0:InitFoodData(slot1)
	end

	return uv0[slot1].hasCookNum
end

function slot1.GetFoodTypeCookNum(slot0, slot1)
	slot2 = 0

	if uv0 then
		for slot6, slot7 in pairs(uv0) do
			if BackHomeCanteenFoodCfg[slot6].cook_type == slot1 then
				slot2 = slot2 + slot7.hasCookNum
			end
		end
	end

	return slot2
end

function slot1.AddFoodProficiency(slot0, slot1, slot2)
	slot4 = 0

	for slot8, slot9 in ipairs(GameSetting.canteen_cook_mastery.value) do
		if slot9[1] == slot2 then
			slot4 = slot9[2]

			break
		end
	end

	uv0[slot1].proficiency = uv0[slot1].proficiency or 0
	uv0[slot1].proficiency = math.min(uv0[slot1].proficiency + slot4, GameSetting.canteen_cook_mastery_max.value[1])
end

function slot1.UpdataFoodProficiency(slot0, slot1)
	if not uv0 then
		uv0 = {}
	end

	if not uv0[slot1.id] then
		uv0[slot1.id] = {}
		uv0[slot1.id] = slot0:InitFoodData(slot1.id)
	end

	uv0[slot1.id].proficiency = slot1.proficiency
	uv0[slot1.id].num = slot1.num
end

slot22 = nil

function slot1.GetCanOrderFoodList(slot0)
	return uv0
end

function slot1.RefreshCanOrderFoodList(slot0)
	uv0 = {}

	if slot0:GetChooseFoodList() then
		for slot5, slot6 in pairs(slot1) do
			slot7 = slot0:GetSignFoodInfo(slot6)
			slot8 = 0

			if slot7.sellNum - slot7.soldNum - (not uv1 and 0 or uv1[slot6] or 0) > 0 then
				table.insert(uv0, slot6)
			end
		end
	end
end

function slot1.GetSignFoodTime(slot0, slot1)
	return math.ceil(BackHomeCanteenFoodCfg[slot1].cost_time * (uv0[uv1][slot1].sellNum - uv0[uv1][slot1].soldNum) * (100 - DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FoodCostQucik, nil, , BackHomeCanteenFoodCfg[slot1].cook_type)) / 100)
end

function slot1.GetFoodUnitCost(slot0, slot1)
	return math.floor(BackHomeCanteenFoodCfg[slot1].sell * (100 + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FoodCostRise, nil, , BackHomeCanteenFoodCfg[slot1].cook_type)) / 100)
end

function slot1.CalculateFoodCanCookNum(slot0, slot1)
	slot3 = 0

	if uv0:CheckIsSignFood(slot1) then
		slot3 = uv1[uv2][slot1].sellNum - uv1[uv2][slot1].soldNum
	elseif BackHomeCanteenFoodCfg[slot1].ingredient_list then
		slot5 = 100000

		for slot9, slot10 in pairs(slot4) do
			slot12 = slot10[2]
			slot13 = slot0:GetCateenIngredientNum(slot10[1]) or 0

			if uv3 then
				if slot13 < slot12 then
					return 0
				else
					slot5 = math.min(math.modf(slot13 / slot12), slot5)
				end
			end
		end

		if slot5 ~= 10000 then
			slot3 = slot5
		end
	end

	if slot3 >= 0 then
		return slot3
	else
		print("可制作数量错误")

		return 0
	end
end

function slot1.OnIngredientChange(slot0)
	if uv0 then
		slot0:RefreshCanOrderFoodList()
		manager.notify:Invoke(CANTEEN_INGREDIENTS_CHANGE)
		slot0:Notify(RedPointConst.CANTEEN_BUSINESS_STOPPED, #slot0:GetCanOrderFoodList() < DormConst.ORDER_FOOD_NUM)
	end
end

function slot1.CalculateCurLevelNum(slot0)
	slot2 = 0

	if slot0:CalculateCanteenLevel() < #BackHomeFestivalCanteenLevel.all then
		slot3 = 0

		if slot1 <= 1 then
			slot2 = uv0[uv1].totalEar
		else
			for slot7 = 1, slot1 - 1 do
				slot3 = BackHomeFestivalCanteenLevel[slot7].need + slot3
			end

			slot2 = uv0[uv1].totalEar - slot3
		end
	else
		slot2 = 0
	end

	return slot2
end

function slot1.GetAutoNextAwardTime(slot0)
	if uv0[uv1].last_receive_earnings_time + GameSetting.canteen_receive_time_interval.value[1] - manager.time:GetServerTime() > 0 then
		slot4 = math.modf(slot3 / 3600)

		return slot4, math.floor((slot3 - slot4 * 3600) / 60), (slot3 - slot4 * 3600) % 60
	else
		return -1, -1, -1
	end
end

function slot1.GetAutoAwardNum(slot0)
	if uv0[uv1].earnings then
		return uv0[uv1].earnings
	else
		print("自动收益数据不存在")
	end
end

function slot1.ReceiveCurPenEar(slot0)
	if uv0 then
		CanteenAction:ReceiveCanteenAutoAward(uv0)
	end
end

function slot1.ReceiveAutoEarSuccess(slot0, slot1)
	slot0:ReceiveCurPenEarSuccess(slot1, uv0.RestaurantMode.RestaurantAuto)
	manager.notify:Invoke(CANTEEN_AUTO_GET_AWARD_SUCCESS)
end

function slot1.ReceiveCurPenEarSuccess(slot0, slot1, slot2)
	slot0:ChangeCanteenCurrency(slot1)

	uv0[uv1].totalEar = uv0[uv1].totalEar + slot1

	if slot2 == uv2.RestaurantMode.RestaurantAuto then
		uv0[uv1].earnings = 0
		uv0[uv1].last_receive_earnings_time = manager.time:GetServerTime()
	elseif slot2 == uv2.RestaurantMode.RestaurantManual then
		slot0:ClearAllManualData()
	end
end

function slot1.SwitchCanteenBgm(slot0, slot1)
	if slot1 == uv0.RestaurantMode.Start then
		slot2 = MusicReference[1]

		manager.audio:PlayBGM(slot2.cuesheet, slot2.cueName, slot2.awbName)
	elseif slot1 == uv0.RestaurantMode.RestaurantAuto or slot1 == uv0.RestaurantMode.Close then
		slot2 = MusicReference[3]

		manager.audio:PlayBGM(slot2.cuesheet, slot2.cueName, slot2.awbName)
	elseif slot1 == uv0.RestaurantMode.RestaurantManual then
		slot2 = MusicReference[2]

		manager.audio:PlayBGM(slot2.cuesheet, slot2.cueName, slot2.awbName)
	end
end

function slot1.ChangeCanteenCurrency(slot0, slot1)
	CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_DORM_GOLD, slot1)
end

slot1.RedPointType = {
	Session = 1,
	LocalMachine = 2,
	Normal = 0
}

function slot1.SkipNotify(slot0, slot1)
	return RedPointData:GetSessionCacheRedPoint(slot1) == RedPointData.HasNotified or RedPointData:GetJsonCacheRedPoint(slot1) == RedPointData.HasNotified
end

function slot1.Notify(slot0, slot1, slot2)
	if ((slot2 == false or slot0:SkipNotify(slot1)) and 0 or 1) ~= manager.redPoint:getTipBoolean(slot1) then
		manager.redPoint:setTip(slot1, slot2)
	end
end

function slot1.ConsumeNotification(slot0, slot1, slot2)
	manager.redPoint:setTip(slot1, 0)

	if slot2 == uv0.RedPointType.Session and RedPointData:GetSessionCacheRedPoint(slot1) ~= 0 then
		RedPointData:SetSessionCacheRedPoint(slot1)
	elseif slot2 == uv0.RedPointType.LocalMachine and RedPointData:GetJsonCacheRedPoint(slot1) ~= 0 then
		RedPointData:SetJsonCacheRedPoint(slot1)
	end
end

function slot1.DisposeTimer(slot0)
	if slot0.updateEntrustTimer then
		slot0.updateEntrustTimer:Stop()

		slot0.updateEntrustTimer = nil
	end

	if slot0.updataHotTimer then
		slot0.updataHotTimer:Stop()

		slot0.updataHotTimer = nil
	end

	if slot0.fatigueStartTimer then
		slot0.fatigueStartTimer:Stop()

		slot0.fatigueStartTimer = nil
	end

	if slot0.fatigueTimer then
		slot0.fatigueTimer:Stop()

		slot0.fatigueTimer = nil
	end

	if slot0.startHotTimer then
		slot0.startHotTimer:Stop()

		slot0.startHotTimer = nil
	end
end

function slot1.CheckCanteenOpen(slot0)
	slot1 = false
	slot5 = uv1

	for slot5, slot6 in pairs(uv0[slot5]) do
		if slot6.soldNum < slot6.sellNum then
			slot1 = true

			break
		end
	end

	slot2 = true

	for slot6, slot7 in ipairs(DormConst.DORM_RESTAURANT_SET_JOB_TYPE) do
		if not DormData:HasJobAssignedToHero(slot7) then
			slot2 = false

			break
		end
	end

	return slot1 and slot2
end

function slot1.Dispose(slot0)
	slot0:RemoveEvent()
	slot0:DisposeTimer()

	uv0 = nil
	uv1 = nil
	uv2 = nil
	uv3 = nil
	uv4 = nil
	uv5 = nil

	DormSkillData:Dispose()

	uv6 = manager.time:GetServerTime()

	SDKTools.SendMessageToSDK("backhome_dorm_opt", {
		backhome_type = 1,
		opt_time = uv6 - uv7
	})

	uv7 = nil
	uv6 = nil
end

function slot1.UpdateCanteenNotify(slot0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		slot0:Notify(RedPointConst.CANTEEN_BUSINESS_STOPPED, not slot0:CheckCanteenOpen())
		slot0:Notify(RedPointConst.CANTEEN_DISPATCH_NONE, CanteenData.NoEntrustDispatched())
		slot0:Notify(RedPointConst.CANTEEN_DISPATCH_FINISHED, CanteenData.AnyEntrustFinished())
		slot0:Notify(RedPointConst.CANTEEN_JOB_AVAILABLE, CanteenTools:AnyJobAvailable())
	end
end

return slot1
