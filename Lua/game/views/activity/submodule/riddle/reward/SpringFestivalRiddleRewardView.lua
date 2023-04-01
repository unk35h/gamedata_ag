slot0 = class("SpringFestivalRiddleRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/Riddle/RiddleRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.rewardUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, SpringFestivalRiddleRewardItem)
end

function slot0.OnEnter(slot0)
	slot1 = slot0.params_.activityID
	slot3 = SpringFestivalRiddleData:GetReceiveList(slot1)
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot1]) do
		if table.keyof(slot3, slot10) then
			table.insert(slot5, slot10)
		else
			table.insert(slot4, slot10)
		end
	end

	table.insertto(slot4, slot5)

	slot0.sortList_ = slot4

	slot0.rewardUIList_:StartScroll(#slot2, 1)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.rewardUIList_ then
		slot0.rewardUIList_:Dispose()

		slot0.rewardUIList_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot0.params_.activityID, slot0.sortList_[slot1])
end

return slot0
