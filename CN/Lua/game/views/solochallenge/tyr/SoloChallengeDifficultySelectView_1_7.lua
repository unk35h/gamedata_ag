slot1 = class("SoloChallengeDifficultySelectView_1_7", import("game.views.soloChallenge.SoloChallengeDifficultySelectView"))

function slot1.UIName(slot0)
	return "UI/VersionUI/DarkFlameUI/DFSoloChallengeUI/DFSoloChallengeDifficultyUI"
end

function slot1.Init(slot0)
	uv0.super.Init(slot0)

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "selectDifficulty")
end

function slot1.OnSelectItem(slot0, slot1)
	slot0.difficultyIndex_ = slot1

	SoloChallengeData:SetSelectedDifficultyIndex(slot0.activityID_, slot0.difficultyIndex_)
	slot0.selectController_:SetSelectedState(tostring(slot0.difficultyIndex_))
end

function slot1.RefreshUI(slot0)
	for slot4, slot5 in ipairs(slot0.difficultyItemList_) do
		slot5:SetData(slot0.activityID_, slot4)
	end

	slot0.selectController_:SetSelectedState(tostring(slot0.difficultyIndex_))
end

function slot1.OnStart(slot0)
	SoloChallengeData:SetSelectedDifficultyIndex(slot0.activityID_, slot0.difficultyIndex_)
	slot0:Go("/soloChallengeSelectView_1_7", {
		activityID = slot0.activityID_,
		difficultyIndex = slot0.difficultyIndex_
	})
end

return slot1
