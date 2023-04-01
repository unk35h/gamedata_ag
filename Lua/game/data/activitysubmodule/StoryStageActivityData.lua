slot0 = singletonClass("StoryStageActivityData")

function slot0.Init(slot0)
	slot0.stageList_ = {}
	slot0.historyActivityList_ = {}
	slot0.historyChapterList_ = {}
	slot0.defaultActivityID_ = {}
	slot0.redPointList_ = {}
	slot0.unlockState_ = {}
end

function slot0.InitData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.info) do
		slot0.stageList_[slot7] = slot0.stageList_[slot6.chapter_id] or {}
		slot0.stageList_[slot7][slot6.stage_id] = {
			id = slot6.stage_id,
			clear_times = slot6.clear_time
		}
	end
end

function slot0.GetStageData(slot0, slot1)
	return slot0.stageList_[slot1] or {}
end

function slot0.GetHistoryStage(slot0, slot1)
	slot0.historyChapterList_[slot1] = slot0.historyChapterList_[slot1] or getData("StoryStageData", "chapterID" .. slot1) or 1

	return slot0.historyChapterList_[slot1]
end

function slot0.SaveHistoryStage(slot0, slot1, slot2)
	slot0.historyChapterList_[slot1] = slot2

	saveData("StoryStageData", "chapterID" .. slot1, slot2)
end

function slot0.GetHistoryChapter(slot0, slot1)
	slot0.historyActivityList_[slot1] = slot0.historyActivityList_[slot1] or getData("StoryStageData", "activityID" .. slot1) or ActivityStoryChapterCfg.get_id_list_by_activity_id[slot1][1]

	return slot0.historyActivityList_[slot1]
end

function slot0.SaveHistoryChapter(slot0, slot1, slot2)
	slot0.historyActivityList_[slot1] = slot2

	saveData("StoryStageData", "activityID" .. slot1, slot2)
end

function slot0.SaveDefaultActivityID(slot0, slot1, slot2)
	slot3 = ActivityCfg[slot2].activity_theme
	slot0.defaultActivityID_[slot3] = slot2

	saveData("StoryStageData", "activityID" .. slot3, slot2)
end

function slot0.GetDefaultActivityID(slot0, slot1)
	return slot0.defaultActivityID_[slot1] or getData("StoryStageData", "activityID" .. slot1)
end

function slot0.SetRedPoint(slot0, slot1)
	saveData("StoryStageData", "RedPoint" .. slot1, 0)
end

function slot0.GetRedPoint(slot0, slot1)
	slot0.redPointList_[slot1] = slot0.redPointList_[slot1] or getData("StoryStageData", "RedPoint" .. slot1)

	return slot0.redPointList_[slot1]
end

function slot0.SetUnlockState(slot0, slot1)
	slot0.unlockState_[slot1] = true

	saveData("StoryStageData", "unlock" .. slot1, true)
end

function slot0.GetUnlockState(slot0, slot1)
	return slot0.unlockState_[slot1] or getData("StoryStageData", "unlock" .. slot1)
end

return slot0
