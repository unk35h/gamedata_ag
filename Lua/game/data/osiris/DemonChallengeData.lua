slot0 = singletonClass("DemonChallengeData")

function slot0.Init(slot0)
	slot0.levelIdList_ = StageGroupCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON]
	slot0.activityIdList_ = ChapterCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON]
	slot0.levelCount_ = #slot0.levelIdList_
	slot0.levelDataList_ = {}
	slot0.receivedList_ = {}
	slot0.completedList_ = {}
	slot0.stageIdToIndex_ = {}
	slot0.selectDifficultyIndexList_ = {}
	slot0.selectedList_ = {}
	slot0.openTimeStamp_ = {}
	slot0.remainTimeStamp_ = 0
	slot0.test = false

	manager.notify:RegistListener(ACTIVITY_UPDATE, handler(slot0, slot0.InitData))
end

function slot0.InitData(slot0)
	if slot0.test == true then
		for slot4 = 1, slot0.levelCount_ do
			slot5 = slot0.openTimeStamp_[slot4] - manager.time:GetServerTime() <= 0
		end
	end

	for slot4 = 1, slot0.levelCount_ do
		if slot0.receivedList_[slot4] == nil then
			slot0.receivedList_[slot4] = {}
			slot0.completedList_[slot4] = {}
		end
	end

	if slot0.test == false then
		slot0:UpdateTimeData()
	end
end

function slot0.SetData(slot0, slot1)
	slot2 = slot1.activity_info
	slot3 = slot2.activity_id
	slot0.levelDataList_[slot3] = slot2
	slot5 = slot0:GetLevelIndex(slot3)

	for slot9, slot10 in ipairs(slot2.info) do
		slot12 = slot0:GetStageId(slot5, slot10.difficulty)

		if slot10.challenge_state == 2 and table.keyof(slot0.receivedList_[slot5], slot11) == nil then
			table.insert(slot0.receivedList_[slot5], slot11)
		end

		if (slot10.challenge_state == 1 or slot10.challenge_state == 2) and table.keyof(slot0.completedList_[slot5], slot11) == nil then
			table.insert(slot0.completedList_[slot5], slot11)
		end

		slot0.stageIdToIndex_[slot12] = {
			slot5,
			slot11
		}
	end

	slot0:CalcRedPoint()
end

function slot0.UpdateTimeData(slot0)
	if slot0.test == true then
		return
	end

	if ActivityData:GetActivityData(ActivityConst.OSIRIS_DEMON) ~= nil then
		slot0.remainTimeStamp_ = slot2.stopTime
	end

	slot3 = ""

	for slot7, slot8 in ipairs(slot0.levelIdList_) do
		if ActivityData:GetActivityData(ActivityConst[slot0:GetRedPointConst(slot7)]) ~= nil then
			slot0.openTimeStamp_[slot7] = slot2.startTime
		end
	end
end

function slot0.GetLevelIndex(slot0, slot1)
	if table.keyof(slot0.activityIdList_, slot1) ~= nil then
		return slot2 - 1
	end
end

function slot0.GetSubActivityID(slot0, slot1)
	if slot1 + 1 <= #slot0.activityIdList_ then
		return slot0.activityIdList_[slot1 + 1]
	end
end

function slot0.GetLevelCount(slot0)
	return slot0.levelCount_
end

function slot0.GetCacheSelectLevelIndex(slot0)
	return getData("DemonChallenge", "levelIndex")
end

function slot0.GetDemonChallengeCfg(slot0)
end

function slot0.SaveSelectLevelIndex(slot0, slot1)
	saveData("DemonChallenge", "levelIndex", slot1)
end

function slot0.GetLevelId(slot0, slot1)
	return slot0.levelIdList_[slot1]
end

function slot0.GetStageId(slot0, slot1, slot2)
	return StageGroupCfg[slot0.levelIdList_[slot1]].stage_list[slot2]
end

function slot0.GetBoosId(slot0, slot1)
	return StageGroupCfg[slot0.levelIdList_[slot1]].boss_id
end

function slot0.SetReceiveList(slot0, slot1, slot2)
	if table.keyof(slot0.receivedList_[slot2], slot1) == nil then
		table.insert(slot0.receivedList_[slot2], slot1)
		slot0:CalcRedPoint()
	end
end

function slot0.GetReceiveList(slot0, slot1)
	return slot0.receivedList_[slot1]
end

function slot0.GetCompletedList(slot0, slot1)
	return slot0.completedList_[slot1]
end

function slot0.IsCompleted(slot0, slot1, slot2)
	if slot0.completedList_[slot1] == nil then
		print(string.format("**********************self.completedList_[%d] 为空***********************************", slot1))

		return false
	end

	if table.keyof(slot3, slot2) then
		return true
	end

	return false
end

function slot0.IsCompletedLevel(slot0, slot1)
	if slot0.completedList_[slot1] == nil then
		print(string.format("**********************self.completedList_[%d] 为空***********************************", slot1))

		return false
	end

	return #slot0.completedList_[slot1] > 0
end

function slot0.IsOpened(slot0, slot1)
	return slot0.openTimeStamp_[slot1] - manager.time:GetServerTime() <= 0
end

function slot0.SetSelectDifficultyIndex(slot0, slot1, slot2)
	slot0.selectDifficultyIndexList_[slot1] = slot2
end

function slot0.GetSelectDifficultyIndex(slot0, slot1)
	return slot0.selectDifficultyIndexList_[slot1]
end

function slot0.GetDifficultyDes(slot0, slot1, slot2)
	return DemonChallengeCfg[slot0:GetStageId(slot1, slot2)].difficulty_desc
end

function slot0.GetLevelName(slot0, slot1)
	return BattleHeartDemonStageCfg[slot0:GetStageId(slot1, 1)].name
end

function slot0.GetDescText(slot0, slot1)
	return BattleHeartDemonStageCfg[slot0:GetStageId(slot1, 1)].tips
end

function slot0.GetLevelOpenTimeByIndex(slot0, slot1)
	return slot0.openTimeStamp_[slot1]
end

function slot0.GetRemainTime(slot0)
	return slot0.remainTimeStamp_
end

function slot0.GetDropId(slot0, slot1, slot2)
	return BattleHeartDemonStageCfg[slot0:GetStageId(slot1, slot2)].drop_lib_id
end

function slot0.GetSortedRewardIndexList(slot0, slot1)
	slot2 = {}
	slot3 = {}
	slot4 = slot0.receivedList_[slot1]
	slot5 = slot0.completedList_[slot1]

	for slot11, slot12 in ipairs(StageGroupCfg[slot0:GetLevelId(slot1)].stage_list) do
		if table.keyof(slot5, slot11) == nil then
			table.insert(slot3, slot11)
		elseif table.keyof(slot4, slot11) == nil then
			table.insert(slot2, slot11)
		end
	end

	table.insertto(slot2, slot3)
	table.insertto(slot2, slot4)

	return slot2
end

function slot0.CalcRedPoint(slot0)
	for slot4, slot5 in pairs(slot0.completedList_) do
		slot6 = slot0:GetRedPointConst(slot4)
		slot7 = false
		slot8 = slot0:IsCompletedLevel(slot4)

		if slot0:IsOpened(slot4) and not slot8 and slot0.selectedList_[slot4] == nil then
			slot7 = true
		elseif slot9 and slot8 then
			slot10 = slot0.receivedList_[slot4]

			for slot14, slot15 in ipairs(slot5) do
				if table.keyof(slot10, slot15) == nil then
					slot7 = true

					break
				end
			end
		end

		if slot7 then
			manager.redPoint:setTip(RedPointConst[slot6], 1)
		else
			manager.redPoint:setTip(RedPointConst[slot6], 0)
		end
	end
end

function slot0.SaveSelected(slot0, slot1)
	if slot0:IsOpened(slot1) then
		slot0.selectedList_[slot1] = true

		slot0:CalcRedPoint()
	end
end

function slot0.IsSelected(slot0, slot1)
	if slot0.selectedList_[slot1] == nil then
		return false
	else
		return true
	end
end

function slot0.GetRedPointConst(slot0, slot1)
	return "OSIRIS_DEMON_LEVEL" .. tostring(slot1)
end

function slot0.SetAllRedPoint(slot0, slot1)
	slot2 = ""

	for slot6, slot7 in ipairs(slot0.levelIdList_) do
		manager.redPoint:setTip(RedPointConst[slot0:GetRedPointConst(slot6)], slot1)
	end
end

function slot0.GetRoleImg(slot0, slot1)
	return getSpriteWithoutAtlas("Textures/VersionUI/OsirisUI/" .. BattleHeartDemonStageCfg[slot0:GetStageId(slot1, 1)].background_1)
end

function slot0.GetAnyOpen(slot0)
	for slot4 = 1, slot0.levelCount_ do
		if slot0:IsOpened(slot4) then
			return slot4
		end
	end

	return -1
end

return slot0
