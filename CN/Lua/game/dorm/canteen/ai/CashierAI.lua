slot0 = singletonClass("CashierAI")

function slot0.Init(slot0)
	slot0:RegisterEvent()

	slot0.CashierState = {
		CashierGotoCounter = "CashierGotoCounter",
		CashierTakeBill = "CashierTakeBill",
		CashierEnterScene = "CashierEnterScene",
		CashierIdle = "CashierIdle"
	}
	slot0.CashierStateList = {}
end

function slot0.AIInit(slot0, slot1)
	if slot1 == nil or slot0.CashierStateList[slot1] then
		error("传入参数为空或实体对象id重复")

		return
	end

	slot0.cashierData = CanteenAIFunction:GetEntityData(slot1)
	slot0.cashierData.cashierObject = nil
	slot0.CashierStateList[slot1] = {
		state = slot0.CashierState.CashierEnterScene,
		lastState = {}
	}
	slot0.cashierEID = slot1

	slot0:AIChoice(slot1)
end

function slot0.RegisterEvent(slot0)
	slot0.listener = slot0.listener or EventListener.New()

	slot0.listener:RemoveAll()

	slot5 = slot0
	slot6 = slot0.DisposeEntity

	for slot5, slot6 in pairs({
		[DORM_RESTAURANT_NEW_CASHIER] = handler(slot0, slot0.AIInit),
		[ON_DORM_CHARACTER_MOVE_FINISH] = handler(slot0, slot0.ListenMoveEvent),
		[ON_DORM_CHARACTER_INTERACT_FINISH] = handler(slot0, slot0.ListenInteractEvent),
		[DORM_CHARACTER_DISPOSE] = handler(slot5, slot6)
	}) do
		slot0.listener:Register(slot5, slot6)
	end
end

function slot0.RemoveListener(slot0)
	slot0.listener:RemoveAll()
end

function slot0.ListenMoveEvent(slot0, slot1, slot2)
	if not slot0.CashierStateList[slot1] then
		return
	end

	if slot2 then
		slot0:AIChoice(slot1)
	end
end

function slot0.ListenInteractEvent(slot0, slot1, slot2)
	if not slot0.CashierStateList[slot1] then
		return
	end

	if slot2 then
		slot0:AIChoice(slot1)
	end
end

function slot0.AIChoice(slot0, slot1)
	if slot0.CashierStateList[slot1].state == nil then
		return
	end

	slot3 = CanteenAIFunction:GetEntityData(slot1)

	if slot2 == slot0.CashierState.CashierEnterScene then
		CanteenAIFunction:SetCharacterBusy(slot1, false)

		slot5 = CanteenAIFunction:GetAllEIDNameSpace(CanteenAIFunction:GetNameSpace(DormEnum.ItemType.CashierTable))[1]
		slot0.CashierStateList[slot1].lastState = slot0.CashierState.CashierEnterScene
		slot0.CashierStateList[slot1].state = slot0.CashierState.CashierGotoCounter

		DormEventInvoke(DORM_CHARACTER_MOVE_LOOK_AT, slot0.CashierState.CashierGotoCounter, slot1, CanteenAIFunction:GetNearestPoint(slot1, CanteenItemManager.GetItemInteractPositions(slot5)), Dorm.DormEntityManager.QueryPosition(slot5), false)
	elseif slot2 == slot0.CashierState.CashierGotoCounter then
		if CanteenAIFunction:GetCharacterBusy(slot1) == false then
			slot0.CashierStateList[slot1].lastState = slot0.CashierState.CashierGotoCounter
			slot0.CashierStateList[slot1].state = slot0.CashierState.CashierIdle
		else
			return
		end
	elseif slot2 == slot0.CashierState.CashierIdle then
		CanteenAIFunction:SetCharacterBusy(slot1, true)
	end
end

function slot0.RePlaneAI(slot0, slot1, slot2)
	if slot2 then
		slot0:AIChoice(slot1)
	else
		slot0.CashierStateList[slot1].state = slot0.CashierStateList[slot1].lastState
		slot0.CashierStateList[slot1].lastState = nil

		slot0:AIChoice(slot1)
	end
end

function slot0.DisposeEntity(slot0, slot1)
	if slot0.CashierStateList[slot1] then
		slot0.CashierStateList[slot1] = nil
	end
end

function slot0.DisposeAllEntity(slot0)
	slot0.CashierStateList = nil
end

function slot0.Dispose(slot0)
	slot0:DisposeAllEntity()
	slot0:RemoveListener()
end

return slot0
