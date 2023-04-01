slot0 = class("DemonChallengerewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/OsirisUI/OsirisChallengerewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.levelIndex_ = DemonChallengeData:GetCacheSelectLevelIndex()

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.scrollView_, TaskDemonChallengeItemView)
	slot0.refreshHandler_ = handler(slot0, slot0.RefreshScroll)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backMask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.levelIndex_ = DemonChallengeData:GetCacheSelectLevelIndex()

	slot0:RefreshUI()
	manager.notify:RegistListener(DEMON_CHALLENGE_RECEIVE_REWARD, slot0.refreshHandler_)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshLevelName()
	slot0:RefreshScroll()
end

function slot0.RefreshLevelName(slot0)
	slot0.levelNameText_.text = DemonChallengeData:GetLevelName(slot0.levelIndex_)
end

function slot0.RefreshScroll(slot0)
	slot0:UpdateData()
	slot0.scrollHelper_:StartScroll(#slot0.sortedRewardList_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(DemonChallengeData:GetDropId(slot0.levelIndex_, slot0.sortedRewardList_[slot1]), slot0.sortedRewardList_[slot1], slot0.levelIndex_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(DEMON_CHALLENGE_RECEIVE_REWARD, slot0.refreshHandler_)
end

function slot0.UpdateData(slot0)
	slot0.sortedRewardList_ = DemonChallengeData:GetSortedRewardIndexList(slot0.levelIndex_)
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
