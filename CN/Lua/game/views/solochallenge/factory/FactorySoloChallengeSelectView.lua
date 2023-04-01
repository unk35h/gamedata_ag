slot1 = class("FactorySoloChallengeSelectView", import("game.views.soloChallenge.SoloChallengeSelectView"))

function slot1.UIName(slot0)
	return "UI/MardukUI/SoloChallenge/MardukSoloChallengeBattleTeamUI"
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.scrollView_, FactorySoloChallengeSelectItem)
	slot0.goBackHandler_ = handler(slot0, slot0.OnGoBack)
end

function slot1.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(slot0.goBackHandler_)

	slot0.activityID_ = slot0.params_.activityID
	slot0.difficultyIndex_ = slot0.params_.difficultyIndex
	slot0.stageList_ = ActivitySoloChallengeCfg[slot0.activityID_].stage_id[slot0.difficultyIndex_][2]

	slot0.list_:StartScroll(#slot0.stageList_)
	slot0:RefreshUI()
end

function slot1.OnResetData(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		SoloChallengeData:ResetLockData(slot2)
		JumpTools.OpenPageByJump("/factorySoloChallengeMain", {
			activityID = ActivitySoloChallengeCfg[slot0.activityID_].main_activity_id
		})
	else
		ShowTips(slot1.result)
	end
end

function slot1.OnGoBack(slot0)
	JumpTools.OpenPageByJump("/factorySoloChallengeMain", {
		activityID = ActivitySoloChallengeCfg[slot0.activityID_].main_activity_id
	})
	JumpTools.OpenPageByJump("soloChallengeDifficultySelect", {
		activityID = slot0.activityID_
	})
end

function slot1.Dispose(slot0)
	slot0.goBackHandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot1
