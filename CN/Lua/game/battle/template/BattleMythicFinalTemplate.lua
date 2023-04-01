slot0 = class("BattleMythicFinalTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleMythicFinalCfg[slot1]
	slot0.levelcfg = MythicFinalCfg[MythicData:GetCurHotLevelId()]

	if slot3 then
		slot0.teamID_ = slot3.teamID
	end

	slot0.nextBattleStage_ = nil
	slot0.heroList, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL, slot1, slot3, nil, slot0.teamID_)

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.InitComboSkillID(slot0)
	if slot0.teamID_ then
		slot0.comboSkillID_ = BattleTeamData:GetComboInfo(BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL, nil, , slot0.teamID_)
	else
		slot0.super.InitComboSkillID(slot0)
	end
end

function slot0.InitChipData(slot0)
	if slot0.teamID_ then
		slot1 = {}
		slot0.chipManagerID_, slot1 = BattleTeamData:GetMimirInfo(BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL, nil, , slot0.teamID_)

		if MythicData:GetIsBattleIng() then
			if slot0.heroList then
				for slot5, slot6 in ipairs(slot0.heroList) do
					if ChipData:GetEnableHeroChipIdByHeroId(slot6) then
						slot9 = ChipData
						slot11 = slot9

						for slot10, slot11 in ipairs(slot9.GetEnableHeroChipIdByHeroId(slot11, slot6)) do
							if slot11 ~= 0 then
								table.insert(slot1, slot11)
							end
						end
					end
				end
			end

			slot0.chipList_ = slot1
		else
			slot0.chipList_ = ChipData:GetEnableAllChipList(slot0.chipManagerID_, slot0.heroList, slot1)
		end
	else
		slot0.super.InitChipData(slot0)
	end
end

function slot0.GetDest(slot0)
	if slot0.teamID_ then
		return slot0.teamID_
	else
		return 1
	end
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level
end

function slot0.GetAttributeFactor(slot0)
	if MythicFinalCfg[MythicData:GetCurHotLevelId()].attribute_factor and slot1.attribute_factor[3] then
		return Vector3.New(slot1.attribute_factor[1] / 1000, slot1.attribute_factor[2] / 1000, slot1.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot5 = pairs
	slot7 = MythicData:GetMonsterAffix() or {}

	for slot8, slot9 in slot5(slot7) do
		table.insert(slot1, slot9[1])
		table.insert(slot2, slot9[2])
		table.insert(slot3, slot9[3])
	end

	return slot1, slot2, slot3
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList, slot0.heroTrialList_
end

function slot0.GetEnemyLevel(slot0)
	return slot0.levelcfg.monster_level
end

function slot0.GetNextStage(slot0)
	return slot0.nextBattleStage_
end

function slot0.SetNextStage(slot0, slot1)
	slot0.nextBattleStage_ = slot1
end

function slot0.GetBattleTime(slot0)
	return MythicData:GetBattleRemainTime(slot0:GetDest())
end

return slot0
