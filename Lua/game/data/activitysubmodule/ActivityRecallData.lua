slot0 = singletonClass("ActivityRecallData")

function slot0.InitActivityRecallData(slot0, slot1)
	slot0.recallCode = slot1.recall_code
	slot0.recallActivityID = slot1.activity_id
	slot0.codeUseNum = tonumber(slot1.code_use_num)
	slot0.recallRewardList = {}

	for slot5 = 1, 3 do
		if slot1.got_recall_reward_id_list[slot5] then
			slot0.recallRewardList[slot1.got_recall_reward_id_list[slot5]] = 1
		end
	end

	slot2 = ActivityData:GetActivityData(slot0.recallActivityID)
	slot0.recallTime = string.format("%s-%s", manager.time:STimeDescS(slot2.startTime, "!%Y/%m/%d %H:%M:%S"), manager.time:STimeDescS(slot2.stopTime, "!%Y/%m/%d %H:%M:%S"))

	slot0:UpdateRecallRewardRedPoint()
	slot0:UpdateTaskData()
	slot0:UpdateShopData()
end

function slot0.UpdateUserInfoList(slot0, slot1)
	slot0.userInfoList = slot1.info_list
end

function slot0.UpdateRecallRewardList(slot0, slot1)
	slot0.recallRewardList[slot1] = 1
end

function slot0.UpdateRecallUserInfo(slot0, slot1)
	slot0.isSubmit = true
	slot0.recallUserInfo = slot1.recall_user_info
end

function slot0.UpdateTaskData(slot0)
	slot0.taskList = {}
	slot1 = TaskData:GetActivityTaskList(ActivityConst.RECALL_TASK) or {}
	slot2 = 0

	for slot6, slot7 in pairs(slot1) do
		if AssignmentCfg[slot6].need <= slot7.progress and slot7.complete_flag == 0 then
			slot2 = 1
		end

		table.insert(slot0.taskList, slot7)
	end

	slot1 = ActivityData:GetActivityData(ActivityConst.RECALL_TASK)
	slot0.taskTime = string.format("%s-%s", manager.time:STimeDescS(slot1.startTime, "!%Y/%m/%d %H:%M:%S"), manager.time:STimeDescS(slot1.stopTime, "!%Y/%m/%d %H:%M:%S"))

	manager.redPoint:setTip(RedPointConst.RECALL_TASK, slot2)
end

function slot0.TaskSort(slot0)
	table.sort(slot0.taskList, function (slot0, slot1)
		if uv0:GetTaskStatus(slot0) ~= uv0:GetTaskStatus(slot1) then
			return slot2 < slot3
		end

		if AssignmentCfg[slot0.id].type ~= AssignmentCfg[slot1.id].type then
			return AssignmentCfg[slot0.id].type < AssignmentCfg[slot1.id].type
		end

		return slot1.id < slot0.id
	end)
end

function slot0.GetTaskStatus(slot0, slot1)
	slot3 = slot1.progress
	slot4 = AssignmentCfg[slot1.id].need

	if slot1.complete_flag == 1 then
		return 3
	elseif slot4 <= slot3 then
		return 1
	else
		return 2
	end
end

function slot0.UpdateRecallRewardRedPoint(slot0)
	for slot4 = 1, 3 do
		if slot4 <= slot0.codeUseNum and slot0.recallRewardList[slot4] == nil then
			manager.redPoint:setTip(RedPointConst.RECALL_REWARD, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.RECALL_REWARD, 0)
end

function slot0.InitActivityRecalledData(slot0, slot1)
	slot0.recalledActivityID = slot1.activity_id
	slot0.isSubmit = slot1.is_submit
	slot0.recallUserInfo = slot1.recall_user_info
	slot2 = ActivityData:GetActivityData(slot0.recalledActivityID)
	slot0.recalledTime = string.format("%s-%s", manager.time:STimeDescS(slot2.startTime, "!%Y/%m/%d %H:%M:%S"), manager.time:STimeDescS(slot2.stopTime, "!%Y/%m/%d %H:%M:%S"))
	slot0.firstPage = slot0.recalledActivityID ~= nil
end

function slot0.UpdateSignState(slot0)
	slot0.signState = SignData:GetSevenDaySignInfo(slot0.signActivityID)
end

function slot0.UpdateSignRedPoint(slot0)
	for slot4 = 1, #slot0.signData do
		if slot4 <= slot0.signCount and slot0.getRewardList[slot4] == nil then
			manager.redPoint:setTip(RedPointConst.RECALL_SIGN, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.RECALL_SIGN, 0)
end

function slot0.UpdateShopData(slot0)
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in pairs(ActivityShopCfg.get_id_list_by_activity_theme[ActivityCfg[ActivityConst.RECALL_MAIN].activity_theme]) do
		table.insert(slot3, ShopListCfg[ActivityShopCfg[slot8].shop_id].activity_id)
		table.insert(slot2, ActivityShopCfg[slot8].shop_id)
	end

	slot4 = 0
	slot0.shopID = slot2[1]

	for slot8, slot9 in ipairs(slot3) do
		if ActivityData:GetActivityData(slot9).stopTime - manager.time:GetServerTime() > 0 then
			slot0.shopTime = string.format("%s-%s", manager.time:STimeDescS(slot10.startTime, "!%Y/%m/%d %H:%M:%S"), manager.time:STimeDescS(slot10.stopTime, "!%Y/%m/%d %H:%M:%S"))

			if slot4 == 0 or slot12 < slot4 then
				slot4 = slot12
				slot0.shopID = slot2[slot8]
			end
		end
	end

	slot0.shopData = ExchangeTools.FilterExchangeDataList(slot0.shopID, ShopListCfg[slot0.shopID].chain_last_visible == 1)
end

function slot0.InitRecalledSignData(slot0, slot1)
	slot0.getRewardList = {}
	slot0.signActivityID = slot1.activity_id
	slot0.signCount = slot1.sign_count
	slot0.lastSignTime = slot1.last_sign_time

	for slot5, slot6 in ipairs(slot1.got_reward_sign_day_list) do
		slot0.getRewardList[slot6] = 1
	end

	slot0:UpdateSignRedPoint()
end

function slot0.UpdateSignData(slot0, slot1)
	slot0.getRewardList[slot1] = 1
end

function slot0.GetSevenDaySignIndex(slot0, slot1)
	if slot1 <= slot0.signCount and slot0.getRewardList[slot1] == nil then
		return 1
	end

	return 0
end

function slot0.Init(slot0)
	slot0.recalledActivityID = nil
	slot0.firstPage = false
	slot0.isSubmit = false
	slot0.recallUserInfo = nil
	slot0.recallCode = nil
	slot0.recallActivityID = nil
	slot0.codeUseNum = nil
	slot0.recallRewardList = {}
	slot0.getRewardList = {}
	slot0.recallReward = GameSetting.recall_reward.value
	slot0.codeLimit = GameSetting.recall_code_limit.value
	slot0.recalledReward = GameSetting.recalled_reward.value
	slot0.recallLevel = GameSetting.recall_level.value[1]
	slot1 = ActivityCfg.get_id_list_by_activity_template[ActivityConst.RECALL_SIGN][1]
	slot0.signActivityID = slot1
	slot0.signData = {}

	for slot6, slot7 in pairs(ActivityCumulativeSignCfg[slot1].config_list) do
		table.insert(slot0.signData, SignCfg[slot7])
	end
end

function slot0.GetDataByPara(slot0, slot1)
	return slot0[slot1]
end

return slot0
