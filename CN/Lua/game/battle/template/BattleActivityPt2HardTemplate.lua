slot0 = class("BattleActivityPt2HardTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id_ = slot1
	slot0.activityID_ = slot2
	slot0.stageID_ = slot1
	slot0.cfg = BattleStageTools.GetStageCfg(slot0:GetType(), slot1)
	slot0.heroList_, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(slot0:GetType(), slot0.stageID_, slot2)

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return ActivityPt2Cfg.GetCfgFromActivityIdAndStageId[slot0.activityID_][slot0.stageID_].id
end

function slot0.GetStageId(slot0)
	return slot0.stageID_
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
end

function slot0.GetActivityID(slot0)
	return slot0.activityID_
end

function slot0.GetThreeStar(slot0)
	return {}
end

function slot0.GetCost(slot0)
	return ActivityPt2Cfg[slot0:GetDest()].cost[1][2] or 0
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot5 = pairs
	slot7 = type(slot0.cfg.affix_type) == "table" and slot0.cfg.affix_type or {} or {}

	for slot8, slot9 in slot5(slot7) do
		table.insert(slot1, slot9[1])
		table.insert(slot2, slot9[2])
		table.insert(slot3, slot9[3])
	end

	return slot1, slot2, slot3
end

function slot0.GetAddUserExp(slot0)
	return slot0.cfg.user_exp or 0
end

function slot0.GetAddHeroExp(slot0)
	return slot0.cfg.hero_exp or 0
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level
end

return slot0
