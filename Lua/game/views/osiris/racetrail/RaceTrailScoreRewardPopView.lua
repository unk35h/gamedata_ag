slot0 = class("RaceTrailScoreRewardPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/OsirisUI/OsirisintegralUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, slot0:GetRewardItemClass())
end

function slot0.GetRewardItemClass(slot0)
	return RaceTrailScoreRewardItem
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.list_[slot1], slot0.scoreNum_, slot0.params_.activityID)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.list_ = RaceTrailData:GetScoreRewardSortList(slot0.params_.activityID)
	slot0.scoreNum_ = RaceTrailData:GetTotalScore(slot0.params_.activityID)
	slot0.score_.text = slot0.scoreNum_

	slot0.scrollHelper_:StartScroll(#slot0.list_)
end

function slot0.OnPointReceive(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
