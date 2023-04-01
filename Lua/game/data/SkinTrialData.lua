slot0 = singletonClass("SkinTrialData")

function slot0.Init(slot0)
	slot0.skinTrialStateList_ = {}
	slot0.selectSkinTrialIDList_ = {}
	slot0.completedSkinTrialIDList_ = {}
	slot0.stageIDToSkinTrialID_ = {}
end

function slot0.InitData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.activity_info) do
		if ActivitySkinTrialCfg[slot6.id] ~= nil then
			slot0.skinTrialStateList_[slot6.id] = slot6.clear_time

			if slot6.clear_time == 1 then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_TRIAL, slot7.activity_id), 0)

				if table.keyof(slot0.completedSkinTrialIDList_, slot6.id) == nil then
					table.insert(slot0.completedSkinTrialIDList_, slot6.id)
				end
			else
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_TRIAL, slot7.activity_id), 1)
			end
		end
	end
end

function slot0.GetSkinTrialStateList(slot0)
	return slot0.skinTrialStateList_
end

function slot0.SetSelectSkinTrialID(slot0, slot1, slot2)
	slot0.selectSkinTrialIDList_[slot1] = slot2

	saveData("SkinTrial", "activityID_" .. tostring(slot1), slot2)

	if slot0.skinTrialStateList_[slot2] == 0 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_TRIAL, ActivitySkinTrialCfg[slot2].activity_id), 0)
	end
end

function slot0.GetSelectSkinTrialID(slot0, slot1)
	if slot0.selectSkinTrialIDList_[slot1] == nil then
		slot0.selectSkinTrialIDList_[slot1] = getData("SkinTrial", "activityID_" .. tostring(slot1))
	end

	return slot0.selectSkinTrialIDList_[slot1]
end

function slot0.IsCompleted(slot0, slot1)
	if table.keyof(slot0.completedSkinTrialIDList_, slot1) then
		return true
	else
		return false
	end
end

function slot0.SaveStageID(slot0, slot1)
	slot0.stageIDToSkinTrialID_[ActivitySkinTrialCfg[slot1].stage_id] = slot1
end

function slot0.GetSkinTrialID(slot0, slot1)
	return slot0.stageIDToSkinTrialID_[slot1]
end

return slot0
