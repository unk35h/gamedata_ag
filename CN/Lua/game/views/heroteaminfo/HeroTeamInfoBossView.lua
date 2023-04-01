slot1 = class("HeroTeamInfoBossView", import("game.views.heroTeamInfo.HeroTeamInfoBaseView"))

function slot1.OnEnter(slot0)
	slot0.bossIndex_ = slot0.params_.bossIndex

	uv0.super.OnEnter(slot0)
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	uv0.super.HeadRenderer(slot0, slot1, slot2)
	slot2:SetHeroLock(table.keyof(slot0.lockHeroList_, slot0.heroDataList_[slot1].id) ~= nil)
	slot2:SetChallengeFlag(slot0:IsCurrentBossLock(slot3))
end

function slot1.SelectHero(slot0, slot1, slot2)
	slot0.selectID_ = slot1
	slot0.selectTrialID_ = slot2
	slot5 = slot0.heroHeadList_
	slot7 = slot5

	for slot6, slot7 in pairs(slot5.GetItemList(slot7)) do
		slot7:SetSelected(slot7.heroId_ == slot1)
	end

	slot0:UpdateHeroView()
	slot0:RefreshJoinBtn()
end

function slot1.GetHeroTeam(slot0)
	slot0.heroTeam_, slot0.lockStateList_, slot0.lockHeroList_, slot0.heroTrialList_ = GetLocalHeroTeam(slot0.params_.stageType, slot0.params_.stageID, slot0.params_.bossIndex, slot0.params_.cont_id, slot0.params_.team_id)
end

function slot1.GetDefaultHeroData(slot0)
	if BattleFieldData:GetCurrentSelectHeroID() ~= 0 then
		return slot1, 0
	end

	if (slot0.heroTeam_[slot0.params_.selectHeroPos] or 0) == 0 then
		for slot6, slot7 in pairs(slot0.heroDataList_) do
			if not slot0:IsInTeam(slot7.id) and not table.keyof(slot0.lockHeroList_, slot8) then
				return slot8, 0
			end
		end
	end

	if slot2 == 0 then
		for slot6, slot7 in pairs(slot0.heroDataList_) do
			return slot7.id, 0
		end
	end

	return slot2, 0
end

function slot1.IsInTeam(slot0, slot1)
	slot6 = slot0.params_.bossIndex

	for slot6 = 1, #GetLocalHeroTeam(slot0.params_.stageType, slot0.params_.stageID, slot6, slot0.params_.cont_id, slot0.params_.team_id) do
		if slot2[slot6] == slot1 then
			return true, slot0.heroTeam_[1] == slot1
		end
	end

	return false
end

function slot1.ChangeTeam(slot0, slot1, slot2, slot3)
	SetHeroTeam(slot0.params_.stageType, slot0.params_.stageID, slot0.params_.activityID, slot1, slot2, nil, , slot0.params_.cont_id, slot0.params_.team_id)
	ComboSkillData:SetBossChallengeNeedRefresh(slot0.bossIndex_, slot3)
end

function slot1.GetLockHeroList(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(BossTools.GetLockHero()) do
		if slot6 ~= slot0.bossIndex_ then
			table.insertto(slot1, slot7)
		end
	end

	return slot1
end

function slot1.GetHeroList(slot0)
	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot5 = BossTools.GetLockHero()[slot0.bossIndex_]

	for slot9, slot10 in ipairs(HeroTools.Sort(HeroData:GetHeroList())) do
		if table.keyof(slot5, slot10) then
			table.insert(slot2, slot10)
		elseif table.keyof(slot0.lockHeroList_, slot10) then
			table.insert(slot3, slot10)
		else
			table.insert(slot4, slot10)
		end
	end

	table.insertto(slot2, slot4)
	table.insertto(slot2, slot3)

	slot10 = slot0.params_.bossIndex
	slot6 = GetLocalHeroTeam(slot0.params_.stageType, slot0.params_.stageID, slot10, slot0.params_.cont_id, slot0.params_.team_id)

	for slot10 = 3, 1, -1 do
		if slot6[slot10] ~= 0 then
			table.removebyvalue(slot2, slot6[slot10])
			table.insert(slot2, 1, slot6[slot10])
		end
	end

	return slot2
end

function slot1.IsCurrentBossLock(slot0, slot1)
	return table.keyof(BossTools.GetLockHero()[slot0.bossIndex_], slot1) ~= nil
end

return slot1
