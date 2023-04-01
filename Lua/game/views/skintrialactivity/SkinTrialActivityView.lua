slot0 = class("SkinTrialActivityView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/HellaUI/HellaSkinTrialMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.skinItemList_ = {}
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.activityID_ = slot0.params_.activityID
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:RefreshUI()
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.skinItemList_) do
		slot5:Dispose()
	end

	slot0.skinItemList_ = nil
end

function slot0.RefreshUI(slot0)
	slot0.skinTrialIDList_ = slot0:GetskinTrialIDList()

	slot0:RefreshSkinItem()
end

function slot0.RefreshSkinItem(slot0)
	for slot4, slot5 in ipairs(slot0.skinTrialIDList_) do
		if slot0.skinItemList_[slot4] then
			slot0.skinItemList_[slot4]:SetSkinTrialID(slot5)
		else
			slot0.skinItemList_[slot4] = slot0:GetItemClass().New(slot0.skinItem_, slot0.skinItemPanel_, slot5, slot0.activityID_)
		end
	end

	for slot4 = #slot0.skinItemList_, #slot0.skinTrialIDList_ + 1, -1 do
		slot0.skinItemList_[slot4]:Dispose()

		slot0.skinItemList_[slot4] = nil
	end
end

function slot0.GetskinTrialIDList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(ActivityData:GetActivityData(slot0.activityID_).subActivityIdList) do
		for slot12, slot13 in ipairs(ActivitySkinTrialCfg.get_id_list_by_activity_id[slot7]) do
			table.insert(slot1, slot13)
		end
	end

	return slot1
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	for slot4, slot5 in ipairs(slot0.skinTrialIDList_) do
		if slot0.skinItemList_[slot4] and slot0.skinItemList_[slot4].RefreshTime ~= nil then
			slot0.skinItemList_[slot4]:RefreshTime()
		end
	end

	slot0.textTime_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		for slot3, slot4 in ipairs(uv0.skinTrialIDList_) do
			if uv0.skinItemList_[slot3] and uv0.skinItemList_[slot3].RefreshTime ~= nil then
				uv0.skinItemList_[slot3]:RefreshTime()
			end
		end

		uv0.textTime_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.GetItemClass(slot0)
	return SkinTrialActivityItem
end

return slot0
