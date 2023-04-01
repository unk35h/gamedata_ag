slot0 = class("ActivityRaceRewardPanelView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIDownUI/ActivityRace/ActivityRaceRewardPanelUI"
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.scrollView_, ActivityRaceRewardItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backMask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.sortedRewardList_ = ActivityRaceData:GetSortedRewardList(slot0.activityID_)

	slot0.scrollHelper_:StartScroll(#slot0.sortedRewardList_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.sortedRewardList_[slot1])
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
