slot0 = singletonClass("SkuldTravelData")
slot1 = 10111

function slot0.Init(slot0)
	slot0.attrib_ = {
		0,
		0,
		0,
		0
	}
	slot0.statu_ = 0
	slot0.getplotlist_ = {}
	slot0.getendinglist_ = {}
	slot0.gettasklist_ = {}
end

function slot0.InitRedPointGroup(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(TravelSkuldStoryCfg.get_id_list_by_location_id) do
		slot7 = RedPointConst.TRAVEL_SKULD_TRAVELMAP .. slot5
		slot8 = {}

		for slot12, slot13 in pairs(slot6) do
			table.insert(slot8, RedPointConst.TRAVEL_SKULD_TRAVELITEM .. slot13)
		end

		manager.redPoint:addGroup(slot7, slot8)
		table.insert(slot1, slot7)
	end

	manager.redPoint:addGroup(RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, slot1)

	slot3 = RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
	slot4 = RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_1_6) then
		manager.redPoint:addGroup(RedPointConst.TRAVEL_SKULD_ACTIVITY .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, {
			slot2,
			slot3,
			slot4
		})
	end

	manager.redPoint:addGroup(RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, {
		slot2,
		slot3,
		slot4
	})

	slot6 = RedPointConst.TRAVEL_SKULD_CHAPTER .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_1_6) then
		manager.redPoint:addGroup(slot6, {
			slot4
		})
	elseif ChapterTools.IsFinishPreChapter(uv0) then
		manager.redPoint:addGroup(slot6, {
			slot4
		})
	end
end

function slot0.SetData(slot0, slot1)
	slot0.attrib_[1] = slot1.memory
	slot0.attrib_[2] = slot1.favorite
	slot0.attrib_[3] = slot1.trust
	slot0.attrib_[4] = slot1.mood
	slot0.statu_ = slot1.travel_state
	slot0.curplotid_ = slot1.plot_id
	slot0.getplotlist_ = {}

	for slot5, slot6 in ipairs(slot1.plot_list) do
		table.insert(slot0.getplotlist_, slot6)
	end

	slot0.getendinglist_ = {}

	for slot5, slot6 in ipairs(slot1.complete_ending) do
		table.insert(slot0.getendinglist_, slot6)
	end

	slot0.gettasklist_ = {}

	for slot5, slot6 in ipairs(slot1.complete_task) do
		table.insert(slot0.gettasklist_, slot6)
	end

	slot0:UpdateAllRedPoint()
end

function slot0.SetTravelStatu(slot0, slot1)
	slot0.statu_ = slot1

	slot0:UpdateEndingUnLockRedPoint()
	slot0:UpdateTravelItemRedPoint()
	slot0:UpdateSkuldStatuRedPoint()
end

function slot0.GetSkuldIsCanTravel(slot0)
	if slot0.statu_ == 0 then
		return true
	end

	return false
end

function slot0.GetAttrib(slot0)
	return slot0.attrib_
end

function slot0.GetSkuldStatu(slot0)
	return slot0.statu_
end

function slot0.GetCurPlotId(slot0)
	return slot0.curplotid_
end

function slot0.GetEndingStatu(slot0, slot1)
	if table.keyof(slot0.getendinglist_, slot1) then
		return "get"
	elseif slot0:GetEndingIsCanOpen(slot1) then
		return "canopen"
	else
		return "lock"
	end
end

function slot0.GetEndingIsOpened(slot0, slot1)
	if table.keyof(slot0.getendinglist_, slot1) then
		return true
	else
		return false
	end
end

function slot0.GetEndingIsCanOpen(slot0, slot1)
	for slot6, slot7 in pairs(TravelSkuldEndingCfg[slot1].unlock_attrib) do
		if slot0.attrib_[slot6] < slot7 then
			return false
		end
	end

	for slot6, slot7 in pairs(slot2.unlock_story_collect) do
		if table.keyof(slot0.getplotlist_, slot7) == nil then
			return false
		end
	end

	return true
end

function slot0.AttribIndexToString(slot0, slot1)
	if slot1 == 1 then
		return GetTips("TIP_MEMORY")
	end

	if slot1 == 2 then
		return GetTips("TIP_CURIOSITY")
	end

	if slot1 == 3 then
		return GetTips("TIP_MOOD")
	end

	if slot1 == 4 then
		return GetTips("TIP_COGNITION")
	end
end

function slot0.GetPlotIsGeted(slot0, slot1)
	return table.indexof(slot0.getplotlist_, slot1)
end

function slot0.GetPlotIdByMapIdAndItemId(slot0, slot1, slot2)
	for slot6, slot7 in pairs(TravelSkuldStoryCfg.get_id_list_by_location_id[slot1]) do
		if TravelSkuldStoryCfg[slot7].item_id == slot2 then
			return slot7
		end
	end

	print("请检查配置表！！！！ ， mapid ， itemid", slot1, slot2)

	return nil
end

function slot0.GetPlotIsGetByMapIdAndItemId(slot0, slot1, slot2)
	for slot6, slot7 in pairs(TravelSkuldStoryCfg.get_id_list_by_location_id[slot1]) do
		if TravelSkuldStoryCfg[slot7].item_id == slot2 then
			if table.indexof(slot0.getplotlist_, slot7) then
				return true
			else
				return false
			end
		end
	end

	print("请检查配置表！！！！ ， mapid ， itemid", slot1, slot2)

	return nil
end

function slot0.GetTaskTextByTaskId(slot0, slot1)
	if TravelSkuldRewardCfg[slot1].condition[1] == 1 then
		return string.format(GetTips("TRAVEL_SKULD_STORY_GET"), slot2.condition[2])
	elseif slot2.condition[1] == 2 then
		return string.format(GetTips("TRAVEL_SKULD_ENDING_OPEN"), slot2.condition[2])
	end
end

function slot0.GetTaskStatuByTaskId(slot0, slot1)
	if table.indexof(slot0.gettasklist_, slot1) then
		return 3
	elseif TravelSkuldRewardCfg[slot1].condition[1] == 1 then
		if #slot0.getplotlist_ < slot2.condition[2] then
			return 2
		else
			return 1
		end
	elseif TravelSkuldRewardCfg[slot1].condition[1] == 2 then
		if #slot0.getendinglist_ < slot2.condition[2] then
			return 2
		else
			return 1
		end
	end
end

function slot0.GetTaskControllerStatu(slot0, slot1)
	if slot1 == 1 then
		return "complete"
	end

	if slot1 == 2 then
		return "incomplete"
	end

	if slot1 == 3 then
		return "received"
	end
end

function slot0.GetedTaskReward(slot0, slot1)
	table.insert(slot0.gettasklist_, slot1)
	getReward(TravelSkuldRewardCfg[slot1].reward_item_list)
	slot0:UpdateRewardRedPoint()
end

function slot0.OpenEnding(slot0, slot1)
	table.insert(slot0.getendinglist_, slot1)
	slot0:UpdateEndingOpenRedPoint()
	slot0:UpdateRewardRedPoint()
end

function slot0.GetSkuldBtnIsBreach(slot0)
	if slot0:IsPassNewEnding() then
		return false
	end

	return (BattleStageData:GetStageData()[GameSetting.travel_skuld_destroy.value[1]] and slot3.clear_times > 0 and 1 or 0) >= 1
end

function slot0.GetSkuldTravelIsOpen(slot0)
	return (BattleStageData:GetStageData()[GameSetting.travel_skuld_unlock.value[1]] and slot3.clear_times > 0 and 1 or 0) >= 1
end

function slot0.UpdateAllRedPoint(slot0)
	if not slot0:GetSkuldTravelIsOpen() then
		return
	end

	slot0:UpdateEndingUnLockRedPoint()
	slot0:UpdateEndingOpenRedPoint()
	slot0:UpdateTravelItemRedPoint()
	slot0:UpdateSkuldStatuRedPoint()
	slot0:UpdateRewardRedPoint()
end

function slot0.UpdateEndingUnLockRedPoint(slot0)
	slot1 = RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	if slot0.statu_ == 0 then
		for slot5 = 1, #TravelSkuldEndingCfg.all - 1 do
			if not slot0:GetEndingIsOpened(TravelSkuldEndingCfg.all[slot5]) and not slot0:GetEndingIsCanOpen(slot6) then
				manager.redPoint:setTip(slot1, 1)

				return
			end
		end

		manager.redPoint:setTip(slot1, 0)
	else
		manager.redPoint:setTip(slot1, 0)
	end
end

function slot0.UpdateEndingOpenRedPoint(slot0)
	slot1 = RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	for slot5, slot6 in pairs(TravelSkuldEndingCfg.all) do
		if slot5 > 3 then
			if not table.indexof(slot0.getendinglist_, slot6) and slot0:IsOpenNewEnding() then
				manager.redPoint:setTip(slot1, 1)

				return
			end
		elseif not table.indexof(slot0.getendinglist_, slot6) and slot0:GetEndingIsCanOpen(slot6) then
			manager.redPoint:setTip(slot1, 1)

			return
		end
	end

	manager.redPoint:setTip(slot1, 0)
end

function slot0.UpdateTravelItemRedPoint(slot0)
	for slot4, slot5 in pairs(TravelSkuldStoryCfg.get_id_list_by_location_id) do
		for slot9, slot10 in pairs(slot5) do
			slot11 = TravelSkuldStoryCfg[slot10].item_id
			slot12 = RedPointConst.TRAVEL_SKULD_TRAVELITEM .. slot10

			if slot0.statu_ == 0 then
				slot13 = false

				for slot17, slot18 in pairs(TravelSkuldItemCfg[slot11].unlock) do
					if slot0.attrib_[slot17] < slot18 then
						slot13 = true
					end
				end

				if slot13 or table.indexof(slot0.getplotlist_, slot10) then
					manager.redPoint:setTip(slot12, 0)
				else
					manager.redPoint:setTip(slot12, 1)
				end
			else
				manager.redPoint:setTip(slot12, 0)
			end
		end
	end
end

function slot0.UpdateSkuldStatuRedPoint(slot0)
	slot1 = RedPointConst.TRAVEL_SKULD_ACTIVITY .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
	slot2 = RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	if slot0.statu_ == 2 then
		manager.redPoint:setTip(slot1, 1)
		manager.redPoint:setTip(slot2, 1)
	else
		manager.redPoint:setTip(slot1, 0)
		manager.redPoint:setTip(slot2, 0)
	end
end

function slot0.UpdateRewardRedPoint(slot0)
	slot1 = RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	for slot5, slot6 in pairs(TravelSkuldRewardCfg.all) do
		if slot0:GetTaskStatuByTaskId(slot6) == 1 then
			manager.redPoint:setTip(slot1, 1)

			return
		end
	end

	manager.redPoint:setTip(slot1, 0)
end

function slot0.IsCollectAllPhoto(slot0)
	if #slot0.getendinglist_ < #TravelSkuldEndingCfg.all - 1 then
		return false
	else
		return true
	end
end

function slot0.IsOpenNewEnding(slot0)
	return (BattleStageData:GetStageData()[GameSetting.travel_skuld_new_ending.value[1]] and slot3.clear_times > 0 and 1 or 0) >= 1
end

function slot0.IsPassNewEnding(slot0)
	return (BattleStageData:GetStageData()[GameSetting.travel_skuld_new_ending_stage_id.value[1]] and slot3.clear_times > 0 and 1 or 0) >= 1
end

function slot0.GetChapterID(slot0)
	return uv0
end

return slot0
