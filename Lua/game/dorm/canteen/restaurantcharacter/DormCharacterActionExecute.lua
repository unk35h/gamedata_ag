slot0 = singletonClass("DormCharacterActionExecute")
slot1 = import(".InteractAction.InteractUtil")

function slot0.Ctor(slot0)
	slot0.listen = {
		[ON_DORM_CHARACTER_INTERACT] = handler(slot0, slot0.Interact)
	}
end

slot2 = {
	NewTask = function (slot0, slot1)
		return DormCharacterActionManager.taskRunner:NewTask():Then(slot0)
	end,
	NewTimer = function (slot0, slot1, slot2, slot3)
		return DormCharacterActionManager.taskRunner:NewTimer(slot0, slot1, slot2, slot3)
	end
}
slot0.GetEntityBB = slot1.GetEntityBB
slot0.GetEntityType = slot1.GetEntityType

function slot0.Init(slot0)
	slot0:RegisterEvents()
end

function slot0.Reset(slot0)
	slot0:RemoveEvents()
end

function slot0.RegisterEvents(slot0)
	for slot4, slot5 in pairs(slot0.listen) do
		manager.notify:RegistListener(slot4, slot5)
	end
end

function slot0.RemoveEvents(slot0)
	for slot4, slot5 in pairs(slot0.listen) do
		manager.notify:RemoveListener(slot4, slot5)
	end
end

function slot0.Interact(slot0, slot1, slot2, slot3)
	slot6 = nil

	if ({
		entityID = slot1,
		targetID = slot2,
		finish = slot3,
		entityType = uv0.GetEntityType(slot1),
		targetType = uv0.GetEntityType(slot2),
		entityData = uv0.GetEntityBB(slot1),
		targetData = uv0.GetEntityBB(slot2)
	}).entityType == DormEnum.CharacterType.RestaurantCashier then
		slot6 = require("game.dorm.canteen.RestaurantCharacter.InteractAction.CashierInteract")
	elseif slot5 == DormEnum.CharacterType.RestaurantCook then
		slot6 = require("game.dorm.canteen.RestaurantCharacter.InteractAction.CookInteract")
	elseif slot5 == DormEnum.CharacterType.RestaurantWaiter then
		slot6 = require("game.dorm.canteen.RestaurantCharacter.InteractAction.WaiterInteract")
	elseif uv0.IsCustomer(slot5) then
		slot6 = require("game.dorm.canteen.RestaurantCharacter.InteractAction.CustomerInteract")
	end

	if slot6 then
		slot6(slot4)
	end
end

function slot0.FindAllItemGroup(slot0, slot1, slot2)
	slot4 = {}
	slot8 = CanteenItemManager.ItemEIdNamespace(slot1)
	slot9 = pairs

	for slot8, slot9 in Dorm.storage:ForeachData(slot8, slot9) do
		if slot0.GetEntityBB(slot9).group == slot2 then
			table.insert(slot4, slot9)
		end
	end

	return slot4
end

function slot3(slot0)
	for slot4, slot5 in ipairs(slot0) do
		slot5.statue = DormEnum.FoodState.HasServer
	end
end

return slot0
