slot0 = class("DormTaskDispatchView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/canteen/EmptyDreamTaskPop"
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

	slot0.taskScroll_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.taskuilistUilist_, DormDispatchMissionItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(CANTEEN_REFRESH_ENTRUST_CALLBACK, function (slot0)
		if uv0.refreshFlag then
			ShowTips("CANTEEN_TASK_REFRESH_SUCCESS")
		end

		uv0.taskScroll_:GetItemByIndex(slot0):RefreshUI(CanteenData:GetEntrustByPos(slot0))
	end)
	slot0:RegistEventListener(CANTEEN_DISPATCH_ENTRUST_SUCCESS, function (slot0)
		uv0.taskScroll_:GetItemByIndex(slot0):RefreshUI(CanteenData:GetEntrustByPos(slot0))
	end)
	slot0:RegistEventListener(CANTEEN_DISPATCH_REWARD_VIEW, function ()
		JumpTools.OpenPageByJump("/canteenEntrustAwardView", {
			flag = true
		})
	end)
	slot0:RegistEventListener(CANTEEN_DISPATCH_TIME_OVER, function ()
		uv0:GetAward()
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.dispatchItemList_[slot1])
	slot2:RegisterConfirmCallBack(function (slot0, slot1)
		CanteenData:SetCurDispatchTask(slot0, slot1)
		JumpTools.OpenPageByJump("/chooseCharacterView")
	end)
	slot2:RegisterRefreshCallBack(function (slot0)
		uv0.refreshFlag = true

		CanteenData:RefreshEntrustData(slot0)
	end)
	slot2:RegisterCancelCallBack(function (slot0, slot1)
		CanteenData:CancelEntrust(slot1)
	end)
end

function slot0.OnEnter(slot0)
	slot0:GetAward()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	slot0:RegisterEvent()

	slot0.dispatchItemList_ = CanteenData:GetEntrustList()

	slot0.taskScroll_:StartScroll(#slot0.dispatchItemList_)

	slot0.refreshFlag = false

	if not slot0.refreshTimer then
		slot0.refreshTimer = Timer.New(function ()
			uv0:RefreshItemTime()
		end, 1, -1)
	end

	slot0.refreshTimer:Start()
end

function slot0.RefreshItemTime(slot0)
	if slot0.dispatchItemList_ then
		for slot4 = 1, #slot0.dispatchItemList_ do
			if slot0.taskScroll_:GetItemByIndex(slot4) then
				slot5:RefreshTimeMessage()
			end
		end
	end
end

function slot0.GetAward(slot0)
	if #CanteenData:CheckHasTimeOverEntrust() > 0 then
		CanteenData:ReceiveEntrustAward(slot1)
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()

	if slot0.refreshTimer then
		slot0.refreshTimer:Stop()

		slot0.refreshTimer = nil
	end
end

function slot0.Dispose(slot0)
	if slot0.taskScroll_ then
		slot0.taskScroll_:Dispose()

		slot0.taskScroll_ = nil
	end

	if slot0.refreshTimer then
		slot0.refreshTimer:Stop()

		slot0.refreshTimer = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
