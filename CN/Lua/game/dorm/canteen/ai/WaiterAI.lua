slot0 = singletonClass("WaiterAI")

function slot0.Init(slot0)
	slot0:RegisterEvent()

	slot0.WaiterStateList = {}
	slot0.WaiterState = {
		WaiterInteractPassTable = "WaiterInteractPassTable",
		WaiterPassFood = "WaiterPassFood",
		WaiterPlaceFood = "WaiterPlaceFood",
		WaiterIdle = "WaiterIdle",
		WaiterEnterScene = "WaiterEnterScene",
		WaiterMove = "WaiterMove"
	}
end

function slot1()
	return Dorm.storage:PickData(CanteenAIFunction:GetNameSpace(DormEnum.ItemType.PassTable))
end

function slot0.AIInit(slot0, slot1)
	if slot1 == nil or slot0.WaiterStateList[slot1] then
		error("传入参数为空或实体对象id重复")

		return
	end

	slot0.WaiterStateList[slot1] = {
		state = slot0.WaiterState.WaiterEnterScene,
		lastState = {}
	}

	slot0:AIChoice(slot1)
end

function slot0.RegisterEvent(slot0)
	slot0.listener = slot0.listener or EventListener.New()

	slot0.listener:RemoveAll()

	slot5 = slot0
	slot6 = slot0.DisposeEntity

	for slot5, slot6 in pairs({
		[DORM_RESTAURANT_NEW_WAITER] = handler(slot0, slot0.AIInit),
		[ON_DORM_CHARACTER_MOVE_FINISH] = handler(slot0, slot0.ListenMoveEvent),
		[ON_DORM_CHARACTER_INTERACT_FINISH] = handler(slot0, slot0.ListenInteractEvent),
		[DORM_RESTAURANT_LOGIC_TICK] = handler(slot0, slot0.Update),
		[DORM_CHARACTER_DISPOSE] = handler(slot5, slot6)
	}) do
		slot0.listener:Register(slot5, slot6)
	end
end

slot2 = 0
slot3 = 1
slot4 = 2

function slot0.ListenMoveEvent(slot0, slot1, slot2)
	if not slot0.WaiterStateList[slot1] then
		return
	end

	if slot2 then
		slot0:AIChoice(slot1, uv0)
	end
end

function slot0.ListenInteractEvent(slot0, slot1, slot2)
	if not slot0.WaiterStateList[slot1] then
		return
	end

	if slot2 then
		slot0:AIChoice(slot1, uv0, slot2)
	end
end

function slot0.RemoveListener(slot0)
	slot0.listener:RemoveAll()
end

function slot0.SwitchState(slot0, slot1, slot2, slot3)
	slot0.WaiterStateList[slot1].lastState = slot3 or slot0.WaiterStateList[slot1].state
	slot0.WaiterStateList[slot1].state = slot2
end

function slot0.MoveToTarget(slot0, slot1)
	slot2, slot3 = slot0:ChoiceEndPosition(slot1)
	slot4 = slot0.WaiterStateList[slot1].state

	if slot3 then
		DormEventInvoke(DORM_CHARACTER_MOVE_LOOK_AT, slot4, slot1, slot2, slot3, false)
	else
		DormEventInvoke(DORM_CHARACTER_MOVE, slot4, slot1, slot2, false)
	end
end

function slot0.ShouldReturnFoodToPassTable(slot0)
	if slot0.pick and slot0.selectedOrder then
		if slot0.selectedOrder.status == DormEnum.FoodState.Canceled then
			return true
		end

		if NormalCustomerAI.CheckFoodServeComplete(slot0.selectedOrder.orderCharacterID) then
			return true
		end
	end
end

function slot0.AIChoice(slot0, slot1, slot2, ...)
	if slot0.WaiterStateList[slot1].state == nil then
		print("服务员列表不存在该实例对象id")

		return
	end

	slot4 = CanteenAIFunction:GetEntityData(slot1)
	slot5 = {
		...
	}

	if slot3 == slot0.WaiterState.WaiterEnterScene then
		slot0:SwitchState(slot1, slot0.WaiterState.WaiterMove)
		slot0:MoveToTarget(slot1)
	elseif slot3 == slot0.WaiterState.WaiterMove then
		if slot0.ShouldReturnFoodToPassTable(slot4) then
			slot4.selectedOrder = nil

			Dorm.DormEntityManager.StopAllCmd(slot1)
			slot0:MoveToTarget(slot1)
		elseif slot2 == uv0 then
			if CanteenAIFunction:GetCharacterPickItem(slot1) then
				if slot4.selectedOrder then
					slot0:SwitchState(slot1, slot0.WaiterState.WaiterPlaceFood)
					DormEventInvoke(DORM_CHARACTER_INTERACT, slot3, slot1, slot4.selectedOrder.orderTableID)
				else
					slot0:SwitchState(slot1, slot0.WaiterState.WaiterInteractPassTable)
					DormEventInvoke(DORM_CHARACTER_INTERACT, slot3, slot1, uv1())
				end
			else
				slot0:SwitchState(slot1, slot0.WaiterState.WaiterIdle)
				CanteenAIFunction:SetCharacterBusy(slot1, false)
			end
		end
	elseif slot3 == slot0.WaiterState.WaiterIdle then
		if slot2 == uv2 then
			for slot10, slot11 in ipairs(slot5[1]) do
				if slot0:ArrangeFood(slot11) then
					CanteenAIFunction:SetCharacterBusy(slot1, true)
					CanteenAIFunction:SetCharacterTarget(slot1, slot12)

					slot4.selectedOrder = slot11
					slot11.status = DormEnum.FoodState.HasServer

					slot0:SwitchState(slot1, slot0.WaiterState.WaiterInteractPassTable)
					DormEventInvoke(DORM_CHARACTER_INTERACT, slot3, slot1, uv1())
					manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, slot11.orderTableID)

					break
				end
			end
		end
	elseif slot3 == slot0.WaiterState.WaiterInteractPassTable then
		if slot2 == uv3 then
			slot0:SwitchState(slot1, slot0.WaiterState.WaiterMove)
			slot0:MoveToTarget(slot1)
		end
	elseif slot3 == slot0.WaiterState.WaiterPlaceFood then
		if slot2 == uv3 then
			slot0:SwitchState(slot1, slot0.WaiterState.WaiterMove)
			slot0:MoveToTarget(slot1)
		end
	else
		error("未找到对应状态")
	end
end

function slot0.ChoiceEndPosition(slot0, slot1)
	if CanteenAIFunction:GetEntityData(slot1).pick and slot2.selectedOrder ~= nil and not slot0.ShouldReturnFoodToPassTable(slot2) then
		slot3 = slot2.selectedOrder.orderTableID

		return CanteenAIFunction:GetNearestPoint(slot1, CanteenItemManager.GetItemInteractPositions(slot3)), Dorm.DormEntityManager.QueryPosition(slot3)
	else
		return CanteenAIFunction:GetNearestPoint(slot1, CanteenItemManager.GetItemInteractPositions(uv0()))
	end
end

function slot5()
	return Dorm.storage:GetData(DormEnum.Namespace.RestaurantBusiness, CanteenManager.orderFoodListField)
end

function slot0.Update(slot0)
	slot1 = uv0()

	for slot5, slot6 in pairs(slot0.WaiterStateList) do
		slot0:AIChoice(slot5, uv1, slot1)
	end
end

function slot0.FindFood(slot0, slot1)
	if nullable(CanteenAIFunction:GetEntityData(uv0()), "foodList") then
		for slot7, slot8 in ipairs(slot3) do
			if slot1 == CanteenAIFunction:GetEntityData(slot8).cfgID then
				return slot8
			end
		end
	end
end

function slot0.ArrangeFood(slot0, slot1)
	if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
		if slot1.status == DormEnum.FoodState.Wait and slot0:FindFood(slot1.cfgID) then
			slot1.status = DormEnum.FoodState.HasCook
			slot1.foodEID = slot2

			return slot1.foodEID
		end
	elseif slot1.status == DormEnum.FoodState.HasCook then
		return slot1.foodEID
	end
end

function slot0.AnyFreeWaiter(slot0)
	for slot4, slot5 in pairs(slot0.WaiterStateList) do
		if not CanteenAIFunction:GetCharacterBusy(slot4) then
			return slot4
		end
	end
end

function slot0.DisposeEntity(slot0, slot1)
	if slot0.WaiterStateList[slot1] then
		slot0.WaiterStateList[slot1] = nil
	end
end

function slot0.DisposeAllEntity(slot0)
	slot0.WaiterStateList = {}
end

function slot0.Dispose(slot0)
	slot0:DisposeAllEntity()
	slot0:RemoveListener()
end

return slot0
