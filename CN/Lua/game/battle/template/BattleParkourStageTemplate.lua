slot0 = class("BattleSlayerStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.entrust_activity_id = slot1
	slot0.parkour_activity_id = slot2
	slot4 = ActivityParkourCfg[slot1].stage_id

	slot0.super.Ctor(slot0, slot4)

	slot0.id_ = slot4
	slot0.cfg = BattleParkourStageCfg[slot4]
	slot0.heroList_, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(slot0:GetType(), slot4, slot2)

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0.entrust_activity_id
end

function slot0.GetStageId(slot0)
	return slot0.id_
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.PARKOUR
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level
end

function slot0.GetStageAffix(slot0)
	return {}, {}, {}
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
end

function slot0.GetActivityID(slot0)
	return slot0.parkour_activity_id
end

function slot0.GetThreeStar(slot0)
	return slot0.cfg.three_star_need
end

return slot0
