slot0 = singletonClass("TowerGameData")

function slot0.Init(slot0)
	slot0.levelinfo_ = {}
	slot0.curLevel_ = 1
	slot0.passMaxLevel_ = 0
	slot0.planeStatus_ = {}
	slot0.curpoint_ = 0
	slot0.isDirty_ = true
	slot0.APlaneCfg_ = {}
	slot0.BPlaneCfg_ = {}

	for slot4, slot5 in pairs(TowerGamePlaneCfg) do
		if slot5.type and slot5.type == 0 then
			table.insert(slot0.APlaneCfg_, slot5)
		elseif slot5.type and slot5.type == 1 then
			table.insert(slot0.BPlaneCfg_, slot5)
		end
	end

	table.sort(slot0.APlaneCfg_, function (slot0, slot1)
		return slot0.id < slot1.id
	end)
	table.sort(slot0.BPlaneCfg_, function (slot0, slot1)
		return slot0.id < slot1.id
	end)
	slot0:InitRedPoint()
end

function slot0.InitRedPoint(slot0)
	slot1 = {}
	slot2 = {}

	for slot6, slot7 in pairs(TowerGameCfg.all) do
		slot11 = string.format

		table.insert(slot1, slot11("%s_%s", RedPointConst.MARDUK_TOWERGAME_NOT_FIGHT, slot7))

		for slot11, slot12 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot7]) do
			table.insert(slot2, string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_REWARD, slot12))
		end
	end

	slot3 = string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME, ActivityConst.FACTORY_TOWERGAME)

	manager.redPoint:addGroup(slot3, slot1)
	manager.redPoint:addGroup(RedPointConst.MARDUK_TOWERGAME_REWARD, slot2)
	manager.redPoint:addGroup(slot3, {
		RedPointConst.MARDUK_TOWERGAME_REWARD
	})
end

function slot0.SetData(slot0, slot1)
	slot5 = slot1.clear_state
	slot0.levelinfo_[slot1.activity_id] = {
		isclick = false,
		point = slot1.activity_point,
		rewards = {},
		statu = slot5
	}

	for slot5, slot6 in ipairs(slot1.reward_info) do
		slot0.levelinfo_[slot1.activity_id].rewards[slot6.point_id] = slot6.point_reward_state
	end

	for slot5, slot6 in pairs(slot0.levelinfo_) do
		if slot6.statu == 1 and slot0.passMaxLevel_ < slot5 then
			slot0.passMaxLevel_ = slot5
		end
	end

	slot0:RefreshPlaneStatus()
	slot0:RefreshRewardRedPoint()
	slot0:RefreshBattleRedPoint()
end

function slot0.GetLevelStatuByLevelId(slot0, slot1)
	if ActivityData:GetActivityIsOpen(slot1) then
		if slot0.levelinfo_[slot1] and slot0.levelinfo_[slot1].statu == 1 then
			return "finish"
		else
			return "normal"
		end
	else
		return "lock"
	end
end

function slot0.GetLevelIsShowPointByLevelID(slot0, slot1)
	if ActivityData:GetActivityIsOpen(slot1) then
		if slot0.levelinfo_[slot1] and slot0.levelinfo_[slot1].statu == 1 then
			return "true", slot0.levelinfo_[slot1].point
		else
			return "false", 0
		end
	else
		return "false", 0
	end
end

function slot0.GetRewardStatuByLevelIDAndPointId(slot0, slot1, slot2)
	if slot0.levelinfo_[slot1] and slot0.levelinfo_[slot1].rewards and slot0.levelinfo_[slot1].rewards[slot2] and slot0.levelinfo_[slot1].rewards[slot2] == 2 then
		return "finished"
	elseif slot0.levelinfo_[slot1] and ActivityPointRewardCfg[slot2].need <= slot0.levelinfo_[slot1].point then
		return "normal"
	else
		return "unfinished"
	end
end

function slot0.GetReward(slot0, slot1)
	slot0.levelinfo_[ActivityPointRewardCfg[slot1].activity_id].rewards[slot1] = 2

	slot0:RefreshRewardRedPoint()
end

function slot0.SetSeverPoint(slot0, slot1)
	slot0.curpoint_ = slot1
end

function slot0.GetCurPoint(slot0)
	return slot0.curpoint_
end

function slot0.SetLevel(slot0, slot1)
	slot0.curLevel_ = slot1
end

function slot0.GetRewardsNum(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.levelinfo_) do
		if slot6.rewards then
			for slot10, slot11 in pairs(slot6.rewards) do
				if slot11 == 2 then
					slot1 = slot1 + 1
				end
			end
		end
	end

	return slot1
end

function slot0.GetAllRewardNum(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(TowerGameCfg.all) do
		slot1 = slot1 + #ActivityPointRewardCfg.get_id_list_by_activity_id[slot6]
	end

	return slot1
end

function slot0.GetATypePlaneNum(slot0)
	return #slot0.APlaneCfg_
end

function slot0.GetBTypePlaneNum(slot0)
	return #slot0.BPlaneCfg_
end

function slot0.GetPlaneCfgByTypeAndIndex(slot0, slot1, slot2)
	if slot1 == 0 then
		return slot0.APlaneCfg_[slot2]
	else
		return slot0.BPlaneCfg_[slot2]
	end
end

function slot0.GetPointByLevelID(slot0, slot1)
	if slot0.levelinfo_[slot1] and slot0.levelinfo_[slot1].point then
		return slot0.levelinfo_[slot1].point
	end
end

function slot0.RefreshPlaneStatus(slot0)
	for slot4, slot5 in ipairs(TowerGamePlaneCfg.all) do
		if TowerGamePlaneCfg[slot5].condition <= slot0.passMaxLevel_ then
			slot0.planeStatus_[slot5] = true
		else
			slot0.planeStatus_[slot5] = false
		end
	end
end

function slot0.GetCanUsePlane(slot0)
	slot0:RefreshPlaneStatus()

	slot1 = {}

	for slot5, slot6 in pairs(slot0.planeStatus_) do
		if slot6 then
			table.insert(slot1, slot5)
		end
	end

	table.sort(slot1, function (slot0, slot1)
		return slot0 < slot1
	end)

	return slot1
end

function slot0.GetPlaneIsUnlock(slot0, slot1)
	return slot0.planeStatus_[slot1]
end

function slot0.SetLevleClick(slot0, slot1)
	slot0.levelinfo_[slot1].isclick = true

	slot0:RefreshBattleRedPoint()
end

function slot0.RefreshRewardRedPoint(slot0)
	for slot4, slot5 in pairs(slot0.levelinfo_) do
		for slot9, slot10 in pairs(slot5.rewards) do
			if slot10 == 1 then
				if ActivityPointRewardCfg[slot9].need < slot5.point then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_REWARD, slot9), 1)
				else
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_REWARD, slot9), 0)
				end
			elseif slot10 == 2 then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_REWARD, slot9), 0)
			end
		end
	end
end

function slot0.RefreshBattleRedPoint(slot0)
	for slot4, slot5 in pairs(slot0.levelinfo_) do
		if slot5.statu == 1 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_NOT_FIGHT, slot4), 0)
		elseif slot5.statu == 0 then
			if slot5.isclick == false then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_NOT_FIGHT, slot4), 1)
			else
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_NOT_FIGHT, slot4), 0)
			end
		end
	end
end

function slot0.GetFirstCanGetRewardIndex(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.levelinfo_) do
		for slot10, slot11 in pairs(slot6.rewards) do
			if slot11 == 1 and ActivityPointRewardCfg[slot10].need <= slot6.point then
				if slot1 == 0 then
					slot1 = slot5
				elseif slot5 < slot1 then
					slot1 = slot5
				end
			end
		end
	end

	if slot1 > 0 then
		return table.indexof(TowerGameCfg.all, slot1)
	else
		return 1
	end
end

return slot0
