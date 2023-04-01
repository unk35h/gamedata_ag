slot0 = class("BattleArtifactStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleArtifactCfg[slot1]
	slot0.heroList, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(slot0:GetType(), slot1, slot2)

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return ArtifactLevelData:GetLevelIdByStageId(slot0.id)
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetActivityID(slot0)
	return slot0.activityID_
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.ARTIFACT
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetName(slot0)
	return slot0.cfg.name
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot8 = slot0.id

	for slot8, slot9 in ipairs(ActivityArtifactLevelCfg[ArtifactLevelData:GetLevelIdByStageId(slot8)].affix_list) do
		table.insert(slot1, slot9[1])
		table.insert(slot2, slot9[2])
		table.insert(slot3, slot9[3])
	end

	return slot1, slot2, slot3
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList, slot0.heroTrialList_
end

return slot0
