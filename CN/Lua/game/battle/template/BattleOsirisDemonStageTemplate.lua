slot0 = class("BattleOsirisDemonStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleHeartDemonStageCfg[slot1]
	slot0.heroList, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON, slot1, slot2)

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0.activityID_
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON
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
	slot3 = {}
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(TalentTreeData:GetTalentListByTheme(ActivityTools.GetActivityTheme(DemonChallengeCfg[slot0.activityID_].activity_id))) do
		table.insert(slot3, slot10[1])
		table.insert(slot4, slot10[2])
		table.insert(slot5, slot10[3])
	end

	slot7 = pairs
	slot9 = type(slot0.cfg.affix_type) == "table" and slot0.cfg.affix_type or {} or {}

	for slot10, slot11 in slot7(slot9) do
		table.insert(slot3, slot11[1])
		table.insert(slot4, slot11[2])
		table.insert(slot5, slot11[3])
	end

	return slot3, slot4, slot5
end

return slot0
