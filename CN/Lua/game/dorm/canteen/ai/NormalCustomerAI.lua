slot0 = singletonClass("NormalCustomerAI")
slot1 = {
	NormalCustomerEnterScene = "NormalCustomerEnterScene",
	NormalCustomerOrderFood = "NormalCustomerOrderFood",
	NormalCustomerTakeSeat = "NormalCustomerTakeSeat",
	NormalCustomerWaitFood = "NormalCustomerWaitFood",
	FvckOff = "NormalCustomerExpel",
	NormalCustomerTakeBillWithCashier = "NormalCustomerTakeBillWithCashier",
	NormalCustomerGotoExit = "NormalCustomerGotoExit",
	NormalCustomerGotoTable = "NormalCustomerGotoTable",
	NormalCustomerEatFood = "NormalCustomerEatFood",
	NormalCustomerDispose = "NormalCustomerDispose",
	NormalCustomerWaitBill = "NormalCustomerWaitBill",
	NormalCustomerGotoCashier = "NormalCustomerGotoCashier",
	NormalCustomerLeaveSeat = "NormalCustomerLeaveSeat",
	NormalCustomerThinkOrder = "NormalCustomerThinkOrder"
}
slot2 = {
	[slot1.NormalCustomerGotoTable] = function (slot0, slot1)
		slot2, slot3 = uv0.GotoDinningChair(slot0)

		DormEventInvoke(DORM_CHARACTER_MOVE_LOOK_AT, slot1, slot0, slot2, slot3)
	end,
	[slot1.NormalCustomerLeaveSeat] = function (slot0, slot1)
		slot2 = CanteenAIFunction:GetEntityData(slot0).chairEid

		DormEventInvoke(DORM_CHARACTER_INTERACT, slot1, slot0, slot2)
		DormEventInvoke(DORM_CHARACTER_MOVE, slot1, slot0, CanteenAIFunction:GetNearestPoint(slot0, CanteenItemManager.GetItemInteractPositions(slot2)), true, true)
	end,
	[slot1.NormalCustomerGotoExit] = function (slot0, slot1)
		slot2 = CanteenAIFunction:FindNearestPoint(slot0, DormEnum.Points.RestaurantExit)

		Dorm.DormEntityManager.FadeOutNearPoint(slot0, slot2, 0.75)
		DormEventInvoke(DORM_CHARACTER_MOVE, slot1, slot0, slot2)
	end,
	[slot1.NormalCustomerGotoCashier] = function (slot0, slot1)
		DormEventInvoke(DORM_CHARACTER_MOVE, slot1, slot0, CanteenAIFunction:FindPoint(DormEnum.Points.RestaurantCustomerPay))
	end,
	[slot1.NormalCustomerOrderFood] = function (slot0, slot1)
		slot2 = CanteenAIFunction:GetEntityData(slot0)
		slot2.orderInfo = uv0.OrderFood(slot2.peer)

		DormEventInvoke(DORM_CHARACTER_INTERACT, slot1, slot0, CanteenAIFunction:GetAllEIDNameSpace(CanteenAIFunction:GetNameSpace(DormEnum.ItemType.OrderFoodDummy))[1])
	end,
	[slot1.NormalCustomerEatFood] = function (slot0, slot1)
		DormEventInvoke(DORM_CHARACTER_INTERACT, slot1, slot0, CanteenAIFunction:GetEntityData(slot0).tableEid)
	end
}
slot3 = 0
slot4 = 1
slot5 = 2
slot6 = 3
slot7 = nil

function slot0.Init(slot0)
	slot0:RegisterEvent()

	slot0.NormalCustomerStateList = {}
end

function slot0.AIInit(slot0, slot1, slot2)
	if slot1 == nil or slot0.NormalCustomerStateList[slot1] then
		error("传入参数为空或实体对象id重复")

		return
	end

	slot0.NormalCustomerStateList[slot1] = {
		state = uv0.NormalCustomerEnterScene
	}

	slot0:AIChoice(slot1, uv1, "Init")
end

function slot0.RegisterEvent(slot0)
	slot1 = slot0.listener or EventListener.New()

	slot1:RemoveAll()
	slot1:Register(DORM_RESTAURANT_NEW_CUSTOMER, handler(slot0, slot0.AIInit))
	slot1:Register(ON_DORM_CHARACTER_MOVE_FINISH, handler(slot0, slot0.ListenMoveEvent))
	slot1:Register(ON_DORM_CHARACTER_INTERACT_FINISH, handler(slot0, slot0.ListenInteractEvent))
	slot1:Register(DORM_RESTAURANT_INTERACT_CUSTOMER, handler(slot0, slot0.ListenPlayerInteractEvent))
	slot1:Register(DORM_RESTAURANT_LOGIC_TICK, handler(slot0, slot0.Update))
	slot1:Register(DORM_CHARACTER_DISPOSE, handler(slot0, slot0.DisposeEntity))

	slot0.listener = slot1
end

function slot0.RemoveListener(slot0)
	slot0.listener:RemoveAll()
end

function slot0.ListenMoveEvent(slot0, slot1, slot2)
	if not slot0.NormalCustomerStateList[slot1] then
		return
	end

	if slot2 then
		slot0:AIChoice(slot1, uv0)
	end
end

function slot0.ListenInteractEvent(slot0, slot1, slot2)
	if not slot0.NormalCustomerStateList[slot1] then
		return
	end

	slot0:AIChoice(slot1, uv0, slot2)
end

function slot0.ListenPlayerInteractEvent(slot0, slot1, slot2, slot3)
	slot6 = CanteenAIFunction
	slot8 = slot6

	for slot7, slot8 in ipairs(slot6.GetEntityData(slot8, slot1).peer) do
		slot0:SwitchState(slot8, uv0.FvckOff)
	end
end

function slot0.SwitchState(slot0, slot1, slot2, slot3)
	slot0.NormalCustomerStateList[slot1].lastState = slot3 or slot0.NormalCustomerStateList[slot1].state
	slot0.NormalCustomerStateList[slot1].state = slot2

	if uv0[slot2] then
		uv0[slot2](slot1, slot2)
	end
end

function slot0.GetState(slot0, slot1)
	return slot0.NormalCustomerStateList[slot1].state
end

function slot8(slot0)
	for slot4, slot5 in pairs(slot0) do
		if not CanteenAIFunction:GetEntityData(slot5).sit then
			return false
		end
	end

	return true
end

function slot0.CheckFoodDelivering(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.curOrder) do
		if slot6.status == DormEnum.FoodState.HasServer then
			slot1 = slot1 + 1
		end
	end

	return slot1 > (slot0.foodList and #slot0.foodList or 0)
end

function slot0.AIChoice(slot0, slot1, slot2, ...)
	slot3 = {
		...
	}

	if slot0.NormalCustomerStateList[slot1].state == nil then
		error("普通客人列表不存在实例对象id:" .. slot1)

		return
	end

	slot7 = CanteenAIFunction:GetEntityData(CanteenAIFunction:GetEntityData(slot1).tableEid)

	if slot4 == uv0.NormalCustomerEnterScene then
		slot0:SwitchState(slot1, uv0.NormalCustomerGotoTable)
	elseif slot4 == uv0.NormalCustomerGotoTable then
		if slot2 == uv1 then
			slot8 = uv0.NormalCustomerTakeSeat

			slot0:SwitchState(slot1, slot8)

			slot10 = slot5.chairEid

			DormEventInvoke(DORM_CHARACTER_MOVE_LOOK_TO_DIR, slot8, slot1, Dorm.DormEntityManager.QueryEntityAttachPointWorldPos(slot10, "gua_start_sit"), Dorm.DormEntityManager.QueryForwardDir(slot10), true, true)
			DormEventInvoke(DORM_CHARACTER_INTERACT, slot8, slot1, slot5.chairEid, true)
		end
	elseif slot4 == uv0.NormalCustomerTakeSeat then
		if slot5.pay then
			if slot2 == uv2 then
				slot0:SwitchState(slot1, uv0.NormalCustomerOrderFood)
			end
		elseif uv3(slot5.peer) then
			slot0:SwitchState(slot1, uv0.NormalCustomerWaitFood)
		end
	elseif slot4 == uv0.NormalCustomerOrderFood then
		if slot2 == uv2 then
			if #slot7.curOrder == 0 then
				slot0:SwitchState(slot1, uv0.FvckOff)
			else
				slot0:SwitchState(slot1, uv0.NormalCustomerWaitFood)

				slot8 = slot5.tableEid

				if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
					CanteenAIFunction:SetCustomerWaitFoodTimer(slot8, DormCharacterActionManager.taskRunner:NewTimer(function ()
						uv0:WaitFoodCallBack(uv1, uv2.curOrder)
					end, GameSetting.dorm_customer_wait_food_time.value[1], 1))
					manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, slot8)
				end
			end
		end
	elseif slot4 == uv0.NormalCustomerWaitFood then
		slot8 = slot7.foodList

		if slot2 == uv4 then
			if nullable(slot7, "curOrder") and #slot7.curOrder == 0 then
				slot0:SwitchState(slot1, uv0.FvckOff)
			elseif slot0.CheckFoodServeComplete(slot1) then
				if slot5.pay then
					CanteenAIFunction:StopCustomerWaitFoodTimer(slot5.tableEid)

					if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
						slot7.hasServer = true
						slot7.quality = slot0:CalculateFoodQuality(slot1, slot8, slot6)

						manager.notify:Invoke(DORM_CANTEEN_QUALITY_BUBBLE_REFRESH, slot6)
					end
				end

				slot0:SwitchState(slot1, uv0.NormalCustomerEatFood)
			elseif slot0.NormalCustomerStateList[slot1].timeout and slot5.pay and not slot0.CheckFoodDelivering(slot7) then
				slot9 = nil

				if slot0:HasFoodToEat(slot1) then
					if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
						slot7.hasServer = true
						slot7.quality = slot0:CalculateFoodQuality(slot1, slot8, slot6)

						manager.notify:Invoke(DORM_CANTEEN_QUALITY_BUBBLE_REFRESH, slot6)
					end

					slot9 = uv0.NormalCustomerEatFood
				else
					slot9 = uv0.NormalCustomerLeaveSeat
				end

				for slot13, slot14 in pairs(slot5.peer) do
					slot0:SwitchState(slot14, slot9)
				end

				CanteenAIFunction:StopCustomerWaitFoodTimer(slot5.tableEid)
			end
		elseif slot2 == uv5 then
			slot0.NormalCustomerStateList[slot1].timeout = true
		end
	elseif slot4 == uv0.NormalCustomerEatFood then
		if slot2 == uv2 and true then
			slot0:SwitchState(slot1, uv0.NormalCustomerLeaveSeat)
			manager.notify:Invoke(CANTEEN_CLEAR_BUBBLE_LIST, slot6)
		end
	elseif slot4 == uv0.NormalCustomerLeaveSeat then
		if slot2 == uv1 then
			slot8 = slot0.NormalCustomerStateList[slot1].lastState

			if slot5.pay then
				slot9 = true

				if slot5.eat and slot8 ~= uv0.FvckOff and slot9 then
					slot0:SwitchState(slot1, uv0.NormalCustomerGotoCashier)
				else
					slot0:SwitchState(slot1, uv0.NormalCustomerGotoExit)
				end
			else
				slot0:SwitchState(slot1, uv0.NormalCustomerGotoExit)
			end
		end
	elseif slot4 == uv0.NormalCustomerGotoCashier then
		if slot2 == uv1 then
			slot0:SwitchState(slot1, uv0.NormalCustomerTakeBillWithCashier)
			DormEventInvoke(DORM_CHARACTER_INTERACT, uv0.NormalCustomerTakeBillWithCashier, slot1, CanteenAIFunction:GetAllEIDNameSpace(CanteenAIFunction:GetNameSpace(DormEnum.CharacterType.RestaurantCashier))[1])
		end
	elseif slot4 == uv0.NormalCustomerTakeBillWithCashier then
		if slot2 == uv2 then
			slot0:SwitchState(slot1, uv0.NormalCustomerGotoExit)
		end
	elseif slot4 == uv0.NormalCustomerGotoExit then
		if slot2 == uv1 then
			CanteenCharacterManager.FindAndRemoveEntity(slot1)
		end
	elseif slot4 == uv0.FvckOff then
		if slot5.pay then
			CanteenAIFunction:StopCustomerWaitFoodTimer(slot5.tableEid)
		end

		if slot5.sit then
			slot0:SwitchState(slot1, uv0.NormalCustomerLeaveSeat)
			manager.notify:Invoke(CANTEEN_CLEAR_BUBBLE_LIST, slot6)
		end
	else
		error("未找到" .. slot1 .. "对象的选择")
	end
end

function slot0.GotoDinningChair(slot0)
	if CanteenAIFunction:GetEntityData(slot0).chairEid == nil then
		slot1.chairEid = CanteenAIFunction:FindAvailableItem(slot0, DormEnum.ItemType.DinningChair)

		CanteenAIFunction:SetItemAvailable(slot1.chairEid, false)
	end

	slot3 = Dorm.DormEntityManager.QueryEntityAttachPointWorldPos(slot1.chairEid, "gua_start_sit")

	return CanteenAIFunction:GetNearestPointFrom(slot3, CanteenItemManager.GetItemInteractPositions(slot1.chairEid)), slot3
end

function slot0.CheckFoodServeComplete(slot0)
	if CanteenAIFunction:GetEntityData(CanteenAIFunction:GetEntityData(slot0).tableEid).curOrder == nil then
		return false
	end

	if slot2.foodList == nil then
		return false
	end

	if #slot3 >= #slot2.curOrder then
		return true
	end

	return false
end

function slot0.HasFoodToEat(slot0, slot1)
	return CanteenAIFunction:GetEntityData(CanteenAIFunction:GetEntityData(slot1).tableEid).foodList and #slot4 > 0
end

function slot9(slot0)
	slot1 = BackHomeCanteenFoodCfg[slot0].tag

	return {
		cfgID = slot0,
		taste = slot1[math.random(1, #slot1)]
	}
end

function slot10(slot0)
	if next(BackHomeCustomerCfg[slot0].food_list) == nil then
		slot1 = BackHomeCanteenFoodCfg.all
	end

	return slot1
end

function slot11(slot0)
	slot1 = nil

	if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
		slot1 = CanteenManager.CalcCanOrderFoodList()
	else
		slot1 = {}
		slot4 = CanteenData
		slot6 = slot4

		for slot5, slot6 in pairs(slot4.GetChooseFoodList(slot6)) do
			slot1[slot6] = true
		end
	end

	slot2 = {}

	for slot6, slot7 in pairs(slot0) do
		slot13 = CanteenAIFunction:GetEntityData(slot7).cfgID

		for slot12, slot13 in pairs(uv0(slot13)) do
			if slot1[slot13] then
				slot2[slot13] = true
			end
		end
	end

	slot3 = {}

	for slot7, slot8 in pairs(slot2) do
		table.insert(slot3, slot7)
	end

	return slot3
end

function slot0.OrderFood(slot0)
	slot2 = {}

	if next(uv0(slot0)) then
		if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
			slot6 = DormConst.ORDER_FOOD_NUM

			for slot6 = 1, math.min(slot6, #slot1) do
				slot7 = math.random(#slot1)
				slot1[#slot1] = slot1[slot7]
				slot1[slot7] = slot1[#slot1]

				table.insert(slot2, uv1(table.remove(slot1)))
			end
		else
			for slot6 = 1, DormConst.ORDER_FOOD_NUM do
				table.insert(slot2, uv1(slot1[math.random(#slot1)]))
			end
		end
	end

	return slot2
end

function slot0.CalculateFoodQuality(slot0, slot1, slot2, slot3)
	if CanteenAIFunction:GetEntityData(slot1).pay == false then
		return
	end

	slot5 = slot4.orderInfo
	slot6 = 0
	slot7 = 0

	for slot11, slot12 in ipairs(slot2) do
		slot13 = false

		for slot17, slot18 in ipairs(slot5) do
			if CanteenAIFunction:GetEntityData(slot12).cfgID == slot18.cfgID and not slot18.hasCalculat then
				slot6 = slot6 + slot19.quality
				slot18.hasCalculat = true
				slot7 = slot19.taste == slot18.taste and slot7 + 0.5 or slot7 + 0.5 - 0.5
				slot13 = true

				break
			end
		end

		if not slot13 then
			slot6 = slot6 + DormEnum.FoodQuality.low
		end

		CanteenData:RecordFoodDelivery(CanteenAIFunction:GetFoodManualIndex(slot12), slot1, slot4.cfgID)
	end

	if #slot2 == 1 then
		slot6 = slot6 + DormEnum.FoodQuality.low
	end

	slot9 = GameSetting.canteen_customer_evaluation.value[#GameSetting.canteen_customer_evaluation.value][1]

	if slot6 - 1 + math.floor(slot7) < GameSetting.canteen_customer_evaluation.value[1][1] then
		slot6 = slot8
	end

	if slot9 < slot6 then
		slot6 = slot9
	end

	if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
		CanteenData:RecordFoodQuality(slot2, slot6)
		CanteenData:AddPopularityNum(slot6)
	end

	return slot6
end

function slot0.WaitFoodCallBack(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot2) do
		if slot7.status ~= DormEnum.FoodState.HasServer then
			slot7.status = DormEnum.FoodState.TimeOut
		end
	end

	slot6 = CANTEEN_CLEAR_BUBBLE_LIST
	slot7 = slot1.tableEid

	manager.notify:Invoke(slot6, slot7)

	for slot6, slot7 in pairs(slot1.peer) do
		slot0:AIChoice(slot7, uv0)
	end

	CanteenAIFunction:StopCustomerWaitFoodTimer(slot1.tableEid)
end

function slot0.Update(slot0)
	if slot0.NormalCustomerStateList then
		for slot4, slot5 in pairs(slot0.NormalCustomerStateList) do
			slot0:AIChoice(slot4, uv0)
		end
	end
end

function slot0.DisposeEntity(slot0, slot1)
	if slot0.NormalCustomerStateList[slot1] then
		slot0.NormalCustomerStateList[slot1] = nil
	end
end

function slot0.DisposeAllEntity(slot0)
	slot0.NormalCustomerStateList = nil
end

function slot0.Dispose(slot0)
	slot0:DisposeAllEntity()
	slot0:RemoveListener()
end

return slot0
