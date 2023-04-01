slot0 = singletonClass("SpecialCustomerAI")

function slot0.Init(slot0)
	slot0.restaurantBB = 1

	slot0:RegisterEvent()

	slot0.SpecialCustomerTargetList = {}
	slot0.SpecialCustomerTarget = {
		SpecialCustomerEnterScene = "SpecialCustomerEnterScene",
		SpecialCustomerOrderFood = "SpecialCustomerOrderFood",
		SpecialCustomerGotoCashier = "SpecialCustomerGotoCashier",
		SpecialCustomerWaitBill = "SpecialCustomerWaitBill",
		SpecialCustomerLeaveSeat = "SpecialCustomerLeaveSeat",
		SpecialCustomerTakeBillWithCashier = "SpecialCustomerTakeBillWithCashier",
		SpecialCustomerTakeSeat = "SpecialCustomerTakeSeat",
		SpecialCustomerGotoExit = "SpecialCustomerGotoExit",
		SpecialCustomerEatFood = "SpecialCustomerEatFood",
		SpecialCustomerWaitFood = "SpecialCustomerWaitFood",
		SpecialCustomerDispose = "SpecialCustomerDispose",
		SpecialCustomerGotoTable = "SpecialCustomerGotoTable"
	}
end

function slot0.AIInit(slot0, slot1)
	if slot1 == nil or slot0.SpecialCustomerTargetList[slot1] then
		error("传入参数为空或实体对象id重复")

		return
	end

	slot0.SpecialCustomerTargetList[slot1] = {
		target = slot0.SpecialCustomerTarget.SpecialCustomerEnterScene,
		interactID = {}
	}

	slot0:AIChoice(slot1)
end

function slot0.RegisterEvent(slot0)
	slot1 = manager.notify

	slot1:RegistListener(DORM_RESTAURANT_NEW_CUSTOMER, function (slot0)
		uv0:AIInit(slot0)
	end)

	slot1 = manager.notify

	slot1:RegistListener(ON_DORM_CHARACTER_MOVE_FINISH, function (slot0, slot1)
		if not uv0.SpecialCustomerTargetList[slot0] then
			return
		end

		if slot1 then
			uv0:AIChoice(slot0)
		else
			uv0:RePlaneAI(slot0)
		end
	end)

	slot1 = manager.notify

	slot1:RegistListener(ON_DORM_CHARACTER_INTERACT_FINISH, function (slot0, slot1)
		if not uv0.SpecialCustomerTargetList[slot0] then
			return
		end

		if slot1 then
			uv0:AIChoice(slot0)
		else
			uv0:RePlaneAI(slot0)
		end
	end)

	slot1 = manager.notify

	slot1:RegistListener(DORM_RESTAURANT_INTERACT_CUSTOMER, function (slot0)
		if not uv0.SpecialCustomerTargetList[slot0] and uv0.SpecialCustomerTargetList[slot0].target == uv0.SpecialCustomerTarget.SpecialCustomerWaitBill then
			uv0.SpecialCustomerTargetList[slot0].payTimer:Stop()
			uv0:AIChoice(slot0)
		end
	end)
end

function slot0.AIChoice(slot0, slot1)
	if slot0.SpecialCustomerTargetList[slot1].target == nil then
		print("普通客人列表不存在该实例对象id")

		return
	end

	if slot2 == slot0.SpecialCustomerTarget.SpecialCustomerEnterScene then
		print(string.format("生成客人%d号", slot1))

		slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTarget.SpecialCustomerGotoTable

		DormEventInvoke(DORM_CHARACTER_MOVE, slot0.SpecialCustomerTarget.SpecialCustomerGotoTable, slot1, slot0:ChoiceEndPosition(slot1))
	elseif slot2 == slot0.SpecialCustomerTarget.SpecialCustomerGotoTable then
		slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTarget.SpecialCustomerTakeSeat

		print(string.format("%d号客人抵达餐桌", slot1))
		DormEventInvoke(DORM_CHARACTER_INTERACT, slot0.SpecialCustomerTarget.SpecialCustomerTakeSeat, slot1)
	elseif slot2 == slot0.SpecialCustomerTarget.SpecialCustomerTakeSeat then
		if slot0:OrderFood(slot1) then
			slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTarget.SpecialCustomerWaitFood

			DormEventInvoke(DORM_CHARACTER_INTERACT, slot0.SpecialCustomerTarget.SpecialCustomerWaitFood, slot1)

			slot0.SpecialCustomerTargetList[slot1].waitTimer = Timer.New(handlerArg1(slot0, slot0.WaitFoodCallBack, slot1), DormData.dorm_customer_wait_food_time, 1)

			slot0.SpecialCustomerTargetList[slot1].waitTimer:Start()
		else
			slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTarget.SpecialCustomerLeaveSeat

			DormEventInvoke(DORM_CHARACTER_INTERACT, slot0.SpecialCustomerTarget.SpecialCustomerLeaveSeat, slot1)
		end
	elseif slot2 == slot0.SpecialCustomerTarget.SpecialCustomerWaitFood then
		slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTarget.SpecialCustomerEatFood

		DormEventInvoke(DORM_CHARACTER_INTERACT, slot0.SpecialCustomerTarget.SpecialCustomerEatFood, slot1)
	elseif slot2 == slot0.SpecialCustomerTarget.SpecialCustomerEatFood then
		if DormCharacterActionManager:CheckSetRole(DormEnum.CharacterType.Cashier) then
			slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTarget.SpecialCustomerLeaveSeat

			DormEventInvoke(DORM_CHARACTER_INTERACT, slot0.SpecialCustomerTarget.SpecialCustomerLeaveSeat, slot1)
		else
			slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTarget.SpecialCustomerWaitBill

			manager.notify:Invoke(DORM_RESTAURANT_CUSTOMER_WAIT_TAKE_BILL, slot1)

			slot0.SpecialCustomerTargetList[slot1].payTimer = Timer.New(handlerArg1(slot0, slot0.WaitBillCallBack, slot1), DormData.dorm_customer_wait_pay_time, 1)

			slot0.SpecialCustomerTargetList[slot1].payTimer:Start()
			DormEventInvoke(DORM_CHARACTER_INTERACT, slot0.SpecialCustomerTarget.SpecialCustomerWaitBill, slot1)
		end
	elseif slot2 == slot0.SpecialCustomerTarget.SpecialCustomerWaitBill then
		slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTarget.SpecialCustomerLeaveSeat

		DormEventInvoke(DORM_CHARACTER_INTERACT, slot0.SpecialCustomerTarget.SpecialCustomerLeaveSeat, slot1)
	elseif slot2 == slot0.SpecialCustomerTarget.SpecialCustomerLeaveSeat then
		if slot1.eat then
			if slot1.pay then
				slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTarget.SpecialCustomerGotoExit

				DormEventInvoke(DORM_CHARACTER_MOVE, slot0.SpecialCustomerTarget.SpecialCustomerGotoExit, slot1, slot0:ChoiceEndPosition(slot1))
			elseif slot1.pay == false and cashier.has == false then
				slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTarget.SpecialCustomerGotoExit

				DormEventInvoke(DORM_CHARACTER_MOVE, slot0.SpecialCustomerTarget.SpecialCustomerGotoExit, slot1, slot0:ChoiceEndPosition(slot1))
			elseif slot1.pay == false and cashier.has then
				slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTarget.SpecialCustomerGotoCashier

				DormEventInvoke(DORM_CHARACTER_MOVE, slot0.SpecialCustomerTarget.SpecialCustomerGotoCashier, slot1, slot0:ChoiceEndPosition(slot1))
			end
		else
			slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTarget.SpecialCustomerGotoExit

			DormEventInvoke(DORM_CHARACTER_MOVE, slot0.SpecialCustomerTarget.SpecialCustomerGotoExit, slot1, slot0:ChoiceEndPosition(slot1))
		end
	elseif slot2 == slot0.SpecialCustomerTarget.SpecialCustomerGotoCashier then
		slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTarget.SpecialCustomerTakeBillWithCashier

		manager.notify:Invoke(DORM_RESTAURANT_CASHIER_TAKE_BILL, slot1)
		DormEventInvoke(DORM_CHARACTER_INTERACT, slot0.SpecialCustomerTarget.SpecialCustomerTakeBillWithCashier, slot1)
	elseif slot2 == slot0.SpecialCustomerTarget.SpecialCustomerTakeBillWithCashier then
		slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTarget.SpecialCustomerGotoExit

		DormEventInvoke(DORM_CHARACTER_MOVE, slot0.SpecialCustomerTarget.SpecialCustomerGotoExit, slot1, slot0:ChoiceEndPosition(slot1))
	elseif slot2 == slot0.SpecialCustomerTarget.SpecialCustomerGotoExit then
		slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTarget.SpecialCustomerDispose

		DormEventInvoke(DORM_CHARACTER_DISPOSE, slot0.SpecialCustomerTarget.SpecialCustomerDispose, slot1)
		slot0:DisposeEntity(slot1)
	else
		error("未找到" .. slot1 .. "对象的选择")
	end
end

function slot0.RePlaneAI(slot0, slot1)
	if slot0.SpecialCustomerTargetList[slot1].target == slot0.SpecialCustomerTarget.SpecialCustomerGotoTable then
		-- Nothing
	elseif slot2 == slot0.SpecialCustomerTarget.SpecialCustomerGotoExit then
		-- Nothing
	elseif slot2 == slot0.SpecialCustomerTarget.SpecialCustomerGotoCashier then
		-- Nothing
	end
end

function slot0.ChoiceEndPosition(slot0, slot1)
	if slot0.SpecialCustomerTargetList[slot1].target == slot0.SpecialCustomerTarget.SpecialCustomerGotoTable then
		return buildVector3({
			10,
			0,
			3
		})
	elseif slot0.SpecialCustomerTargetList[slot1].target == slot0.SpecialCustomerTarget.SpecialCustomerGotoCashier then
		return buildVector3({
			8,
			0,
			3
		})
	elseif slot0.SpecialCustomerTargetList[slot1].target == slot0.SpecialCustomerTarget.SpecialCustomerGotoExit then
		return buildVector3({
			-10,
			0,
			0
		})
	end
end

function slot0.OrderFood(slot0, slot1)
	slot2 = {}

	for slot6 = 1, DormConst.ORDER_FOOD_NUM do
		if 101 then
			table.insert(slot7)
		else
			break
		end
	end

	DormEventInvoke(DORM_ORDER_FOOD, slot0.SpecialCustomerTarget.SpecialCustomerOrderFood, slot1, slot2)

	return true
end

function slot0.WaitFoodCallBack(slot0, slot1)
	if slot0.SpecialCustomerTargetList[slot1].target == slot0.SpecialCustomerTarget.SpecialCustomerWaitFood then
		slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTargetSpecialCustomerLeaveSeat

		slot0.SpecialCustomerTargetList[slot1].waitTimer:Stop()
		slot0.AIChoice(slot1)
	end
end

function slot0.WaitBillCallBack(slot0, slot1)
	if slot0.SpecialCustomerTargetList[slot1].target == slot0.SpecialCustomerTarget.SpecialCustomerWaitBill then
		slot0.SpecialCustomerTargetList[slot1].target = slot0.SpecialCustomerTarget.SpecialCustomerLeaveSeat

		slot0.SpecialCustomerTargetList[slot1].payTimer:Stop()
		slot0:AIChoice(slot1)
	end
end

function slot0.DisposeEntity(slot0, slot1)
	slot0.SpecialCustomerTargetList[slot1] = nil
end

return slot0
