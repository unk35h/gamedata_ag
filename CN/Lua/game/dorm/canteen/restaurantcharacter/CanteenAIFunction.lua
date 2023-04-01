return {
	FindAvailableChair = function (slot0, slot1)
	end,
	FindAvailableItem = function (slot0, slot1, slot2)
		slot5 = {}
		slot9 = CanteenItemManager.ItemEIdNamespace(slot2)
		slot10 = pairs

		for slot9, slot10 in Dorm.storage:ForeachData(slot9, slot10) do
			if slot0.GetItemAvailable(slot0, slot10) then
				table.insert(slot5, slot10)
			end
		end

		return slot5[math.random(1, #slot5)]
	end,
	FindPoint = function (slot0, slot1)
		if Dorm.storage:RndPickData(CanteenManager.PosNamespace(slot1)) == nil then
			error(string.format("无%s类点可随机挑选", slot1))
		end

		return slot3.transform.position
	end,
	FindNearestPoint = function (slot0, slot1, slot2)
		slot4 = {}
		slot8 = CanteenManager.PosNamespace(slot2)
		slot9 = pairs

		for slot8, slot9 in Dorm.storage:ForeachData(slot8, slot9) do
			table.insert(slot4, slot9.transform.position)
		end

		return uv0:GetNearestPoint(slot1, slot4)
	end,
	GetNearestPoint = function (slot0, slot1, slot2)
		return slot0.GetNearestPointFrom(slot0, Dorm.DormEntityManager.QueryPosition(slot1), slot2)
	end,
	GetNearestPointFrom = function (slot0, slot1, slot2)
		if #slot2 > 1 then
			table.sort(slot2, function (slot0, slot1)
				return slot0:Distance(uv0) < slot1:Distance(uv0)
			end)
		end

		return slot2[1]
	end,
	GetItemAvailable = function (slot0, slot1)
		if slot0.GetEntityData(slot0, slot1).available == nil then
			slot2.available = true
		end

		return slot2.available
	end,
	SetItemAvailable = function (slot0, slot1, slot2)
		slot0.GetEntityData(slot0, slot1).available = slot2
	end,
	SetCharacterBusy = function (slot0, slot1, slot2)
		if slot0.GetEntityData(slot0, slot1) then
			slot3.busy = slot2
		end
	end,
	SetCharacterTarget = function (slot0, slot1, slot2)
		if slot0.GetEntityData(slot0, slot1) then
			slot3.target = slot2
		end
	end,
	GetCharacterBusy = function (slot0, slot1)
		return slot0.GetEntityData(slot0, slot1).busy
	end,
	GetCharacterPickItem = function (slot0, slot1)
		return slot0.GetEntityData(slot0, slot1).pick
	end,
	GetCurCanteenMode = function (slot0)
		if CanteenAIFunction:GetEntityIDInSpace(DormEnum.Namespace.RestaurantBusiness, CanteenManager.businessModeField) ~= nil then
			return slot1
		else
			error("未获取到当前餐厅运营模式")
		end
	end,
	GetEntityData = function (slot0, slot1)
		return Dorm.storage:GetData(DormEnum.Namespace.EntityData, slot1)
	end,
	GetNameSpace = function (slot0, slot1)
		return CanteenItemManager.ItemEIdNamespace(slot1)
	end,
	GetEntityIDInSpace = function (slot0, slot1, slot2)
		return Dorm.storage:GetData(slot1, slot2)
	end,
	GetFoodManualIndex = function (slot0, slot1)
		return Dorm.storage:GetData(CanteenItemManager.ItemIdxNamespace(DormEnum.ItemType.Food), slot1)
	end,
	GetAllEIDByItemType = function (slot0, slot1)
		return slot0.GetAllEIDNameSpace(slot0, CanteenItemManager.ItemEIdNamespace(slot1))
	end,
	GetAllEIDNameSpace = function (slot0, slot1)
		slot2 = {}
		slot6 = slot1
		slot7 = pairs

		for slot6, slot7 in Dorm.storage:ForeachData(slot6, slot7) do
			table.insert(slot2, slot7)
		end

		return slot2
	end,
	SetCustomerWaitFoodTimer = function (slot0, slot1, slot2)
		slot0.GetEntityData(slot0, slot1).waitFoodTimer = slot2

		slot2.Start(slot2)
	end,
	StopCustomerWaitFoodTimer = function (slot0, slot1)
		if slot0.GetEntityData(slot0, slot1).waitFoodTimer ~= nil then
			slot2.waitFoodTimer:Stop()

			slot2.waitFoodTimer = nil
		end
	end,
	SetCustomerWaitBillTimer = function (slot0, slot1, slot2)
		if slot0.GetEntityData(slot0, slot1).waitBillTimer == nil then
			slot3.waitBillTimer = slot2
		else
			error("顾客已经有等待结账计时器")
		end
	end,
	StopCustomerWaiteBillTimer = function (slot0, slot1)
		if slot0.GetEntityData(slot0, slot1) and slot2.waitBillTimer then
			slot2.waitBillTimer:Stop()
			print("关闭顾客等待结账计时器")
		end
	end,
	CheckCharacterInteractPostion = function (slot0, slot1, slot2)
	end,
	GetEntityType = function (slot0, slot1)
		return Dorm.storage:GetData(DormEnum.Namespace.EntityType, slot1)
	end,
	IdentifyCookType = function (slot0, slot1)
		if slot0.GetEntityType(slot0, slot1) == DormEnum.ItemType.Pan or slot2 == DormEnum.ItemType.Oven or slot2 == DormEnum.ItemType.Pot or slot2 == DormEnum.ItemType.Steamer then
			return true
		end

		return false
	end,
	GetAllEntityInSameGroup = function (slot0, slot1)
		return slot0.GetEntityData(slot0, slot1).peer
	end
}
