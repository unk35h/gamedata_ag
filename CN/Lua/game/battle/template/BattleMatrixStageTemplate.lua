slot0 = class("BattleMatrixStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1)
	slot5 = slot1

	uv0.super.Ctor(slot0, slot5)

	slot0.id = slot1
	slot0.cfg = BattleMatrixStageCfg[slot1]
	slot0.heroList = MatrixData:GetMatrixBattleHeroTeam()
	slot0.systemHeroList = {}

	for slot5, slot6 in ipairs(slot0.heroList) do
		if MatrixData:GetHeroData(slot6) and slot7:GetStandardId() ~= 0 then
			slot0.systemHeroList[slot5] = slot7:GetStandardId()
		end
	end

	slot0.roleDataInLua = {}

	slot0:InitChipData()
	slot0:InitComboSkill()
end

function slot0.GetDest(slot0)
	return slot0.id
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX
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

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot5 = pairs
	slot7 = MatrixData:GetTotalAffix() or {}

	for slot8, slot9 in slot5(slot7) do
		table.insert(slot1, slot9[1])
		table.insert(slot2, slot9[2])
		table.insert(slot3, slot9[3])
	end

	return slot1, slot2, slot3
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList, {}
end

function slot0.GetSystemHeroTeam(slot0)
	return slot0.systemHeroList
end

function slot0.GetAttributeFactor(slot0)
	slot2 = MatrixData:GetDifficulty()

	if MatrixTierCfg[MatrixData:GetTierID()] and slot3.monster_level_coefficient[slot2] then
		return Vector3.New(slot3.monster_level_coefficient[slot2][1] and slot4[1] / 1000 or 1, 1, slot4[2] and slot4[2] / 1000 or 1)
	end

	return Vector3.New(1, 1, 1)
end

function slot0.UpdateRoleDatas(slot0, slot1)
	slot0.serverTeamPlayer = slot1
	slot0.roleDataInLua = {}

	for slot6, slot7 in pairs(MatrixData:GetMatrixBattleHeroTeam()) do
		if not MatrixData:GetHeroData(slot7):IsDead() then
			table.insert(slot0.roleDataInLua, BattleController.GetInstance():SetMatrixHeroData(slot8, slot1.playerID, slot1.level, slot0.matrix_activity_id))
		end
	end

	slot0:SetMaxRaceData()
end

function slot0.GetRoleDatas(slot0)
	return slot0.roleDataInLua
end

function slot0.GetServerChipData(slot0)
	slot0.chipManagerID_ = MatrixData:GetChipManagerID()
	slot0.chipList_ = MatrixData:GetChipList()
end

function slot0.InitComboSkill(slot0)
	slot0.comboSkillID_ = ComboSkillData:GetComboSkillID(slot0:GetType(), slot0:GetActivityID(), 1)
end

return slot0
