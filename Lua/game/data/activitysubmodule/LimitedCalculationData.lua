RankStruct = class("RankStruct")

function RankStruct.Ctor(slot0, slot1)
	slot0.user_id = slot1.user_id
	slot0.score = slot1.score
	slot0.difficulty = slot1.difficulty
	slot0.rank = slot1.rank
	slot0.timestamp = slot1.timestamp

	if PlayerData:GetPlayerInfo() and tonumber(slot0.user_id) == slot2.userID then
		slot0.nick = slot2.nick
		slot0.icon = slot2.portrait
		slot0.icon_frame = slot2.icon_frame
	else
		slot0.nick = slot1.nick
		slot0.icon = slot1.portrait
		slot0.icon_frame = slot1.frame
	end

	slot0.select_hero_id_list = {}
	slot3 = slot1.team_info[1] and slot1.team_info[1].hero_info_list or {}

	for slot7, slot8 in ipairs(slot3) do
		table.insert(slot0.select_hero_id_list, {
			id = slot8.hero_id,
			skin_id = slot8.skin_id
		})
	end
end

slot0 = singletonClass("LimitedCalculationData")
slot1 = {}
slot2 = {}
slot3 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
end

function slot0.SetData(slot0, slot1)
	if not uv0[slot1.activity_id] then
		uv0[slot1.activity_id] = {
			isNeed = true,
			score = 0,
			activityID = slot1.activity_id,
			lastDifficulty = getData("LimitedCalculation", "lastDifficulty" .. slot1.activity_id) or 1
		}
	end

	uv0[slot1.activity_id].clearActivityList = {}
	slot2 = ipairs
	slot4 = slot1.clear_list or {}

	for slot5, slot6 in slot2(slot4) do
		table.insert(uv0[slot1.activity_id].clearActivityList, slot6)
	end

	uv0[slot1.activity_id].score = math.max(uv0[slot1.activity_id].score, slot1.high_score)
	slot2 = {}
	slot6 = slot1.activity_id

	for slot6, slot7 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot6]) do
		slot2[slot7] = {
			complete_flag = 0,
			id = slot7
		}
	end

	for slot6, slot7 in ipairs(slot1.got_reward_list) do
		if slot2[slot7] then
			slot2[slot7].complete_flag = 1
		end
	end

	uv0[slot1.activity_id].rewards = slot2
	uv0[slot1.activity_id].difficultyList = {}
	uv1[slot1.activity_id] = {}

	if ActivityData:GetActivityData(slot1.activity_id) then
		slot4 = ipairs
		slot6 = slot3.subActivityIdList or {}

		for slot7, slot8 in slot4(slot6) do
			if ActivityTemplateConst.LIMITED_DIFFICULTY == ActivityTools.GetActivityType(slot8) then
				table.insert(uv0[slot1.activity_id].difficultyList, slot8)
			elseif ActivityTemplateConst.LIMITED_RANK == slot9 then
				uv1[slot1.activity_id] = {
					rank_version = 0,
					activityID = slot1.activity_id,
					rankID = slot8,
					rankList = {}
				}
				uv2[slot1.activity_id] = {
					activityID = slot1.activity_id,
					rankID = slot8,
					rankList = {}
				}
			end
		end
	end
end

function slot0.SetRankData(slot0, slot1, slot2)
	slot3 = {}
	slot4 = ipairs
	slot6 = slot2.rank_list or {}

	for slot7, slot8 in slot4(slot6) do
		table.insert(slot3, RankStruct.New(slot8))
	end

	uv0[slot1].rankList = slot3
	uv0[slot1].curRank = RankStruct.New(slot2.my_rank)
	uv0[slot1].total_people = slot2.total
	uv0[slot1].rank_version = slot2.version
end

function slot0.SetGuildRankData(slot0, slot1, slot2)
	GuildAction.RequiredGuildMemberList(function ()
		slot0 = {}
		slot1 = ipairs
		slot3 = uv0.rank_list or {}

		for slot4, slot5 in slot1(slot3) do
			table.insert(slot0, RankStruct.New(slot5))
		end

		uv1[uv2].rankList = slot0

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
		uv1[uv2].curRank = nil
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
	end)
end

function slot0.GetCurDifficulty(slot0, slot1)
	if uv0[slot1] == nil then
		print("activity data is null", slot1, debug.traceback())

		return 1
	end

	if (uv0[slot1].lastDifficulty or {}) == 1 then
		uv0[slot1].lastDifficulty = uv0[slot1].difficultyList[1]

		return uv0[slot1].difficultyList[1]
	else
		return slot2
	end
end

function slot0.SetCurDifficulty(slot0, slot1, slot2)
	uv0[slot1].lastDifficulty = slot2

	saveData("LimitedCalculation", "lastDifficulty" .. slot1, slot2)
	manager.notify:CallUpdateFunc(LIMITED_DIFFICULTY_CHANGE)
end

function slot0.GetDifficultyList(slot0, slot1)
	return uv0[slot1].difficultyList
end

function slot0.IsClearActivity(slot0, slot1, slot2)
	return table.keyof(uv0[slot1].clearActivityList, slot2)
end

function slot0.GetCurRank(slot0, slot1)
	return uv0[slot1].curRank
end

function slot0.GetScore(slot0, slot1)
	return uv0[slot1].score
end

function slot0.GetTotalPeople(slot0, slot1)
	return uv0[slot1].total_people
end

function slot0.GetRewardList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot1]) do
		table.insert(slot2, uv0[slot1].rewards[slot7])
	end

	return slot2
end

function slot0.SetRewardState(slot0, slot1, slot2)
	uv0[slot1].rewards[slot2].complete_flag = ActivityConst.LIMITED_CALCULATION_REWARD_STATE.REWARDED
end

function slot0.GetRankVersion(slot0, slot1)
	return uv0[slot1].rank_version
end

function slot0.GetRankList(slot0, slot1)
	return uv0[slot1].rankList or {}
end

function slot0.GetRankID(slot0, slot1)
	return uv0[slot1].rankID
end

function slot0.GetIsNeed(slot0, slot1)
	return uv0[slot1].isNeed
end

function slot0.SetIsNeed(slot0, slot1, slot2)
	if uv0[slot1].isNeed and slot2 == false then
		manager.redPoint:setTip(RedPointConst.LIMITED_CALCULATION_OPEN .. slot1, 0)
	end

	uv0[slot1].isNeed = slot2
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
