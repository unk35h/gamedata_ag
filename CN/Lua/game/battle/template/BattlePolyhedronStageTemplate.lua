slot0 = class("BattlePolyhedronStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.cfg = BattlePolyhedronStageCfg[slot0.id]

	if not slot0.cfg then
		error(string.format("找不到stageId为 %s 的关卡，请检查配置！！！！！！！", tostring(slot0.id)))
	end

	slot0.heroList = {
		1084
	}
	slot0.systemHeroList = {}
	slot0.heroTrialList_ = {}

	slot0:InitComboSkillID()
	slot0:InitChipData()

	slot0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
end

function slot0.GetDest(slot0)
	return slot0.id
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.POLYHEDRON
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

function slot0.GetSystemHeroTeam(slot0)
	return slot0.systemHeroList
end

function slot0.GetRevive(slot0)
	slot1, slot2 = slot0.polyhedronInfo:GetReviveCount()

	return true, 0, slot1, 1, slot2
end

function slot0.GetAttributeFactor(slot0)
	slot3 = 1
	slot4 = 1
	slot5 = 1

	if PolyhedronTierCfg[slot0.polyhedronInfo:GetTierId()] and slot2.monster_level_coefficient then
		slot3 = slot2.monster_level_coefficient[1] and slot6[1] / 1000 or 1
		slot5 = slot6[2] and slot6[2] / 1000 or 1
	end

	for slot10 = 1, PolyhedronData:GetPolyhedronInfo().difficulty do
		for slot15, slot16 in ipairs(PolyhedronDifficultyCfg[slot10].params) do
			if slot16[1] == 2 then
				slot19 = slot16[3] / 1000

				if slot16[2] == 11 then
					slot3 = slot3 * (1 + slot19)
				elseif slot18 == 21 then
					slot4 = slot4 * (1 + slot19)
				elseif slot18 == 31 then
					slot5 = slot5 * (1 + slot19)
				end
			end
		end
	end

	return Vector3.New(slot3, slot4, slot5)
end

function slot0.UpdateRoleDatas(slot0, slot1)
	slot0.serverTeamPlayer = slot1
	slot0.roleDataInLua = {}
	slot2 = PolyhedronData:GetPolyhedronInfo()
	slot10 = PolyhedronHeroCfg[slot2:GetLeaderHeroData().id].standard_id
	slot11 = slot1.playerID

	table.insert(slot0.roleDataInLua, BattleController.GetInstance():SetPolyhedronHeroData(slot2, nil, slot10, slot11, slot1.level))

	for slot10, slot11 in ipairs(slot2:GetFightHeroList()) do
		if not slot2:GetHeroPolyData(slot11):IsDead() and slot11 ~= slot3.id then
			table.insert(slot0.roleDataInLua, BattleController.GetInstance():SetPolyhedronHeroData(slot2, nil, PolyhedronHeroCfg[slot11].standard_id, slot1.playerID, slot1.level))
		end
	end

	slot0:SetMaxRaceData()
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot5 = pairs
	slot7 = slot0.polyhedronInfo:GetTotalAffix() or {}

	for slot8, slot9 in slot5(slot7) do
		table.insert(slot1, slot9[1])
		table.insert(slot2, slot9[2])
		table.insert(slot3, slot9[3])
	end

	return slot1, slot2, slot3
end

function slot0.GetResurrectHP(slot0)
	return slot0.polyhedronInfo:GetReviveHp()
end

function slot0.GetResurrectImmediately(slot0)
	return true
end

function slot0.GetTargetEnemyID(slot0)
	if PolyhedronConst.REWARD_TYEP.TEAMMATE == slot0.polyhedronInfo:GetRewardType() then
		for slot6, slot7 in ipairs(slot0.polyhedronInfo:GetEnlistHeroList()) do
			if slot7.enlist_type == PolyhedronConst.ENLIST_TYPE.BATTLE then
				return PolyhedronHeroCfg[slot7.heroId].target_enemy
			end
		end
	end

	return 5050
end

function slot0.GetActivityID(slot0)
	return PolyhedronData:GetActivityID() or 0
end

return slot0
