slot1 = import(".InteractUtil").NewTask

function slot2(slot0)
	slot1 = slot0.entityID
	slot2 = slot0.targetID
	slot3 = slot0.finish
	slot4 = slot0.entityData

	for slot9, slot10 in pairs(slot0.targetData.booked) do
		CanteenAIFunction:SetItemAvailable(slot10, false)
	end

	uv0.commonAction.PlaceCarryingItemAction(slot1, slot2, function (slot0)
		slot4 = uv1

		uv0.PutFoodOnTable(slot0, slot4)
		uv0.RefreshFoodContainer(uv1)

		for slot4, slot5 in pairs(uv2.booked) do
			CanteenAIFunction:SetItemAvailable(slot5, true)
		end
	end):Then(function ()
		uv0:Notify()
	end):Start()
end

function slot3(slot0)
	slot1 = slot0.entityID
	slot2 = slot0.targetID
	slot3 = slot0.finish

	if slot0.entityData.pick then
		uv0.PlaceCarryingItemAction(slot1, slot2, function (slot0)
			uv0.PutFoodOnTable(slot0, uv1)
			uv0.RefreshFoodContainer(uv1)
		end):Then(function (slot0)
			uv0:Notify()
		end):Start()
	else
		CanteenManager.RefreshOrder()

		slot4.target = uv0.PickFoodFromTable(slot4.target, slot2)

		uv0.commonAction.PickItemAction(slot1, slot2, function (slot0)
			uv0.RefreshFoodContainer(uv1)
		end):Then(function ()
			uv0:Notify()
		end):Start()
	end
end

return function (slot0)
	slot2 = slot0.finish

	if slot0.targetType == DormEnum.ItemType.DinningTable then
		uv0(slot0)
	elseif slot1 == DormEnum.ItemType.PassTable then
		uv1(slot0)
	else
		slot2.Notify(slot2, false)
		error("错误交互")
	end
end
