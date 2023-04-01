slot0 = singletonClass("CanteenCharacterManager")

function slot1(slot0)
	return function (slot0)
		return "CharDorm/" .. nullable(uv0, nullable(slot0, "heroID"), "model")
	end
end

slot2 = slot1(BackHomeHeroCfg)
slot3 = slot1(BackHomeCustomerCfg)

function slot4(slot0)
	slot1 = CanteenManager.PosNamespace(slot0.jobID)

	return nullable(Dorm.storage:GetData(slot1, slot0.jobCharaIndex or 1) or Dorm.storage:PickData(slot1), "transform")
end

slot5 = 1.25
slot6 = {
	[DormEnum.CharacterType.RestaurantCook] = DORM_RESTAURANT_NEW_COOK,
	[DormEnum.CharacterType.RestaurantWaiter] = DORM_RESTAURANT_NEW_WAITER,
	[DormEnum.CharacterType.RestaurantCashier] = DORM_RESTAURANT_NEW_CASHIER,
	[DormEnum.CharacterType.RestaurantNormalCustomer] = DORM_RESTAURANT_NEW_CUSTOMER
}

function slot0.Ctor(slot0)
	slot1 = EntityManager.CreateModel.New(uv0, uv1, true)
	slot6 = true
	slot2 = EntityManager.CreateModel.New(uv2, uv1, slot6)
	slot0.workingCharaManagers = {}

	for slot6, slot7 in pairs(DormEnum.CharacterType) do
		slot8 = slot1

		if slot6 == DormEnum.CharacterType.RestaurantNormalCustomer then
			slot8 = slot2
		end

		slot9 = EntityManager.New(slot8)

		function slot9.OnCreate(slot0, slot1, slot2)
			Dorm.DormEntityManager.StartFadeInCMD(slot1, uv0)
			uv1:RecordEntityInfo(slot1, slot2)
			manager.notify:Invoke(uv2[uv3], slot1)
		end

		function slot9.OnRemove(slot0, slot1)
			uv0:RemoveEntityInfo(slot1)
			manager.notify:Invoke(DORM_CHARACTER_DISPOSE, slot1, uv1)
		end

		slot0.workingCharaManagers[slot6] = slot9
	end

	slot0.listener = EventListener.New()
	slot0.nextCustomerIdx = 1
end

function slot0.RegisterEvents(slot0)
	slot5 = slot0
	slot6 = slot0.UpdateJobCharacter

	for slot5, slot6 in pairs({
		[DORM_RESTAURANT_START_INIT] = handler(slot0, slot0.Init),
		[DORM_RESTAURANT_UPDATE_CHARACTER_BY_TYPE] = handler(slot5, slot6)
	}) do
		slot0.listener:Register(slot5, slot6)
	end
end

function slot0.RemoveEvents(slot0)
	slot0.listener:RemoveAll()
end

function slot0.CheckFoodEnoughGenCustomer()
	slot0 = 0

	for slot4, slot5 in pairs(CanteenManager.CalcCanOrderFoodList()) do
		slot0 = slot0 + 1
	end

	slot1 = nil

	return ((CanteenAIFunction:GetCurCanteenMode() ~= DormEnum.RestaurantMode.RestaurantManual or DormConst.ORDER_FOOD_NUM) and DormConst.ORDER_FOOD_AUTO_NUM) <= slot0
end

function slot7(slot0)
	return CanteenManager.GetInstance():GetCustomerGroupCount() < slot0 and uv0.CheckFoodEnoughGenCustomer()
end

slot8 = nil

function slot9()
	slot0 = CanteenManager.GetInstance():GetCurPopularity()

	if uv0 == nil then
		slot1 = {}
		slot3 = nil

		for slot7 = #GameSetting.dorm_canteen_customer_time.value, 1, -1 do
			slot8 = slot2[slot7][1]

			table.insert(slot1, {
				l = slot8,
				r = slot3,
				cd = slot2[slot7][2]
			})

			slot3 = slot8
		end

		uv0 = slot1
	end

	for slot4, slot5 in ipairs(uv0) do
		if slot5.l <= slot0 and (slot5.r == nil or slot0 < slot5.r) then
			return slot5.cd
		end
	end

	error(string.format("人气值%d不在有效区间内，无法找到对应的客人生成间隔时间信息"))
end

function slot0.StartGenCustomerTask(slot0, slot1)
	if slot0.genCustomerTask then
		slot0:StopGenCustomerTask()
	end

	slot0.genCustomerTask = DormCharacterActionManager.taskRunner:NewTask():WaitUntil(function (slot0)
		slot2 = not slot0.timer or not slot1:IsRunning()
		slot3 = uv0()

		if CanteenTools:AutoModeReadyForBusiness() and slot2 and uv1(slot3) then
			slot0.timer = uv2:NewTimer(nil, uv3(), false, false)

			slot0.timer:Start()
			uv4:GenCustomer()
		end

		return false
	end, {})

	slot0.genCustomerTask:Start()
end

function slot0.StopGenCustomerTask(slot0)
	if slot0.genCustomerTask then
		slot0.genCustomerTask:Abort()

		slot0.genCustomerTask = nil
	end
end

function slot10()
	slot0 = {}
	slot1 = {}

	for slot5, slot6 in pairs(BackHomeCustomerCfg.all) do
		if next(BackHomeCustomerCfg[slot6].food_list) then
			for slot11, slot12 in pairs(slot7.food_list) do
				slot0[slot12] = slot0[slot12] or {}

				table.insert(slot0[slot12], slot6)
			end
		else
			table.insert(slot1, slot6)
		end
	end

	return slot0, slot1
end

function slot11(slot0)
	slot1 = 0
	slot2 = {}

	for slot6, slot7 in pairs(slot0) do
		slot8 = BackHomeCustomerCfg[slot7].weight
		slot1 = slot1 + slot8
		slot2[slot7] = slot8
	end

	slot3 = math.random(1, slot1)
	slot4 = nil

	for slot8, slot9 in pairs(slot2) do
		if slot3 > 0 then
			slot3 = slot3 - slot9
			slot4 = slot8
		else
			break
		end
	end

	return slot4
end

function slot12(slot0, slot1)
	slot2 = CanteenManager.CalcCanOrderFoodList()
	slot3 = {}
	slot4, slot5 = uv0()

	while slot1 > #slot3 do
		if slot0 <= #slot3 and next(slot2) == nil and math.random() >= 0.5 then
			break
		end

		slot6 = nil
		slot7 = {}

		for slot11, slot12 in pairs(slot2) do
			table.insert(slot7, slot11)
		end

		if next(slot7) then
			if slot4[slot7[math.random(#slot7)]] == nil or next(slot6) == nil or #slot3 == slot1 - 1 and #slot7 > 1 then
				slot6 = slot5
				slot2 = {}
			end
		else
			slot6 = BackHomeCustomerCfg.all
		end

		slot8 = uv1(slot6)
		slot12 = slot8

		table.insert(slot3, slot12)

		for slot12, slot13 in pairs(BackHomeCustomerCfg[slot8].food_list) do
			slot2[slot13] = nil
		end
	end

	return slot3
end

function slot0.GenCustomer(slot0)
	slot1 = DormEnum.CharacterType.RestaurantNormalCustomer
	slot7 = #uv0(1, #CanteenItemManager.GetItemsInItemGroup(DormEnum.ItemType.DinningChair, CanteenAIFunction:GetEntityData(CanteenManager.ArrangeDinningTableForCustomer()).group))
	slot8 = math.random(1, slot7)
	slot9 = {}

	for slot13 = 1, slot7 do
		slot14 = math.random(1, #slot5)
		slot5[#slot5] = slot5[slot14]
		slot5[slot14] = slot5[#slot5]

		table.insert(slot9, slot0:GenerateCharacterEntity(slot1, slot0.nextCustomerIdx, {
			heroID = slot6[slot13],
			jobID = slot1,
			jobCharaIndex = slot13
		}, {
			cfgID = slot6[slot13],
			tableEid = slot2,
			chairEid = table.remove(slot5),
			pay = slot13 == slot8
		}))

		slot0.nextCustomerIdx = slot0.nextCustomerIdx + 1

		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
			CanteenData:RecordManualGenCustomerNum(1)
		end
	end

	for slot13, slot14 in ipairs(slot9) do
		slot0.GetEntityData(slot14).peer = slot9
	end

	slot3.booked = slot9

	CanteenManager.GetInstance():OnCustomerCome()
end

slot13 = DormEnum.RestaurantJobToClientMap

function slot0.EIdNamespace(slot0)
	return "entity." .. slot0 .. ".eid"
end

function slot0.IdxNamespace(slot0)
	return "entity." .. slot0 .. ".idx"
end

function slot0.Init(slot0)
	slot0:RegisterEvents()

	for slot4, slot5 in pairs(slot0.workingCharaManagers) do
		slot5:Clear()
		Dorm.storage:MapToData(uv0.EIdNamespace(slot4), slot5.managed)
		Dorm.storage:MapToData(uv0.IdxNamespace(slot4), slot5.reverseQuery)
	end

	slot0:GenerateJobCharacter(uv1)
end

function slot0.UpdateJobCharacter(slot0, slot1)
	if slot0.workingCharaManagers[slot1] then
		slot2:Clear()
		slot0:GenerateJobCharacter({
			slot1
		})
	end
end

function slot0.GenerateJobCharacter(slot0, slot1)
	slot2 = DormData:GetCanteenJobList()

	for slot6, slot7 in pairs(slot1) do
		if ({
			heroID = slot2[DormEnum.RestaurantJobToServerMap[slot7]].heroID,
			jobID = slot7
		}).heroID then
			Dorm.DormEntityManager.SetEntitySpeedCMD(slot0:GenerateCharacterEntity(slot7, 1, slot9), BackHomeHeroCfg[slot9.heroID].speed)
		end
	end
end

function slot0.GenerateCharacterEntity(slot0, slot1, slot2, slot3, slot4)
	slot4 = slot4 or {}
	slot6 = slot0.workingCharaManagers[slot1]:Create(slot2, slot3, slot4)
	slot4.eid = slot6

	return slot6, true
end

function slot0.RecordEntityInfo(slot0, slot1, slot2)
	Dorm.storage:RecordData(DormEnum.Namespace.EntityType, slot1, nullable(slot2, "jobID"))
end

function slot0.RemoveEntityInfo(slot0, slot1)
	Dorm.storage:RecordData(DormEnum.Namespace.EntityType, slot1, nil)
end

function slot0.Reset(slot0)
	slot0:RemoveEvents()
	slot0:StopGenCustomerTask()

	for slot4, slot5 in pairs(slot0.workingCharaManagers) do
		slot5:Clear()
	end
end

function slot0.GetCharacterCount(slot0, slot1)
	return slot0.workingCharaManagers[slot1]:EntityNum()
end

function slot0.FindAndRemoveEntity(slot0)
	EntityManager.FindAndRemoveEntity(uv0.GetInstance().workingCharaManagers, slot0)
end

function slot0.GetEntityData(slot0)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityData, slot0)
end

return slot0
