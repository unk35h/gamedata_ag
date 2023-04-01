slot0 = class("BattleSequentialBattleStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.cfg = BattleSequentialBattleStageCfg[slot1]
	slot0.activityID_ = slot2
	slot0.currentStageIndex_ = SequentialBattleData:GetCurrentFinishStageIndex(slot2) + 1
	slot0.heroList, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE, slot1, slot2)

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0.id
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList, slot0.heroTrialList_
end

function slot0.InitComboSkillID(slot0)
	slot0.comboSkillID_ = SequentialBattleData:GetHeroTeamData(slot0.activityID_)[slot0.currentStageIndex_].comboSkillID
end

function slot0.GetServerChipData(slot0)
	slot0.chipManagerID_ = SequentialBattleData:GetHeroTeamData(slot0.activityID_)[slot0.currentStageIndex_].chipID
	slot1, slot2 = slot0:GetHeroTeam()
	slot3 = {}
	slot4 = false

	for slot8, slot9 in pairs(slot1) do
		slot4 = false

		for slot13, slot14 in pairs(slot2) do
			if slot9 == (slot14 - slot14 % 100) / 100 then
				slot4 = true
			end
		end

		if slot4 == false then
			table.insert(slot3, slot9)
		end
	end

	slot0.chipList_ = ChipData:GetEnableAllChipList(slot0.chipManagerID_, slot3)
end

function slot0.GetStageAffix(slot0)
	slot2 = {}
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in ipairs(SequentialBattleData:GetHeroTeamData(slot0.activityID_)[slot0.currentStageIndex_].enabledBuff) do
		table.insert(slot2, SequentialBattleBuffCfg[slot9].affix_id)
		table.insert(slot3, 1)
		table.insert(slot4, 3)
	end

	return slot2, slot3, slot4
end

return slot0
