slot0 = class("LimitedCalculationDifficultyView", ReduxView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummerDifficultySelectionPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, DifficultySelectItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.activityID_, slot0.list_[slot1])
	slot2:SetSelected(slot0.curDifficulty_)
	slot2:RegisterClickListener(function (slot0)
		uv0.curDifficulty_ = slot0

		uv0:Back()
	end)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityId

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.curDifficulty_ = LimitedCalculationData:GetCurDifficulty(slot0.activityID_)
	slot0.list_ = LimitedCalculationData:GetDifficultyList(slot0.activityID_)

	if table.indexof(slot0.list_, slot0.curDifficulty_) == 1 then
		slot0.scrollHelper_:StartScroll(#slot0.list_)
	else
		slot0.scrollHelper_:StartScroll(#slot0.list_, slot1 - 1)
	end
end

function slot0.RefreshList(slot0)
	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:SetSelected(slot0.curDifficulty_)
	end
end

function slot0.OnExit(slot0)
	LimitedCalculationData:SetCurDifficulty(slot0.activityID_, slot0.curDifficulty_)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
