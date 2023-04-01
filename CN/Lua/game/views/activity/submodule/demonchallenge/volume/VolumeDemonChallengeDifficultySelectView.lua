slot0 = class("VolumeDemonChallengeDifficultySelectView", DemonChallengeDifficultySelectView)

function slot0.RefreshUI(slot0)
	slot0:RefreshSelectedUI()
	slot0:RefreshDesc()

	if SubDemonChallengeData:GetChallengeInfo(slot0.activityId_).challengeInfo then
		slot3 = slot1.challengeInfo[3].hurt_state

		if slot1.challengeInfo[3].challenge_state == ActivityConst.DEMON_CHALLENGE_STATE.FINISHED and slot3 == ActivityConst.DEMON_CHALLENGE_HURT_STATE.NO_HURT then
			slot0.completedUIControllerS_[3]:SetSelectedState("nodamag")
		end
	end
end

return slot0
