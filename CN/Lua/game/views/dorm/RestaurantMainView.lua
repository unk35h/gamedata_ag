slot0 = class("RestaurantMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/canteen/EmptyDreamCanteenMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:InitTimer()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.statusGo_.transform, "state")
	slot0.manualViewController = ControllerUtil.GetController(slot0.transform_, "mode")
	slot0.switchBtnController = ControllerUtil.GetController(slot0.switchTrs_, "state")
	slot0.hideButtonController = ControllerUtil.GetController(slot0.transform_, "hide")
	slot0.signFoodListScroll_ = LuaList.New(handler(slot0, slot0.indexSignFoodList), slot0.signfoodlistUilist_, NeedCookFoodItem)
	slot0.offset = 200
	slot0.activityId = ActivityConst.SPRING_CANTEEN

	CanteenData:SwitchCanteenBgm(DormEnum.RestaurantMode.Start)

	slot0.autoScrollTime = GameDisplayCfg.canteen_roller_speed.value[1]
	slot0.currencyiconImg_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_DORM_GOLD.item_id)
	slot0.moneyAnimator = slot0:FindCom(typeof(Animator), "", slot0.emptydreamcanteenitemTrs_)
	slot0.leableAnimator = slot0:FindCom(typeof(Animator), "", slot0.labelTrs_)
end

function slot0.OnEnter(slot0)
	slot0:RefreshBar()
	manager.redPoint:bindUIandKey(slot0.taskbtnBtn_.transform, RedPointConst.CANTEEN_DISPATCH)
	manager.redPoint:bindUIandKey(slot0.jobSetBtn_.transform, RedPointConst.CANTEEN_JOB_AVAILABLE)
	manager.redPoint:bindUIandKey(slot0.cookBtn_.transform, RedPointConst.CANTEEN_UPGRADE_AVAILABLE)
	CanteenData:Notify(RedPointConst.CANTEEN_UPGRADE_AVAILABLE, CanteenTools:CheckAllFurCanLevelUp())
	slot0:RegisterEvents()
	slot0:UpdateView()
	slot0:UpdateFoodScroll()

	slot0.canJump = true

	slot0.moneyAnimator:Update(0)
end

function slot0.UpdateFoodScroll(slot0)
	slot0.index = 1

	if #slot0.signFoodList >= 6 then
		slot0:StartAutoScroll()

		if not slot0.AutoScrollTimer then
			slot0.AutoScrollTimer = Timer.New(handler(slot0, slot0.StartAutoScroll), slot0.autoScrollTime, -1)

			slot0.AutoScrollTimer:Start()
		end
	end
end

function slot1(slot0)
	DormData:SetCurrentScene(nil)
	LuaExchangeHelper.GoToMain()

	if slot0 == "back" then
		OpenPageUntilLoaded("/backHomeEnterView")
	elseif slot0 == "main" then
		OpenPageUntilLoaded("/home")
	end
end

function slot0.RefreshBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_DORM_GOLD
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_DORM_GOLD, true)

	if #GameSetting.canteen_festival_info_describe.value > 0 then
		manager.windowBar:SetGameHelpKey({
			view = "/gameHelpPro",
			type = "jump",
			params = {
				hideHomeBtn = 1,
				pages = slot1
			}
		})
	end

	slot2 = manager.windowBar

	slot2:RegistBackCallBack(function ()
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
			ShowMessageBox({
				isTop = true,
				content = GetTips("CANTEEN_QUIT_CONFIRM"),
				OkCallback = function ()
					CharacterBubbleManager:Dispose()
					CanteenData:UnUsualExitManualMode()
					CanteenData:ClearManualPopular()
					uv0:EndAutoScroll()
					uv1("back")
				end,
				CancelCallback = function ()
				end
			})
		else
			uv0:EndAutoScroll()
			uv1("back")
		end
	end)

	slot2 = manager.windowBar

	slot2:RegistHomeCallBack(function ()
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
			ShowMessageBox({
				isTop = true,
				content = GetTips("CANTEEN_QUIT_CONFIRM"),
				OkCallback = function ()
					CharacterBubbleManager:Dispose()
					CanteenData:UnUsualExitManualMode()
					CanteenData:ClearManualPopular()
					uv0:EndAutoScroll()
					uv1("main")
				end,
				CancelCallback = function ()
				end
			})
		else
			uv0:EndAutoScroll()
			uv1("main")
		end
	end)
end

function slot0.InitTimer(slot0)
	slot0:InitAwardBubble()
end

function slot0.StartAutoScroll(slot0)
	slot0.index = slot0.index + 1

	if #slot0.signFoodList - 1 == slot0.index then
		slot0.index = slot1 / 2 - 2

		slot0.signFoodListScroll_:ScrollToIndex(slot0.index, false, false)

		slot0.index = slot0.index + 1

		slot0.signFoodListScroll_:ScrollToIndex(slot0.index, false, true, slot0.autoScrollTime)
	else
		slot0.signFoodListScroll_:ScrollToIndex(slot0.index, false, true, slot0.autoScrollTime)
	end

	slot0.signfoodlistUilist_:GetComponent("ScrollRectEx").horizontal = false
end

function slot0.EndAutoScroll(slot0)
	if slot0.AutoScrollTimer then
		slot0.AutoScrollTimer:Stop()

		slot0.AutoScrollTimer = nil

		slot0.signFoodListScroll_:RemoveTween()
	end
end

function slot0.InitAwardBubble(slot0)
	slot0:UpdataAwardBubble()

	slot0.atuoAwardTrsTimer = FrameTimer.New(function ()
		uv0:UpdataAwardBubbleTrs()
		uv0:UpdataAwardBubble()
	end, 0.03333333333333333, -1)

	slot0.atuoAwardTrsTimer:Start()
end

function slot0.ChooseCanteenState(slot0)
	if #CanteenData:GetCanOrderFoodList() < DormConst.ORDER_FOOD_AUTO_NUM then
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto or CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Start then
			CanteenData:SetCanteenState(DormEnum.RestaurantMode.Close)
		end
	elseif not CanteenTools:CheckCanteenJobCanOpen() then
		CanteenData:SetCanteenState(DormEnum.RestaurantMode.Close)
	elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Close or CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Start then
		CanteenData:SetCanteenState(DormEnum.RestaurantMode.RestaurantAuto)
	end
end

function slot0.ValidateSignFood(slot0)
	if #CanteenData:GetCanOrderFoodList() < DormConst.ORDER_FOOD_NUM then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("CANTEEN_FOOD_NOT_FIT"),
			OkCallback = function ()
				JumpTools.OpenPageByJump("/chooseSignFoodView", {
					type = DormEnum.FurnitureTypeNum.Pan
				})
			end
		})

		return false
	end

	return true
end

function slot0.ValidateJobCharacter(slot0)
	for slot4, slot5 in ipairs(DormConst.DORM_RESTAURANT_SET_JOB_TYPE) do
		if not DormData:HasJobAssignedToHero(slot5) then
			slot7 = CanteenTools

			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("DORM_CANTEEN_JOB_NOT_SET"), slot7:GetJobNameByIndex(DormEnum.RestaurantJobToServerMap[slot5])),
				OkCallback = function ()
				end
			})

			return false
		end
	end

	return true
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.startautomoduleBtn_, nil, function ()
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto then
			return
		end

		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
			CanteenData:SetCanteenState(DormEnum.RestaurantMode.RestaurantAuto)

			return
		end

		if #CanteenData:GetCanOrderFoodList() < DormConst.ORDER_FOOD_AUTO_NUM then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("CANTEEN_FOOD_NOT_FIT"),
				OkCallback = function ()
					JumpTools.OpenPageByJump("/chooseSignFoodView")
				end
			})

			return
		end

		CanteenData:SetCanteenState(DormEnum.RestaurantMode.RestaurantAuto)
	end)
	slot0:AddBtnListenerScale(slot0.manualbtnBtn_, nil, function ()
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
			return
		end

		if not uv0:ValidateSignFood() or not uv0:ValidateJobCharacter() then
			return
		end

		ShowMessageBox({
			isTop = true,
			content = GetTips("CANTEEN_MANNUALLY_OPT"),
			OkCallback = function ()
				CanteenData:SetCanteenState(DormEnum.RestaurantMode.RestaurantManual)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListenerScale(slot0.shopbtnBtn_, nil, function ()
		if uv0.canJump then
			JumpTools.GoToSystem("/shop", {
				shopId = 35,
				hideHomeBtn = 1,
				showShops = {
					35
				}
			}, ViewConst.SYSTEM_ID.SHOP)
		end
	end)
	slot0:AddBtnListenerScale(slot0.taskbtnBtn_, nil, function ()
		if uv0.canJump then
			if #CanteenData:CheckHasTimeOverEntrust() <= 0 then
				CanteenData:ConsumeNotification(RedPointConst.CANTEEN_DISPATCH_NONE, CanteenData.RedPointType.Session)
			end

			JumpTools.OpenPageByJump("/dormTaskDispatchView")
		end
	end)
	slot0:AddBtnListenerScale(slot0.signfoodBtn_, nil, function ()
		if uv0.canJump then
			if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
				return
			end

			JumpTools.OpenPageByJump("/chooseSignFoodView")
		end
	end)
	slot0:AddBtnListenerScale(slot0.recipebtnBtn_, nil, function ()
		if uv0.canJump then
			JumpTools.OpenPageByJump("/restaurantFoodMenuView", {
				state = DormEnum.MenuType.foodMenu
			})
		end
	end)
	slot0:AddBtnListenerScale(slot0.warehousebtnBtn_, nil, function ()
		if uv0.canJump then
			JumpTools.OpenPageByJump("/restaurantFoodMenuView", {
				state = DormEnum.MenuType.bag
			})
		end
	end)
	slot0:AddBtnListenerScale(slot0.hidebtnBtn_, nil, function ()
		if uv0.hideButtonController:GetSelectedState() == "false" then
			uv0.hideButtonController:SetSelectedState("true")
		else
			uv0.hideButtonController:SetSelectedState("false")
			uv0.leableAnimator:SetFloat("speed", 1)
			uv0.leableAnimator:Play("ShowLabel")
		end
	end)
	slot0:AddBtnListenerScale(slot0.autoAwardBtn_, nil, function ()
		slot0, slot1 = CanteenData:GetAutoNextAwardTime()

		if slot0 < 0 and slot1 < 0 then
			if CanteenData:GetAutoAwardNum() == 0 then
				ShowTips("CANTEEN_ADMITTED_NULL")

				return
			end

			CanteenData:ReceiveCurPenEar()
			uv0.moneyAnimator:Play("GetMoney", 0, 0)
			manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_coin", "")

			uv0.canJump = false

			if uv0.canJumpTimer then
				uv0.canJumpTimer:Stop()

				uv0.canJumpTimer = nil
			end

			uv0.canJumpTimer = Timer.New(function ()
				uv0.canJump = true
			end, 0.3, 1)

			uv0.canJumpTimer:Start()
		end
	end)
	slot0:AddBtnListenerScale(slot0.jobSetBtn_, nil, function ()
		if uv0.canJump then
			JumpTools.OpenPageByJump("/restaurantJobView")
			CanteenData:ConsumeNotification(RedPointConst.CANTEEN_JOB_AVAILABLE, CanteenData.RedPointType.Session)
		end
	end)
	slot0:AddBtnListenerScale(slot0.cookBtn_, nil, function ()
		if uv0.canJump then
			JumpTools.OpenPageByJump("/restaurantCookUpView")
			CanteenData:ConsumeNotification(RedPointConst.CANTEEN_UPGRADE_AVAILABLE, CanteenData.RedPointType.Session)
		end
	end)
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_REFRESH_RESTAURANT_STATUS_EVENT, function (slot0)
		if slot0 == DormEnum.RestaurantMode.Close then
			uv0:CloseMode()
		elseif slot0 == DormEnum.RestaurantMode.RestaurantAuto then
			uv0:StartAutoMode()
		elseif slot0 == DormEnum.RestaurantMode.RestaurantManual then
			uv0:StartManualMode()
		end
	end)
	slot0:RegistEventListener(CANTEEN_INGREDIENTS_CHANGE, function ()
		uv0.signFoodListScroll_:Refresh()
	end)
	slot0:RegistEventListener(CANTEEN_MANUAL_REWARD_CALLBACK, function ()
		uv0:ChooseCanteenState()
		JumpTools.OpenPageByJump("/canteenManualRewardView")
	end)
	slot0:RegistEventListener(DORM_RESTAURANT_LOGIC_TICK, handler(slot0, slot0.UpdataTimeBar))
	slot0:RegistEventListener(DORM_REFRESH_POPULAR_EVENT, function ()
		uv0:UpdataPopularity()
	end)
	slot0:RegistEventListener(CANTEEN_AUTO_GET_AWARD_SUCCESS, function ()
	end)
	slot0:RegistEventListener(CANTEEN_FUR_LEVEL, function (slot0)
		if uv0.canJump then
			JumpTools.OpenPageByJump("/restaurantCookUpView", {
				type = BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[slot0].type_id].type,
				furEID = slot0
			})
		end
	end)
end

function slot0.UpdateView(slot0)
	slot0:UpdataPopularity()
	slot0:UpdataSignFoodList()
end

function slot0.UpdataSignFoodList(slot0)
	slot0.signFoodList = {}
	slot1 = 1

	if #CanteenData:GetChooseFoodList() > 2 then
		while slot1 <= 2 do
			for slot6, slot7 in ipairs(slot2) do
				table.insert(slot0.signFoodList, slot7)
			end

			slot1 = slot1 + 1
		end
	else
		for slot6, slot7 in ipairs(slot2) do
			table.insert(slot0.signFoodList, slot7)
		end
	end

	slot0.signFoodListScroll_:StartScroll(#slot0.signFoodList)
	slot0:ChooseCanteenState()
end

function slot0.UpdataCanteenState(slot0)
	if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto then
		slot0.manualViewController:SetSelectedState("auto")
		slot0.stateController:SetSelectedState("business")
		slot0.switchBtnController:SetSelectedState("automatic")
		SetActive(slot0.emptydreamcanteenitemGo_1, true)
	elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
		slot0.stateController:SetSelectedState("ManualOperating")
		slot0.manualViewController:SetSelectedState("manual")
		slot0.switchBtnController:SetSelectedState("manual")
		SetActive(slot0.emptydreamcanteenitemGo_1, false)
	elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Close then
		slot0.stateController:SetSelectedState("closed")
	end
end

function slot0.UpdataAwardBubble(slot0)
	slot1, slot2, slot3 = CanteenData:GetAutoNextAwardTime()
	slot4 = CanteenData:GetAutoAwardNum()
	slot5 = DormSkillData:GetInComeStorageMax()

	if slot1 < 0 or slot2 < 0 then
		slot0.awardtimetextText_.text = GetTips("CANTEEN_MONEY_TIPS2")

		if slot4 == 0 then
			slot0.awardtimetextText_.text = GetTips("CANTEEN_MONEY_TIPS3")
		end
	else
		slot6 = ""

		if slot1 > 0 then
			slot6 = string.format("%d", slot1) .. GetTips("HOUR") .. string.format("%d", slot2) .. GetTips("MINUTE")
		elseif slot1 == 0 and slot2 > 0 then
			slot6 = string.format("%d", slot2) .. GetTips("MINUTE")
		elseif slot2 == 0 and slot3 > 0 then
			slot6 = string.format("%d", slot3) .. GetTips("SECOND")
		end

		slot0.awardtimetextText_.text = string.format(GetTips("CANTEEN_MONEY_TIPS1"), slot6)
	end

	slot0.awardtotaltextText_.text = string.format("%d<size=26><color=#767878>/%d</color></size>", slot4, slot5)
end

function slot0.UpdataAwardBubbleTrs(slot0)
	slot8, slot9 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(slot0.transform_, UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.mainCameraCom_, Dorm.DormEntityManager.QueryPosition(CanteenAIFunction:GetAllEIDNameSpace(CanteenItemManager.ItemEIdNamespace(DormEnum.ItemType.CashierTable))[1])), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, {})

	if slot9 == nil then
		print("未找到对应的视口坐标")

		return
	end

	slot9.y = slot9.y + slot0.offset
	slot0.emptydreamcanteenitemTrs_.localPosition = slot9
end

function slot0.UpdataPopularity(slot0)
	slot0.popnumText_.text = CanteenData:GetPopularityNum()
end

function slot0.indexSignFoodList(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.signFoodList[slot1])
end

function slot0.UpdataTimeBar(slot0)
	slot2 = 1

	if Dorm.storage:GetData(DormEnum.Namespace.RestaurantBusiness, "timer") and slot1:IsRunning() then
		slot2 = slot1:QueryTime() / slot1.duration
	end

	slot0.timebarImg_.fillAmount = 1 - slot2
end

function slot0.StartManualMode(slot0)
	slot0:UpdataCanteenState()
end

function slot0.StartAutoMode(slot0)
	slot0:UpdataCanteenState()
end

function slot0.CloseMode(slot0)
	slot0:UpdataCanteenState()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.taskbtnBtn_.transform, RedPointConst.CANTEEN_DISPATCH)
	manager.redPoint:unbindUIandKey(slot0.jobSetBtn_.transform, RedPointConst.CANTEEN_JOB_AVAILABLE)
	manager.redPoint:unbindUIandKey(slot0.cookBtn_.transform, RedPointConst.CANTEEN_UPGRADE_AVAILABLE)
	slot0:RemoveAllEventListener()
	slot0:EndAutoScroll()
end

function slot0.Dispose(slot0)
	if slot0.signFoodListScroll_ then
		slot0.signFoodListScroll_:Dispose()

		slot0.signFoodListScroll_ = nil
	end

	if slot0.atuoAwardTrsTimer then
		slot0.atuoAwardTrsTimer:Stop()

		slot0.atuoAwardTrsTimer = nil
	end

	if slot0.canJumpTimer then
		slot0.canJumpTimer:Stop()

		slot0.canJumpTimer = nil
	end

	slot0.moneyAnimator = nil

	uv0.super.Dispose(slot0)
end

return slot0
