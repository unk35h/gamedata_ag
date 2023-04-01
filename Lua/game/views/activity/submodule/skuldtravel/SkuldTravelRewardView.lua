slot0 = class("SkuldTravelRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelreward"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardlist_ = deepClone(TravelSkuldRewardCfg.all)

	slot0:RewardSort()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listgo_, SkuldTravelRewardItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.rewardlist_[slot1])
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgbtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RewardSort()
	slot0.list_:StartScroll(#TravelSkuldRewardCfg.all)
end

function slot0.OnExit(slot0)
end

function slot0.RewardSort(slot0)
	slot1 = {
		{},
		{},
		{}
	}

	for slot5, slot6 in pairs(slot0.rewardlist_) do
		table.insert(slot1[SkuldTravelData:GetTaskStatuByTaskId(slot6)], slot6)
	end

	slot0.rewardlist_ = {}

	for slot5, slot6 in pairs(slot1) do
		table.sort(slot6)
		table.insertto(slot0.rewardlist_, slot6)
	end
end

function slot0.OnSkuldGetReward(slot0)
	slot0:RewardSort()
	slot0.list_:Refresh()
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	slot0.super.Dispose(slot0)
end

return slot0
