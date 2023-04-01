slot0 = class("BattleGuildBossChallengeTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1)
	slot0.cfg = BattleClubBossCfg[slot1]

	uv0.super.Ctor(slot0, slot1)
end

function slot0.GetStageId(slot0)
	return slot0.cfg.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroDataList_, {}
end

function slot0.GetActivityID(slot0)
	return BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE
end

function slot0.GetThreeStar(slot0)
	return {}
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot5 = pairs
	slot7 = GuildData:GetHaveGetBossBuffList() or {} or {}

	for slot8, slot9 in slot5(slot7) do
		table.insert(slot1, slot9[1])
		table.insert(slot2, slot9[2])
		table.insert(slot3, slot9[3])
	end

	return slot1, slot2, slot3
end

function slot0.GetAttributeFactor(slot0)
	if ClubBossCfg[GuildData:GetBossDifficulty()].attribute_factor and slot1.attribute_factor[3] then
		return Vector3.New(slot1.attribute_factor[1] / 1000, slot1.attribute_factor[2] / 1000, slot1.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function slot0.GetAddUserExp(slot0)
	return slot0.cfg.user_exp or 0
end

function slot0.GetAddHeroExp(slot0)
	return slot0.cfg.hero_exp or 0
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level
end

function slot0.GetDest(slot0)
	return slot0.dest_
end

function slot0.SetDest(slot0, slot1)
	slot0.dest_ = slot1
end

function slot0.GetEnemyLevel(slot0)
	return ClubBossCfg[GuildData:GetBossDifficulty()].monster_level
end

function slot0.SetGuildBossTeam(slot0, slot1, slot2)
	slot0.heroDataList_ = slot1
	slot0.ownerList_ = slot2
end

function slot0.GetAssistHeroOwnerList(slot0)
	return slot0.ownerList_
end

function slot0.GetComboSkillID(slot0)
	return BattleTeamData:GetComboInfo(slot0:GetType(), slot0:GetActivityID())
end

function slot0.SetChipDic(slot0, slot1)
	slot0.chipOfHeroDic_ = slot1
end

function slot0.GetChipOfHeroDic(slot0)
	return slot0.chipOfHeroDic_ or {}
end

return slot0
