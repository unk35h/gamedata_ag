slot0 = singletonClass("RestaurantManager")

function slot0.Ctor(slot0)
	slot0.characterManager = CanteenCharacterManager.GetInstance()
	slot0.dormItemManager = CanteenItemManager.GetInstance()
	slot0.listener = EventListener.New()

	slot0:ResetAllData()
end

function slot0.PosNamespace(slot0)
	return "restaurant.pos." .. slot0
end

function slot0.StartAutoRestaurant()
	slot0 = Dorm.restaurant
	slot1 = DormEnum.RestaurantMode.RestaurantAuto

	slot0:Reset()
	Dorm.storage:Reset()
	slot0:Init(slot1)
	slot0:StartGenCustomer(slot1)
end

function slot0.StartManualRestaurant()
	slot0 = Dorm.restaurant
	slot1 = DormEnum.RestaurantMode.RestaurantManual

	slot0:Reset()
	Dorm.storage:Reset()
	slot0:Init(slot1)
	slot0:StartGenCustomer(slot1)
	CookAI.GetInstance():Dispose()
end

function slot0.RegisterEvent(slot0)
	for slot5, slot6 in pairs({
		[DORM_RESTAURANT_START_AUTO] = uv0.StartAutoRestaurant,
		[DORM_RESTAURANT_START_MANUAL] = uv0.StartManualRestaurant,
		[DORM_RESTAURANT_NEW_ITEM] = function (slot0, slot1)
			if slot0 == DormEnum.ItemType.DinningTable then
				CanteenAIFunction:GetEntityData(slot1).available = false
			end
		end,
		[DORM_CLICK_ENTITY] = uv0.OnClickEntity
	}) do
		slot0.listener:Register(slot5, slot6)
	end
end

function slot0.RemoveEvent(slot0)
	slot0.listener:RemoveAll()
end

function slot0.ResetAllData(slot0, slot1)
	slot0.businessInfo = {
		[slot0.businessModeField] = slot1,
		[slot0.orderFoodListField] = {}
	}
	slot5 = DormEnum.Namespace.RestaurantBusiness
	slot6 = slot0.businessInfo

	Dorm.storage:MapToData(slot5, slot6)

	for slot5, slot6 in pairs(Dorm.sceneItemInfo) do
		Dorm.storage:MapToData(slot5, slot6)
	end
end

function slot0.Init(slot0, slot1)
	slot0:ResetAllData(slot1)
	slot0.dormItemManager:Init()
	CookAI.GetInstance():Init()
	CashierAI.GetInstance():Init()
	NormalCustomerAI.GetInstance():Init()
	WaiterAI.GetInstance():Init()
	slot0.characterManager:Init()
	DormCharacterActionManager:Init()
	DormCharacterActionExecute.GetInstance():Init()
end

function slot0.Reset(slot0)
	CookAI.GetInstance():Dispose()
	CashierAI.GetInstance():Dispose()
	NormalCustomerAI.GetInstance():Dispose()
	WaiterAI.GetInstance():Dispose()
	DormCharacterActionManager:Reset()
	DormCharacterActionExecute.GetInstance():Reset()
	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_stop", "")
	slot0.characterManager:Reset()
	slot0.dormItemManager:Reset()
	slot0:ResetAllData()
end

slot0.businessModeField = "businessMode"
slot0.orderFoodListField = "orderFoodList"

function slot1()
	slot0 = 0
	slot5 = CanteenItemManager.ItemEIdNamespace(DormEnum.ItemType.DinningTable)
	slot6 = pairs

	for slot5, slot6 in Dorm.storage:ForeachData(slot5, slot6) do
		if CanteenAIFunction:GetEntityData(slot6).level and slot7.level > 0 then
			slot0 = slot0 + 1
		end
	end

	return slot0
end

function slot2(slot0)
	slot1 = uv0()
	slot3 = slot0:QueryTime() / slot0.duration * 100
	slot4 = {
		0,
		0
	}

	for slot8, slot9 in ipairs(GameDisplayCfg.canteen_customer_limited.value) do
		if slot3 < slot9[1] then
			break
		end

		slot4 = slot9
	end

	return math.min(slot1, slot4[2])
end

function slot0.StartGenCustomer(slot0, slot1)
	if slot1 == DormEnum.RestaurantMode.RestaurantManual then
		slot2 = slot0:StartManualBusinessTimer()
		slot3 = slot0.characterManager

		slot3:StartGenCustomerTask(function ()
			return uv0(uv1)
		end)

		return
	end

	slot2 = slot0.characterManager

	slot2:StartGenCustomerTask(function ()
		return uv0()
	end)
end

function slot0.StartManualBusinessTimer(slot0)
	slot4 = DormCharacterActionManager.taskRunner:NewTimer(function ()
		uv0.characterManager:StopGenCustomerTask()
		uv1:NewTask():WaitUntil(function ()
			return uv0.characterManager:GetCharacterCount(DormEnum.CharacterType.RestaurantNormalCustomer) == 0
		end):Then(function ()
			CanteenData:SetCanteenState(DormEnum.RestaurantMode.RestaurantAuto)
		end):Start()
	end, GameSetting.dorm_operate_time.value[1], false, false)

	slot4:Start()

	slot0.businessInfo.timer = slot4

	return slot4
end

function slot0.FinishManualRestaurant(slot0)
end

function slot0.GetCurPopularity(slot0)
	return CanteenData:GetPopularityNum()
end

function slot0.OnChooseFood(slot0, slot1)
	slot6 = "restaurant.foodList"

	slot0:ClearData(slot6)

	for slot6, slot7 in ipairs(CanteenData:GetChooseFoodList()) do
		slot0:RecordData("restaurant.foodList", slot6, slot7)
	end
end

slot0.InteractPointMap = "restaurant.interactPointMap"

function slot0.PointToGridKey(slot0)
	return Dorm.DormEntityManager.GetGridIndex(slot0)
end

function slot0.RecordInteractPointInfo(slot0, slot1, slot2)
	Dorm.storage:GetData(uv0.InteractPointMap, uv0.PointToGridKey(slot0), {})[slot1] = slot2 or ""
end

function slot0.RemoveInteractPointInfo(slot0)
	slot4 = uv0.InteractPointMap
	slot5 = pairs

	for slot4, slot5 in Dorm.storage:ForeachData(slot4, slot5) do
		for slot9, slot10 in pairs(slot5) do
			if slot9 == slot0 then
				slot5[slot9] = nil
			end
		end
	end
end

function slot0.GetItemInteractPointsOnGrid(slot0)
	return Dorm.storage:GetData(uv0.InteractPointMap, uv0.PointToGridKey(slot0), {})
end

function slot0.GetCustomerGroupCount(slot0)
	return slot0.businessInfo.customerGroup or 0
end

function slot0.OnCustomerCome(slot0)
	slot0.businessInfo.customerGroup = slot0:GetCustomerGroupCount() + 1
end

function slot0.OnCustomerLeave(slot0, slot1)
	slot2 = slot0:GetCustomerGroupCount() - 1
	slot0.businessInfo.customerGroup = slot2

	uv0.ReleaseDinningTableFromCustomer(slot1)

	if slot2 == 0 and CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual and not CanteenCharacterManager.CheckFoodEnoughGenCustomer() then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("CANTEEN_MANNUALLY_FOOD_EMPTY"),
			OkCallback = function ()
				CanteenData:SetCanteenState(DormEnum.RestaurantMode.RestaurantAuto)
			end
		})
	end
end

function slot0.ReleaseDinningTableFromCustomer(slot0)
	CanteenAIFunction:GetEntityData(CanteenAIFunction:GetEntityData(slot0).tableEid).booked = nil
end

function slot0.ArrangeDinningTableForCustomer()
	slot1 = {}
	slot5 = CanteenItemManager.ItemEIdNamespace(DormEnum.ItemType.DinningTable)
	slot6 = pairs

	for slot5, slot6 in Dorm.storage:ForeachData(slot5, slot6) do
		if CanteenAIFunction:GetEntityData(slot6).level and slot7.level > 0 and not slot7.booked then
			table.insert(slot1, slot6)
		end
	end

	return slot1[math.random(1, #slot1)]
end

function slot3(slot0, slot1)
	slot1 = slot1 or {}

	if CanteenAIFunction:GetEntityData(slot0).foodList then
		for slot6, slot7 in pairs(slot2.foodList) do
			slot1[CanteenAIFunction:GetEntityData(slot7).cfgID] = true
		end
	end

	return slot1
end

function slot4(slot0, slot1)
	slot1 = slot1 or {}

	if CanteenAIFunction:GetEntityData(slot0).pick then
		slot1[CanteenAIFunction:GetEntityData(slot2.pick).cfgID] = true
	end

	return slot1
end

function slot0.CalcCanOrderFoodList()
	slot0 = {}
	slot3 = CanteenData
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetCanOrderFoodList(slot5)) do
		slot0[slot5] = true
	end

	if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
		slot2 = CanteenCharacterManager.EIdNamespace(DormEnum.CharacterType.RestaurantCook)
		slot6 = CanteenItemManager.ItemEIdNamespace(DormEnum.ItemType.PassTable)
		slot7 = pairs

		for slot6, slot7 in Dorm.storage:ForeachData(slot6, slot7) do
			slot0 = uv0(slot7, slot0)
		end

		slot6 = slot2
		slot7 = pairs

		for slot6, slot7 in Dorm.storage:ForeachData(slot6, slot7) do
			slot0 = uv1(slot7, slot0)
		end
	end

	return slot0
end

function slot0.GetRestaurantOrderList()
	return Dorm.storage:GetData(DormEnum.Namespace.RestaurantBusiness, uv0.orderFoodListField)
end

function slot0.AddOrder(slot0)
	slot0.status = DormEnum.FoodState.Wait

	table.insert(uv0.GetRestaurantOrderList(), slot0)
	manager.notify:Invoke(CANTEEN_ORDER_FOOD_LIST_CHANGE)

	return slot0
end

function slot5(slot0)
	return slot0.status == DormEnum.FoodState.TimeOut or slot0.status == DormEnum.FoodState.HasServer or slot0.status == DormEnum.FoodState.Canceled
end

function slot0.RefreshOrder()
	for slot4 = #uv0.GetRestaurantOrderList(), 1, -1 do
		if uv1(slot0[slot4]) then
			table.remove(slot0, slot4)
		end
	end
end

function slot0.OnClickEntity(slot0)
	slot2 = CanteenAIFunction:GetEntityData(slot0)

	if DormEnum.ItemType[CanteenAIFunction:GetEntityType(slot0)] and slot2.groupID then
		manager.notify:Invoke(CANTEEN_FUR_LEVEL, slot2.groupID)
	end
end

function slot0.SetGroupItemLocked(slot0, slot1)
end

return slot0
