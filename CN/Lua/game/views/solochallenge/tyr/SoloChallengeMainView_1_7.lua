slot1 = class("SoloChallengeMainView_1_7", import("game.views.soloChallenge.Factory.FactorySoloChallengeMainView"))

function slot1.UIName(slot0)
	return "UI/VersionUI/DarkFlameUI/DFSoloChallengeUI/DFSoloChallengeMainUI"
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("soloChallengeRewardView_1_7", {
			activityID = uv0.selectActivityID_
		})
	end)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("soloChallengeDifficultySelectView_1_7", {
			activityID = uv0.selectActivityID_
		})
	end)
end

return slot1
