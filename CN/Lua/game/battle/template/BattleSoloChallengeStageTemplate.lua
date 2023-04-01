slot0 = class("BattleSoloChallengeStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleSoloChallengeStageCfg[slot1]
	slot0.heroList, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(slot0:GetType(), slot1, slot2)

	slot0:InitComboSkillID()
end

function slot0.GetDest(slot0)
	return table.keyof(ActivitySoloChallengeCfg[slot0.activityID_].stage_id[SoloChallengeData:GetSelectedDifficultyIndex(slot0.activityID_)][2], slot0.id)
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE
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
	slot1 = nil
	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot9 = slot0.id

	for slot9, slot10 in pairs(SoloChallengeData:GetCustomAffixList(slot0.activityID_, slot9)) do
		slot1 = ActivityAffixPoolCfg[slot10].affix

		table.insert(slot2, slot1[1])
		table.insert(slot3, slot1[2])
		table.insert(slot4, slot1[3])
	end

	return slot2, slot3, slot4
end

function slot0.GetChipList(slot0)
	return {}
end

return slot0
