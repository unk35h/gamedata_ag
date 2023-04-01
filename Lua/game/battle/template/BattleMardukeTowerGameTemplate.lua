slot0 = class("BattleMardukeTowerGameTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.activityID_ = slot2
	slot0.cfg = BattleTowerGameCfg[slot1]
	slot0.stageID_ = slot1
	slot0.heroList_, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(slot0:GetType(), slot0.stageID_, slot2)

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0.activityID_
end

function slot0.GetStageId(slot0)
	return slot0.stageID_
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.MARDUK_GAME
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level
end

return slot0
