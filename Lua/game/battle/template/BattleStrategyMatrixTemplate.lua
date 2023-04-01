slot0 = class("BattleStrategyMatrixTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.matrix_activity_id = slot2
	slot0.activityID_ = slot2
	slot0.tier = slot3
	slot0.cfg = BattleStrategyMatrixCfg[slot1]
	slot7 = slot2
	slot0.heroList = StrategyMatrixData:GetMatrixBattleHeroTeam(slot7)
	slot0.systemHeroList = {}

	for slot7, slot8 in ipairs(slot0.heroList) do
		if StrategyMatrixData:GetHeroData(slot2, slot8) and slot9:GetStandardId() ~= 0 then
			slot0.systemHeroList[slot7] = slot9:GetStandardId()
		end
	end

	slot0.roleDataInLua = {}

	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0.id
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX
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
	slot7 = StrategyMatrixData:GetTotalAffix(slot0.matrix_activity_id) or {}

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
	slot2 = 1

	if StrategyMatrixTierTemplateCfg[StrategyMatrixData:GetTierID(slot0.matrix_activity_id)] and slot3.monster_level_coefficient[slot2] then
		return Vector3.New(slot3.monster_level_coefficient[slot2][1] and slot4[1] / 1000 or 1, 1, slot4[2] and slot4[2] / 1000 or 1)
	end

	return Vector3.New(1, 1, 1)
end

function slot0.UpdateRoleDatas(slot0, slot1)
	slot0.serverTeamPlayer = slot1
	slot0.roleDataInLua = {}

	for slot6, slot7 in pairs(StrategyMatrixData:GetMatrixBattleHeroTeam(slot0.matrix_activity_id)) do
		if not StrategyMatrixData:GetHeroData(slot0.matrix_activity_id, slot7):IsDead() then
			table.insert(slot0.roleDataInLua, BattleController.GetInstance():SetMatrixHeroData(slot8, slot1.playerID, slot1.level, slot0.matrix_activity_id))
		end
	end

	slot0:SetMaxRaceData()
	slot0:SetMaxRaceData()
end

function slot0.GetRoleDatas(slot0)
	return slot0.roleDataInLua
end

function slot0.GetServerChipData(slot0)
	slot0.chipManagerID_ = 0
	slot0.chipList_ = {}
end

return slot0
