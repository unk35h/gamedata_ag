slot0 = singletonClass("AchievementData")

function slot0.Init(slot0)
	slot0.achievementData_ = {}

	for slot4, slot5 in ipairs(AchievementCfg.all) do
		slot0.achievementData_[slot5] = {
			process = 0,
			timestamp = 0,
			rewardState = 0,
			id = slot5
		}
	end

	slot0.achievementSortData_ = {}

	for slot4, slot5 in ipairs(AchievementCfg.get_id_list_by_type_id) do
		slot0.achievementSortData_[slot4] = {}

		for slot9, slot10 in ipairs(slot5) do
			if AchievementCfg[slot10].is_hide ~= 1 then
				table.insert(slot0.achievementSortData_[slot4], slot10)
			end
		end
	end

	slot0.needSortFlag_ = {}
	slot0.canReceiveReward_ = {}
	slot0.finishAchievementList_ = {}
	slot0.achievementPoint_ = 0
	slot0.storyReadList_ = {}
	slot0.achievementLevel_ = 0
	slot0.achievementOldLevel_ = 0
end

function slot0.GetFinishAchievementCnt(slot0, slot1)
	if slot1 == nil then
		slot2 = 0

		for slot6, slot7 in pairs(slot0.finishAchievementList_) do
			slot2 = slot2 + #slot7
		end

		return slot2
	else
		return slot0.finishAchievementList_[slot1] and #slot0.finishAchievementList_[slot1] or 0
	end
end

function slot0.UpdateAchievementList(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		slot0:UpdateAchievement(slot7, slot2)
	end
end

function slot0.UpdateAchievement(slot0, slot1, slot2)
	slot4 = slot1.progress

	if not AchievementCfg[slot1.id] then
		return
	end

	slot6 = slot5.type_id
	slot7 = 0

	if slot1.complete_flag == 1 then
		slot7 = -1
	elseif slot5.need <= slot4 then
		slot7 = 1
	end

	if slot7 == 1 or slot7 == -1 then
		if slot0.finishAchievementList_[slot6] then
			if not table.keyof(slot0.finishAchievementList_[slot6], slot3) then
				table.insert(slot0.finishAchievementList_[slot6], slot3)
			end
		else
			slot0.finishAchievementList_[slot6] = {
				slot3
			}
		end

		if AchievementCfg[slot3].is_hide ~= 0 and not table.keyof(slot0.achievementSortData_[slot6], slot3) then
			table.insert(slot0.achievementSortData_[slot6], slot3)
		end
	end

	slot8 = true

	if slot7 == 1 and slot0.achievementData_[slot3] and slot0.achievementData_[slot3].rewardState == slot7 then
		slot8 = false
	end

	if slot8 == true then
		slot0.achievementData_[slot3] = {
			id = slot3,
			process = slot5.need < slot4 and slot5.need or slot4,
			rewardState = slot7,
			timestamp = slot1.achieve_time + manager.time:GetDeltaTimeZone()
		}

		if slot7 == 1 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT, slot6), 1)

			if not slot0.canReceiveReward_[slot6] then
				slot0.canReceiveReward_[slot6] = {}
			end

			if not table.keyof(slot0.canReceiveReward_[slot6], slot3) then
				table.insert(slot0.canReceiveReward_[slot6], slot3)
			end

			if slot2 == false then
				manager.achievementTips:AddAchievementID(slot3)
			end
		end
	end

	slot0.needSortFlag_[slot6] = true
end

function slot0.GetAchievementIDList(slot0, slot1)
	if slot0.needSortFlag_[slot1] then
		table.sort(slot0.achievementSortData_[slot1], function (slot0, slot1)
			if uv0.achievementData_[slot0].rewardState == uv0.achievementData_[slot1].rewardState then
				return slot0 < slot1
			else
				return slot3 < slot2
			end
		end)

		slot0.needSortFlag_[slot1] = false
	end

	return slot0.achievementSortData_[slot1]
end

function slot0.GetAchievementTotalCnt(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.achievementSortData_) do
		slot1 = slot1 + #slot6
	end

	return slot1
end

function slot0.GetAchievementCnt(slot0, slot1)
	return #slot0.achievementSortData_[slot1]
end

function slot0.GetAchievementData(slot0, slot1)
	if not slot0.achievementData_[slot1] then
		slot0.achievementData_[slot1] = {
			process = 0,
			timestamp = 0,
			rewardState = 0,
			id = slot1
		}
	end

	return slot0.achievementData_[slot1]
end

function slot0.ChangedAchievementState(slot0, slot1, slot2)
	slot0.achievementData_[slot1].rewardState = slot2
	slot3 = AchievementCfg[slot1].type_id
	slot0.needSortFlag_[slot3] = true

	table.remove(slot0.canReceiveReward_[slot3], table.keyof(slot0.canReceiveReward_[slot3], slot1))

	if table.length(slot0.canReceiveReward_[slot3]) <= 0 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT, slot3), 0)
	end
end

function slot0.InitAchievementPoint(slot0, slot1)
	slot0.achievementPoint_ = slot1
	slot5 = slot1
	slot0.achievementLevel_ = slot0:CalcAchievementLevel(slot5)
	slot0.achievementOldLevel_ = slot0.achievementLevel_

	for slot5 = 1, slot0.achievementLevel_ do
		if not slot0.storyReadList_[slot5] then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT_STORY, slot5), 1)
		end
	end
end

function slot0.AddAchievementPoint(slot0, slot1)
	slot0.achievementPoint_ = slot0.achievementPoint_ + slot1
	slot5 = slot0.achievementPoint_
	slot0.achievementLevel_ = slot0:CalcAchievementLevel(slot5)

	for slot5 = slot0.achievementOldLevel_, slot0.achievementLevel_ do
		if not slot0.storyReadList_[slot5] then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT_STORY, slot5), 1)
		end
	end
end

function slot0.GetAchievementPoint(slot0)
	return slot0.achievementPoint_
end

function slot0.InitAchievementStoryReadList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0.storyReadList_[slot6] = true

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT_STORY, slot6), 0)
	end
end

function slot0.UpdateStoryRead(slot0, slot1)
	slot0.storyReadList_[slot1] = true

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT_STORY, slot1), 0)
end

function slot0.GetStoryReadFlag(slot0, slot1)
	return slot0.storyReadList_[slot1]
end

function slot0.NeedUpgradeLevel(slot0)
	return slot0.achievementOldLevel_ < slot0.achievementLevel_
end

function slot0.RefreshOldLevel(slot0)
	slot0.achievementOldLevel_ = slot0.achievementLevel_
end

function slot0.GetCurrentPoint(slot0)
	if slot0.achievementLevel_ + 1 > #AchievementStoryCfg.all then
		return slot0.achievementPoint_ - AchievementStoryCfg[slot0.achievementLevel_ - 1].unlock_point
	elseif slot1 == 1 then
		return slot0.achievementPoint_
	elseif slot1 > 1 then
		return slot0.achievementPoint_ - AchievementStoryCfg[slot1 - 1].unlock_point
	end
end

function slot0.GetCurrentLevelPoint(slot0)
	if slot0.achievementLevel_ + 1 > #AchievementStoryCfg.all then
		return AchievementStoryCfg[slot0.achievementLevel_].unlock_point - AchievementStoryCfg[slot0.achievementLevel_ - 1].unlock_point
	elseif slot1 == 1 then
		return AchievementStoryCfg[slot1].unlock_point
	elseif slot1 > 1 then
		return AchievementStoryCfg[slot1].unlock_point - AchievementStoryCfg[slot1 - 1].unlock_point
	end
end

function slot0.CalcAchievementLevel(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in ipairs(AchievementStoryCfg.all) do
		if slot1 - AchievementStoryCfg[slot7].unlock_point < 0 then
			return slot7 - 1
		end

		slot2 = slot7
	end

	return slot2
end

function slot0.SetScrollRecord(slot0, slot1)
	slot0.scrollRecord_ = slot1
end

function slot0.GetScrollRecord(slot0)
	return slot0.scrollRecord_
end

return slot0
