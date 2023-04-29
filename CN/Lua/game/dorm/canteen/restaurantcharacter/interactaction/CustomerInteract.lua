slot0 = import(".InteractUtil")
slot1 = slot0.waitAnime.defaultWaitAnimation
slot2 = slot0.waitAnime.handleEventWaitAnimation
slot3 = slot0.GetEntityType
slot4 = slot0.GetEntityBB
slot5 = slot0.NewTask
slot6 = slot0.NewTimer
slot7 = slot0.IsCanteenManualMode
slot8 = slot0.SnapToNearestInteractPoint
slot9 = slot0.RefreshFoodContainer
slot10 = slot0.PickFoodFromTable
slot11 = slot0.PutFoodOnTable
slot12 = slot0.commonAction.PickItemAction
slot13 = slot0.commonAction.PlaceCarryingItemAction

function slot14(slot0)
	slot1 = slot0.entityID
	slot2 = slot0.targetID
	slot3 = slot0.finish
	slot4 = slot0.entityData
	slot0.targetData.character = slot1

	uv0(function ()
		Dorm.DormEntityManager.PutEntityAt(uv0, uv1, "gua_sit")
		Dorm.DormEntityManager.PlayAnimeDuringInteract(uv0, "sit_down", nil, 0)
	end):HandleAnimeLoop(uv1(slot1, "sit_down", function ()
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(uv0, "sit")
		Dorm.DormEntityManager.SetEntityMobility(uv0, false)
	end)):Then(function ()
		uv0.sit = true

		if uv0.pay then
			CanteenAIFunction:SetItemAvailable(uv0.tableEid, true)
		end

		uv1:Notify()
	end):Start()
end

function slot15(slot0)
	slot2 = slot0.targetID
	slot3 = slot0.finish
	slot5 = slot0.targetData
	slot6 = CanteenItemManager.GetItemInteractPositions(slot2)
	slot8 = slot6[math.random(1, #slot6)]
	slot9 = Dorm.DormEntityManager.QueryForwardDir(slot2)
	slot0.entityData.sit = false

	uv0(function ()
		Dorm.DormEntityManager.PutEntityAt(uv0, uv1, "gua_start_sit")
		Dorm.DormEntityManager.PlayAnimeDuringInteract(uv0, "sit_up", nil, 0)
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(uv0, "default")
	end):HandleAnimeLoop(uv1(slot0.entityID, "sit_up")):Then(function ()
		if uv0.pay then
			CanteenAIFunction:SetItemAvailable(uv0.tableEid, false)
		end

		uv1.character = nil

		CanteenAIFunction:SetItemAvailable(uv2, true)
		Dorm.DormEntityManager.SetEntityMobility(uv3, true)

		if uv0.pay then
			CanteenManager.GetInstance():OnCustomerLeave(uv3)
		end

		uv4:Notify()
	end):Start()
end

function slot16(slot0)
	slot2 = uv0(slot0.entityData.tableEid)

	uv1():WaitUntil(function ()
		return uv0.orderInfo ~= nil
	end, true):Then(function ()
		for slot3, slot4 in ipairs(uv0.orderInfo) do
			slot4.orderCharacterID = uv1.entityID
			slot4.orderTableID = uv0.tableEid

			CanteenManager.AddOrder(slot4)
		end

		uv2.curOrder = uv0.orderInfo
		uv0.eat = false

		uv1.finish:Notify()
	end):Start(true)
end

function slot17(slot0)
	for slot5 = #slot0.foodList, 1, -1 do
		slot6 = slot1[slot5]

		table.remove(slot1, slot5)
		uv0(function ()
			Dorm.DormEntityManager.StartFadeOutCMD(uv0, 1)
		end):WaitForSec(1):Then(function ()
			CanteenItemManager.FindAndRemoveEntity(uv0)
		end):Start()
	end
end

function slot18(slot0)
	slot1 = slot0.entityID
	slot2 = slot0.targetID
	slot3 = slot0.finish

	if uv0() then
		CanteenData:RecordManualSerCustomerNum(1)
	end

	slot4 = slot0.entityData
	slot4.eat = true

	CanteenAIFunction:SetItemAvailable(slot4.tableEid, false)
	uv1(function ()
		Dorm.DormEntityManager.PlayAnimeDuringInteract(uv0, "sit_eat")
	end):HandleAnimeLoop(uv2(slot1, "sit_eat")):Then(function ()
		if uv0.pay then
			uv1(uv2.targetData)
		end

		uv3:Notify()
	end):Start()
end

function slot19(slot0)
	slot1 = slot0.entityID
	slot2 = slot0.targetID
	slot3 = slot0.finish
	slot4 = slot0.entityData

	uv0(function ()
		Dorm.DormEntityManager.PlayAnimeDuringInteract(uv0, "manners")
		Dorm.DormEntityManager.PlayAnimeDuringInteract(uv1, "stand")
	end):WaitForSec(5):Then(function ()
		uv0:Notify()
	end):Start()
end

return function (slot0)
	slot2 = slot0.entityData

	if slot0.targetType == DormEnum.ItemType.DinningChair then
		if not slot2.sit then
			uv0(slot0)
		else
			uv1(slot0)
		end
	elseif slot1 == DormEnum.ItemType.OrderFoodDummy then
		uv2(slot0)
	elseif slot1 == DormEnum.ItemType.DinningTable then
		uv3(slot0)
	elseif slot1 == DormEnum.CharacterType.RestaurantCashier then
		uv4(slot0)
	else
		slot0.finish:Notify(false)
		print("交互对象类型没找到")
	end
end
