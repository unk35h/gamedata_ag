slot0 = singletonClass("MoonBoData")

function slot0.Init(slot0)
	slot0.todayGetCount_ = 0
	slot0.showRewards_ = {}
	slot0.curDices_ = {}
	slot0.curLevel_ = 0
	slot0.curReward_ = {}
	slot0.canGetCount_ = 0
	slot0.levelNum_ = #MoonBoCfg.all
	slot0.isShowReward_ = false
	slot0.isShowText_ = false
	slot0.rewards_ = {}
	slot0.rewardsCount_ = {}
	slot0.isOpenActivity_ = false
	slot5 = GameSetting.refresh_time1.value[1][1]
	slot6 = 0
	slot0.freshTime_ = TimeMgr.GetInstance():GetNextTime(slot5, slot6, 0)

	for slot5, slot6 in ipairs(MoonBoCfg.all) do
		slot0.rewards_[slot6] = {}
		slot0.rewardsCount_[slot6] = {}
		slot7 = 1

		for slot11, slot12 in pairs(MoonBoCfg[slot6].reward) do
			if slot0.rewards_[slot6][slot7 - 1] and slot12[1] ~= slot0.rewards_[slot6][slot7 - 1][1] then
				slot0.rewards_[slot6][slot7] = slot12
				slot7 = slot7 + 1
			end

			if slot0.rewards_[slot6][slot7 - 1] == nil then
				slot0.rewards_[slot6][slot7] = slot12
				slot7 = slot7 + 1
			end

			if slot0.rewardsCount_[slot6][slot12[1]] then
				slot0.rewardsCount_[slot6][slot12[1]] = slot0.rewardsCount_[slot6][slot12[1]] + 1
			else
				slot0.rewardsCount_[slot6][slot12[1]] = 1
			end
		end
	end
end

function slot0.SetData(slot0, slot1)
	if slot1.activity_id == ActivityConst.MOONBO then
		slot0.todayTime_ = manager.time:GetServerTime()
		slot0.todayGetCount_ = slot1.today_draw_times

		slot0:FreshCanGetCount()

		for slot5, slot6 in ipairs(slot1.unclaimed_reward) do
			slot0.showRewards_[slot6.level] = {}

			for slot10, slot11 in ipairs(slot6.unclaimed_item) do
				if slot0.showRewards_[slot6.level][slot11.id] ~= nil then
					slot0.showRewards_[slot6.level][slot11.id].count = slot0.showRewards_[slot6.level][slot11.id].count + 1
				else
					slot0.showRewards_[slot6.level][slot11.id] = {
						count = 1,
						id = slot11.id,
						num = slot11.num
					}
				end
			end
		end
	end
end

function slot0.GetRewards(slot0, slot1)
	if slot1 then
		for slot5, slot6 in ipairs(slot1.dice_list) do
			slot0.curDices_[slot5] = slot6
		end

		if slot1.level then
			slot0.curLevel_ = slot1.level
		end

		if slot1.reward then
			slot0.curReward_ = {
				{
					slot1.reward.id,
					slot1.reward.num
				}
			}

			if slot0.showRewards_[slot0.curLevel_] and slot0.showRewards_[slot0.curLevel_][slot1.reward.id] and slot0.showRewards_[slot0.curLevel_][slot1.reward.id].count > 0 then
				slot0.showRewards_[slot0.curLevel_][slot1.reward.id].count = slot0.showRewards_[slot0.curLevel_][slot1.reward.id].count - 1
				slot0.isShowText_ = false
			else
				slot0.isShowText_ = true
			end
		end

		slot0.todayGetCount_ = slot0.todayGetCount_ + 1

		slot0:FreshCanGetCount()
	end
end

function slot0.GetCurDices(slot0)
	return slot0.curDices_
end

function slot0.GetCurReward(slot0)
	return slot0.curReward_
end

function slot0.GetCanGetCount(slot0)
	slot0:FreshCanGetCount()

	return slot0.canGetCount_
end

function slot0.SubTodayGetCount(slot0, slot1)
	slot0.todayGetCount_ = slot0.todayGetCount_ + slot1

	slot0:FreshCanGetCount()
end

function slot0.FreshCanGetCount(slot0)
	slot0.isOpenActivity_ = ActivityData:GetActivityIsOpen(ActivityConst.MOONBO)

	if slot0.isOpenActivity_ then
		slot1 = 0

		for slot5, slot6 in ipairs(GameSetting.activity_mooncake_gambling_num_get.value) do
			if slot6 <= ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT) then
				slot1 = slot5
			else
				break
			end
		end

		slot0.canGetCount_ = slot1 - slot0.todayGetCount_
	else
		slot0.canGetCount_ = 0

		manager.notify:Invoke(ACTIVITY_MOONBO_NEWDAY)
	end

	if slot0.canGetCount_ > 0 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.MOONBO), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.MOONBO), 0)
	end
end

function slot0.FreshTime(slot0)
	slot0:FreshCanGetCount()

	if slot0.freshTime_ ~= TimeMgr.GetInstance():GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0) then
		slot0.freshTime_ = slot2

		slot0:PassDayClear()
	end
end

function slot0.PassDayClear(slot0)
	slot0.todayGetCount_ = 0

	slot0:FreshCanGetCount()
	manager.notify:Invoke(ACTIVITY_MOONBO_NEWDAY)
end

function slot0.GetRewardIsShow(slot0, slot1, slot2)
	if slot0.showRewards_[slot1] and slot0.showRewards_[slot1][slot2] and slot0.showRewards_[slot1][slot2].count > 0 then
		return true
	end

	return false
end

function slot0.LevelNumToLanguage(slot0, slot1)
	slot2, slot3 = GetTips("ACTIVITY_MOONCAKE_GAMBLING_NUM_ZERO")

	return GetTips(slot3 + slot1)
end

function slot0.GetCurLevel(slot0)
	return slot0.curLevel_
end

function slot0.SetIsShowReward(slot0, slot1)
	slot0.isShowReward_ = slot1
end

function slot0.GetIsShowReward(slot0)
	return slot0.isShowReward_
end

function slot0.GetIsShowText(slot0)
	return slot0.isShowText_
end

function slot0.GetCfgRewards(slot0, slot1)
	return slot0.rewards_[slot1]
end

function slot0.GetCfgRewardsCount(slot0, slot1, slot2)
	return slot0.rewardsCount_[slot1][slot2]
end

function slot0.GetCurCanGetRewardCount(slot0, slot1, slot2)
	if slot0.showRewards_[slot1] and slot0.showRewards_[slot1][slot2] and slot0.showRewards_[slot1][slot2].count then
		return slot0.showRewards_[slot1][slot2].count
	end

	return 0
end

return slot0
