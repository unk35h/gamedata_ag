slot0 = class("BattleEquipBreakThroughMaterialStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.cfg = BattleEquipBreakThroughMaterialStageCfg[slot1]
	slot0.heroList, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(slot0:GetType(), slot1)

	slot0:InitComboSkillID()
	slot0:InitChipData()

	slot0.mapStageID_ = EquipBreakThroughMaterialData:GetChooseMapStageID()
end

function slot0.GetDest(slot0)
	return slot0.id
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL
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

function slot0.GetServerChipData(slot0)
	slot0.chipManagerID_ = EquipBreakThroughMaterialData:GetChipManagerID()
	slot0.chipList_ = clone(EquipBreakThroughMaterialData:GetChipList())
end

function slot0.GetChipAndAIList(slot0, slot1)
	slot2 = {}

	if slot0.chipManagerID_ ~= 0 then
		table.insert(slot2, slot3)
	end

	for slot7, slot8 in ipairs(slot0.chipList_) do
		table.insert(slot2, slot8)
	end

	if slot1 ~= 0 then
		slot1 = SkinCfg[slot1].hero
	end

	slot4, slot5 = slot0:GetHeroTeam()

	if table.keyof(slot4, slot1) and slot1 ~= 0 and slot5[slot6] == 0 then
		slot7 = ChipData:GetEnableHeroChipIdByHeroId(slot1) or {}

		for slot11, slot12 in ipairs(slot7) do
			table.insert(slot2, slot12)
		end
	end

	return slot2
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList, slot0.heroTrialList_
end

function slot0.UpdateRoleDatas(slot0, slot1)
	slot0.serverTeamPlayer = slot1
	slot0.roleDataInLua = {}
	slot2 = slot0:GetSystemHeroTeam()

	for slot6, slot7 in ipairs(slot1.heroList) do
		table.insert(slot0.roleDataInLua, BattleController.GetInstance():SetEquipBreakThroughMaterialHeroData(slot6, slot7, slot7.trialID ~= 0 and slot7.trialID or slot2[slot6] or 0, slot1.playerID, slot1.level))
	end

	slot0:SetMaxRaceData()
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot5 = pairs
	slot7 = EquipBreakThroughMaterialData:GetGlobalAffixList() or {}

	for slot8, slot9 in slot5(slot7) do
		table.insert(slot1, slot9[1])
		table.insert(slot2, slot9[2])
		table.insert(slot3, slot9[3])
	end

	slot6 = pairs
	slot8 = EquipBreakThroughMaterialData:GetBuffList() or {}

	for slot9, slot10 in slot6(slot8) do
		slot11 = EquipBreakThroughMaterialItemCfg[slot10].params

		table.insert(slot1, slot11[1])
		table.insert(slot2, slot11[2])
		table.insert(slot3, slot11[3])
	end

	slot7 = pairs
	slot9 = EquipBreakThroughMaterialData:GetAttributeList() or {}

	for slot10, slot11 in slot7(slot9) do
		slot12 = getAttributeAffix(slot10, slot11)

		table.insert(slot1, slot12[1])
		table.insert(slot2, slot12[2])
		table.insert(slot3, slot12[3])
	end

	return slot1, slot2, slot3
end

function slot0.GetAttributeFactor(slot0)
	slot2 = EquipBreakThroughMaterialDifficultyCfg[EquipBreakThroughMaterialData:GetSelectModeID()]

	return Vector3.New(slot2.difficult_multipliter[1] / 1000, slot2.difficult_multipliter[2] / 1000, slot2.difficult_multipliter[3] / 1000)
end

function slot0.GetServerExtant(slot0)
	return slot0.mapStageID_
end

return slot0
