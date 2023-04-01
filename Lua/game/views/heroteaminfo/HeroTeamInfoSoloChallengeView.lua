slot1 = class("HeroTeamInfoSoloChallengeView", import("game.views.heroTeamInfo.HeroTeamInfoBaseView"))

function slot1.HeadRenderer(slot0, slot1, slot2)
	uv0.super.HeadRenderer(slot0, slot1, slot2)

	slot3 = slot0.heroDataList_[slot1].id
	slot5, slot6, slot7 = slot0:IsInTeam(slot3, slot0.heroDataList_[slot1].trialID)

	if (table.keyof(slot0.lockHeroList_, slot3) ~= nil or table.keyof(slot0.lockHeroList_, slot4) ~= nil) == false then
		slot2:SetSoloChallengeIndex(slot7)
	else
		slot2:SetSoloChallengeIndex(-1)
	end

	slot2:SetHeroLock(slot8)
	slot2:SetInTeamFlag(false)
end

function slot1.ChangeTeam(slot0, slot1, slot2, slot3)
	SoloChallengeData:SetLastTeamData(slot0.params_.activityID, true)
	SoloChallengeData:SetCustomHeroList(slot0.params_.activityID, SoloChallengeData:GetSelectedDifficultyIndex(slot0.params_.activityID), slot1, slot2)
	SoloChallengeAction.SaveCustomList(slot0.params_.activityID)
	ComboSkillData:SetNeedRefresh(slot3)
end

return slot1
