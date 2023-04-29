slot0 = class("BattleBossAdvanceStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.cfg = BattleBossStageCfg[slot0.id]
	slot0.heroList, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(slot0:GetType(), slot0.id, slot2)
	slot0.bossIndex_ = slot2
	slot3 = BossTools.GetBossID(slot0:GetType(), slot0.bossIndex_)
	slot0.comboSkillID_ = BattleTeamData:GetComboInfo(slot0:GetType(), slot0:GetActivityID(), BossTools.GetContID(slot0:GetType(), slot0.bossIndex_))

	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0.id
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level
end

function slot0.GetEnemyLevel(slot0)
	return BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].monster_level
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList, slot0.heroTrialList_
end

function slot0.GetServerChipData(slot0)
	slot1 = {}
	slot0.chipManagerID_, slot1 = BattleTeamData:GetMimirInfo(slot0:GetType(), slot0:GetActivityID(), BossTools.GetContID(slot0:GetType(), slot0.bossIndex_))
	slot3, slot4 = slot0:GetHeroTeam()
	slot5 = {}
	slot6 = false

	for slot10, slot11 in pairs(slot3) do
		slot6 = false

		for slot15, slot16 in pairs(slot4) do
			if slot11 == (slot16 - slot16 % 100) / 100 then
				slot6 = true
			end
		end

		if slot6 == false then
			table.insert(slot5, slot11)
		end
	end

	slot0.chipList_ = ChipData:GetEnableAllChipList(slot0.chipManagerID_, slot5, slot1)
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot8 = BossConst.TYPE_AFFIX

	for slot8, slot9 in pairs(BattleBossChallengeAdvanceData:GetBossAffixList(slot0.bossIndex_, slot8)) do
		slot10 = ActivityAffixPoolCfg[slot9].affix

		table.insert(slot1, slot10[1])
		table.insert(slot2, slot10[2])
		table.insert(slot3, slot10[3])
	end

	slot6 = BossChallengeUICfg[BossTools.GetBossID(slot0:GetType(), slot0.bossIndex_)]

	table.insert(slot1, slot6.custom_affix[1])
	table.insert(slot2, slot6.custom_affix[2])
	table.insert(slot3, slot6.custom_affix[3])

	return slot1, slot2, slot3
end

function slot0.GetAttributeFactor(slot0)
	slot4 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].monster_value[BattleBossChallengeAdvanceData:GetBossList()[slot0.bossIndex_].multipleIndex]

	return Vector3.New(slot4[1] / 1000, slot4[2] / 1000, slot4[3] / 1000)
end

function slot0.GetServerExtant(slot0)
	return BattleBossChallengeAdvanceData:GetBossList()[slot0.bossIndex_].id
end

function slot0.GetBossIndex(slot0)
	return slot0.bossIndex_
end

return slot0
