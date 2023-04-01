slot0 = class("InfinityTaskBaseView", ReduxView)

function slot0.UIName(slot0)
	return "UI/OsirisUI/OsirisUITaskUI"
end

function slot0.GetTaskViewClass(slot0)
	return ActivityTaskBaseView
end

function slot0.GetInfinityPoolViewClass(slot0)
	return ActivityInfinityBaseView
end

function slot0.GetInfinityPoolItemID(slot0)
	return CurrencyConst.CURRENCY_TYPE_OSIRIS_INFINITY_COIN
end

function slot0.GetHelpTips(slot0)
	return "ACTIVITY_OSIRIS_INFINITY_POOL_DESCRIPE"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.viewList_ = {}
	slot0.controller_ = {}

	for slot4 = 1, 5 do
		slot0.controller_[slot4] = ControllerUtil.GetController(slot0[string.format("transformTreeItem%s_", slot4)], "lock")
	end

	slot0.refreshTreeItemHandler_ = handler(slot0, slot0.RefreshInfinityBtn)
	slot0.toggleUpdateHandler_ = handler(slot0, slot0.OnToggleUpdate)
	slot0.toggleListView_ = ToggleListView.New(slot0.goToggleList_, {
		0,
		5
	})
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(OSIRIS_INFINITY_OPEN_CORE_ITEM, slot0.refreshTreeItemHandler_)

	slot4 = TOGGLE_LIST_UPDATE
	slot5 = slot0.toggleUpdateHandler_

	manager.notify:RegistListener(slot4, slot5)

	for slot4, slot5 in pairs(slot0.viewList_) do
		slot5:OnEnter()
	end

	slot0.toggleListView_:OnEnter()

	if slot0.params_.activityType == OsirisConst.ACTIVITY_TYPE.TASK then
		slot0.toggleListView_:SetSelectOn(1)
	else
		slot0.toggleListView_:SetSelectOn(2, OsirisInfinityPoolData:GetClickPhaseValue(slot0.params_.activityInfinityID))
		slot0:ChangeSelect(2)
	end

	manager.redPoint:bindUIandKey(slot0.transformTask_, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot0.params_.activityTaskID), {
		x = 0,
		y = 0
	})
	slot0:RefreshInfinityBtn()
end

function slot0.OnTop(slot0)
	if slot0.curActivityType ~= slot0.params_.activityType then
		if slot0.params_.activityType == OsirisConst.ACTIVITY_TYPE.TASK then
			slot0.toggleListView_:SetSelectOn(1)
		else
			slot0.toggleListView_:SetSelectOn(2, OsirisInfinityPoolData:GetClickPhaseValue(slot0.params_.activityInfinityID))
			slot0:ChangeSelect(2)
		end
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(OSIRIS_INFINITY_OPEN_CORE_ITEM, slot0.refreshTreeItemHandler_)
	manager.notify:RemoveListener(TOGGLE_LIST_UPDATE, slot0.toggleUpdateHandler_)

	slot5 = slot0.transformTask_
	slot6 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot0.params_.activityTaskID)

	manager.redPoint:unbindUIandKey(slot5, slot6, {
		x = 0,
		y = 0
	})

	for slot5, slot6 in pairs(slot0.viewList_) do
		slot6:OnExit()
	end

	slot0.toggleListView_:OnExit()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.toggleListView_:Dispose()

	slot0.toggleListView_ = nil
	slot0.refreshTreeItemHandler_ = nil
	slot0.toggleUpdateHandler_ = nil

	for slot4, slot5 in pairs(slot0.viewList_) do
		slot5:Dispose()
	end

	slot0.viewList_ = nil
end

function slot0.AddListeners(slot0)
end

function slot0.RefreshInfinityBtn(slot0)
	slot1 = OsirisInfinityPoolData:GetOpenPhase(slot0.params_.activityInfinityID)

	for slot5 = 1, 5 do
		slot0.controller_[slot5]:SetSelectedState(slot5 <= slot1 and "false" or "true")
	end
end

function slot0.OnToggleUpdate(slot0, slot1, slot2)
	slot0:ChangeSelect(slot1)

	if slot1 == 2 and slot2 == nil then
		slot0.toggleListView_:SetSelectOn(2, OsirisInfinityPoolData:GetClickPhaseValue(slot0.params_.activityInfinityID))

		return
	end

	if slot0.viewList_[slot1] == nil then
		if slot1 == 1 then
			slot0.viewList_[slot1] = slot0:GetTaskViewClass().New(slot0.goContent_, slot0.params_.activityTaskID)
		else
			slot0.viewList_[slot1] = slot0:GetInfinityPoolViewClass().New(slot0.goContent_, slot0.params_.activityInfinityID)
		end
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		slot0:GetInfinityPoolItemID()
	})

	slot7 = true

	manager.windowBar:SetBarCanAdd(slot0:GetInfinityPoolItemID(), slot7)

	slot6 = slot0.GetHelpTips

	manager.windowBar:SetGameHelpKey(slot6(slot0))

	for slot6, slot7 in pairs(slot0.viewList_) do
		slot7:Show(slot6 == slot1)
	end

	if slot2 then
		if OsirisInfinityPoolData:GetOpenPhase(slot0.params_.activityInfinityID) < slot2 then
			slot0.toggleListView_:SetSelectOn(2, slot3 < OsirisInfinityPoolData:GetClickPhaseValue(slot0.params_.activityInfinityID) and slot3 or slot4)
			ShowTips("INFINITY_LOCK")

			return
		end

		OsirisInfinityPoolData:SetClickPhaseValue(slot0.params_.activityInfinityID, slot2)
		slot0.viewList_[2]:SetPhase(slot2)
	end
end

function slot0.ChangeSelect(slot0, slot1)
	slot0.curActivityType = slot1
	slot0.params_.activityType = slot1
end

return slot0
