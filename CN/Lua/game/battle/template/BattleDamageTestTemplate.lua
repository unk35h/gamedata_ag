slot0 = class("BattleDamageTestTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.damageTestId = slot2
	slot0.cfg = BattleDamageTestCfg[slot0.id]
	slot0.heroList, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(slot0:GetType(), slot0.id, slot2)
	slot0.comboSkillID_ = BattleTeamData:GetComboInfo(slot0:GetType(), slot0:GetActivityID())

	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0.id
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.DAMAGE_TEST
end

function slot0.GetActivityID(slot0)
	return slot0.damageTestId
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

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot8 = BossConst.TYPE_AFFIX

	for slot8, slot9 in pairs(DamageTestData:GetAffixList(slot0.damageTestId, slot8)) do
		slot10 = ActivityAffixPoolCfg[slot9].affix

		table.insert(slot1, slot10[1])
		table.insert(slot2, slot10[2])
		table.insert(slot3, slot10[3])
	end

	return slot1, slot2, slot3
end

function slot0.GetThreeStar(slot0)
	if slot0.cfg.three_star_need == "" then
		return {}
	end

	return slot0.cfg.three_star_need
end

function slot0.GetAttributeFactor(slot0)
	slot1 = BossChallengeAdvanceCfg[102].monster_value[4]

	return Vector3.New(slot1[1] / 1000, slot1[2] / 1000, slot1[3] / 1000)
end

return slot0
