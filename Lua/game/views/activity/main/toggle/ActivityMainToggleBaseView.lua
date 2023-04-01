slot0 = class("ActivityMainToggleBaseView", ReduxView)

function slot0.UIName(slot0)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.toggleClickHandler_ = handler(slot0, slot0.ToggleOnClick)
	slot0.toggleOverHandler_ = handler(slot0, slot0.ToggleOver)
	slot0.toggleItemList_ = {}
	slot0.panelItemList_ = {}
	slot4 = slot0:GetActivityID()

	for slot4, slot5 in ipairs(ActivityToggleCfg.get_id_list_by_main_activity_id[slot4]) do
		slot6 = ActivityToggleCfg[slot5]
		slot0.toggleItemList_[slot6.activity_id] = ActivityMainToggleItem.New(slot0.itemGo_, slot0.itemParentGo_, slot5, slot6.activity_id)
	end
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RegistListener(ACTIVITY_MAIN_TOGGLE_CLICK, slot0.toggleClickHandler_)

	slot4 = ACTIVITY_MAIN_TOGGLE_OVER
	slot5 = slot0.toggleOverHandler_

	manager.notify:RegistListener(slot4, slot5)

	for slot4, slot5 in pairs(slot0.toggleItemList_) do
		slot5:OnEnter()
	end

	for slot4, slot5 in pairs(slot0.panelItemList_) do
		slot5:OnEnter()
	end

	slot1 = nil

	if ((not slot0.params_.isBack or ActivityVersionData:GetSelectActivityID(slot0:GetActivityID())) and (not slot0.params_.subActivityID or slot0.params_.subActivityID) and slot0:GetOpenActivityID()) == nil then
		slot0:Go("/home")

		return
	end

	slot0:ToggleOnClick(slot1, true)

	slot0.scrollTimer_ = FrameTimer.New(function ()
		if uv0.scrollView_ then
			slot0, slot1 = uv0:GetActivityIndex(uv1)

			if slot0 == nil then
				uv0.scrollView_.verticalNormalizedPosition = 1
			else
				uv0.scrollView_.verticalNormalizedPosition = 1 - (slot0 - 1) / (slot1 - 1)
			end
		end
	end, 1, 1)

	slot0.scrollTimer_:Start()
end

function slot0.OnTop(slot0)
	if ActivityVersionData:GetSelectActivityID(slot0:GetActivityID()) == nil then
		return
	end

	if slot0.panelItemList_[slot1] then
		slot0.panelItemList_[slot1]:OnTop()

		if slot0.panelItemList_[slot1].UpdateBar then
			slot0.panelItemList_[slot1]:UpdateBar()
		end
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(ACTIVITY_MAIN_TOGGLE_CLICK, slot0.toggleClickHandler_)

	slot4 = ACTIVITY_MAIN_TOGGLE_OVER
	slot5 = slot0.toggleOverHandler_

	manager.notify:RemoveListener(slot4, slot5)

	for slot4, slot5 in pairs(slot0.toggleItemList_) do
		slot5:OnExit()
	end

	for slot4, slot5 in pairs(slot0.panelItemList_) do
		slot5:Show(false)
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.toggleClickHandler_ = nil
	slot0.toggleOverHandler_ = nil

	for slot4, slot5 in pairs(slot0.panelItemList_) do
		slot5:Dispose()
	end

	slot0.panelItemList_ = nil

	for slot4, slot5 in pairs(slot0.toggleItemList_) do
		slot5:Dispose()
	end

	slot0.toggleItemList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddToggleListener(slot0.scrollView_, function (slot0)
		if uv0.viewTf_.rect.height < uv0.contentTf_.rect.height and uv0.scrollView_.verticalNormalizedPosition > 0 then
			SetActive(uv0.arrowGo_, true)
		else
			SetActive(uv0.arrowGo_, false)
		end
	end)
end

function slot0.GetToggleCfg(slot0)
	return {}
end

function slot0.GetActivityID(slot0)
	return slot0.params_.activityID
end

function slot0.ToggleOnClick(slot0, slot1, slot2)
	if ActivityVersionData:GetSelectActivityID(slot0:GetActivityID()) == slot1 and slot2 ~= true then
		return
	end

	ActivityVersionData:SetSelectActivityID(slot0:GetActivityID(), slot1)

	if not slot0.panelItemList_[slot1] then
		slot0.panelItemList_[slot1] = ActivityTools.GetTogglePanelView(slot1).New(slot0.panelParentGo_, slot1)

		slot0.panelItemList_[slot1]:OnEnter()
	end

	for slot7, slot8 in pairs(slot0.panelItemList_) do
		if slot7 == slot1 then
			slot8:UpdateBar()
		else
			slot8:Show(false)
		end
	end

	slot7 = true

	slot0.panelItemList_[slot1]:Show(slot7)

	for slot7, slot8 in pairs(slot0.toggleItemList_) do
		slot8:OnSelect(slot7 == slot1)
	end
end

function slot0.ToggleOver(slot0, slot1)
	if ActivityVersionData:GetSelectActivityID(slot0:GetActivityID()) == slot1 then
		if slot0:GetOpenActivityID() == nil then
			slot0:Go("/home")

			return
		end

		slot0:ToggleOnClick(slot3, true)
	end
end

function slot0.GetOpenActivityID(slot0)
	slot1 = manager.time:GetServerTime()

	for slot6, slot7 in ipairs(ActivityToggleCfg.get_id_list_by_main_activity_id[slot0:GetActivityID()]) do
		slot8 = ActivityToggleCfg[slot7].activity_id
		slot9 = ActivityData:GetActivityData(slot8)
		slot10 = slot9.startTime
		slot11 = slot9.stopTime

		if ActivityShopCfg[slot8] then
			slot11 = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[slot8].shop_id].activity_id).stopTime
		end

		if slot10 <= slot1 and slot1 < slot11 then
			return slot8
		end
	end
end

function slot0.GetActivityIndex(slot0, slot1)
	slot2 = manager.time:GetServerTime()
	slot4 = {}

	for slot8, slot9 in ipairs(ActivityToggleCfg.get_id_list_by_main_activity_id[slot0:GetActivityID()]) do
		slot10 = ActivityToggleCfg[slot9].activity_id
		slot11 = ActivityData:GetActivityData(slot10)

		if ActivityShopCfg[slot10] then
			if ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[slot10].shop_id].activity_id):IsActivitying() then
				table.insert(slot4, slot10)
			end
		elseif slot11.startTime <= slot2 and slot2 < slot11.stopTime then
			table.insert(slot4, slot10)
		end
	end

	return table.keyof(slot4, slot1), #slot4
end

return slot0
