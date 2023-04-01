slot0 = class("CharacterBubbleManager")

function slot0.Init(slot0)
	slot0.bubbleList = {}
	slot0.offset = 200

	slot0:RegisterEvent()

	slot0.Timer = FrameTimer.New(function ()
		uv0:Updata()
	end, 0.016666666666666666, -1)

	slot0.Timer:Start()
end

function slot0.RegisterEvent(slot0)
	slot1 = slot0.listener or EventListener.New()

	slot1:Register(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, handler(slot0, slot0.RefreshWaiteFoodBubbleList))
	slot1:Register(DORM_CANTEEN_QUALITY_BUBBLE_REFRESH, handler(slot0, slot0.RefreshEmotionBubbleList))
	slot1:Register(CANTEEN_CLEAR_BUBBLE_LIST, handler(slot0, slot0.ClearBubbleList))

	slot0.listener = slot1
end

function slot0.RemoveRegister(slot0)
	slot0.listener:RemoveAll()
end

function slot0.GenerateBubbleList(slot0, slot1)
	slot2 = slot0:GetCharacterBubbleList(slot1)
	slot3 = slot0:GetCharacterScreenPosition(slot1)
	slot3.y = slot3.y + slot0.offset
	slot4.listRect = slot0.bubbleList[slot1].listRect or slot2:GetComponent("RectTransform")
	slot4.listRect.localPosition = slot3
	slot4.bubbleContentList = {}
	slot4.enmptyComtroller = ControllerUtil.GetController(slot2.transform, "empty")
	slot4.scroll = slot4.scroll or LuaList.New(handlerArg1(slot0, slot0.RefreshBubble, slot1), slot2, CharacterBubbleItem)

	slot4.scroll:StartScroll(0)
	slot4.enmptyComtroller:SetSelectedState("false")
end

function slot0.ClearBubbleList(slot0, slot1)
	if slot0.bubbleList[slot1] then
		slot2.bubbleContentList = {}

		slot2.scroll:StartScroll(0)
		slot2.enmptyComtroller:SetSelectedState("false")
	end
end

function slot0.RefreshWaiteFoodBubbleList(slot0, slot1)
	slot2 = CanteenAIFunction:GetEntityData(slot1)

	if slot0.bubbleList[slot1] == nil then
		return
	end

	slot4 = {}

	if CanteenAIFunction:GetEntityType(slot1) == DormEnum.ItemType.DinningTable and slot2.waitFoodTimer then
		for slot9, slot10 in ipairs(slot5.curOrder) do
			if slot10.status ~= DormEnum.FoodState.HasServer then
				table.insert(slot4, {
					type = DormEnum.BubbleType.WaitForFood,
					entityID = slot1,
					duration = GameSetting.dorm_customer_wait_food_time.value[1],
					params = slot10
				})
			end
		end

		slot3.bubbleContentList = slot4

		slot3.scroll:StartScroll(#slot4)

		if #slot4 == 0 then
			slot3.enmptyComtroller:SetSelectedState("false")
		end
	end

	slot0:GetCharacterBubbleList(slot1):GetComponent("ScrollRectEx").vertical = false
end

function slot0.RefreshEmotionBubbleList(slot0, slot1)
	slot2 = CanteenAIFunction:GetEntityData(slot1)
	slot3 = slot0.bubbleList[slot1]
	slot4 = {}

	if CanteenAIFunction:GetEntityType(slot1) == DormEnum.ItemType.DinningTable then
		table.insert(slot4, {
			type = DormEnum.BubbleType.CharacterEmotion,
			params = slot2
		})

		slot3.bubbleContentList = slot4

		slot3.scroll:StartScroll(#slot4)
	end

	slot0:GetCharacterBubbleList(slot1):GetComponent("ScrollRectEx").vertical = false
end

function slot0.RefreshBubble(slot0, slot1, slot2, slot3)
	slot3:RefreshUI(slot0.bubbleList[slot1].bubbleContentList[slot2])
end

function slot0.SetFlag(slot0, slot1)
	slot0.flag = slot1
end

function slot0.Updata(slot0)
	slot0:UpdataListRect()
end

function slot0.UpdataListRect(slot0)
	for slot4, slot5 in pairs(slot0.bubbleList) do
		slot6 = slot0:GetCharacterScreenPosition(slot4)
		slot6.y = slot6.y + slot0.offset
		slot0.bubbleList[slot4].listRect.localPosition = slot6
	end
end

function slot0.GetCharacterBubbleList(slot0, slot1)
	if slot0.bubbleList[slot1] == nil then
		slot0.bubbleList[slot1] = {
			go = slot0.listPool:GetCanUsingObj()
		}
	end

	return slot0.bubbleList[slot1].go
end

function slot0.SetUiListPrefab(slot0, slot1, slot2)
	if slot1 and slot2 then
		slot0.uiListPrefab = slot1
		slot0.uiFatherTrs = slot2
	else
		print("未传入uilist预制体与ui预制体")
	end

	slot0.listPool = Pool.New(slot0.uiListPrefab, slot0.uiFatherTrs, 0)
end

function slot0.GetCharacterScreenPosition(slot0, slot1)
	slot7, slot8 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(slot0.uiFatherTrs, UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.mainCameraCom_, Dorm.DormEntityManager.QueryPosition(slot1)), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, {})

	if slot8 == nil then
		print("未找到对应的视口坐标")
	end

	return slot8
end

function slot0.Dispose(slot0)
	if slot0.listener then
		slot0:RemoveRegister()
	end

	if slot0.Timer then
		slot0.Timer:Stop()

		slot0.Timer = nil
	end

	if slot0.bubbleList then
		for slot4, slot5 in pairs(slot0.bubbleList) do
			slot5.scroll:StartScroll(0)
			slot5.enmptyComtroller:SetSelectedState("false")
			slot5.scroll:Dispose()

			slot5.scroll = nil
		end
	end

	slot0.listPool:Dispose()

	slot0.bubbleList = nil
end

return slot0
