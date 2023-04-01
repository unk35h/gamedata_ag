slot0 = class("SoloChallengeDifficultySelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MardukUI/SoloChallenge/MardukSoloChallengeChoosedifficult"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectItemHandler_ = handler(slot0, slot0.OnSelectItem)
	slot0.difficultyItemList_ = {}

	for slot5 = 1, slot0.panelTrans_.childCount do
		slot0.difficultyItemList_[slot5] = SoloChallengeDifficultyItem.New(slot0.panelTrans_:GetChild(slot5 - 1))

		slot0.difficultyItemList_[slot5]:SetSelectCallBack(slot0.selectItemHandler_)
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.difficultyIndex_ == nil then
			ShowTips("SELECT_CURRENT")

			return
		end

		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SoloChallengeAction.SaveDifficulty(uv0.activityID_, uv0.difficultyIndex_, handler(uv0, uv0.OnStart))
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnStart(slot0)
	SoloChallengeData:SetSelectedDifficultyIndex(slot0.activityID_, slot0.difficultyIndex_)
	slot0:Go("/factorySoloChallengeSelect", {
		activityID = slot0.activityID_,
		difficultyIndex = slot0.difficultyIndex_
	})
end

function slot0.OnEnter(slot0)
	manager.windowBar:HideBar()

	slot0.activityID_ = slot0.params_.activityID
	slot0.difficultyIndex_ = SoloChallengeData:GetSelectedDifficultyIndex(slot0.activityID_) or 1

	SoloChallengeData:SetSelectedDifficultyIndex(slot0.activityID_, slot0.difficultyIndex_)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot0.difficultyIndex_ = nil
end

function slot0.Dispose(slot0)
	slot0.selectItemHandler_ = nil

	for slot4, slot5 in ipairs(slot0.difficultyItemList_) do
		slot5:Dispose()
	end

	slot0.difficultyItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnSelectItem(slot0, slot1)
	slot0.difficultyIndex_ = slot1
	slot5 = slot0.activityID_
	slot6 = slot0.difficultyIndex_

	SoloChallengeData:SetSelectedDifficultyIndex(slot5, slot6)

	for slot5, slot6 in ipairs(slot0.difficultyItemList_) do
		slot6:SetSelect(slot1)
	end
end

function slot0.RefreshUI(slot0)
	for slot4, slot5 in ipairs(slot0.difficultyItemList_) do
		slot5:SetData(slot0.activityID_, slot4)
		slot5:SetSelect(slot0.difficultyIndex_)
	end
end

return slot0
