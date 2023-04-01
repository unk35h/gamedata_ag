require("game.data.MythicDataTemplate")

slot0 = singletonClass("MythicData")
slot1 = false
slot2 = 0
slot3 = {}
slot4 = {}
slot5 = {}
slot6 = 0
slot7 = 1001
slot8 = {}
slot9 = {}
slot10 = 0
slot11 = {}
slot12 = {}
slot13 = {}
slot14 = false
slot15 = {}
slot16 = 1
slot17 = {}
slot18 = {}
slot19 = 0
slot20 = false
slot21 = 1
slot22 = 0
slot23 = {}
slot24 = 0
slot25 = {}
slot26 = {}
slot27 = {
	CHIP = 2,
	HERO = 1,
	COMBO = 3
}
slot28 = 0
slot29 = {}
slot30 = nil
slot31 = 0
slot32 = {}
slot33 = nil

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = {}
	uv4 = {}
	uv5 = 0
	uv6 = {}
	uv7 = {}
	uv8 = {}
	uv9 = false
	uv10 = false
	uv11 = {}
	uv12 = 1
	uv13 = 1
	uv14 = {}
	uv15 = {}
	uv16 = 0
	slot0.teamData_ = {}
	uv17 = 0
	uv18 = {}
	uv19 = nil
	uv20 = 0
end

function slot0.InitMythicData(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.difficulty_list) do
		slot7 = {
			difficulty = slot6.difficulty,
			main_partition = MythicDifficultyTemplate.New(slot6.main_partition),
			sub_partition_list = {}
		}

		for slot12, slot13 in ipairs(slot6.sub_partition_list) do
			table.insert(slot7.sub_partition_list, MythicDifficultyTemplate.New(slot13))
		end

		uv0[slot8] = slot7
	end

	uv1 = {}

	for slot5, slot6 in ipairs(slot1.superiority_affix_list) do
		table.insert(uv1, {
			slot6.id,
			slot6.level,
			slot6.type
		})
	end

	uv2 = {}

	for slot5, slot6 in ipairs(slot1.inferiority_affix_list) do
		table.insert(uv2, {
			slot6.id,
			slot6.level,
			slot6.type
		})
	end

	if slot1.next_refresh_timestamp ~= uv3 then
		uv4 = true
	end

	uv3 = slot1.next_refresh_timestamp
end

function slot0.InitFinalMythicData(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.stage_list) do
		uv0[slot6.difficulty_id] = {}

		for slot10, slot11 in ipairs(slot6.stage_id) do
			table.insert(uv0[slot6.difficulty_id], slot11)
		end
	end
end

function slot0.InitFinalMythicUserData(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.difficulty_id_can_choose) do
		if uv1 < slot6 then
			uv1 = slot6
		end

		table.insert(uv0, slot6)
	end

	uv2 = slot1.now_difficulty
	uv3 = {}

	for slot5, slot6 in ipairs(slot1.receive_reward) do
		table.insert(uv3, slot6)
	end

	uv4 = 0
	uv5 = {}

	for slot5, slot6 in ipairs(slot1.clear_list) do
		if uv4 < slot6 then
			uv4 = slot6
		end

		table.insert(uv5, slot6)
	end

	uv6 = slot1.is_new_difficulty
	uv7 = 0
	uv8 = {}

	if slot1.challenge_info[1] then
		for slot5, slot6 in ipairs(slot1.challenge_info) do
			uv8[slot6.team_id] = {
				team_id = slot6.team_id,
				clear_state = slot6.clear_state,
				use_time = slot6.use_time
			}

			if uv7 == 0 and slot6.clear_state == 0 then
				uv7 = slot6.team_id
			end
		end
	else
		uv7 = 1
	end
end

function slot0.InitMythicUserPublicData(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.open_difficulty_list) do
		table.insert(uv0, slot6)
	end

	uv1 = slot1.difficulty
	uv2 = slot1.is_new_difficulty
end

function slot0.InitMythicUserData(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.clear_partition_id_list) do
		table.insert(uv0, slot6)
	end

	uv1 = {}

	for slot5, slot6 in ipairs(slot1.main_partition_star_list) do
		table.insert(uv1, slot6)
	end

	uv2 = {}

	for slot5, slot6 in ipairs(slot1.star_reward_provide_list) do
		table.insert(uv2, slot6)
	end
end

function slot0.GetHeroAffix(slot0)
	slot1 = {}

	if uv0 ~= 0 then
		slot2 = MythicCfg[uv0] and MythicCfg[uv0].sub_partition_list or {}

		for slot6, slot7 in ipairs(slot2) do
			if table.indexof(uv1, slot7) and uv2[slot6] then
				table.insert(slot1, uv2[slot6])
			end
		end
	end

	return slot1
end

function slot0.GetAllHeroAffix(slot0)
	return uv0
end

function slot0.GetMonsterAffix(slot0)
	return uv0 or {}
end

function slot0.GetDifficulty(slot0)
	return uv0 or 1
end

function slot0.SetDifficulty(slot0, slot1)
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = slot1
end

function slot0.GetIsOpenDifficulty(slot0, slot1)
	return table.indexof(uv0, slot1)
end

function slot0.GetNextRefreshTime(slot0)
	return uv0
end

function slot0.GetDifficultyData(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetIsOver(slot0)
	if uv0 == 0 then
		return false
	end

	return not not uv1[uv1[uv0] and slot1.main_partition.partition or -1]
end

function slot0.GetIsFirstClear(slot0, slot1)
	return not table.indexof(uv0, slot1)
end

function slot0.UpdatePartitionState(slot0, slot1)
	if not table.indexof(uv0, slot1) then
		table.insert(uv0, slot1)
	end

	SendMessageManagerToSDK("blackzone_clear", {
		partition = slot1
	})
end

function slot0.GetPartitionCount(slot0)
	return #uv0
end

function slot0.GetStarCount(slot0)
	return #uv0
end

function slot0.GetStarOpen(slot0, slot1)
	for slot5, slot6 in ipairs(uv0) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.UpdateStarIndex(slot0, slot1)
	for slot5, slot6 in ipairs(uv0) do
		if slot6 == slot1 then
			return
		end
	end

	table.insert(uv0, slot1)
end

function slot0.GetStarRewardState(slot0, slot1)
	for slot5, slot6 in ipairs(uv0) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.SetStarRewardState(slot0, slot1)
	table.insert(uv0, slot1)
end

function slot0.GetStarRewardCount(slot0)
	return table.length(uv0)
end

function slot0.GetAttributeFactor(slot0, slot1)
	if MythicPartitionCfg[slot1].attribute_factor and slot2.attribute_factor[3] then
		return Vector3.New(slot2.attribute_factor[1] / 1000, slot2.attribute_factor[2] / 1000, slot2.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function slot0.GetMonsterLevel(slot0, slot1)
	return MythicPartitionCfg[slot1] and MythicPartitionCfg[slot1].monster_level or 0
end

function slot0.SetIsNewDifficulty(slot0, slot1)
	uv0 = slot1
end

function slot0.GetIsNewDifficulty(slot0)
	return uv0
end

function slot0.SetIsNew(slot0, slot1)
	uv0 = slot1
end

function slot0.GetIsNew(slot0)
	return uv0
end

function slot0.GetMaxDifficulty(slot0)
	slot1 = 1

	for slot5, slot6 in ipairs(uv0) do
		if slot1 < slot6 then
			slot1 = slot6
		end
	end

	return slot1
end

function slot0.IsShowDifficultySelectView(slot0)
	if uv0 == 0 then
		return true
	end

	return false
end

function slot0.IsShowDifficultySelectView_Guide(slot0)
	if uv0 == 0 then
		return true
	end

	return false
end

function slot0.GetFinalId(slot0)
	return uv0
end

function slot0.GetFinalIsReward(slot0)
	return table.length(uv0)
end

function slot0.GetFinalRewardNotGet(slot0)
	for slot4 = 1, uv0 do
		if table.indexof(uv1, slot4) == false then
			return true
		end
	end

	return false
end

function slot0.GetPassHotLevel(slot0)
	return uv0
end

function slot0.GetFinalRewardStateByHotLevel(slot0, slot1)
	return table.keyof(uv0, slot1)
end

function slot0.GetPassHotLevelStatu(slot0)
	return table.length(uv0)
end

function slot0.GetHotLevelIsPass(slot0, slot1)
	return table.indexof(uv0, slot1)
end

function slot0.SetCurHotLevelId(slot0, slot1)
	uv0 = slot1
end

function slot0.GetCurHotLevelId(slot0)
	return uv0
end

function slot0.GetCurLevelIdList(slot0)
	return uv0[uv1]
end

function slot0.CheckCanEnterMutiBattle(slot0, slot1)
	for slot5 = 1, slot1 do
		if #BattleTeamData:GetSingleTeam(BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL, nil, , slot5) == 0 or slot6[1] == 0 then
			return false
		end
	end

	return true
end

function slot0.ReSetTeam(slot0)
	BattleTeamData:ReSetMythicTeamData()
end

function slot0.GetFinalReward(slot0, slot1)
	table.insert(uv0, slot1)

	return MythicFinalCfg[slot1].reward_list
end

function slot0.GetLevelIsOpen(slot0, slot1)
	return table.indexof(uv0, slot1)
end

function slot0.GetAllFinalReward(slot0)
	slot1 = {}

	for slot5 = 1, uv0 do
		if table.indexof(uv1, slot5) == false then
			slot9 = slot5

			table.insert(uv1, slot9)

			for slot9, slot10 in ipairs(MythicFinalCfg[slot5].reward_list) do
				if slot1[slot10[1]] then
					slot1[slot10[1]] = slot1[slot10[1]] + slot10[2]
				else
					slot1[slot10[1]] = slot10[2]
				end
			end
		end
	end

	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		table.insert(slot2, {
			slot6,
			slot7
		})
	end

	return slot2
end

function slot0.GetRemainTime(slot0)
	slot1 = uv0

	for slot5, slot6 in pairs(uv1) do
		if slot6.clear_state == 1 then
			slot1 = slot1 - slot6.use_time
		end
	end

	return slot1
end

function slot0.SetRemainTime(slot0, slot1)
	uv0 = slot1
end

function slot0.GetIsNewHotLevel(slot0)
	return uv0
end

function slot0.SetIsNewHotLevel(slot0, slot1)
	uv0 = slot1
end

function slot0.SubLevel(slot0, slot1)
	slot2 = uv0 + slot1
	slot3 = true

	if slot1 > 0 then
		if uv1 < slot2 then
			return
		end
	elseif slot2 <= 0 then
		return
	end

	MythicAction:SelectLevel(slot2)
end

function slot0.SetCurHotLevelIdMax(slot0)
	MythicAction:SelectLevel(uv0)
end

function slot0.GetevelStatu(slot0)
	if uv0 == 1 then
		return "nofront"
	elseif uv0 == uv1 then
		return "nonext"
	else
		return "mid"
	end
end

function slot0.GetLevelMax(slot0)
	return uv0
end

function slot0.GetIsHaveRewardNotGet(slot0)
	for slot4 = 1, uv0 do
		if table.indexof(uv1, slot4) == false then
			return true
		end
	end

	return false
end

function slot0.SortRewards(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in ipairs(MythicFinalCfg.all) do
		if uv0 < slot8 then
			table.insert(slot3, slot8)
		elseif table.indexof(uv1, slot8) then
			table.insert(slot2, slot8)
		else
			table.insert(slot1, slot8)
		end
	end

	slot4 = 1

	for slot8, slot9 in pairs(slot1) do
		uv2[slot4] = slot9
		slot4 = slot4 + 1
	end

	for slot8, slot9 in pairs(slot3) do
		uv2[slot4] = slot9
		slot4 = slot4 + 1
	end

	for slot8, slot9 in pairs(slot2) do
		uv2[slot4] = slot9
		slot4 = slot4 + 1
	end
end

function slot0.GetRealIndex(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetCurPoint(slot0, slot1)
	uv0 = slot1
end

function slot0.GetCurPoint(slot0)
	return uv0
end

function slot0.GetCurBattleIndex(slot0)
	return uv0
end

function slot0.GetIsBattleIng(slot0)
	if uv0 > 1 then
		return true
	else
		return false
	end
end

function slot0.InitSeverTeamData(slot0, slot1)
	uv0 = {}

	if slot1.teams_info_list[1] and slot1.teams_info_list[1].stage_type == BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL then
		for slot5, slot6 in ipairs(slot1.teams_info_list) do
			for slot10, slot11 in ipairs(slot6.teams) do
				uv0[slot11.id] = {
					heroList = {}
				}

				for slot15, slot16 in ipairs(slot11.hero_list) do
					table.insert(uv0[slot11.id].heroList, slot16.hero_id)
				end

				if slot11.ai_chip_list[1] then
					uv0[slot11.id].chipManagerID = slot11.ai_chip_list[1]
					uv0[slot11.id].chipList = {}

					for slot15, slot16 in ipairs(slot11.ai_chip_list) do
						if slot15 > 1 then
							table.insert(uv0[slot11.id].chipList, slot16)
						end
					end
				else
					uv0[slot11.id].chipManagerID = 0
				end

				uv0[slot11.id].uniqueSkillID = slot11.cooperate_unique_skill_id
			end
		end
	end
end

function slot0.TryToSaveCurTeamData(slot0, slot1)
	uv0 = {}

	if slot1.teams_info_list and slot1.teams_info_list.stage_type == BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL then
		for slot5, slot6 in ipairs(slot1.teams_info_list.teams) do
			uv0[slot6.id] = {
				heroList = {}
			}

			for slot10, slot11 in ipairs(slot6.hero_list) do
				table.insert(uv0[slot6.id].heroList, slot11.hero_id)
			end

			if slot6.ai_chip_list[1] then
				uv0[slot6.id].chipManagerID = slot6.ai_chip_list[1]
				uv0[slot6.id].chipList = {}

				for slot10, slot11 in ipairs(slot6.ai_chip_list) do
					if slot10 > 1 then
						table.insert(uv0[slot6.id].chipList, slot11)
					end
				end
			else
				uv0[slot6.id].chipManagerID = 0
			end

			uv0[slot6.id].uniqueSkillID = slot6.cooperate_unique_skill_id
		end
	end
end

function slot0.GetChipListByTeamID(slot0, slot1)
	return uv0[slot1].chipList
end

function slot0.ClearBattleData(slot0)
	uv0 = 0
	uv1 = {}
end

MythicRankTemplate = class("MythicRankTemplate")

function MythicRankTemplate.Ctor(slot0, slot1)
	slot0.user_id = slot1.user_id
	slot0.score = slot1.score
	slot0.difficulty = slot1.difficulty
	slot0.rank = slot1.rank
	slot0.timestamp = slot1.timestamp
	slot0.team_list = {}

	for slot5, slot6 in ipairs(slot1.team_info) do
		slot7 = {}

		for slot11, slot12 in ipairs(slot6.hero_info_list) do
			table.insert(slot7, {
				id = slot12.hero_id,
				skin_id = slot12.skin_id
			})
		end

		table.insert(slot0.team_list, slot7)
	end

	if PlayerData:GetPlayerInfo() and tonumber(slot0.user_id) == slot2.userID then
		slot0.nick = slot2.nick
		slot0.icon = slot2.portrait
		slot0.icon_frame = slot2.icon_frame
	else
		slot0.nick = slot1.nick
		slot0.icon = slot1.portrait
		slot0.icon_frame = slot1.frame
	end
end

slot35 = ({
	ALL = 1,
	GUILD = 2
}).ALL

function slot0.GetRankTypeConst(slot0)
	return uv0
end

function slot0.GetCurRankType(slot0)
	return uv0
end

function slot0.SetCurRankType(slot0, slot1)
	uv0 = slot1
end

function slot0.GetRankVersion(slot0)
	return uv0
end

function slot0.GetRankTotalPeople(slot0)
	return uv0
end

function slot0.InitCurRank(slot0, slot1)
	uv0 = MythicRankTemplate.New(slot1.my_rank)
	uv1 = slot1.total
end

function slot0.InitRankData(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.rank_list) do
		table.insert(uv0, MythicRankTemplate.New(slot6))
	end

	uv1 = MythicRankTemplate.New(slot1.my_rank)
	uv2 = slot1.total
	uv3 = slot1.version
end

function slot0.InitGuildRankData(slot0, slot1, slot2)
	GuildAction.RequiredGuildMemberList(function ()
		uv0 = {}

		for slot3, slot4 in ipairs(uv1.rank_list) do
			if GuildData:GetGuildMemberData(slot4.user_id) then
				table.insert(uv0, MythicRankTemplate.New(slot4))
			end
		end

		table.sort(uv0, function (slot0, slot1)
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

		slot1 = PlayerData:GetPlayerInfo().userID
		uv2 = nil

		for slot5, slot6 in ipairs(uv0) do
			slot6.rank = slot5
			slot7 = GuildData:GetGuildMemberData(slot6.user_id)
			slot6.nick = slot7.name
			slot6.icon = slot7.icon
			slot6.icon_frame = slot7.frame

			if tonumber(slot6.user_id) == slot1 then
				uv2 = slot6
			end
		end

		if uv3 ~= nil then
			uv3()
		end
	end)
end

function slot0.ResetGuildRankData(slot0)
	uv0 = {}
	uv1 = nil
end

function slot0.GetRankList(slot0)
	return uv0
end

function slot0.GetCurRank(slot0)
	return uv0
end

function slot0.GetGuildRankList(slot0)
	return uv0
end

function slot0.GetGuildCurRank(slot0)
	return uv0
end

function slot0.GetCurTime(slot0)
	slot1 = MythicFinalCfg[uv0].time

	if slot0:GetIsBattleIng() then
		for slot5, slot6 in pairs(uv1) do
			if slot6.clear_state == 1 then
				slot1 = slot1 - slot6.use_time
			end
		end
	end

	return slot1
end

function slot0.GetBattlingTime(slot0)
	slot1 = MythicFinalCfg[uv0].time

	for slot5, slot6 in pairs(uv1) do
		if slot6.clear_state == 1 then
			slot1 = slot1 - slot6.use_time
		end
	end

	return slot1
end

function slot0.GetBattleRemainTime(slot0, slot1)
	slot2 = MythicFinalCfg[uv0].time

	for slot6 = 1, slot1 - 1 do
		slot2 = slot2 - uv1[slot6].use_time
	end

	return slot2
end

return slot0
