ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("DrawFeedbackView_2_0", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return "UI/VersionUI/XuHeng1stUI/XH1stRaffleFeedbackUI/XH1stRaffleFeedbackUI"
end

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.taskUpdateHandler_ = handler(slot0, slot0.TaskUpdate)
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, DrawFeedbackItem)
	slot0.receiveAllController_ = ControllerUtil.GetController(slot0.transform_, "clear")
	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:RefreshReceiveAllBtn()
	slot0:AddShopTimer()
	slot0:AddTaskTimer()
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, slot0.taskUpdateHandler_)
	manager.redPoint:bindUIandKey(slot0.shopBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP))
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.notify:RemoveListener(OSIRIS_TASK_UPDATE, slot0.taskUpdateHandler_)
	manager.redPoint:unbindUIandKey(slot0.shopBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP))
	slot0:StopShopTimer()
	slot0:StopTaskTimer()
end

function slot0.Dispose(slot0)
	slot0.taskUpdateHandler_ = nil

	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.tipBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "DRAW_FEEDBACK_INFO",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("DRAW_FEEDBACK_INFO")
		})
	end)
	slot0:AddBtnListener(slot0.allReceiveBtn_, nil, function ()
		slot1 = {}

		if #TaskData:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK) > 0 then
			for slot5, slot6 in ipairs(slot0) do
				table.insert(slot1, slot6.id)
			end
		end

		TaskAction:TryToSubmitActivityTaskList(slot1)
	end)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP), 0)

		slot1, slot2 = ShopTools.IsShopOpen(ActivityShopCfg[ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP].shop_id)

		if slot1 then
			JumpTools.GoToSystem("/shop", {
				shopId = slot0.shop_id,
				showShops = {
					slot0.shop_id
				}
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif slot2 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif slot2 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.GoToSystem("/draw", nil, ViewConst.SYSTEM_ID.DRAW)
	end)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DRAW_FEEDBACK_COIN
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DRAW_FEEDBACK_COIN, true)
end

function slot0.Show(slot0, slot1)
	uv0.super.Show(slot0, slot1)

	if slot1 then
		slot0.scrollHelper_:StartScroll(#TaskData:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK))
	end
end

function slot0.TaskUpdate(slot0)
	slot0.scrollHelper_:StartScroll(#TaskData:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK))
	slot0:RefreshReceiveAllBtn()
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(TaskData:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK)[slot1].id)
end

function slot0.RefreshReceiveAllBtn(slot0)
	if #TaskData:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK) > 0 then
		slot0.receiveAllController_:SetSelectedState("true")
	else
		slot0.receiveAllController_:SetSelectedState("false")
	end
end

function slot0.RefreshShopTime(slot0)
	slot1 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP)
	slot0.shopTimeText_.text = manager.time:GetLostTimeStr2(slot1.stopTime, nil)

	if slot1.stopTime <= manager.time:GetServerTime() + 604800 then
		if slot0.shopTimeGo_.activeSelf == false then
			SetActive(slot0.shopTimeGo_, true)
		end
	elseif slot0.shopTimeGo_.activeSelf == true then
		SetActive(slot0.shopTimeGo_, false)
	end
end

function slot0.AddShopTimer(slot0)
	slot0:StopShopTimer()
	slot0:RefreshShopTime()

	slot0.shopTimer_ = Timer.New(function ()
		uv0:RefreshShopTime()
	end, 1, -1)

	slot0.shopTimer_:Start()
end

function slot0.StopShopTimer(slot0)
	if slot0.shopTimer_ then
		slot0.shopTimer_:Stop()

		slot0.shopTimer_ = nil
	end
end

function slot0.RefreshTaskPanel(slot0)
	if ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK).stopTime < manager.time:GetServerTime() then
		slot0.lockController_:SetSelectedState("onlyShop")
	elseif slot2 < slot1.startTime then
		slot0.lockController_:SetSelectedState("lock")
	else
		slot0.lockController_:SetSelectedState("unlock")
	end
end

function slot0.AddTaskTimer(slot0)
	slot0:StopTaskTimer()
	slot0:RefreshTaskPanel()

	slot0.taskTimer_ = Timer.New(function ()
		uv0:RefreshTaskPanel()
	end, 1, -1)

	slot0.taskTimer_:Start()
end

function slot0.StopTaskTimer(slot0)
	if slot0.taskTimer_ then
		slot0.taskTimer_:Stop()

		slot0.taskTimer_ = nil
	end
end

return slot0
