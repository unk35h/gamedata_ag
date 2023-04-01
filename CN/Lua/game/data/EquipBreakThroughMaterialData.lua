slot0 = singletonClass("EquipBreakThroughMaterialData")

function slot0.Init(slot0)
	slot0.openModeList_ = {}
	slot0.selectModeID_ = 0
	slot0.globalAffixList_ = {}
	slot0.chipManagerID_ = 0
	slot0.chipIDList_ = {}
	slot0.refreshTimestamp_ = 0
	slot0.mapID_ = 0
	slot0.finishStageList_ = {}
	slot0.stageList_ = {}
	slot0.buffList_ = {}
	slot0.attributeList_ = {}
	slot0.taskList_ = {}
	slot0.heroStateList_ = {}
	slot0.receivedList_ = {}
	slot0.totalPoint_ = 0
	slot0.mapStageID_ = nil
	slot0.sortRewardList_ = {}
	slot0.comboSkillID_ = nil
	slot0.cacheHeroList_ = {
		0,
		0,
		0
	}
end

function slot0.InitData(slot0, slot1)
	slot0.openModeList_ = {}

	for slot5, slot6 in ipairs(slot1.unlock_difficulty) do
		table.insert(slot0.openModeList_, slot6)
	end

	slot0.selectModeID_ = slot1.difficulty
	slot0.receivedList_ = {}

	for slot5, slot6 in ipairs(slot1.receive_list) do
		table.insert(slot0.receivedList_, slot6)
	end

	slot0.globalAffixList_ = {}

	for slot5, slot6 in ipairs(slot1.global_affix) do
		table.insert(slot0.globalAffixList_, {
			slot6.id,
			slot6.level,
			slot6.type
		})
	end

	if slot0.selectModeID_ == 0 then
		manager.notify:Invoke(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE)
	end

	slot0.chipManagerID_ = slot1.ai_chip_list[1] or 0
	slot0.chipIDList_ = {}

	for slot5, slot6 in ipairs(slot1.ai_chip_list) do
		if slot5 > 1 then
			table.insert(slot0.chipIDList_, slot6)
		end
	end

	slot0.refreshTimestamp_ = slot1.refresh_timestamp
end

function slot0.UpdateMapData(slot0, slot1)
	slot0.mapID_ = slot1.map_id
	slot0.totalPoint_ = slot1.total_points
	slot0.finishStageList_ = {}

	for slot5, slot6 in ipairs(slot1.progress_id_list) do
		table.insert(slot0.finishStageList_, slot6)
	end

	slot0.stageList_ = {}

	for slot5, slot6 in ipairs(slot1.choice_buff_list) do
		slot7 = {}

		for slot11, slot12 in ipairs(slot6.buff_id) do
			table.insert(slot7, slot12)
		end

		slot0.stageList_[slot6.id] = {
			buffList = slot7
		}
	end

	for slot5, slot6 in ipairs(slot1.choice_stage_list) do
		slot0.stageList_[slot6.id] = {
			stageID = slot6.stage
		}
	end

	slot0.buffList_ = {}
	slot0.attributeList_ = {}

	for slot5, slot6 in ipairs(slot1.buff_list) do
		if EquipBreakThroughMaterialItemCfg[slot6].item_type == 1 then
			slot0.attributeList_[slot6] = (slot0.attributeList_[slot6] or 0) + 1
		else
			table.insert(slot0.buffList_, slot6)
		end
	end

	slot0.taskList_ = {}

	for slot5, slot6 in ipairs(slot1.assignment_list) do
		slot0.taskList_[slot6.id] = {
			currentValue = slot6.now_progress,
			targetValue = slot6.total_progress
		}
	end

	slot0.heroStateList_ = {}

	for slot5, slot6 in ipairs(slot1.hero_status) do
		slot0.heroStateList_[slot5] = {
			heroID = slot6.hero_id,
			rate = slot6.health_rate
		}
	end

	slot0:CheckRedPoint()
	slot0:SortRewardList()

	slot0.comboSkillID_ = slot1.cooperate_unique_skill

	if slot0.mapStageID_ and slot0.stageList_[slot0.mapStageID_] == nil then
		slot0.mapStageID_ = nil
	end
end

function slot0.GetOpenModeList(slot0)
	return slot0.openModeList_
end

function slot0.GetSelectModeID(slot0)
	return slot0.selectModeID_
end

function slot0.GetMapID(slot0)
	return slot0.mapID_
end

function slot0.GetRefreshTimestamp(slot0)
	return slot0.refreshTimestamp_
end

function slot0.GetReceivedList(slot0)
	return slot0.receivedList_
end

function slot0.GetGlobalAffixList(slot0)
	return slot0.globalAffixList_
end

function slot0.GetChipManagerID(slot0)
	return slot0.chipManagerID_
end

function slot0.GetChipList(slot0)
	return slot0.chipIDList_
end

function slot0.GetTotalPoint(slot0)
	return slot0.totalPoint_
end

function slot0.GetFinishStageList(slot0)
	return slot0.finishStageList_
end

function slot0.GetStageData(slot0)
	return slot0.stageList_
end

function slot0.GetBuffList(slot0)
	return slot0.buffList_
end

function slot0.GetAttributeList(slot0)
	return slot0.attributeList_
end

function slot0.GetTaskList(slot0)
	return slot0.taskList_
end

function slot0.GetHeroState(slot0)
	return slot0.heroStateList_
end

function slot0.GetCacheHero(slot0)
	return slot0.cacheHeroList_ or {
		0,
		0,
		0
	}
end

function slot0.SetHeroTeam(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0.heroStateList_[slot5] = {
			rate = 10000,
			heroID = slot6
		}
	end

	slot0.cacheHeroList_ = slot1
end

function slot0.SetChooseMapStageID(slot0, slot1)
	slot0.mapStageID_ = slot1
end

function slot0.GetChooseMapStageID(slot0)
	return slot0.mapStageID_
end

function slot0.SortRewardList(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in pairs(slot0.taskList_) do
		if table.keyof(slot0.receivedList_, slot7) then
			table.insert(slot2, slot7)
		elseif slot8.targetValue <= slot8.currentValue then
			table.insert(slot1, slot7)
		else
			table.insert(slot3, slot7)
		end
	end

	slot0.sortRewardList_ = {}

	table.insertto(slot0.sortRewardList_, slot1)
	table.insertto(slot0.sortRewardList_, slot3)
	table.insertto(slot0.sortRewardList_, slot2)
end

function slot0.GetSortRewardList(slot0)
	return slot0.sortRewardList_
end

function slot0.CheckRedPoint(slot0)
	for slot4, slot5 in pairs(slot0.taskList_) do
		if slot5.targetValue <= slot5.currentValue and not table.keyof(slot0.receivedList_, slot4) then
			manager.redPoint:setTip(RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL_REWARD, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL_REWARD, 0)
end

function slot0.GetCanReceiveList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.taskList_) do
		if not table.keyof(slot0.receivedList_, slot5) and slot6.targetValue <= slot6.currentValue then
			table.insert(slot1, slot5)
		end
	end

	return slot1
end

function slot0.ReceiveReward(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.receivedList_, slot6)
	end

	slot0:CheckRedPoint()
	slot0:SortRewardList()
end

function slot0.SetComboSkillID(slot0, slot1)
	slot0.comboSkillID_ = slot1
end

function slot0.GetComboSkillID(slot0)
	return slot0.comboSkillID_
end

return slot0
