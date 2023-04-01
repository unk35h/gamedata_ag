slot0 = class("BattleRaceTrailStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.super.Ctor(slot0, slot1)

	slot0.id_ = slot1
	slot0.activityID_ = slot2
	slot0.cfg_ = BattleRaceTrailStageCfg[ActivityRaceTrialCfg[slot1].stage_id]
	slot0.heroList_, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(slot0:GetType(), slot1, slot2)

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0.id_
end

function slot0.GetStageId(slot0)
	return slot0.id_
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.RACE_TRAIL
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

function slot0.GetStageAffix(slot0)
	slot1 = nil
	slot2 = {}
	slot3 = {}
	slot4 = {}

	for slot9, slot10 in ipairs(RaceTrailData:GetCustomList(slot0.activityID_)) do
		slot1 = ActivityAffixPoolCfg[slot10].affix

		table.insert(slot2, slot1[1])
		table.insert(slot3, slot1[2])
		table.insert(slot4, slot1[3])
	end

	return slot2, slot3, slot4
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
end

function slot0.GetMaxRaceData(slot0)
	return ActivityRaceTrialCfg[slot0.id_].race, 3
end

return slot0
