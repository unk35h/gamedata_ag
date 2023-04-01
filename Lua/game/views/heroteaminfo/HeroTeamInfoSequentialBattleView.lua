slot1 = class("HeroTeamInfoSequentailBattleView", import("game.views.heroTeamInfo.HeroTeamInfoBaseView"))

function slot1.ExtraSorter(slot0, slot1, slot2, slot3, slot4)
	slot6 = slot0.heroTrialList_
	slot7 = SequentialBattleData:GetHeroTeamData(slot0.params_.activityID)
	slot8 = table.keyof(SequentialBattleChapterCfg[slot0.params_.activityID].stage_id, slot0.params_.stageID)
	slot9 = {}

	for slot13, slot14 in pairs(slot0.heroTeam_) do
		slot9[slot13] = {
			id = slot14,
			trialID = slot6[slot13]
		}
	end

	slot10 = false
	slot11 = false

	for slot15, slot16 in ipairs(slot7) do
		if slot15 ~= slot8 then
			for slot20, slot21 in pairs(slot16.heroList) do
				if slot1.id == slot21.heroID then
					slot10 = true
				end

				if slot2.id == slot21.heroID then
					slot11 = true
				end
			end
		end
	end

	if slot10 ~= slot11 then
		return true, slot11 and true or false
	end

	if slot0:indexof(slot9, slot1) ~= slot0:indexof(slot9, slot2) then
		return true, slot12 < slot13
	end

	if slot1.trialID ~= 0 or slot2.trialID ~= 0 then
		if slot1.trialID ~= 0 and slot2.trialID ~= 0 then
			if slot3 == 0 and slot1.star ~= slot2.star then
				if slot0.curOrder_ == "desc" then
					return true, slot2.star < slot1.star
				else
					return true, slot1.star < slot2.star
				end
			end

			if getHeroPower(slot1.trialID, true) ~= getHeroPower(slot2.trialID, true) then
				if slot4 == "desc" then
					return true, slot15 < slot14
				else
					return true, slot14 < slot15
				end
			else
				return true, slot2.trialID < slot1.trialID
			end
		else
			return true, slot2.trialID < slot1.trialID
		end
	end

	return false, false
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	uv0.super.HeadRenderer(slot0, slot1, slot2)
	slot2:SetHeroLock(table.keyof(slot0.lockHeroList_, slot0.heroDataList_[slot1].id) ~= nil)
end

function slot1.ChangeTeam(slot0, slot1, slot2, slot3)
	slot4 = table.keyof(SequentialBattleChapterCfg[slot0.params_.activityID].stage_id, slot0.params_.stageID)

	SequentialBattleAction.SaveTeam(slot0.params_.activityID, slot4, slot1, slot2)
	SequentialBattleData:SetComboSkillID(slot0.params_.activityID, slot4, ComboSkillTools.GetRecommendSkillID(slot1, true), false)
end

function slot1.GetTextAndImage(slot0)
	if slot0:IsSameHeroInTeam(slot0.selectID_) and not slot0:IsInTeam(slot0.selectID_, slot0.selectTrialID_) then
		if slot0.heroTeam_[slot0.params_.selectHeroPos] ~= slot0.selectID_ then
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
		else
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
		end
	end

	if slot0.heroTeam_[slot0.params_.selectHeroPos] == 0 then
		if slot0:IsInTeam(slot0.selectID_, slot0.selectTrialID_) then
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
		else
			return string.format("<color=#222222>%s</color>", GetTips("JOIN_TEAM")), "0"
		end
	end

	if slot0.selectID_ == slot0.heroTeam_[slot0.params_.selectHeroPos] then
		return string.format("<color=#EBEBEB>%s</color>", GetTips("REMOVE_FROM_TEAM")), "2"
	end

	return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
end

function slot1.OnJoinClick(slot0)
	if table.keyof(slot0.lockHeroList_, slot0.selectID_) then
		slot1 = slot0.params_.activityID
		slot2 = GetTips("HERO_IN_OTHER_TEAM")
		slot3 = SequentialBattleData:GetHeroTeamData(slot1)
		slot4 = table.keyof(SequentialBattleChapterCfg[slot1].stage_id, slot0.params_.stageID)
		slot5 = ""

		for slot9 = 1, #SequentialBattleChapterCfg[slot1].stage_id do
			if slot9 ~= slot4 then
				slot14 = slot9

				for slot14, slot15 in ipairs(SequentialBattleData:GetHeroTeam(slot1, slot14)) do
					if slot15.heroID == slot0.selectID_ then
						slot5 = GetTips(string.format("TEAM_%s", slot9))
					end
				end
			end
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(slot2, slot5),
			OkCallback = function ()
				uv0.super.OnJoinClick(uv1)
			end
		})

		return
	end

	uv0.super.OnJoinClick(slot0)
end

return slot1
