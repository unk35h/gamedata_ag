slot0 = class("BattleMardukSpecialTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleQuickTrainingCfg[slot1]
	slot0.heroList, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL, slot1, slot2)

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL
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

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}

	table.insert(slot1, slot0.cfg.affix_type_in_map[1])
	table.insert(slot2, slot0.cfg.affix_type_in_map[2])
	table.insert(slot3, slot0.cfg.affix_type_in_map[3])

	return slot1, slot2, slot3
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

function slot0.GetAttributeFactor(slot0)
	if slot0.cfg.attribute_factor and slot1.attribute_factor[3] then
		return Vector3.New(slot1.attribute_factor[1] / 1000, slot1.attribute_factor[2] / 1000, slot1.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

return slot0
