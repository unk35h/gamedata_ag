slot0 = class("SoloChallengeRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MardukUI/SoloChallenge/MardukSoloChallengeRewardUI"
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, slot0:GetRewardItemClass())
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
	slot0:RefreshLevelName()
	slot0:RefreshScroll()
end

function slot0.RefreshLevelName(slot0)
	slot0.levelNameText_.text = ActivitySoloChallengeCfg[slot0.activityID_].name
end

function slot0.RefreshScroll(slot0)
	slot0.scrollHelper_:StartScroll(slot0:GetAwardListLength())
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData({
		activityID = slot0.activityID_,
		difficultyIndex = slot1
	})
end

function slot0.OnExit(slot0)
end

function slot0.GetAwardListLength(slot0)
	return #ActivitySoloChallengeCfg[slot0.activityID_].reward_item_list
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
end

function slot0.GetRewardItemClass(slot0)
	return SoloChallengeRewardItem
end

return slot0
