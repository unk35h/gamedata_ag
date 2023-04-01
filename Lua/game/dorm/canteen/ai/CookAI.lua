slot0 = singletonClass("CookAI")
slot1 = {}
slot2 = {}
slot3 = {
	Interact = "Interact",
	Move = "Move",
	Idle = "Idle",
	Wait = "Wait"
}

function slot0.Ctor(slot0)
	slot0.listener = EventListener.New()
	uv0[uv1.Move] = slot0.MoveToTarget
	uv0[uv1.Interact] = slot0.InteractToTarget
	uv0[uv1.Idle] = slot0.OnIdle
end

slot4 = 0
slot5 = 1
slot6 = 2

function slot0.CurState(slot0, slot1)
	return slot0.CookTargetList[slot1].state
end

function slot0.SwitchState(slot0, slot1, slot2, slot3)
	slot4 = slot3 or slot0.CookTargetList[slot1].state
	slot0.CookTargetList[slot1].lastState = slot4
	slot0.CookTargetList[slot1].state = slot2

	if uv0[slot4] then
		uv0[slot4](slot0, slot1)
	end

	if uv1[slot2] then
		uv1[slot2](slot0, slot1)
	end
end

function slot0.Init(slot0)
	slot0:RegisterEvent()

	slot0.CookTargetList = {}
	slot0.passtableEID = CanteenAIFunction:GetAllEIDNameSpace(CanteenAIFunction:GetNameSpace(DormEnum.ItemType.PassTable))[1]
end

function slot0.AIInit(slot0, slot1)
	slot0.CookTargetList[slot1] = {
		state = uv0.Idle
	}

	slot0:OnIdle(slot1)
	slot0:AIChoice(slot1)
end

function slot0.RegisterEvent(slot0)
	slot0.listener = slot0.listener or EventListener.New()

	slot0.listener:RemoveAll()

	slot5 = slot0
	slot6 = slot0.DisposeEntity

	for slot5, slot6 in pairs({
		[DORM_RESTAURANT_NEW_COOK] = handler(slot0, slot0.ListenGenerate),
		[ON_DORM_CHARACTER_MOVE_FINISH] = handler(slot0, slot0.ListenMoveEvent),
		[ON_DORM_CHARACTER_INTERACT_FINISH] = handler(slot0, slot0.ListenInteractEvent),
		[DORM_RESTAURANT_LOGIC_TICK] = handler(slot0, slot0.Update),
		[DORM_CHARACTER_DISPOSE] = handler(slot5, slot6)
	}) do
		slot0.listener:Register(slot5, slot6)
	end
end

function slot0.ListenGenerate(slot0, slot1)
	slot0:AIInit(slot1)
end

function slot0.ListenMoveEvent(slot0, slot1, slot2)
	if not slot0.CookTargetList[slot1] then
		return
	end

	slot0:AIChoice(slot1, uv0, slot2)
end

function slot0.ListenInteractEvent(slot0, slot1, slot2, slot3, ...)
	if not slot0.CookTargetList[slot1] then
		return
	end

	if slot3 then
		slot0:AIChoice(slot1, uv0, slot3)
	end
end

function slot0.RemoveListener(slot0)
	slot0.listener:RemoveAll()
end

function slot7(slot0)
	return DormEnum.RestaurantKitchenWare[BackHomeCanteenFoodCfg[slot0].cook_type]
end

function slot8(slot0)
	return CanteenAIFunction:GetItemAvailable(slot0) and not CanteenAIFunction:GetEntityData(slot0).cookComplete
end

function slot9(slot0)
	return CanteenAIFunction:GetItemAvailable(slot0) and CanteenAIFunction:GetEntityData(slot0).cookComplete
end

function slot0.ChooseByRestaurantOrders()
	slot0 = Dorm.storage:GetData(DormEnum.Namespace.RestaurantBusiness, CanteenManager.orderFoodListField)
	slot1 = {}

	for slot5, slot6 in pairs(DormEnum.RestaurantKitchenWare) do
		slot11 = CanteenItemManager.ItemEIdNamespace(slot6)
		slot12 = pairs

		for slot11, slot12 in Dorm.storage:ForeachData(slot11, slot12) do
			if uv0(slot12) then
				slot1[slot6] = slot12

				break
			end
		end
	end

	for slot5, slot6 in ipairs(slot0) do
		slot7 = slot1[uv1(slot6.cfgID)]

		if slot6.status == DormEnum.FoodState.Wait and slot7 then
			slot6.status = DormEnum.FoodState.Cooking

			return slot6, slot7
		end
	end
end

function slot0.AIChoice(slot0, slot1, slot2, ...)
	slot3 = CanteenAIFunction:GetEntityData(slot1)

	if slot0.CookTargetList[slot1].state == nil then
		print("厨圣列表不存在该实例对象id")

		return
	end

	if slot4 == uv0.Idle then
		if slot3.pick then
			slot0:SetAITarget(slot1, slot0.passtableEID)
		elseif slot0:PickFood() then
			slot0:SetAITarget(slot1, slot5)
		elseif slot0:CookFood(slot1) then
			slot0:SetAITarget(slot1, slot6)
		end

		if slot0:HasAITarget(slot1) then
			slot0:SwitchState(slot1, uv0.Move)
		end
	elseif slot4 == uv0.Move then
		if slot2 == uv1 then
			slot0:SwitchState(slot1, uv0.Wait)
		end
	elseif slot4 == uv0.Wait then
		if CanteenAIFunction:GetItemAvailable(slot0.CookTargetList[slot1].targetItem) then
			slot0:SwitchState(slot1, uv0.Interact)
		end
	elseif slot4 == uv0.Interact and slot2 == uv2 then
		slot0:SwitchState(slot1, uv0.Idle)
	end
end

function slot10(slot0)
	return {
		cfgID = slot0,
		quality = DormEnum.FoodQuality.normal
	}
end

function slot0.CookFood(slot0, slot1)
	slot2 = CanteenAIFunction:GetEntityData(slot1)
	slot3, slot4 = slot0.ChooseByRestaurantOrders()

	if slot3 then
		CanteenAIFunction:SetCharacterBusy(slot1, true)

		slot2.selectedOrder = slot3
		CanteenAIFunction:GetEntityData(slot4).curCooking = uv0(slot2.selectedOrder.cfgID)

		return slot4
	end
end

function slot0.PickFood(slot0)
	for slot4, slot5 in pairs(DormEnum.RestaurantKitchenWare) do
		slot10 = CanteenAIFunction:GetNameSpace(slot5)
		slot11 = pairs

		for slot10, slot11 in Dorm.storage:ForeachData(slot10, slot11) do
			if uv0(slot11) then
				return slot11
			end
		end
	end
end

function slot0.ToTargetPos(slot0, slot1, slot2)
	return CanteenAIFunction:GetNearestPoint(slot1, CanteenItemManager.GetItemInteractPositions(slot2))
end

function slot0.Move(slot0, slot1, slot2)
	DormEventInvoke(DORM_CHARACTER_MOVE, slot0:CurState(slot1), slot1, slot2)
end

function slot0.MoveLookToDir(slot0, slot1, slot2, slot3)
	DormEventInvoke(DORM_CHARACTER_MOVE_LOOK_TO_DIR, slot0:CurState(slot1), slot1, slot2, slot3)
end

function slot0.MoveToTarget(slot0, slot1)
	slot2 = slot0.CookTargetList[slot1].targetItem
	slot3 = slot0:ToTargetPos(slot1, slot2)

	if slot2 == slot0.passtableEID then
		slot0:Move(slot1, slot3)
	else
		slot0:MoveLookToDir(slot1, slot3, Dorm.DormEntityManager.QueryForwardDir(slot2))
	end
end

function slot0.InteractToTarget(slot0, slot1)
	DormEventInvoke(DORM_CHARACTER_INTERACT, slot0:CurState(slot1), slot1, slot0.CookTargetList[slot1].targetItem)
end

function slot0.HasAITarget(slot0, slot1)
	return slot0.CookTargetList[slot1].targetItem ~= nil
end

function slot0.SetAITarget(slot0, slot1, slot2)
	slot0.CookTargetList[slot1].targetItem = slot2
end

function slot0.OnIdle(slot0, slot1)
	slot0.CookTargetList[slot1].targetItem = nil

	CanteenAIFunction:SetCharacterBusy(slot1, false)
end

function slot0.DisposeEntity(slot0, slot1)
	slot0.CookTargetList[slot1] = nil
end

function slot0.DisposeAllEntity(slot0)
	slot0.CookTargetList = nil
end

function slot0.Dispose(slot0)
	slot0:RemoveListener()
	slot0:DisposeAllEntity()
end

function slot0.Update(slot0)
	for slot4, slot5 in pairs(slot0.CookTargetList) do
		slot0:AIChoice(slot4, uv0)
	end
end

return slot0
