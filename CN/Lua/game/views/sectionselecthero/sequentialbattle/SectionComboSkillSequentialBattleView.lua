slot0 = class("SectionComboSkillSequentialBattleView", import("..SectionComboSkillView"))

function slot0.ClickComboSkillBtn(slot0)
	JumpTools.OpenPageByJump("comboSkillSelectSequentialBattle", {
		stageType = slot0.stageType_,
		stageID = slot0.stageID_,
		activityID = slot0.activityID_,
		heroList = slot0.heroList_,
		comboSkillID = slot0.comboSkillID_
	})
end

function slot0.SetHeroList(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.stageIndex_ = table.keyof(SequentialBattleChapterCfg[slot3].stage_id, slot2)

	uv0.super.SetHeroList(slot0, slot1, slot2, slot3, slot4, slot5)
end

function slot0.SetComboSkillID(slot0, slot1)
	SequentialBattleData:SetComboSkillID(slot0.activityID_, slot0.stageIndex_, slot1, false)
end

function slot0.GetNeedRefresh(slot0)
	return SequentialBattleData:GetHeroTeamData(slot0.activityID_)[slot0.stageIndex_].needRefreshComboSkill
end

function slot0.SetNeedRefresh(slot0, slot1)
	SequentialBattleData:GetHeroTeamData(slot0.activityID_)[slot0.stageIndex_].needRefreshComboSkill = false
end

function slot0.GetComboSkillID(slot0)
	return SequentialBattleData:GetHeroTeamData(slot0.activityID_)[slot0.stageIndex_].comboSkillID
end

return slot0
