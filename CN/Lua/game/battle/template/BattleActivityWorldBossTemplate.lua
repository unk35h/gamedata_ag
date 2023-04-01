slot0 = class("BattleActivityWorldBossTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleActivityWorldBossCfg[slot1]
	slot3 = nil
	slot0.heroList, slot3, slot3, slot0.heroTrialList_ = GetLocalHeroTeam(slot0:GetType(), slot0.id, slot2)
	slot0.roleDataInLua = {}

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList, slot0.heroTrialList_
end

function slot0.GetDest(slot0)
	return slot0.activityID_
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS
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

function slot0.GetAttributeFactor(slot0)
	if slot0.cfg.attribute_factor and slot1.attribute_factor[3] then
		return Vector3.New(slot1.attribute_factor[1] / 1000, slot1.attribute_factor[2] / 1000, slot1.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot6 = pairs
	slot8 = {
		ActivityWorldBossData:GetAffix(slot0.activityID_)
	} or {}

	for slot9, slot10 in slot6(slot8) do
		table.insert(slot1, slot10[1])
		table.insert(slot2, slot10[2])
		table.insert(slot3, slot10[3])
	end

	return slot1, slot2, slot3
end

return slot0
