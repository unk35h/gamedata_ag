slot0 = singletonClass("PaperCutData")

function slot0.Init(slot0)
	slot0.scoreList_ = {}
	slot0.receivedList_ = {}
	slot0.playedList_ = {}
end

function slot0.SetData(slot0, slot1)
	slot2 = slot1.activity_id
	slot0.scoreList_[slot2] = slot1.score
	slot0.receivedList_[slot2] = {}

	for slot7, slot8 in ipairs(slot1.got_reward_list) do
		table.insert(slot0.receivedList_[slot2], slot8)
	end

	slot0.playedList_[slot2] = slot1.is_play

	slot0:RefreshSelectRedPoint(slot2)
	slot0:RefreshRewardRedPoint(slot2)
end

function slot0.GetPlayedList(slot0, slot1)
	return slot0.playedList_[slot1] or false
end

function slot0.GetScore(slot0, slot1)
	return slot0.scoreList_[slot1] or 0
end

function slot0.SetScore(slot0, slot1, slot2)
	if slot0.scoreList_[slot1] == nil then
		slot0.scoreList_[slot1] = slot2
	else
		slot0.scoreList_[slot1] = slot2 < slot0.scoreList_[slot1] and slot0.scoreList_[slot1] or slot2
	end

	slot0.playedList_[slot1] = true

	slot0:RefreshSelectRedPoint(slot1)
	slot0:RefreshRewardRedPoint(slot1)
end

function slot0.GetReceivedList(slot0, slot1)
	return slot0.receivedList_[slot1] or {}
end

function slot0.SetReceivedList(slot0, slot1, slot2)
	slot0.receivedList_[slot1] = slot0.receivedList_[slot1] or {}

	if table.keyof(slot0.receivedList_[slot1], slot2) == nil then
		table.insert(slot0.receivedList_[slot1], slot2)
	end

	slot0:RefreshRewardRedPoint(slot1)
end

function slot0.GetRewardList(slot0, slot1)
	slot3 = {}
	slot4 = {}
	slot5 = {}
	slot6 = {}

	for slot10, slot11 in ipairs(ActivityCfg[slot1].sub_activity_list) do
		slot13 = slot0:GetScore(slot11)
		slot14 = slot0:GetReceivedList(slot11)

		for slot18, slot19 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot11]) do
			if slot13 < ActivityPointRewardCfg[slot19].need then
				slot4[#slot4 + 1] = slot19
			elseif table.keyof(slot14, slot19) == nil then
				slot5[#slot5 + 1] = slot19
			else
				slot6[#slot6 + 1] = slot19
			end
		end
	end

	table.insertto(slot3, slot5)
	table.insertto(slot3, slot4)
	table.insertto(slot3, slot6)

	return slot3
end

function slot0.SetSelectActivityID(slot0, slot1)
	manager.redPoint:setTip(string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, PaperCutCfg[slot1].main_activity_id, slot1), 0)
end

function slot0.RefreshSelectRedPoint(slot0, slot1)
	manager.redPoint:setTip(string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, PaperCutCfg[slot1].main_activity_id, slot1), slot0.playedList_[slot1] == true and 0 or 1)
end

function slot0.RefreshRewardRedPoint(slot0, slot1)
	slot2 = 0
	slot3 = PaperCutCfg[slot1].main_activity_id
	slot4 = slot0:GetScore(slot1)

	if PaperCutCfg[slot1] then
		slot2 = ActivityPointRewardCfg[slot5.task_id].need <= slot4 and table.keyof(slot0.receivedList_[slot1], slot6) == nil and 1 or 0
	end

	manager.redPoint:setTip(string.format("%s_%s_%s_Reward", RedPointConst.PAPER_CUT, slot3, slot1), slot2)
end

function slot0.GetLastContentPosX(slot0, slot1)
	return getData(string.format("PaperCut_%d", slot1), "contentPosX")
end

function slot0.SetLastContentPosX(slot0, slot1, slot2)
	saveData(string.format("PaperCut_%d", slot1), "contentPosX", slot2)
end

return slot0
