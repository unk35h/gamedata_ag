slot0 = class("DormPlayerControllerView", ReduxView)

function slot1(slot0)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityType, slot0)
end

function slot2(slot0)
	return EntityManager.ValidateEntity(EntityManager.all, slot0)
end

function slot0.UIName(slot0)
	return "UI/EmptyDream/canteen/EmptyDreamPlayerControlUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

slot3 = {}

function slot0.OnCtor(slot0)
	slot0.playerEID = nil
	slot0.curTargetList = {}
	slot0.curFocusTargetEID = nil
	slot0.interactRange = 0.5
	uv0.carry = {
		[DormEnum.ItemType.PassTable] = true,
		[DormEnum.ItemType.DinningTable] = true,
		[DormEnum.ItemType.TrashCan] = true
	}
	uv0.normal = {
		[DormEnum.ItemType.Pan] = true,
		[DormEnum.ItemType.Oven] = true,
		[DormEnum.ItemType.Steamer] = true,
		[DormEnum.ItemType.Pot] = true,
		[DormEnum.ItemType.Food] = true,
		[DormEnum.ItemType.PassTable] = true,
		[DormEnum.CharacterType.RestaurantNormalCustomer] = true
	}
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0:RegistEventListener(DORM_RESTAURANT_LOGIC_TICK, handler(slot0, slot0.Update))
	slot0:RegistEventListener(ON_DORM_CHARACTER_INTERACT_FINISH, handler(slot0, slot0.Update))
	slot0:RegistEventListener(DORM_CHARACTER_DISPOSE, function (slot0, slot1)
		if slot0 == uv0.playerEID then
			uv0:ReleaseControl()
		end
	end)
	slot0:ReleaseControl()
	slot0:ClaimControl()

	if not slot0.params_.isBack then
		slot0:InitBubbleManager()
	end

	slot0:Update()
end

function slot0.IsKitchenware(slot0, slot1)
	return slot1 == DormEnum.ItemType.Pan or slot1 == DormEnum.ItemType.Oven or slot1 == DormEnum.ItemType.Pot or slot1 == DormEnum.ItemType.Steamer
end

function slot0.SetCustomerHighlighted(slot0, slot1, slot2)
	for slot7, slot8 in pairs(CanteenAIFunction:GetEntityData(slot1).peer) do
		Dorm.DormEntityManager.SetHighlighted(slot8, slot2)
	end
end

function slot0.SetCurTarget(slot0, slot1)
	if slot0.curFocusTargetEID and uv0(slot0.curFocusTargetEID) then
		if CanteenAIFunction:GetEntityType(slot0.curFocusTargetEID) == DormEnum.CharacterType.RestaurantNormalCustomer then
			slot0:SetCustomerHighlighted(slot0.curFocusTargetEID, false)
		else
			Dorm.DormEntityManager.SetHighlighted(slot0.curFocusTargetEID, false)
		end
	end

	if slot1 then
		if CanteenAIFunction:GetEntityType(slot1) == DormEnum.CharacterType.RestaurantNormalCustomer then
			slot0:SetCustomerHighlighted(slot1, true)
		else
			Dorm.DormEntityManager.SetHighlighted(slot1, true)
		end

		if slot0:IsKitchenware(slot2) then
			slot0.interactIconController:SetSelectedState("cook")
		elseif slot2 == DormEnum.ItemType.DinningTable then
			slot0.interactIconController:SetSelectedState("serve")
		elseif slot2 == DormEnum.ItemType.PassTable then
			slot0.interactIconController:SetSelectedState("pick")
		else
			slot0.interactIconController:SetSelectedState("normal")
		end
	end

	slot0.curFocusTargetEID = slot1
end

function slot0.InitBubbleManager(slot0)
	CharacterBubbleManager:Init()
	CharacterBubbleManager:SetUiListPrefab(slot0.bubblelistGo_, slot0.transform_)

	slot6 = CanteenItemManager.ItemEIdNamespace(DormEnum.ItemType.DinningTable)
	slot7 = pairs

	for slot6, slot7 in Dorm.storage:ForeachData(slot6, slot7) do
		CharacterBubbleManager:GenerateBubbleList(slot7)
	end
end

function slot4()
	return Dorm.storage:PickData(CanteenCharacterManager.EIdNamespace(DormEnum.CharacterType.RestaurantCook))
end

function slot0.PlayerEntityData(slot0)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityData, slot0.playerEID)
end

function slot0.ClaimControl(slot0)
	slot0.playerEID = uv0()
	slot0:PlayerEntityData().isControlledByPlayer = true

	Dorm.DormEntityManager.PlayerControlEntity(slot0.playerEID)
end

function slot0.ReleaseControl(slot0)
	if slot0.playerEID and slot0:PlayerEntityData() then
		slot1.isControlledByPlayer = false
	end

	slot0.playerEID = nil
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.interactController = ControllerUtil.GetController(slot0.controllerRoot_, "interact")
	slot0.interactIconController = ControllerUtil.GetController(slot0.interactBtn_.transform, "icon")
	slot0.activeController = ControllerUtil.GetController(slot0.controllerRoot_, "active")
	slot0.movableController = ControllerUtil.GetController(slot0.controllerRoot_, "movable")

	SetActive(slot0.stickGo_, true)
	DormLuaBridge.InitJoystick(slot0.stickGo_)
end

function slot0.Update(slot0)
	slot0:ValidateEntityMobility()

	slot1 = {}

	if slot0.playerEID then
		slot0:UpdateControlActive()
		slot0:FindAvailableInteractOnPlayerGrid(slot1)
		slot0:FindAvailableCustomerInRange(slot1)
	end

	slot0.curTargetList = slot1

	slot0:ValidateCurTargetInRange()

	slot2 = next(slot1)

	if false then
		slot0.interactController:SetSelectedState("multiTarget")
	else
		slot0.interactController:SetSelectedState("singleTarget")
	end

	if slot0.curFocusTargetEID == nil then
		slot0:SetCurTarget(slot2)

		if slot2 == nil then
			slot0.interactController:SetSelectedState("hide")
		end
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.interactBtn_, nil, function ()
		if uv0.interactClickTask then
			uv0.interactClickTask:Abort()

			uv0.interactClickTask = nil
		end

		uv0.activeController:SetSelectedState("false")

		uv0.interactClickTask = DormCharacterActionManager.taskRunner:NewTask():WaitUntil(function ()
			return uv0:EntityCanInteract(uv0.curFocusTargetEID)
		end):Then(function ()
			manager.notify:Invoke(DORM_CHARACTER_INTERACT, uv0.playerEID, uv0.curFocusTargetEID)

			uv0.interactClickTask = nil
		end)

		uv0.interactClickTask:Start()
	end)
	slot0:AddBtnListener(slot0.switchBtn_, nil, function ()
		uv0:ValidateCurTargetInRange()

		if uv0.curTargetList then
			uv0:SetCurTarget(next(slot0, uv0.curFocusTargetEID))

			if uv0.curFocusTargetEID == nil then
				uv0:SetCurTarget(next(slot0))
			end

			printf("当前目标 %s: %d", CanteenAIFunction:GetEntityType(uv0.curFocusTargetEID), uv0.curFocusTargetEID)
		end
	end)
end

function slot0.UpdateControlActive(slot0)
	slot0.activeController:SetSelectedState(CanteenAIFunction:GetEntityData(slot0.playerEID).isDuringInteract and "false" or "true")
end

function slot0.CanInteract(slot0, slot1)
	return (slot0:PlayerEntityData().pick and uv0.carry or uv0.normal)[slot1]
end

function slot0.ValidateEntityMobility(slot0)
	slot0.movableController:SetSelectedState(slot0.playerEID and Dorm.DormEntityManager.QueryMobility(slot0.playerEID) and "true" or "false")
end

function slot0.ValidateCurTargetInRange(slot0)
	if slot0.curFocusTargetEID ~= nil and (not uv0(slot0.curFocusTargetEID) or not slot0.curTargetList[slot0.curFocusTargetEID]) then
		slot0:SetCurTarget(nil)
	end
end

function slot0.EntityCanInteract(slot0, slot1)
	return slot0:CanInteract(uv0(slot1)) and CanteenAIFunction:GetItemAvailable(slot1)
end

function slot0.FindAvailableInteractOnPlayerGrid(slot0, slot1)
	for slot7, slot8 in pairs(CanteenManager.GetItemInteractPointsOnGrid(Dorm.DormEntityManager.QueryPosition(slot0.playerEID))) do
		if slot0:EntityCanInteract(slot7) then
			slot1[slot7] = slot8
		end
	end
end

function slot0.FindAvailableCustomerInRange(slot0, slot1)
	if not slot0:CanInteract(DormEnum.CharacterType.RestaurantNormalCustomer) then
		return
	end

	slot7 = CanteenCharacterManager.EIdNamespace(slot2)
	slot8 = pairs

	for slot7, slot8 in Dorm.storage:ForeachData(slot7, slot8) do
		if CanteenAIFunction:GetEntityData(slot8).pay then
			slot10 = false
			slot11 = true
			slot12 = false

			for slot16, slot17 in pairs(slot9.peer) do
				slot18 = CanteenAIFunction:GetEntityData(slot8)
				slot10 = slot10 or slot0:InRange(slot17)
				slot11 = slot11 and slot18.sit
				slot12 = slot12 or slot18.eat
			end

			if slot10 and slot11 and not slot12 then
				slot1[slot8] = slot2
			end
		end
	end
end

function slot0.InRange(slot0, slot1)
	if EntityManager.ValidateEntity(EntityManager.all, slot1) then
		return Vector3.Distance(Dorm.DormEntityManager.QueryPosition(slot0.playerEID), Dorm.DormEntityManager.QueryPosition(slot1)) < slot0.interactRange
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	if slot0.interactClickTask then
		slot0.interactClickTask:Abort()

		slot0.interactClickTask = nil
	end
end

function slot0.Dispose(slot0)
end

return slot0
