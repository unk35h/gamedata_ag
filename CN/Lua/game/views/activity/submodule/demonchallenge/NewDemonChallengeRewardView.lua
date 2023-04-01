slot0 = class("NewDemonChallengeRewardView", ReduxView)

function slot0.UIName(slot0)
	return DemonChallengeTools.GetAwardUIName(slot0.params_.activityId)
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.scrollView_, NewDemonChallengeRewardItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backMask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityId_ = slot0.params_.activityId

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshLevelName()
	slot0:RefreshScroll()
end

function slot0.RefreshLevelName(slot0)
end

function slot0.RefreshScroll(slot0)
	slot0.sortedRewardList_ = slot0:GetAwardData()
	slot0.completedDifficultyCountList_ = NewDemonChallengeData:GetCompletedDifficultyCountList(slot0.activityId_)

	slot0.scrollHelper_:StartScroll(#slot0.sortedRewardList_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = NewDemonChallengeRewardCfg[slot0.sortedRewardList_[slot1]]

	slot2:RefreshData({
		activityId = slot0.activityId_,
		taskId = slot3.id,
		completeCount = slot0.completedDifficultyCountList_[slot3.difficulty_id]
	})
end

function slot0.OnDemonChallengeReceiveReward(slot0, slot1, slot2)
	for slot7, slot8 in pairs(slot0.scrollHelper_:GetItemList()) do
		if slot8:GetItemInfo().taskId == slot2.id then
			slot8:RefreshData(slot9)
		end
	end
end

function slot0.OnExit(slot0)
end

function slot0.GetAwardData(slot0)
	slot2 = deepClone(NewDemonChallengeRewardCfg.get_id_list_by_activity_id[slot0.activityId_])

	table.sort(slot2, function (slot0, slot1)
		return NewDemonChallengeRewardCfg[slot0].difficulty_id < NewDemonChallengeRewardCfg[slot1].difficulty_id
	end)

	return slot2
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
end

return slot0
