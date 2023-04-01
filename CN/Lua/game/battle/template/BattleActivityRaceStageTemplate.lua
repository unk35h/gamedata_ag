slot0 = class("BattleActivityRaceStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleActivityRaceStageCfg[slot1]
	slot0.heroList, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE, slot1, slot2)

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return table.keyof(ActivityRaceCfg[slot0.activityID_].stage_list, slot0.id)
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level or 0
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level or 0
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList, slot0.heroTrialList_
end

function slot0.GetAddUserExp(slot0)
	return slot0.cfg.user_exp or 0
end

function slot0.GetAddHeroExp(slot0)
	return slot0.cfg.hero_exp or 0
end

function slot0.GetCost(slot0)
	return slot0.cfg.cost or 0
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}

	for slot8, slot9 in pairs(ActivityRaceData:GetUnlockAffixList(slot0.activityID_)) do
		slot10 = ActivityAffixPoolCfg[slot9].affix

		table.insert(slot1, slot10[1])
		table.insert(slot2, slot10[2])
		table.insert(slot3, slot10[3])
	end

	slot6 = ActivityAffixPoolCfg[ActivityRaceCfg[slot0.activityID_].race_buff].affix

	table.insert(slot1, slot6[1])
	table.insert(slot2, slot6[2])
	table.insert(slot3, slot6[3])

	return slot1, slot2, slot3
end

return slot0
