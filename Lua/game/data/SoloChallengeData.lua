slot0 = singletonClass("SoloChallengeData")
slot1 = nil

function slot0.Init(slot0)
	slot0.customAffixList_ = {}
	slot0.completedActivityList_ = {}
	slot0.receivedActivityList_ = {}
	slot0.uncompletedActivityList_ = {}
	slot0.customAffixCounts_ = {}
	slot0.affixStateList_ = {}
	slot0.customHeroList_ = {}
	slot0.lockHeroList_ = {}
	slot0.lockAffixList_ = {}
	slot0.stageIDToActivityID_ = {}
	slot0.completedStageList_ = {}
	slot0.lastTeamDataList_ = {}
	uv0 = nil
end

function slot0.SetData(slot0, slot1)
	slot2 = slot1.info
	slot3 = ActivitySoloChallengeCfg[slot2.challenge_id].activity_id
	slot0.completedActivityList_[slot3] = {}
	slot0.receivedActivityList_[slot3] = {}

	for slot7, slot8 in ipairs(slot2.is_award_admited) do
		slot0:SetReceivedActivityList(slot3, slot8, false)
	end

	slot4 = false

	for slot8, slot9 in ipairs(slot2.is_clear) do
		slot0:SetCompletedActivityList(slot3, slot9, false)

		slot4 = true
	end

	if not slot4 and not table.keyof(slot0.uncompletedActivityList_, slot3) then
		table.insert(slot0.uncompletedActivityList_, slot3)
	end

	slot0:SetSelectedDifficultyIndex(slot3, slot2.select_difficult or 1)

	slot0.customHeroList_[slot3] = {}
	slot0.lockAffixList_[slot3] = {}
	slot0.lockHeroList_[slot3] = {}
	slot0.completedStageList_[slot3] = {}
	slot0.customAffixList_[slot3] = {}
	slot0.affixStateList_[slot3] = {}
	slot0.customAffixCounts_[slot3] = {}

	if slot2.solo_info ~= nil then
		slot7 = 1

		for slot11 = 1, #ActivitySoloChallengeCfg[slot3].stage_id do
			slot0.customHeroList_[slot3][slot11] = {
				heroList = {},
				trialList = {}
			}
			slot0.lockAffixList_[slot3][slot11] = {}
			slot0.lockHeroList_[slot3][slot11] = {}
			slot0.completedStageList_[slot3][slot11] = {}
			slot0.affixStateList_[slot3][slot11] = {}
			slot0.customAffixCounts_[slot3][slot11] = 0

			for slot15 = 1, 3 do
				slot17 = slot2.solo_info[slot7].stage_id
				slot18 = slot2.clear_list[slot7] == 1

				for slot22, slot23 in ipairs(slot16.artifact) do
					if slot23 ~= 0 then
						slot0.customAffixList_[slot3] = slot0.customAffixList_[slot3] or {}
						slot0.customAffixList_[slot3][slot17] = slot0.customAffixList_[slot3][slot17] or {}
						slot0.customAffixList_[slot3][slot17][slot22] = slot23

						if slot18 then
							slot0:SetLockAffixList(slot3, slot11, slot23)
						end

						slot0.affixStateList_[slot3][slot11][slot23] = slot0.affixStateList_[slot3][slot11][slot23] or {}
						slot0.affixStateList_[slot3][slot11][slot23].stageID = slot17
						slot0.affixStateList_[slot3][slot11][slot23].pos = slot22
					end
				end

				slot19 = 0
				slot20 = 0

				if HeroStandardSystemCfg[slot16.hero_Id] == nil then
					slot19 = slot16.hero_Id
				else
					slot19 = slot21.hero_id
					slot20 = slot16.hero_Id
				end

				table.insert(slot0.customHeroList_[slot3][slot11].heroList, slot19)
				table.insert(slot0.customHeroList_[slot3][slot11].trialList, slot20)

				if slot18 then
					slot0:SetLockHeroList(slot3, slot11, slot16.hero_Id)
					table.insert(slot0.completedStageList_[slot3][slot11], slot17)
				end

				slot7 = slot7 + 1
			end
		end
	end

	slot0:RefreshRedPoint(slot3)
end

function slot0.EquipAffix(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0:GetSelectedDifficultyIndex(slot1)
	slot0.customAffixList_[slot1] = slot0.customAffixList_[slot1] or {}
	slot0.customAffixList_[slot1][slot2] = slot0.customAffixList_[slot1][slot2] or {}
	slot0.customAffixList_[slot1][slot2][slot3] = slot4
	slot0.affixStateList_[slot1] = slot0.affixStateList_[slot1] or {}
	slot0.affixStateList_[slot1][slot5] = slot0.affixStateList_[slot1][slot5] or {}
	slot0.affixStateList_[slot1][slot5][slot4] = slot0.affixStateList_[slot1][slot5][slot4] or {}
	slot0.affixStateList_[slot1][slot5][slot4].stageID = slot2
	slot0.affixStateList_[slot1][slot5][slot4].pos = slot3
	slot0.customAffixCounts_[slot1] = slot0.customAffixCounts_[slot1] or {}
	slot0.customAffixCounts_[slot1][slot5] = slot0.customAffixCounts_[slot1][slot5] or 0
	slot0.customAffixCounts_[slot1][slot5] = slot0.customAffixCounts_[slot1][slot5] + 1
end

function slot0.ExchangeAffix(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetSelectedDifficultyIndex(slot1)
	slot5 = slot0.affixStateList_[slot1][slot4][slot2].stageID
	slot6 = slot0.affixStateList_[slot1][slot4][slot3].stageID
	slot7 = slot0.affixStateList_[slot1][slot4][slot2].pos
	slot8 = slot0.affixStateList_[slot1][slot4][slot3].pos
	slot0.customAffixList_[slot1][slot5][slot7] = slot3
	slot0.affixStateList_[slot1][slot4][slot3].stageID = slot5
	slot0.affixStateList_[slot1][slot4][slot3].pos = slot7
	slot0.customAffixList_[slot1][slot6][slot8] = slot2
	slot0.affixStateList_[slot1][slot4][slot2].stageID = slot6
	slot0.affixStateList_[slot1][slot4][slot2].pos = slot8
end

function slot0.DischargeAffix(slot0, slot1, slot2)
	slot3 = slot0:GetSelectedDifficultyIndex(slot1)

	if slot0.affixStateList_[slot1] and slot0.affixStateList_[slot1][slot3] and slot0.affixStateList_[slot1][slot3][slot2] then
		slot0.customAffixList_[slot1][slot0.affixStateList_[slot1][slot3][slot2].stageID][slot0.affixStateList_[slot1][slot3][slot2].pos] = nil
		slot0.affixStateList_[slot1][slot3][slot2].stageID = nil
		slot0.affixStateList_[slot1][slot3][slot2].pos = nil
		slot0.affixStateList_[slot1][slot3][slot2] = nil
		slot0.customAffixCounts_[slot1] = slot0.customAffixCounts_[slot1] or {}
		slot0.customAffixCounts_[slot1][slot3] = slot0.customAffixCounts_[slot1][slot3] or 0
		slot0.customAffixCounts_[slot1][slot3] = slot0.customAffixCounts_[slot1][slot3] - 1
	end
end

function slot0.GetAffixState(slot0, slot1, slot2)
	slot3 = slot0:GetSelectedDifficultyIndex(slot1)

	if slot0.affixStateList_[slot1] == nil or slot0.affixStateList_[slot1][slot3] == nil or slot0.affixStateList_[slot1][slot3][slot2] == nil then
		return {
			stageID = -1,
			pos = -1
		}
	end

	return {
		stageID = slot0.affixStateList_[slot1][slot3][slot2].stageID,
		pos = slot0.affixStateList_[slot1][slot3][slot2].pos
	}
end

function slot0.GetAffixCount(slot0, slot1, slot2)
	if slot0.customAffixList_[slot1] and slot0.customAffixList_[slot1][slot2] then
		return table.nums(slot0.customAffixList_[slot1][slot2])
	end

	return 0
end

function slot0.GetNextEquipPos(slot0, slot1, slot2)
	if slot0.customAffixList_[slot1] and slot0.customAffixList_[slot1][slot2] then
		slot6 = slot0

		for slot6 = 1, slot0.GetMaxAffixCount(slot6, slot1) do
			if slot0.customAffixList_[slot1][slot2][slot6] == nil then
				return slot6
			end
		end
	end

	return -1
end

function slot0.CanEquipAffix(slot0, slot1, slot2)
	return slot0:GetAffixCount(slot1, slot2) < slot0:GetMaxAffixCount(slot1)
end

function slot0.GetCustomAffixList(slot0, slot1, slot2)
	slot3 = {}

	if slot0.customAffixList_[slot1] ~= nil then
		slot7 = slot0

		for slot7 = 1, slot0.GetMaxAffixCount(slot7, slot1) do
			if slot0.customAffixList_[slot1][slot2] and slot0.customAffixList_[slot1][slot2][slot7] then
				slot3[slot7] = slot0.customAffixList_[slot1][slot2][slot7]
			end
		end
	end

	return slot3
end

function slot0.GetCustomHeroList(slot0, slot1, slot2)
	return deepClone(slot0.customHeroList_[slot1][slot2].heroList), deepClone(slot0.customHeroList_[slot1][slot2].trialList)
end

function slot0.SetCustomHeroList(slot0, slot1, slot2, slot3, slot4)
	slot0.customHeroList_[slot1][slot2].heroList = deepClone(slot3)
	slot0.customHeroList_[slot1][slot2].trialList = deepClone(slot4)
end

function slot0.SetLastTeamData(slot0, slot1, slot2)
	slot0.lastTeamDataList_[slot1] = {
		activityID = slot1,
		difficultyIndex = slot0:GetSelectedDifficultyIndex(slot1),
		isHeroData = slot2
	}

	if slot2 == true then
		slot0.lastTeamDataList_[slot1].heroList = deepClone(slot0.customHeroList_[slot1][slot3].heroList or {})
		slot0.lastTeamDataList_[slot1].trialList = deepClone(slot0.customHeroList_[slot1][slot3].trialList or {})
	else
		slot0.lastTeamDataList_[slot1].customAffixList = deepClone(slot0.customAffixList_[slot1])
		slot0.lastTeamDataList_[slot1].affixStateList = deepClone(slot0.affixStateList_[slot1][slot3])
		slot0.lastTeamDataList_[slot1].customAffixCounts = deepClone(slot0.customAffixCounts_[slot1][slot3])
	end
end

function slot0.RevertTeamData(slot0, slot1)
	if slot0.lastTeamDataList_[slot1] then
		slot2 = slot0.lastTeamDataList_[slot1].difficultyIndex

		if slot0.lastTeamDataList_[slot1].isHeroData == true then
			slot0.customHeroList_[slot1][slot2].heroList = slot0.lastTeamDataList_[slot1].heroList
			slot0.customHeroList_[slot1][slot2].trialList = slot0.lastTeamDataList_[slot1].trialList
		else
			slot0.customAffixList_[slot1] = slot0.lastTeamDataList_[slot1].customAffixList
			slot0.affixStateList_[slot1][slot2] = slot0.lastTeamDataList_[slot1].affixStateList
			slot0.customAffixCounts_[slot1][slot2] = slot0.lastTeamDataList_[slot1].customAffixCounts
		end
	end
end

function slot0.GetMaxAffixCount(slot0, slot1)
	slot2 = 2

	if ActivitySoloChallengeCfg[slot1] ~= nil then
		slot2 = ActivitySoloChallengeCfg[slot1].max_affix_count or slot2
	end

	return slot2
end

function slot0.GetCustomAffixCount(slot0, slot1)
	slot2 = slot0:GetSelectedDifficultyIndex(slot1)

	if slot0.customAffixCounts_[slot1] and slot0.customAffixCounts_[slot1][slot2] then
		return slot0.customAffixCounts_[slot1][slot2] or 0
	else
		return 0
	end
end

function slot0.GetLockHeroList(slot0, slot1)
	return slot0.lockHeroList_[slot1] or {}
end

function slot0.SetLockHeroList(slot0, slot1, slot2, slot3)
	table.insert(slot0.lockHeroList_[slot1][slot2], slot3)
end

function slot0.SaveActivityID(slot0, slot1, slot2)
	if slot0.stageIDToActivityID_[slot2] == nil then
		slot0.stageIDToActivityID_[slot2] = {}
	end

	slot0.stageIDToActivityID_[slot2].activityID = slot1
end

function slot0.GetActivityID(slot0, slot1)
	return slot0.stageIDToActivityID_[slot1].activityID
end

function slot0.SaveDifficultyIndex(slot0, slot1, slot2)
	if slot0.stageIDToActivityID_[slot2] == nil then
		slot0.stageIDToActivityID_[slot2] = {}
	end

	slot0.stageIDToActivityID_[slot2].difficultyIndex = slot1
end

function slot0.GetDifficultyIndex(slot0, slot1)
	return slot0.stageIDToActivityID_[slot1].difficultyIndex
end

function slot0.GetCompletedStageList(slot0, slot1)
	return slot0.completedStageList_[slot1] or {}
end

function slot0.GetCompletedStageCount(slot0, slot1)
	return #slot0:GetCompletedStageList(slot1)
end

function slot0.GetLockAffixList(slot0, slot1, slot2)
	if slot0.lockAffixList_[slot1] then
		return slot0.lockAffixList_[slot1][slot2] or {}
	end

	return {}
end

function slot0.SetLockAffixList(slot0, slot1, slot2, slot3)
	table.insert(slot0.lockAffixList_[slot1][slot2], slot3)
end

function slot0.GetCompletedActivityList(slot0)
	return slot0.completedActivityList_
end

function slot0.SetCompletedActivityList(slot0, slot1, slot2, slot3)
	if slot0.completedActivityList_[slot1] == nil then
		slot0.completedActivityList_[slot1] = {}
	end

	if table.keyof(slot0.completedActivityList_[slot1], slot2) == nil then
		table.insert(slot0.completedActivityList_[slot1], slot2)
	end

	table.removebyvalue(slot0.uncompletedActivityList_, slot1)

	if slot3 ~= false then
		slot0:RefreshRedPoint(slot1)
	end
end

function slot0.GetReceivedActivityList(slot0)
	return slot0.receivedActivityList_
end

function slot0.SetReceivedActivityList(slot0, slot1, slot2, slot3)
	if slot0.receivedActivityList_[slot1] == nil then
		slot0.receivedActivityList_[slot1] = {}
	end

	if table.keyof(slot0.receivedActivityList_[slot1], slot2) == nil then
		table.insert(slot0.receivedActivityList_[slot1], slot2)
	end

	if slot3 ~= false then
		slot0:RefreshRedPoint(slot1)
	end
end

function slot0.SetSelectActivityID(slot0, slot1, slot2)
	saveData("SoloChallenge", "selectActivityID_" .. slot1, slot2)

	if table.keyof(slot0.uncompletedActivityList_, slot2) then
		manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, ActivitySoloChallengeCfg[slot2].main_activity_id, slot2), 0)
	end
end

function slot0.GetSelectActivityID(slot0, slot1)
	return getData("SoloChallenge", "selectActivityID_" .. slot1)
end

function slot0.GetActivityTeamData(slot0, slot1)
	slot2 = slot0:GetSelectedDifficultyIndex(slot1)
	slot3 = table.nums(slot0.completedStageList_[slot1][slot2])
	slot4 = {
		before_solo_info = {}
	}
	slot5, slot6 = slot0:GetCustomHeroList(slot1, slot2)
	slot9 = 0
	slot10 = {}

	for slot14, slot15 in ipairs(ActivitySoloChallengeCfg[slot1].stage_id[slot0:GetSelectedDifficultyIndex(slot1)][2]) do
		if slot3 < slot14 then
			slot16 = {
				challenge_id = slot1,
				stage_id = slot15
			}

			if slot6[slot14] ~= 0 then
				slot16.hero_Id = slot6[slot14]
			else
				slot16.hero_Id = slot5[slot14]
			end

			slot21 = slot15
			slot10 = slot0:GetCustomAffixList(slot1, slot21)
			slot17 = {}

			for slot21 = 1, slot0:GetMaxAffixCount(slot1) do
				if slot10[slot21] ~= nil then
					slot17[slot21] = slot10[slot21]
				else
					slot17[slot21] = 0
				end
			end

			slot16.artifact = slot17
			slot4.before_solo_info[#slot4.before_solo_info + 1] = slot16
		end
	end

	return slot4
end

function slot0.ResetLockData(slot0, slot1)
	slot2 = slot0:GetSelectedDifficultyIndex(slot1)
	slot0.lockHeroList_[slot1][slot2] = {}
	slot0.lockAffixList_[slot1][slot2] = {}
	slot0.completedStageList_[slot1][slot2] = {}
end

function slot0.RefreshRedPoint(slot0, slot1)
	slot2 = ActivitySoloChallengeCfg[slot1].main_activity_id
	slot4 = slot0.receivedActivityList_[slot1]
	slot5 = nil

	if #slot0.completedActivityList_[slot1] == 0 then
		slot5 = 1
	else
		for slot9, slot10 in pairs(slot3) do
			if (table.keyof(slot4, slot10) == nil and 1 or 0) == 1 then
				break
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, slot2, slot1), slot5)
end

function slot0.SetSelectedDifficultyIndex(slot0, slot1, slot2)
	saveData("SoloChallenge", "selectDifficultyIndex_" .. slot1, slot2)
end

function slot0.GetSelectedDifficultyIndex(slot0, slot1)
	return getData("SoloChallenge", "selectDifficultyIndex_" .. slot1)
end

function slot0.SetContentPosX(slot0, slot1, slot2)
	saveData("SoloChallenge", "contentPosX" .. slot1, slot2)
end

function slot0.GetContentPosX(slot0, slot1)
	return getData("SoloChallenge", "contentPosX" .. slot1)
end

function slot0.SaveLocalCustomList(slot0, slot1)
	slot2 = slot0:GetSelectedDifficultyIndex(slot1)
	slot3 = {}
	slot4, slot5 = slot0:GetCustomHeroList(slot1, slot2)
	slot7 = 0
	slot8 = {}

	for slot12, slot13 in ipairs(ActivitySoloChallengeCfg[slot1].stage_id[slot2][2]) do
		slot14 = {}

		if slot5[slot12] ~= 0 then
			slot14.hero_Id = slot5[slot12]
		else
			slot14.hero_Id = slot4[slot12]
		end

		slot19 = slot13
		slot8 = slot0:GetCustomAffixList(slot1, slot19)
		slot15 = {}

		for slot19 = 1, slot0:GetMaxAffixCount(slot1) do
			if slot8[slot19] ~= nil then
				slot15[slot19] = slot8[slot19]
			else
				slot15[slot19] = 0
			end
		end

		slot14.artifact = slot15

		table.insert(slot3, slot14)
	end

	uv0 = slot3

	saveData("SoloChallenge", "CustomList", slot3)
end

function slot0.GetLocalCustom(slot0)
	if uv0 == nil then
		uv0 = getData("SoloChallenge", "CustomList")
	end

	return uv0
end

function slot0.GetLocalCustomHeroList(slot0)
	if uv0 == nil then
		uv0 = getData("SoloChallenge", "CustomList")
	end

	if uv0 then
		slot1 = {}
		slot2 = {}

		for slot6 = 1, 3 do
			slot8 = 0
			slot9 = 0

			if uv0[slot6] then
				if HeroStandardSystemCfg[slot7.hero_Id] == nil then
					slot8 = slot7.hero_Id
				else
					slot8 = slot10.hero_id
					slot9 = slot7.hero_Id
				end
			end

			table.insert(slot1, slot8)
			table.insert(slot2, slot9)
		end

		return slot1, slot2
	end

	return {}
end

function slot0.GetLocalCustomAffix(slot0, slot1)
	if uv0 == nil then
		uv0 = getData("SoloChallenge", "CustomList")
	end

	if uv0 then
		slot3 = {}

		if uv0[slot1] then
			for slot7, slot8 in ipairs(slot2.artifact) do
				if slot8 and slot8 ~= 0 then
					slot3[slot7] = slot8
				end
			end
		end

		return slot3
	end

	return {}
end

return slot0
