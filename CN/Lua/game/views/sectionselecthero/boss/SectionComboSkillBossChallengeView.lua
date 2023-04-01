slot0 = class("SectionComboSkillBossChallengeView", import("..SectionComboSkillView"))

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0, slot1)
end

function slot0.SetBossIndex(slot0, slot1)
	slot0.bossIndex_ = slot1
end

function slot0.ClickComboSkillBtn(slot0)
	JumpTools.OpenPageByJump("comboSkillSelectBoss", {
		stageType = slot0.stageType_,
		stageID = slot0.stageID_,
		bossIndex = slot0.bossIndex_,
		heroList = slot0.heroList_,
		comboSkillID = slot0.comboSkillID_
	})
end

function slot0.GetComboSkillID(slot0)
	return BattleTeamData:GetComboInfo(slot0.stageType_, nil, BossTools.GetContID(slot0.stageType_, slot0.bossIndex_))
end

function slot0.SetComboSkillID(slot0, slot1)
	BattleFieldAction.SetComboInfo(slot0.stageType_, nil, slot1, BossTools.GetContID(slot0.stageType_, slot0.bossIndex_))
end

function slot0.GetNeedRefresh(slot0)
	return ComboSkillData:GetBossChallengeNeedRefresh(slot0.bossIndex_)
end

function slot0.SetNeedRefresh(slot0, slot1)
	ComboSkillData:SetBossChallengeNeedRefresh(slot0.bossIndex_, slot1)
end

return slot0
