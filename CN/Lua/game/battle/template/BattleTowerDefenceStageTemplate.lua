slot0 = class("BattleTowerDefenceStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID = slot2
	slot0.cfg = BattleShotStageCfg[slot0.id]
	slot0.heroList, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(slot0:GetType(), slot1, slot2)

	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0.activityID
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetActivityID(slot0)
	return slot0.activityID
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.TOWER_DEFENCE
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList, slot0.heroTrialList_
end

return slot0
