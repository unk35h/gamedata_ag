slot0 = class("BattleSlayerStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.region_activity_id = slot1
	slot4 = ActivitySlayerCfg[slot1].stage_id

	slot0.super.Ctor(slot0, slot4)

	slot0.id_ = slot4
	slot0.activityID_ = slot2
	slot0.cfg = BattleSlayerStageCfg[slot4]
	slot0.heroList_, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(slot0:GetType(), slot4, slot2)

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0.region_activity_id
end

function slot0.GetStageId(slot0)
	return slot0.id_
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.SLAYER
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

function slot0.GetStageAffix(slot0)
	slot3 = {}
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(TalentTreeData:GetTalentListByTheme(ActivityTools.GetActivityTheme(slot0.region_activity_id))) do
		table.insert(slot3, slot10[1])
		table.insert(slot4, slot10[2])
		table.insert(slot5, slot10[3])
	end

	return slot3, slot4, slot5
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
end

return slot0
