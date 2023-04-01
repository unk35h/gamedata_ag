slot0 = class("BattleBaseStageTemplate")

function slot0.Ctor(slot0, slot1)
	slot0.roleDataInLua = {}
	slot0.multiple_ = 1
	slot0.comboSkillID_ = 0
	slot0.maxRaceID_ = 0
	slot0.maxRacePlayerCount_ = 1
	slot0.serverTeamPlayer = nil
end

function slot0.GetDest(slot0)
	return 0
end

function slot0.GetStageId(slot0)
	return 0
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
end

function slot0.GetMap(slot0)
	return 0, false
end

function slot0.GetAILevel(slot0)
	return 0
end

function slot0.GetEnemyLevel(slot0)
	return 0
end

function slot0.GetStageAffix(slot0)
	return {}, {}, {}
end

function slot0.GetRevive(slot0)
	return false, 0, 0, 0
end

function slot0.GetMultiple(slot0)
	return slot0.multiple_ or 1
end

function slot0.SetMultiple(slot0, slot1)
	slot0.multiple_ = slot1
end

function slot0.GetClearTime(slot0)
	return 0
end

function slot0.GetHeroTeam(slot0)
	return {}, {}
end

function slot0.GetAssistHeroOwnerList(slot0)
	return {}
end

function slot0.GetSystemHeroTeam(slot0)
	return {}
end

function slot0.GetRoleDatas(slot0)
	return slot0.roleDataInLua
end

function slot0.GetThreeStar(slot0)
	return {}
end

function slot0.GetAddUserExp(slot0)
	return 0
end

function slot0.GetAddHeroExp(slot0)
	return 0
end

function slot0.GetCost(slot0)
	return 0
end

function slot0.GetAttributeFactor(slot0)
	if BattleStageTools.GetStageCfg(slot0:GetType(), slot0:GetStageId()).attribute_factor and slot1.attribute_factor[3] then
		return Vector3.New(slot1.attribute_factor[1] / 1000, slot1.attribute_factor[2] / 1000, slot1.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function slot0.UpdateRoleDatas(slot0, slot1)
	slot0.serverTeamPlayer = slot1
	slot0.roleDataInLua = {}
	slot2 = slot0:GetSystemHeroTeam()

	for slot6, slot7 in ipairs(slot1.heroList) do
		table.insert(slot0.roleDataInLua, BattleController.GetInstance():SetHeroData(slot7, slot7.trialID ~= 0 and slot7.trialID or slot2[slot6] or 0, slot1.playerID, slot1.level))
	end

	slot0:SetMaxRaceData()
end

function slot0.GetHeroDataByPos(slot0, slot1)
	slot2, slot3 = slot0:GetHeroTeam()
	slot4 = slot0:GetSystemHeroTeam()

	if slot2[slot1] and slot2[slot1] ~= 0 then
		if slot4[slot1] or slot3[slot1] and slot3[slot1] ~= 0 then
			return GetVirtualData(slot4[slot1] or slot3[slot1])
		else
			slot5 = slot2[slot1]

			if (slot0.serverTeamPlayer and slot0.serverTeamPlayer.heroList[slot1]) == nil then
				return nil
			end

			return GetPracticalData(slot6)
		end
	end

	return nil
end

function slot0.GetIsStoryTag(slot0)
	return slot0.storyTag or false
end

function slot0.SetIsStoryTag(slot0, slot1)
	slot0.storyTag = slot1
end

function slot0.GetIsCooperation(slot0)
	return false
end

function slot0.InitComboSkillID(slot0)
	if BattleStageTools.GetStageCfg(slot0:GetType(), slot0:GetStageId()) and slot1.combo_skill_id and slot1.combo_skill_id ~= 0 then
		slot0.comboSkillID_ = slot1.combo_skill_id

		return
	end

	if type(BattleStageTools.GetRestrictHeroList(slot0:GetType(), slot0:GetStageId())) == "table" then
		slot0.comboSkillID_ = 0
	else
		slot0.comboSkillID_ = BattleTeamData:GetComboInfo(slot0:GetType(), slot0:GetActivityID())
	end
end

function slot0.GetComboSkillID(slot0)
	return slot0.comboSkillID_
end

function slot0.InitChipData(slot0)
	if BattleStageTools.GetStageCfg(slot0:GetType(), slot0:GetStageId()) and type(slot1.chip_list) == "table" then
		slot0.chipManagerID_ = slot1.chip_list[1]
		slot0.chipList_ = {}

		for slot5 = 2, 3 do
			slot0.chipList_[slot5 - 1] = slot1.chip_list[slot5]
		end

		return
	end

	slot0:GetServerChipData()
end

function slot0.GetServerChipData(slot0)
	slot1 = {}
	slot0.chipManagerID_, slot1 = BattleTeamData:GetMimirInfo(slot0:GetType(), slot0:GetActivityID())
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

function slot0.GetChipManagerID(slot0)
	return slot0.chipManagerID_
end

function slot0.GetChipList(slot0)
	return slot0.chipList_
end

function slot0.GetChipOfHeroDic(slot0)
	return {}
end

function slot0.SetMaxRaceData(slot0)
	slot1 = {}
	slot2 = 0
	slot3 = false

	for slot7, slot8 in pairs(slot0.roleDataInLua) do
		if SkinCfg[slot8.ID].hero ~= 0 then
			slot1[slot10] = (slot1[HeroCfg[slot9].race] or 0) + 1

			if slot1[slot10] == 2 then
				slot2 = slot10
			elseif slot1[slot10] == 3 then
				slot3 = true
			end
		end
	end

	slot0.maxRaceID_ = slot2
	slot0.maxRacePlayerCount_ = slot1[slot2] or 1
end

function slot0.GetMaxRaceData(slot0)
	return slot0.maxRaceID_, slot0.maxRacePlayerCount_
end

function slot0.GetPathList(slot0)
	return {}
end

function slot0.GetActivityID(slot0)
	return slot0.activityID_ or 0
end

function slot0.GetServerExtant(slot0)
	return 0
end

function slot0.GetBattleTime(slot0)
	return 0
end

function slot0.GetResurrectHP(slot0)
	return 0
end

function slot0.GetResurrectImmediately(slot0)
	return false
end

function slot0.GetTargetEnemyID(slot0)
	return 0
end

return slot0
