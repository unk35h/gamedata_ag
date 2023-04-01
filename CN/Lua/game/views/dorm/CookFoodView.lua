slot0 = class("CookFoodView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/canteen/EmptyDreamDoTheDishesPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.canCookFoodItemScroll = LuaList.New(handler(slot0, slot0.IndexCookFoodItem), slot0.fooduilistUilist_, CookFoodItem)
	slot0.cookMaterialItemScroll_ = LuaList.New(handler(slot0, slot0.IndexFoodMaterialItem), slot0.ingredientuilistUilist_, FoodMaterialItem)
	slot0.finishIngredientItemScroll_ = LuaList.New(handler(slot0, slot0.IndexFoodMaterialItem), slot0.finishingredientuilistUilist_, FoodMaterialItem)
	slot0.chooseTasteItemScroll = LuaList.New(handler(slot0, slot0.IndexTasteItem), slot0.tasteuilistUilist_, CookFoodItem)
	slot0.cookStateController_ = ControllerUtil.GetController(slot0.transform_, "cookState")
	slot0.cookFinishController_ = ControllerUtil.GetController(slot0.transform_, "finish")
	slot0.cookCompletedBgController_ = ControllerUtil.GetController(slot0.transform_, "completedBg")
	slot0.cookcompletedLvController_ = ControllerUtil.GetController(slot0.transform_, "completedLv")
	slot0.qteStartController_ = ControllerUtil.GetController(slot0.transform_, "qteStart")
	slot0.finishFoodController_ = ControllerUtil.GetController(slot0.finishfoodnameGo_, "name")
	slot0.tasteFoodController_ = ControllerUtil.GetController(slot0.tastenameGo_, "name")
	slot0.particleController = ControllerUtil.GetController(slot0.switchwokTrs_, "switchWok")
	slot0.foodId = nil
	slot0.taste = nil
end

function slot1(slot0)
	ShowMessageBox({
		ButtonType = "SingleBtn",
		title = GetTips("PROMPT"),
		content = slot0
	})
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.startbtnBtn_, nil, function ()
		if uv0.foodId == nil then
			uv1(GetTips("CANTEEN_FOOD_UNCHOOSE"))

			return
		end

		if uv0.taste == nil then
			uv1(GetTips("CANTEEN_INGREDIENTS_UNCHOOSE"))

			return
		end

		uv0:StartCookFoodQTE()
	end)
	slot0:AddBtnListenerScale(slot0.confirmbtnBtn_, nil, function ()
		JumpTools:Back()
	end)
end

function slot0.ExitOnCanteenModeChange(slot0)
	slot0.cookFoodFlag = nil

	slot0:Back()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})

	slot0.kitchenwareEid = slot0.params_.cookEid
	slot0.playerEid = slot0.params_.playerEid
	slot0.cookType = CanteenAIFunction:GetEntityType(slot0.kitchenwareEid)

	slot0:UpdataFoodData()
	slot0.canCookFoodItemScroll:StartScroll(#slot0.canCookFoodList_)

	slot0.cookFoodFlag = false
	slot0.startFlag = false
	slot1 = handler(slot0, slot0.ExitOnCanteenModeChange)

	slot0:RegistEventListener(DORM_RESTAURANT_START_AUTO, slot1)
	slot0:RegistEventListener(DORM_RESTAURANT_START_MANUAL, slot1)
	slot0.particleController:SetSelectedState("off")
end

function slot0.OnTop(slot0)
end

function slot0.UpdataFoodData(slot0)
	slot0.canCookFoodList_ = {}

	for slot5, slot6 in ipairs(CanteenData:GetChooseFoodList()) do
		if DormEnum.RestaurantKitchenWare[BackHomeCanteenFoodCfg[slot6].cook_type] == slot0.cookType then
			table.insert(slot0.canCookFoodList_, {
				type = DormEnum.UniversalUIType.FoodName,
				id = slot6
			})
		end
	end

	if #slot0.canCookFoodList_ == 0 then
		slot0.cookFinishController_:SetSelectedState("none")
	else
		slot0.cookFinishController_:SetSelectedState("making")
	end
end

function slot0.IndexTasteItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.chooseFoodTasteList[slot1], slot0.taste)
	slot2:RegistCallBack(function (slot0)
		if uv0.startFlag then
			return
		end

		if uv0.taste == slot0 then
			return
		end

		uv0.taste = slot0

		uv0.chooseTasteItemScroll:Refresh()
		uv0:CheckCookFoodPrecondition()
	end)
end

function slot0.UpdataChooseFoodTaste(slot0, slot1)
	slot0.chooseFoodTasteList = {}

	for slot5, slot6 in ipairs(BackHomeCanteenFoodCfg[slot1].tag) do
		table.insert(slot0.chooseFoodTasteList, {
			type = DormEnum.UniversalUIType.TasteName,
			id = slot6
		})
	end
end

function slot0.UpdataChooseFoodMaterial(slot0, slot1)
	slot0.chooseFoodMaterialList = BackHomeCanteenFoodCfg[slot1].ingredient_list
end

function slot0.IndexFoodMaterialItem(slot0, slot1, slot2)
	slot2:RefreshItem(slot0.chooseFoodMaterialList[slot1], nil, , DormEnum.FoodSellType.SignFood)
end

function slot0.IndexCookFoodItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.canCookFoodList_[slot1], slot0.foodId)
	slot2:RegistCallBack(handler(slot0, slot0.RefreshFoodTasteAndMaterial))
end

function slot0.RefreshFoodTasteAndMaterial(slot0, slot1)
	if slot0.startFlag then
		return
	end

	if slot1 == slot0.foodId then
		return
	end

	slot0.foodId = slot1
	slot0.taste = nil

	slot0.canCookFoodItemScroll:Refresh()
	slot0:UpdataChooseFoodMaterial(slot1)
	slot0.cookMaterialItemScroll_:StartScroll(#slot0.chooseFoodMaterialList)
	slot0:UpdataChooseFoodTaste(slot1)
	slot0.chooseTasteItemScroll:StartScroll(#slot0.chooseFoodTasteList)
	slot0:InitProgressBar(slot1)
end

function slot0.CheckCookFoodPrecondition(slot0)
	if slot0.foodId ~= nil and CanteenData:GetSignFoodCanCookNum(slot0.foodId) <= 0 then
		slot0.cookStateController_:SetSelectedState("lack")
	end
end

function slot0.StartCookFoodQTE(slot0)
	slot0.qteStartController_:SetSelectedState("true")

	if slot0.timer == nil then
		slot0.timer = FrameTimer.New(function ()
			uv0:UpdataCursor()
		end, 0.016666666666666666, -1)

		slot0.timer:Start()

		slot0.startFlag = true

		slot0.particleController:SetSelectedState("on")
		manager.windowBar:HideBar()
	else
		slot0.timer:Stop()

		slot0.timer = nil

		if slot0:QTEResult() == DormEnum.FoodQuality.low then
			manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_bad", "")
		elseif slot1 == DormEnum.FoodQuality.normal then
			manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_commonly", "")
		elseif slot1 == DormEnum.FoodQuality.high then
			manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_perfect", "")
		end

		slot0.startFlag = false

		slot0.particleController:SetSelectedState("off")
		slot0:CookFinish(slot1)
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	end
end

function slot0.InitProgressBar(slot0, slot1)
	slot2 = CanteenData:GetFoodProficiency(slot1)
	slot0.progress1Angel = 0
	slot0.progress2Angel = 0

	for slot6 = 1, #BackHomeCanteenFoodCfg[slot1].cook_range do
		if slot2 < BackHomeCanteenFoodCfg[slot1].cook_range[slot6][1] then
			slot0.progress1Angel = BackHomeCanteenFoodCfg[slot1].cook_range[slot6 - 1][2]
			slot0.progress2Angel = BackHomeCanteenFoodCfg[slot1].cook_range[slot6 - 1][3]

			break
		end

		slot0.progress1Angel = BackHomeCanteenFoodCfg[slot1].cook_range[slot6][2]
		slot0.progress2Angel = BackHomeCanteenFoodCfg[slot1].cook_range[slot6][3]
	end

	slot0.MaxEuler = GameDisplayCfg.canteen_cook_range.value[2]
	slot0.MinEuler = GameDisplayCfg.canteen_cook_range.value[1]

	slot0:RandomProgressBar()

	slot0.CursorTickEuler = GameDisplayCfg.canteen_cook_range_speed.value[1] / DormConst.COOK_CURSOR_FRAME
	slot0.turnNum = 1
	slot0.cursorTrs_.localEulerAngles = Vector3.New(0, 0, slot0.MaxEuler)
end

function slot0.RandomProgressBar(slot0)
	slot0.progressbar1Img_.fillAmount = slot0.progress1Angel / 180 - slot0.progress1Angel / 180 % 0.01
	slot0.progressbar2Img_.fillAmount = slot0.progress2Angel / 180 - slot0.progress2Angel / 180 % 0.01
	slot2 = math.floor(math.random(slot0.MinEuler + 90, slot0.MaxEuler + 90 - slot0.progress1Angel))
	slot0.progressbar1Trs_.localEulerAngles = Vector3.New(0, 0, slot2)
	slot0.progressbar2Trs_.localEulerAngles = Vector3.New(0, 0, math.floor(math.random(slot2, slot2 + slot0.progress1Angel - slot0.progress2Angel)))
end

function slot0.UpdataCursor(slot0)
	slot1 = 0

	if slot0.turnNum % 2 == 1 then
		slot0.cursorTrs_.localEulerAngles = slot0.cursorTrs_.localEulerAngles - Vector3.New(0, 0, slot0.CursorTickEuler)
		slot2 = 0

		if (slot0.cursorTrs_.localEulerAngles.z > 180 and slot0.cursorTrs_.localEulerAngles.z - 360 or slot0.cursorTrs_.localEulerAngles.z) <= slot0.MinEuler then
			slot0.turnNum = slot0.turnNum + 1
		end
	elseif slot0.turnNum % 2 == 0 then
		slot0.cursorTrs_.localEulerAngles = slot0.cursorTrs_.localEulerAngles + Vector3.New(0, 0, slot0.CursorTickEuler)
		slot2 = 0

		if slot0.MaxEuler <= (slot0.cursorTrs_.localEulerAngles.z > 180 and slot0.cursorTrs_.localEulerAngles.z - 360 or slot0.cursorTrs_.localEulerAngles.z) then
			slot0.turnNum = slot0.turnNum + 1
		end
	end

	slot0.cursorTrs_.localEulerAngles.z = slot1
end

function slot0.QTEResult(slot0)
	slot1 = 0

	if slot0:CheckCursorInProgress1() == false then
		slot1 = DormEnum.FoodQuality.low
	elseif slot0:CheckCursorInProgress1() == true and slot0:CheckCursorInProgress2() == false then
		slot1 = DormEnum.FoodQuality.normal
	elseif slot0:CheckCursorInProgress1() == true and slot0:CheckCursorInProgress2() == true then
		slot1 = DormEnum.FoodQuality.high
	end

	return slot1
end

function slot0.CheckCursorInProgress1(slot0)
	if slot0.cursorTrs_.localEulerAngles.z + 90 > 360 then
		slot1 = slot1 - 360
	end

	if slot1 >= slot0.progress1Angel + slot0.progressbar1Trs_.localEulerAngles.z or slot1 <= slot0.progressbar1Trs_.localEulerAngles.z then
		return false
	end

	return true
end

function slot0.CheckCursorInProgress2(slot0)
	if slot0.cursorTrs_.localEulerAngles.z + 90 > 360 then
		slot1 = slot1 - 360
	end

	if slot1 >= slot0.progress2Angel + slot0.progressbar2Trs_.localEulerAngles.z or slot1 <= slot0.progressbar2Trs_.localEulerAngles.z then
		return false
	end

	return true
end

function slot0.CookFinish(slot0, slot1)
	slot0.cookFinishController_:SetSelectedState("completed")
	slot0.cookCompletedBgController_:SetSelectedState("on")
	slot0.finishFoodController_:SetSelectedState("off")
	slot0.tasteFoodController_:SetSelectedState("off")

	slot0.finishfoodtextText_.text = BackHomeCanteenFoodCfg[slot0.foodId].name
	slot0.finishfoodtastetextText_.text = BackHomeCateenFlavor[slot0.taste].flavor

	slot0.finishIngredientItemScroll_:StartScroll(#slot0.chooseFoodMaterialList)
	slot0.cookcompletedLvController_:SetSelectedState(slot1)

	slot0.cookFoodFlag = true

	CanteenData:CookFoodComplete(slot0.playerEid, slot1, slot0.kitchenwareEid, slot0.foodId, slot0.taste)
end

function slot0.ResetView(slot0)
	slot0.cookStateController_:SetSelectedIndex(0)
	slot0.cookFinishController_:SetSelectedIndex(0)
	slot0.cookCompletedBgController_:SetSelectedIndex(0)
	slot0.cookcompletedLvController_:SetSelectedIndex(0)
	slot0.finishFoodController_:SetSelectedState("none")
	slot0.tasteFoodController_:SetSelectedState("none")

	slot0.cursorTrs_.localEulerAngles = Vector3.New(0, 0, slot0.MaxEuler)
	slot0.foodId = nil
	slot0.taste = nil
	slot0.chooseFoodMaterialList = {}
	slot0.chooseFoodTasteList = {}
	slot0.turnNum = 1

	slot0.chooseTasteItemScroll:StartScroll(#slot0.chooseFoodTasteList)
	slot0.cookMaterialItemScroll_:StartScroll(#slot0.chooseFoodMaterialList)
	slot0.qteStartController_:SetSelectedState("false")
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if slot0.cookFoodFlag == false then
		CanteenData:CookFoodCanceled(slot0.playerEid, slot0.kitchenwareEid)
	end

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	slot0:ResetView()
end

function slot0.Dispose(slot0)
	if slot0.cookMaterialItemScroll_ then
		slot0.cookMaterialItemScroll_:Dispose()

		slot0.cookMaterialItemScroll_ = nil
	end

	if slot0.finishIngredientItemScroll_ then
		slot0.finishIngredientItemScroll_:Dispose()

		slot0.finishIngredientItemScroll_ = nil
	end

	if slot0.canCookFoodItemScroll then
		slot0.canCookFoodItemScroll:Dispose()

		slot0.canCookFoodItemScroll = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
