slot0 = class("BattleChessStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleChessStageCfg[slot1]

	if slot3 then
		slot0.teamID_ = slot3.teamID
	else
		slot0.teamID_ = 0
	end

	slot0.nextBattleStage_ = nil
	slot0.heroList, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS, slot1, slot3)

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.InitComboSkillID(slot0)
	if BattleStageTools.GetStageCfg(slot0:GetType(), slot0:GetStageId()) and slot1.combo_skill_id and slot1.combo_skill_id ~= 0 then
		slot0.comboSkillID_ = slot1.combo_skill_id

		return
	end

	if type(BattleStageTools.GetRestrictHeroList(slot0:GetType(), slot0:GetStageId())) == "table" then
		slot0.comboSkillID_ = 0
	else
		slot0.comboSkillID_ = BattleTeamData:GetComboInfo(slot0:GetType(), slot0:GetActivityID(), nil, slot0.teamID_ or 0)
	end
end

function slot0.InitChipData(slot0)
	slot1 = {}
	slot0.chipManagerID_, slot1 = BattleTeamData:GetMimirInfo(slot0:GetType(), slot0:GetActivityID(), nil, slot0.teamID_ or 0)
	slot2, slot3 = slot0:GetHeroTeam()
	slot4 = {}
	slot5 = false

	for slot9, slot10 in pairs(slot2) do
		slot5 = false

		for slot14, slot15 in pairs(slot3) do
			if slot10 == (slot15 - slot15 % 100) / 100 then
				slot5 = true
			end
		end

		if slot5 == false then
			table.insert(slot4, slot10)
		end
	end

	slot0.chipList_ = ChipData:GetEnableAllChipList(slot0.chipManagerID_, slot4, slot1)
end

function slot0.GetDest(slot0)
	return slot0.id
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS
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

function slot0.UpdateRoleDatas(slot0, slot1)
	slot0.serverTeamPlayer = slot1
	slot0.roleDataInLua = {}
	slot2 = slot0:GetSystemHeroTeam()

	for slot6, slot7 in ipairs(slot1.heroList) do
		table.insert(slot0.roleDataInLua, BattleController.GetInstance():SetChessHeroData(slot7, slot7.trialID ~= 0 and slot7.trialID or slot2[slot6] or 0, slot1.playerID, slot1.level))
	end

	slot0:SetMaxRaceData()
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}

	for slot8, slot9 in pairs(WarChessData:GetArtifactData()) do
		if not WarchessItemCfg[slot8] then
			CustomLog.Log("不存在的战棋神器:" .. slot8)
		end

		for slot14, slot15 in ipairs(slot10.params) do
			table.insert(slot1, slot15[1])
			table.insert(slot2, slot15[2])
			table.insert(slot3, slot10.sub_affix_type)
		end
	end

	for slot10, slot11 in ipairs(TalentTreeData:GetTalentListByTheme(ActivityTools.GetActivityTheme(slot0.activityID_))) do
		table.insert(slot1, slot11[1])
		table.insert(slot2, slot11[2])
		table.insert(slot3, slot11[3])
	end

	return slot1, slot2, slot3
end

function slot0.GetServerExtant(slot0)
	return WarChessData:GetBattleIndex()
end

function slot0.GetNextStage(slot0)
	return slot0.nextBattleStage_
end

function slot0.SetNextStage(slot0, slot1)
	slot0.nextBattleStage_ = slot1
end

return slot0
