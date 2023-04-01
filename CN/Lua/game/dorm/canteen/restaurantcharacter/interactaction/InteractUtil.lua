slot0 = {
	GetEntityBB = function (slot0)
		return Dorm.storage:GetData(DormEnum.Namespace.EntityData, slot0)
	end,
	GetEntityType = function (slot0)
		return Dorm.storage:GetData(DormEnum.Namespace.EntityType, slot0)
	end,
	NewTask = function (slot0, slot1)
		slot2 = DormCharacterActionManager.taskRunner:NewTask():SetCancellationSrc(slot1)

		if slot0 then
			slot2:Then(slot0)
		end

		return slot2
	end,
	NewTimer = function (slot0, slot1, slot2, slot3)
		return DormCharacterActionManager.taskRunner:NewTimer(slot0, slot1, slot2, slot3)
	end,
	IsCanteenManualMode = function (slot0)
		return CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual
	end,
	IsCanteenAutoMode = function (slot0)
		return CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto
	end,
	IsCanteenStopBusiness = function (slot0)
		return CanteenData:GetCanteenState() == nil
	end,
	SnapToNearestInteractPoint = function (slot0, slot1, slot2)
		slot5 = CanteenAIFunction:GetNearestPoint(slot0, CanteenItemManager.GetItemInteractPositions(slot1))

		Dorm.DormEntityManager.PutEntityLookToDir(slot0, slot5, slot2 or Dorm.DormEntityManager.QueryPosition(slot1) - slot5)
	end,
	RefreshFoodContainer = function (slot0, slot1)
		slot3 = nil

		if uv0.GetEntityType(slot0) == DormEnum.ItemType.DinningTable then
			slot3 = {
				"gua_food01",
				"gua_food02"
			}
		elseif slot2 == DormEnum.ItemType.PassTable then
			slot3 = {
				"gua_serve01",
				"gua_serve02",
				"gua_serve03"
			}
		end

		slot4 = slot3 and #slot3 or 0
		slot5 = uv0.GetEntityBB(slot0)
		slot1 = slot1 or slot5.foodList
		slot6 = slot5.foodList and #slot5.foodList or 0

		for slot10 = 1, slot6 do
			slot11 = slot1[slot10]

			if slot10 <= slot4 then
				Dorm.DormEntityManager.PutEntityAt(slot11, slot0, slot3[slot10])
				Dorm.DormEntityManager.SetEntityVisible(slot11, true)
			else
				Dorm.DormEntityManager.SetEntityVisible(slot11, false)
			end
		end
	end,
	PutFoodOnTable = function (slot0, slot1)
		if uv0.GetEntityBB(slot1).foodList == nil then
			slot2.foodList = {}
		end

		table.insert(slot2.foodList, slot0)

		if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
			manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, slot1)
		end
	end,
	PickFoodFromTable = function (slot0, slot1)
		if uv0.GetEntityBB(slot1).foodList then
			for slot6, slot7 in ipairs(slot2.foodList) do
				if slot7 == slot0 then
					Dorm.DormEntityManager.SetEntityVisible(slot0, true)

					return table.remove(slot2.foodList, slot6)
				end
			end
		end
	end,
	IsCustomer = function (slot0)
		return slot0 == DormEnum.CharacterType.RestaurantNormalCustomer or slot0 == DormEnum.CharacterType.RestaurantSpecialCustomer
	end,
	waitAnime = {}
}
slot1 = Dorm.DormEntityManager.IsSameAnimeAction

function slot2(slot0, slot1)
	return slot0 == slot1
end

function slot3(slot0)
	return function (slot0, slot1, slot2)
		return function (slot0, slot1, slot2)
			if uv0 ~= slot0 then
				return false
			end

			if slot1 == "end" and uv1(slot2, uv2) or slot1 == "end_play_once" and uv1(slot2, uv2) or slot1 == "start" and not uv1(slot2, uv2) then
				if uv3 then
					uv3(slot0)
				end

				return true
			end
		end
	end
end

function slot4(slot0)
	return function (slot0, slot1, slot2, slot3)
		return function (slot0, slot1, slot2)
			if uv0 ~= slot0 then
				return false
			end

			if uv1 and uv1[slot1] then
				uv1[slot1](slot0, slot1)
			end

			if slot1 == "end" and uv2(slot2, uv3) or slot1 == "end_play_once" and uv2(slot2, uv3) or slot1 == "start" and not uv2(slot2, uv3) then
				if uv4 then
					uv4(slot0)
				end

				return true
			end
		end
	end
end

slot0.waitAnime.waitAnimeFunc = slot3
slot0.waitAnime.defaultWaitAnimation = slot3(slot1)
slot0.waitAnime.defaultWaitExactAnimation = slot3(slot2)
slot0.waitAnime.handleEventWaitAnimation = slot4(slot1)
slot0.waitAnime.handleEventWaitExactAnimation = slot4(slot2)
slot0.commonAction = {
	PlaceCarryingItemAction = function (slot0, slot1, slot2)
		slot4 = uv0.GetEntityBB(slot0).pick
		slot8 = uv0.NewTask(function ()
			Dorm.DormEntityManager.PlayAnimeDuringInteract(uv0, "serve", "02")
			Dorm.DormEntityManager.ChangeEntityAnimeScheme(uv0, "default")
		end)

		return slot8:HandleAnimeLoop(uv0.waitAnime.handleEventWaitExactAnimation(slot0, "serve02", {
			release = function ()
				Dorm.DormEntityManager.DetachFromEntityCMD(uv0)

				if uv1 then
					uv1(uv0)
				end
			end
		}, function ()
			uv0.pick = nil
		end))
	end,
	PickItemAction = function (slot0, slot1, slot2)
		slot3 = uv0.GetEntityBB(slot0)

		manager.notify:Invoke(DORM_CHARACTER_WAIT_PICK_ITEM, slot0, slot1)

		return uv0.NewTask():WaitUntil(function ()
			return uv0.target ~= nil
		end):Then(function ()
			if uv0 then
				uv0(uv1.target)
			end

			uv1.target = nil
			uv1.pick = uv1.target

			Dorm.DormEntityManager.PlayAnimeDuringInteract(uv2, "serve", "01")
			Dorm.DormEntityManager.ChangeEntityAnimeScheme(uv2, "carry")
		end):HandleAnimeLoop(uv0.waitAnime.handleEventWaitExactAnimation(slot0, "serve01", {
			grab = function ()
				Dorm.DormEntityManager.SetEntityVisible(uv0.pick, true)
				Dorm.DormEntityManager.AttachToEntityCMD(uv0.pick, uv1, "gua_R_hand_bone")
			end
		}))
	end
}

return slot0
