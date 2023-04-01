slot0 = singletonClass("OsirisInfinityPoolData")

function slot0.Init(slot0)
	slot0.poolList_ = {}

	for slot4, slot5 in ipairs(ActivityInfinityPoolCfg.all) do
		slot0.poolList_[slot5] = {
			isOpenCoreItem = false,
			openBoxList = {},
			itemList = {},
			resultItemList = {}
		}
	end

	slot0.openPhase_ = {}
	slot0.clickPhase_ = {}
end

function slot0.InitData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.pool_list) do
		slot0.openPhase_[slot7] = slot0.openPhase_[ActivityInfinityPoolCfg[slot6.id].activity_id] or 1
		slot0.poolList_[slot6.id] = slot0:ParsePool(slot6)
	end
end

function slot0.ParsePool(slot0, slot1)
	if slot1.is_got_core_item and slot1.is_got_core_item == 1 then
		slot2 = ActivityInfinityPoolCfg[slot1.id].activity_id

		if slot0.openPhase_[slot2] < table.keyof(ActivityInfinityPoolCfg.get_id_list_by_activity_id[slot2], slot1.id) + 1 then
			slot0.openPhase_[slot2] = slot3 + 1
		end
	end

	slot2 = slot0:ParseOpenBoxList(slot1.box_list)

	return {
		openBoxList = slot2,
		coreItem = slot1.core_item.id ~= 0 and {
			slot1.core_item.id,
			slot1.core_item.num
		} or nil,
		itemList = slot3,
		resultItemList = slot0:StatisticsItem(slot0:ParseItemList(slot1.item_list), slot2),
		isOpenCoreItem = slot1.is_got_core_item == 1
	}
end

function slot0.ParseOpenBoxList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot2[slot7.index] = {
			slot7.item.id,
			slot7.item.num
		}
	end

	return slot2
end

function slot0.ParseItemList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, {
			slot7.id,
			slot7.num
		})
	end

	return sortReward(slot2)
end

function slot0.StatisticsItem(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in pairs(slot1) do
		slot0:InitRewardData(slot3, slot8, slot2)
	end

	return slot3
end

function slot0.InitRewardData(slot0, slot1, slot2, slot3)
	for slot7, slot8 in pairs(slot1) do
		if slot8.reward[1] == slot2[1] and slot8.reward[2] == slot2[2] then
			slot8.maxCnt = slot8.maxCnt + 1

			return
		end
	end

	slot4 = 0

	for slot8, slot9 in pairs(slot3) do
		if slot2[1] == slot9[1] and slot2[2] == slot9[2] then
			slot4 = slot4 + 1
		end
	end

	table.insert(slot1, {
		maxCnt = 1,
		reward = slot2,
		cnt = slot4
	})
end

function slot0.GetPoolData(slot0, slot1)
	return slot0.poolList_[slot1]
end

function slot0.GetOpenPhase(slot0, slot1)
	return slot0.openPhase_[slot1] or 1
end

function slot0.OpenBox(slot0, slot1, slot2, slot3)
	slot0.poolList_[slot1].openBoxList[slot2] = slot3

	slot0:AddRewardData(slot0.poolList_[slot1].resultItemList, slot3)

	slot4 = slot0.poolList_[slot1]
	slot5 = ActivityInfinityPoolCfg[slot1].activity_id

	if slot0.openPhase_[slot5] < #ActivityInfinityPoolCfg.get_id_list_by_activity_id[slot5] and slot4.coreItem and slot3[1] == slot4.coreItem[1] and slot3[2] == slot4.coreItem[2] then
		slot0.openPhase_[slot5] = slot0.openPhase_[slot5] + 1
		slot0.poolList_[slot1].isOpenCoreItem = true

		manager.notify:Invoke(OSIRIS_INFINITY_OPEN_CORE_ITEM)
	end

	if slot4.coreItem == nil and table.length(slot0.poolList_[slot1].openBoxList) >= #slot0.poolList_[slot1].itemList then
		manager.notify:Invoke(OSIRIS_INFINITY_OPEN_CORE_ITEM)
	end
end

function slot0.AddRewardData(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot1) do
		if slot7.reward[1] == slot2[1] and slot7.reward[2] == slot2[2] then
			slot7.cnt = slot7.cnt + 1

			return
		end
	end
end

function slot0.ResetPool(slot0, slot1, slot2)
	slot0.poolList_[slot1] = slot0:ParsePool(slot2)
end

function slot0.SetClickPhaseValue(slot0, slot1, slot2)
	slot0.clickPhase_[slot1] = slot2

	saveData("InfinityPhase", tostring(slot1), slot2)
end

function slot0.GetClickPhaseValue(slot0, slot1)
	return slot0.clickPhase_[slot1] or getData("InfinityPhase", tostring(slot1)) or 1
end

return slot0
