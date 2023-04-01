slot0 = singletonClass("ArtifactLevelData")

function slot0.Init(slot0)
	slot0.curOpenLevelList_ = {}
	slot0.curAwardedLevelList_ = {}
	slot0.levelId_ = {}
	slot0.selectedLevelList_ = {}
	slot0.awardsList_ = {}
	slot0.levelCount_ = 0
	slot0.curLevelIndex_ = 1
	slot2 = ActivityData:GetActivityData(ActivityConst.SUMMER_ARTIFACT)

	for slot6, slot7 in pairs(ActivityArtifactLevelCfg.all) do
		table.insert(slot0.levelId_, slot7)

		slot0.levelCount_ = slot0.levelCount_ + 1
	end

	for slot6, slot7 in pairs(BattleArtifactCfg.all) do
		slot0.awardsList_[slot6] = BattleArtifactCfg[slot7].drop_lib_id
	end

	slot0:InitRedPoint(ActivityConst.SUMMER_ARTIFACT)
end

function slot0.SetData(slot0, slot1)
	slot2 = slot1.artifact

	for slot6, slot7 in pairs(slot0.levelId_) do
		slot0.curAwardedLevelList_[slot6] = false
	end

	if slot2.already_clear_activity_id_list then
		for slot6, slot7 in ipairs(slot2.already_clear_activity_id_list) do
			if slot0:GetIndexByLevelId(slot7) then
				slot0.curAwardedLevelList_[slot0:GetIndexByLevelId(slot7)] = true
			end
		end
	end

	for slot6, slot7 in pairs(ActivityArtifactLevelCfg.all) do
		if ActivityData:GetActivityIsOpen(slot7) then
			slot0.curOpenLevelList_[slot6] = true
		end
	end

	slot0:UpdateRedPoint()
end

function slot0.GetIndexByLevelId(slot0, slot1)
	for slot5, slot6 in pairs(slot0.levelId_) do
		if slot6 == slot1 then
			return slot5
		end
	end

	return nil
end

function slot0.GetLevelCount(slot0)
	return slot0.levelCount_
end

function slot0.GetLevelIdByIndex(slot0, slot1)
	return slot0.levelId_[slot1]
end

function slot0.GetIsAwardedByIndex(slot0, slot1)
	return slot0.curAwardedLevelList_[slot1]
end

function slot0.GetLevelNameByIndex(slot0, slot1)
	return ActivityArtifactLevelCfg[slot0.levelId_[slot1]].name
end

function slot0.GetLevelDesc(slot0, slot1)
	return ActivityArtifactLevelCfg[slot0.levelId_[slot1]].desc
end

function slot0.GetIsOpenByIndex(slot0, slot1)
	return ActivityData:GetActivityIsOpen(slot0.levelId_[slot1])
end

function slot0.GetAwardListByIndex(slot0, slot1)
	return slot0.awardsList_[slot1]
end

function slot0.GetLevelIdByStageId(slot0, slot1)
	for slot5, slot6 in pairs(slot0.levelId_) do
		if ActivityArtifactLevelCfg[slot6].stage_id == slot1 then
			return slot6
		end
	end

	return nil
end

function slot0.GetCurLevelIndex(slot0)
	return slot0.curLevelIndex_
end

function slot0.SetCurLevelIndex(slot0, slot1)
	slot0.curLevelIndex_ = slot1
end

function slot0.SetSelectedByIndex(slot0, slot1)
	slot0.selectedLevelList_[slot1] = true
end

function slot0.UpdateRedPoint(slot0)
	for slot4 = 1, slot0.levelCount_ do
		slot5 = false

		if ActivityData:GetActivityIsOpen(slot0.levelId_[slot4]) and slot0.selectedLevelList_[slot4] == nil and slot0.curAwardedLevelList_[slot4] == false then
			slot5 = true
		end

		if slot5 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ARTIFACT, slot0.levelId_[slot4]), 1)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ARTIFACT, slot0.levelId_[slot4]), 0)
		end
	end
end

function slot0.InitRedPoint(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0.levelId_) do
		table.insert(slot2, string.format("%s_%s", RedPointConst.ARTIFACT, slot7))
	end

	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ARTIFACT, ActivityConst.SUMMER_ARTIFACT), slot2)
end

return slot0
