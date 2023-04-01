slot0 = class("BattleLimitedCalculationStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.super.Ctor(slot0)

	slot0.id_ = slot1
	slot0.activityID_ = slot2
	slot0.difficultyCfg_ = ActivityLimitCalculationCfg[LimitedCalculationData:GetCurDifficulty(slot0.activityID_)]
	slot0.cfg_ = BattleLimitedCalculationStageCfg[slot0.id_]
	slot0.heroList_, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION, slot1, slot2)

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0.difficultyCfg_.activity_id
end

function slot0.GetActivityID(slot0)
	return slot0.activityID_
end

function slot0.GetStageId(slot0)
	return slot0.id_
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION
end

function slot0.GetMap(slot0)
	return slot0.cfg_.map, false
end

function slot0.GetAILevel(slot0)
	return slot0.cfg_.ai_level
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg_.monster_level
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot4 = slot0.difficultyCfg_.player_affix or {}
	slot5 = slot0.difficultyCfg_.enemy_affix or {}

	for slot9, slot10 in ipairs(slot4) do
		table.insert(slot1, slot10[1])
		table.insert(slot2, slot10[2])
		table.insert(slot3, slot10[3])
	end

	for slot9, slot10 in ipairs(slot5) do
		table.insert(slot1, slot10[1])
		table.insert(slot2, slot10[2])
		table.insert(slot3, slot10[3])
	end

	return slot1, slot2, slot3
end

return slot0
