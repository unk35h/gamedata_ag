ActivityRaceRankStruct = class("ActivityRaceRankStruct")

function ActivityRaceRankStruct.Ctor(slot0, slot1, slot2)
	slot0.score = slot1.score
	slot0.difficulty = slot1.difficulty
	slot0.rank = slot1.rank
	slot0.timestamp = slot1.timestamp

	if slot2 == true then
		slot3 = PlayerData:GetPlayerInfo()
		slot0.user_id = slot3.userID
		slot0.nick = slot3.nick
		slot0.icon = slot3.portrait
		slot0.icon_frame = slot3.icon_frame
	else
		slot0.user_id = slot1.user_id
		slot0.nick = slot1.nick
		slot0.icon = slot1.portrait
		slot0.icon_frame = slot1.frame
	end

	slot0.select_hero_id_list = {}
	slot3 = slot1.team_info and slot1.team_info[1] and slot1.team_info[1].hero_info_list or {}

	for slot7, slot8 in ipairs(slot3) do
		table.insert(slot0.select_hero_id_list, {
			id = slot8.hero_id,
			skin_id = slot8.skin_id
		})
	end
end

slot0 = singletonClass("ActivityRaceData")
slot1 = {}
slot2 = {}

function slot0.Init(slot0)
	slot0.affixList_ = {}
	slot0.activityStateList_ = {}
	slot0.receivedTaskList_ = {}
	uv0 = {}
	uv1 = {}
end

function slot0.SetData(slot0, slot1)
	if slot1.info ~= nil then
		slot2 = slot1.activity_id
		slot0.activityStateList_[slot2] = {
			unlockStageList = {}
		}

		for slot7, slot8 in ipairs(slot1.info.chapter_progress) do
			slot0.activityStateList_[slot2].unlockStageList[slot8] = true
		end

		slot0.activityStateList_[slot2].completedStageList = {}

		for slot7, slot8 in ipairs(slot3.clear_progress) do
			slot0.activityStateList_[slot2].completedStageList[slot8] = true
		end

		slot0.activityStateList_[slot2].score = slot3.boss_challenge_score
		slot7 = slot3.total_score
		slot0.activityStateList_[slot2].accumulativeScore = tonumber(slot7)
		slot0.receivedTaskList_[slot2] = {}

		for slot7, slot8 in ipairs(slot3.admitted_award_list) do
			slot0.receivedTaskList_[slot2][slot8] = true
		end

		slot7 = slot2

		slot0:RefreshUnReceiveCount(slot7)

		slot0.affixList_[slot2] = {}

		for slot7, slot8 in ipairs(slot3.affix_list) do
			slot0.affixList_[slot2][ActivityAffixPoolCfg[slot8].affix[1]] = slot8
		end

		slot0:RefreshCompleteRedPoint(slot2)
		slot0:RefreshRewardRedPoint(slot2)
	end

	if ActivityTools.GetActivityType(slot1.activity_id) == ActivityTemplateConst.ACTIVITY_RACE_RANK then
		uv0[slot1.activity_id] = {
			rank_version = 0,
			rankID = slot1.activity_id,
			rankList = {}
		}
		uv1[slot1.activity_id] = {
			rankID = slot1.activity_id,
			rankList = {}
		}
	end
end

function slot0.SetCompleteStage(slot0, slot1, slot2)
	slot3 = ActivityRaceCfg[slot1].stage_list
	slot0.activityStateList_[slot1].completedStageList[slot2] = true

	if table.keyof(slot3, slot2) + 1 <= #slot3 then
		slot0.activityStateList_[slot1].unlockStageList[slot3[slot5]] = true
	end

	slot0:RefreshUnReceiveCount(slot1)
	slot0:RefreshRewardRedPoint(slot1)
end

function slot0.RefreshUnReceiveCount(slot0, slot1)
	slot3 = slot0.activityStateList_[slot1].accumulativeScore
	slot4 = ActivityRaceCfg[slot1].task_list
	slot5 = slot0.activityStateList_[slot1].score
	slot6 = 0

	for slot10, slot11 in ipairs(ActivityRaceCfg[slot1].task_list_id) do
		if ActivityPointRewardCfg[slot11].need <= slot3 and slot0.receivedTaskList_[slot1][slot11] == nil then
			slot6 = slot6 + 1
		end
	end

	for slot10, slot11 in ipairs(slot4) do
		if ActivityPointRewardCfg[slot11].need <= slot5 and slot0.receivedTaskList_[slot1][slot11] == nil then
			slot6 = slot6 + 1
		end
	end

	slot0.activityStateList_[slot1].unreceiveCount = slot6
end

function slot0.GetSortedRewardList(slot0, slot1)
	if ActivityRaceCfg.get_id_list_by_main_activity_id[slot1] == nil then
		slot2 = {
			slot1
		}
	end

	slot3 = {}
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(slot2) do
		if slot0.activityStateList_[slot10] == nil or slot11.unreceiveCount == 0 then
			slot4[#slot4 + 1] = slot10
		else
			slot5[#slot5 + 1] = slot10
		end
	end

	table.insertto(slot3, slot5)
	table.insertto(slot3, slot4)

	return slot3
end

function slot0.SetReceivedTaskList(slot0, slot1, slot2)
	slot0.receivedTaskList_[slot1][slot2] = true
	slot0.activityStateList_[slot1].unreceiveCount = slot0.activityStateList_[slot1].unreceiveCount - 1

	slot0:RefreshRewardRedPoint(slot1)
end

function slot0.GetReceivedTaskList(slot0, slot1)
	return slot0.receivedTaskList_[slot1] or {}
end

function slot0.GetTotalScore(slot0, slot1)
	slot3 = 0
	slot4 = nil

	for slot8, slot9 in ipairs(ActivityRaceCfg.get_id_list_by_main_activity_id[slot1]) do
		slot3 = slot3 + (slot0.activityStateList_[slot9] and slot0.activityStateList_[slot9].score or 0)
	end

	return slot3
end

function slot0.SetScore(slot0, slot1, slot2)
	if slot2 and slot0.activityStateList_[slot1].score < slot2 then
		slot0.activityStateList_[slot1].score = slot2

		slot0:RefreshUnReceiveCount(slot1)
	end

	for slot7, slot8 in ipairs(ActivityRaceCfg[slot1].task_list_id) do
		if slot0.activityStateList_[slot1].accumulativeScore < ActivityPointRewardCfg[slot8].need then
			slot0.activityStateList_[slot1].accumulativeScore = slot0.activityStateList_[slot1].accumulativeScore + slot2

			return
		end
	end
end

function slot0.GetStateList(slot0)
	return slot0.activityStateList_
end

function slot0.GetUnlockAffixList(slot0, slot1)
	return slot0.affixList_[slot1] or {}
end

function slot0.SetDropAffixes(slot0, slot1)
	slot0.dropAffixList_ = {}

	for slot5, slot6 in ipairs(slot1.affix_list) do
		slot7 = ActivityAffixPoolCfg[slot6].affix[1]
		slot0.dropAffixList_[#slot0.dropAffixList_ + 1] = slot7

		if slot0.affixList_[slot0.tempActivityID_][slot7] == nil then
			slot0.affixList_[slot0.tempActivityID_][slot7] = slot6
		else
			slot8 = ActivityRaceAffixLevelUpCfg[slot6].affix_list

			if table.keyof(slot8, slot0.affixList_[slot0.tempActivityID_][slot7]) + 1 <= #slot8 then
				slot0.affixList_[slot0.tempActivityID_][slot7] = slot8[slot11]
			end
		end
	end
end

function slot0.SetTempActivityID(slot0, slot1)
	slot0.tempActivityID_ = slot1
end

function slot0.GetDropAffixes(slot0)
	slot1 = nil

	if slot0.dropAffixList_ ~= nil then
		slot1 = deepClone(slot0.dropAffixList_)
		slot0.dropAffixList_ = nil
	end

	return slot1
end

function slot0.SetSelectActivityID(slot0, slot1)
	slot2 = ActivityRaceCfg[slot1].main_activity_id

	if slot0.activityStateList_[slot1].unreceiveCount <= 0 then
		manager.redPoint:setTip(string.format("%s_%s_%s_complete", RedPointConst.ACTIVITY_RACE, slot2, slot1), 0)
	end
end

function slot0.RefreshCompleteRedPoint(slot0, slot1)
	slot2 = ActivityRaceCfg[slot1].main_activity_id

	if ActivityData:GetActivityIsOpen(slot1) and slot0.activityStateList_[slot1].score <= 0 then
		manager.redPoint:setTip(string.format("%s_%s_%s_complete", RedPointConst.ACTIVITY_RACE, slot2, slot1), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s_%s_complete", RedPointConst.ACTIVITY_RACE, slot2, slot1), 0)
	end
end

function slot0.RefreshRewardRedPoint(slot0, slot1)
	slot2 = ActivityRaceCfg[slot1].main_activity_id

	if slot0.activityStateList_[slot1].unreceiveCount > 0 then
		manager.redPoint:setTip(string.format("%s_%s_%s_reward", RedPointConst.ACTIVITY_RACE, slot2, slot1), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s_%s_reward", RedPointConst.ACTIVITY_RACE, slot2, slot1), 0)
	end
end

function slot0.SetRankData(slot0, slot1, slot2)
	slot3 = {}
	slot4 = ipairs
	slot6 = slot2.rank_list or {}

	for slot7, slot8 in slot4(slot6) do
		table.insert(slot3, ActivityRaceRankStruct.New(slot8))
	end

	uv0[slot1] = {
		rankList = slot3
	}

	table.sort(uv0[slot1].rankList, function (slot0, slot1)
		return slot0.rank < slot1.rank
	end)

	uv0[slot1].curRank = ActivityRaceRankStruct.New(slot2.my_rank, true)
	uv0[slot1].total_people = slot2.total
	uv0[slot1].rank_version = slot2.version
end

function slot0.SetGuildRankData(slot0, slot1, slot2)
	GuildAction.RequiredGuildMemberList(function ()
		slot0 = {}
		slot1 = ipairs
		slot3 = uv0.rank_list or {}

		for slot4, slot5 in slot1(slot3) do
			table.insert(slot0, ActivityRaceRankStruct.New(slot5))
		end

		uv1[uv2] = {
			rankList = slot0
		}

		table.sort(uv1[uv2].rankList, function (slot0, slot1)
			if slot0.score == slot1.score then
				if slot0.timestamp == slot1.timestamp then
					return slot1.user_id < slot0.user_id
				else
					return slot0.timestamp < slot1.timestamp
				end
			else
				return slot1.score < slot0.score
			end
		end)

		slot2 = PlayerData:GetPlayerInfo().userID
		slot6 = uv2

		for slot6, slot7 in ipairs(uv1[slot6].rankList) do
			slot7.rank = slot6
			slot8 = GuildData:GetGuildMemberData(slot7.user_id)
			slot7.nick = slot8.name
			slot7.icon = slot8.icon
			slot7.icon_frame = slot8.frame

			if tonumber(slot7.user_id) == slot2 then
				uv1[uv2].curRank = slot7
			end
		end

		if uv1[uv2].curRank == nil then
			uv1[uv2].curRank = ActivityRaceRankStruct.New({
				score = 0,
				rank = 0,
				difficulty = 0
			}, true)
		end
	end)
end

function slot0.GetCurRank(slot0, slot1)
	return uv0[slot1].curRank
end

function slot0.GetScore(slot0, slot1)
	return uv0[slot1].curRank.score
end

function slot0.GetTotalPeople(slot0, slot1)
	return uv0[slot1].total_people
end

function slot0.GetRankVersion(slot0, slot1)
	if uv0[slot1] ~= nil then
		return uv0[slot1].rank_version
	end

	return 0
end

function slot0.GetRankList(slot0, slot1)
	return uv0[slot1].rankList or {}
end

function slot0.IsRankOpen(slot0, slot1)
	if not uv0[slot1] or not uv0[slot1].rankList then
		return false
	else
		return true
	end
end

function slot0.GetGuildRankList(slot0, slot1)
	return uv0[slot1].rankList or {}
end

function slot0.GetGuildCurRank(slot0, slot1)
	return uv0[slot1].curRank
end

return slot0
