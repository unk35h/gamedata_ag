slot0 = singletonClass("PuzzleData")
slot1 = {
	UNCOMPLETE = 1,
	UNRECEIVE = 2,
	RECEIVED = 3
}

function slot0.Init(slot0)
	slot0.stepCountList_ = {}
	slot0.puzzleStateList_ = {}
	slot0.minStepCountList_ = {}
	slot0.selectedList_ = {}
	slot0.watchedPlotList_ = {}
	slot0.activityStateList_ = {}
end

function slot0.InitData(slot0, slot1)
	slot2 = slot1.activity_id

	if slot1.is_clear == 2 then
		if slot1.is_reward_admitted == 2 then
			slot0.activityStateList_[slot2] = uv0.RECEIVED
		else
			slot0.activityStateList_[slot2] = uv0.UNRECEIVE
		end
	else
		slot0.activityStateList_[slot2] = uv0.UNCOMPLETE
	end

	slot0.stepCountList_[slot2] = slot1.change_times or 0
	slot0.minStepCountList_[slot2] = slot1.least_change_times or 0
	slot0.puzzleStateList_[slot2] = slot1.puzzle.puzzle_data
	slot0.puzzleStateList_[slot2][slot1.puzzle.vacant_position] = ActivityPuzzleCfg[slot2].block

	slot0:RefreshRedPoint(slot2)
end

function slot0.GetStateList(slot0, slot1)
	return slot0.puzzleStateList_[slot1]
end

function slot0.IsCompleted(slot0, slot1)
	if slot0.activityStateList_[slot1] ~= nil then
		return uv0.UNRECEIVE <= slot0.activityStateList_[slot1]
	end

	return false
end

function slot0.IsReceived(slot0, slot1)
	if slot0.activityStateList_[slot1] then
		return slot0.activityStateList_[slot1] == uv0.RECEIVED
	end

	return false
end

function slot0.GetStepCount(slot0, slot1)
	return slot0.stepCountList_[slot1] or 0
end

function slot0.GetMinStepCount(slot0, slot1)
	return slot0.minStepCountList_[slot1]
end

function slot0.SetMinStepCount(slot0, slot1)
	slot2 = slot0.minStepCountList_[slot1]
	slot3 = false

	if slot0.minStepCountList_[slot1] == 0 or slot0.stepCountList_[slot1] < slot0.minStepCountList_[slot1] then
		slot3 = true
		slot0.minStepCountList_[slot1] = slot0.stepCountList_[slot1]
	end

	return slot3, slot2
end

function slot0.SetCompletedActivityList(slot0, slot1)
	if slot0.activityStateList_[slot1] ~= uv0.RECEIVED then
		slot0.activityStateList_[slot1] = uv0.UNRECEIVE
	end

	slot0:RefreshRedPoint(slot1)
end

function slot0.SetReceivedActivityList(slot0, slot1)
	slot0.activityStateList_[slot1] = uv0.RECEIVED

	slot0:RefreshRedPoint(slot1)
end

function slot0.SetPuzzleState(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.puzzleStateList_[slot1] = slot0.puzzleStateList_[slot1] or {}
	slot0.puzzleStateList_[slot1][slot2] = slot3
	slot0.puzzleStateList_[slot1][slot4] = slot5
	slot0.stepCountList_[slot1] = slot0.stepCountList_[slot1] + 1
end

function slot0.ResetData(slot0, slot1)
	slot0.puzzleStateList_[slot1] = clone(ActivityPuzzleCfg[slot1].default_array)
	slot0.stepCountList_[slot1] = 0
end

function slot0.SetSelectActivity(slot0, slot1)
	slot2 = ActivityPuzzleCfg[slot1].main_activity_id

	if slot0.activityStateList_[slot1] ~= uv0.UNRECEIVE then
		manager.redPoint:setTip(string.format("%s_%s_%s_normal", RedPointConst.ACTIVITY_PUZZLE, slot2, slot1), 0)
	end
end

function slot0.SetWatchedVideo(slot0, slot1)
	saveData(string.format("Puzzle_%d", slot1), "watchVideo", true)
	slot0:RefreshVideoRedPoint(slot1, ActivityPuzzleCfg[slot1].main_activity_id)
end

function slot0.RefreshRedPoint(slot0, slot1)
	slot2 = ActivityPuzzleCfg[slot1].main_activity_id

	if ActivityData:GetActivityIsOpen(slot1) and slot0.activityStateList_[slot1] <= uv0.UNRECEIVE then
		manager.redPoint:setTip(string.format("%s_%s_%s_normal", RedPointConst.ACTIVITY_PUZZLE, slot2, slot1), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s_%s_normal", RedPointConst.ACTIVITY_PUZZLE, slot2, slot1), 0)
	end

	slot0:RefreshVideoRedPoint(slot1, slot2)
end

function slot0.RefreshVideoRedPoint(slot0, slot1, slot2)
	slot4 = ActivityPuzzleCfg[slot1].story_id == 0 or getData(string.format("Puzzle_%d", slot1), "watchVideo") == true

	if uv0.UNRECEIVE <= slot0.activityStateList_[slot1] and not slot4 then
		manager.redPoint:setTip(string.format("%s_%s_%s_video", RedPointConst.ACTIVITY_PUZZLE, slot2, slot1), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s_%s_video", RedPointConst.ACTIVITY_PUZZLE, slot2, slot1), 0)
	end
end

function slot0.GetLastContentPosX(slot0, slot1)
	return getData(string.format("Puzzle_%d", slot1), "contentPosX")
end

function slot0.SetLastContentPosX(slot0, slot1, slot2)
	saveData(string.format("Puzzle_%d", slot1), "contentPosX", slot2)
end

return slot0
