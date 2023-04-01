slot0 = singletonClass("SpringFestivalGreetingData")

function slot0.Init(slot0)
	slot0.greetingList_ = {}
end

function slot0.InitData(slot0, slot1)
	slot3 = #slot1.admiited_reward

	if slot1.progress > #ActivitySpringFestivalGreetingCfg.get_id_list_by_activity_id[slot1.activity_id] then
		slot2 = #slot4
	end

	slot0.greetingList_[slot1.activity_id] = {
		unlockCnt = slot2,
		receiveCnt = slot3
	}

	if slot3 < slot2 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_GREETING, slot1.activity_id), 1)
	end

	manager.notify:Invoke(SPRING_FESTIVAL_GREETING_UPDATE)
end

function slot0.GetUnlockCnt(slot0, slot1)
	if slot0.greetingList_[slot1] == nil then
		slot0:CreateData(slot1)
	end

	return slot0.greetingList_[slot1].unlockCnt
end

function slot0.GetReceiveCnt(slot0, slot1)
	if slot0.greetingList_[slot1] == nil then
		slot0:CreateData(slot1)
	end

	return slot0.greetingList_[slot1].receiveCnt
end

function slot0.CreateData(slot0, slot1)
	slot0.greetingList_[slot1] = {
		receiveCnt = 0,
		unlockCnt = 1
	}
end

function slot0.ReceiveReward(slot0, slot1)
	slot0.greetingList_[slot1].receiveCnt = slot0.greetingList_[slot1].receiveCnt + 1

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_GREETING, slot1), 0)
end

return slot0
