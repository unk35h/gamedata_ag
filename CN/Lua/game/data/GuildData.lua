slot0 = singletonClass("GuildData")

function slot0.Init(slot0)
	slot0.showImpeachFlag_ = false
	slot0.recommendRefershStamptime_ = 0
	slot0.requiredMemberStamptime_ = 0
	slot0.recommendList_ = {}
	slot0.searchList_ = {}
	slot0.guildInfo_ = {}
	slot0.guildMemberList_ = {}
	slot0.guildRequestList_ = {}
	slot0.cacheGuildListInfo_ = {}
	slot0.bossData_ = {
		day_clear_prepose_times = 0,
		buff_index = 1,
		personal_score = 0,
		currentAssistHeroId = 0,
		initedFromServer = false,
		day_first_clear_prepose = 0,
		preInfo = {},
		challengeInfo = {
			total_damage = 0,
			boss_id = 1,
			damage = 0,
			damage_level = 0,
			difficulty = 1,
			collective_damage_award_admitted = {},
			personal_score_award_admitted = {},
			cleared_difficulty_list = {}
		},
		assist_info_list = {},
		rank_list = {}
	}
	slot0.exitGuildTime_ = 0
	slot0.renameFreeCnt_ = 0

	JumpTools.SetSystemOpenCheck(ViewConst.SYSTEM_ID.GUILD_BOSS, function ()
		if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
			return false, "NEED_JOIN_CLUB"
		end

		if not GuildData:GetBossData().initedFromServer then
			return false, "GUILD_BOSS_CD_TIP"
		end

		return true, ""
	end)
end

function slot0.ParseRecommendData(slot0, slot1)
	return {
		id = slot1.id,
		icon = slot1.icon,
		name = slot1.name,
		level = slot1.level,
		member = slot1.member_count,
		maxMemberCnt = slot1.member_count_limit,
		contribute = slot1.last_week_total_vitality,
		notice = slot1.notice,
		isFree = slot1.club_setting.examine_recruit_join_request_switch == 1
	}
end

function slot0.ParseRequestMemberData(slot0, slot1)
	return {
		weekContribute = 0,
		contribute = 0,
		id = slot1.id,
		icon = slot1.icon,
		frame = slot1.icon_frame,
		name = slot1.name,
		post = GuildConst.GUILD_POST.TRAINEE,
		level = slot1.level,
		offlineStamptime = slot1.online_info
	}
end

function slot0.ParseMemberData(slot0, slot1)
	return {
		id = slot1.id,
		icon = slot1.icon,
		frame = slot1.icon_frame,
		name = slot1.name,
		post = slot1.duty,
		level = slot1.level,
		contribute = slot1.total_vitality,
		weekContribute = slot1.vitality,
		offlineStamptime = slot1.online_info
	}
end

function slot0.InitGuildRecommendList(slot0, slot1)
	slot0.recommendList_ = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.recommendList_, slot0:ParseRecommendData(slot6))
	end
end

function slot0.InitBossDataFromServer(slot0, slot1)
	slot3 = slot1.info
	slot0.bossData_.initedFromServer = true
	slot0.bossData_.day_first_clear_award_admitted = slot1.day_first_clear_award_admitted
	slot0.bossData_.buff_index = slot1.buff_index
	slot0.bossData_.day_first_clear_prepose = slot1.day_first_clear_prepose
	slot0.bossData_.day_clear_prepose_times = slot1.day_clear_prepose_times
	slot0.bossData_.preInfo = {}

	for slot7, slot8 in ipairs(slot1.pre_info) do
		slot9 = {
			level_id = slot8.level_id,
			score = slot8.score,
			stage_id = slot8.stage_id,
			buff_id = slot8.buff_id
		}
		slot0.bossData_.preInfo[slot9.level_id] = slot9
	end

	slot0.bossData_.challengeInfo = {
		personal_score = slot3.personal_score,
		boss_id = slot3.boss_tempalte_id,
		difficulty = slot3.difficulty,
		total_damage = slot3.total_damage,
		collective_damage_award_admitted = {},
		personal_score_award_admitted = {},
		damage_level = slot3.damage_level,
		damage = slot3.damage,
		cleared_difficulty_list = slot3.cleared_difficulty_list
	}

	for slot7, slot8 in pairs(slot3.collective_damage_award_admitted) do
		table.insert(slot0.bossData_.challengeInfo.collective_damage_award_admitted, slot8)
	end

	for slot7, slot8 in ipairs(slot3.personal_score_award_admitted) do
		table.insert(slot0.bossData_.challengeInfo.personal_score_award_admitted, slot8)
	end

	manager.notify:Invoke(GUILD_BOSS_INIT, {})
end

function slot0.InitAssistInfoListFromServer(slot0, slot1)
	slot0.bossData_.assist_info_list = {}

	for slot5, slot6 in ipairs(slot1) do
		if slot6.member_id ~= tostring(PlayerData:GetPlayerInfo().userID) then
			table.insert(slot0.bossData_.assist_info_list, {
				member_id = slot6.member_id,
				member_post = slot6.member_post,
				assist_hero_id = slot6.assist_hero_id,
				assist_hero_skin = slot6.assist_hero_skin,
				fight_capacity = slot6.fight_capacity,
				hero_rare = slot6.hero_rare,
				hero_level = slot6.hero_level,
				nick = slot6.nick
			})
		end
	end

	manager.notify:Invoke(GUILD_ASSIST_BRIEF_UPDATE, {})
end

function slot0.SetAssistChipId(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0.bossData_.assist_info_list) do
		if tostring(slot7.member_id) == tostring(slot1) then
			slot7.chipId = slot2

			break
		end
	end
end

function slot0.GetAssistantBriefList(slot0)
	return slot0.bossData_.assist_info_list
end

function slot0.OnBossDifficultlyChange(slot0, slot1)
	slot0.bossData_.challengeInfo.difficulty = slot1

	manager.notify:Invoke(GUILD_BOSS_DIFFICULTY_CHANGE, slot1)
end

function slot0.InitGuildBossRankFromServer(slot0, slot1)
	slot0.bossData_.rank_list = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = {
			id = slot6.id,
			icon = slot6.icon,
			icon_frame = slot6.icon_frame,
			nick = slot6.nick,
			score = slot6.score,
			timestamp = slot6.timestamp,
			member_post = slot6.member_post,
			hero_type_info = {}
		}

		for slot11, slot12 in ipairs(slot6.hero_type_info) do
			table.insert(slot7.hero_type_info, {
				hero_id = slot12.hero_id,
				skin_id = slot12.skin_id
			})
		end

		table.insert(slot0.bossData_.rank_list, slot7)
	end

	manager.notify:Invoke(GUILD_BOSS_RANK_UPDATE, {})
end

function slot0.UpdateBossDamage(slot0, slot1)
	slot0.bossData_.challengeInfo.total_damage = slot1

	manager.notify:Invoke(GUILD_BOSS_UPDATE, {})
end

function slot0.GetRankList(slot0)
	return slot0.bossData_.rank_list
end

function slot0.GetBossData(slot0)
	return slot0.bossData_
end

function slot0.CanGetBonus(slot0)
	return slot0.bossData_.day_clear_prepose_times >= 1 and not slot0:IsGetFirstBossBonus()
end

function slot0.IsGetFirstBossBonus(slot0)
	return slot0.bossData_.day_first_clear_award_admitted == 1
end

function slot0.OnGetGuildBossFirstBonus(slot0)
	slot0.bossData_.day_first_clear_award_admitted = 1
end

function slot0.IsPassBossDifficulty(slot0, slot1)
	if table.indexof(slot0.bossData_.challengeInfo.cleared_difficulty_list, slot1) then
		return true
	end

	return false
end

function slot0.GetBossDifficulty(slot0)
	return slot0.bossData_.challengeInfo.difficulty
end

function slot0.GetLastTime(slot0)
	slot1 = nil

	if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_BOSS_PREPARE) then
		return "prepose", ActivityData:GetActivityData(ActivityConst.GUILD_BOSS_PREPARE).stopTime
	else
		return "challenge", ActivityData:GetActivityData(ActivityConst.GUILD_BOSS_CHALLENGE).stopTime
	end
end

function slot0.GetGuildBossBuffList(slot0)
	return ClubBossAffixCfg[slot0.bossData_.buff_index].superiority_affix_list
end

function slot0.GetHaveGetBossBuffList(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0:GetGuildBossBuffList()) do
		if ClubBossPreposeCfg[slot6].point_max <= slot0.bossData_.preInfo[slot6].score then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.GetBossLastTime(slot0)
	return GameSetting.club_boss_prepose_max.value[1] - slot0.bossData_.day_clear_prepose_times
end

function slot0.HaveBossChallengedToday(slot0)
	return slot0.bossData_.day_first_clear_prepose == 1
end

function slot0.GetCurrentBossStageId(slot0)
	return ClubBossIdCfg[slot0.bossData_.challengeInfo.boss_id].stage_id
end

function slot0.GetCurBossId(slot0)
	return BossChallengeUICfg[slot0.bossData_.challengeInfo.boss_id].boss_id_list[1]
end

function slot0.GetBossPersonalScore(slot0)
	return slot0.bossData_.challengeInfo.personal_score
end

function slot0.ResetBossPersonalScore(slot0, slot1)
	slot0.bossData_.challengeInfo.personal_score = math.max(slot0.bossData_.challengeInfo.personal_score, slot1)
end

function slot0.GetCurrentBossAssistantHeroId(slot0)
	return slot0.bossData_.currentAssistHeroId
end

function slot0.GetPreInfoList(slot0)
	return slot0.bossData_.preInfo
end

function slot0.GetCurrentBossDamage(slot0)
	return slot0.bossData_.challengeInfo.total_damage
end

function slot0.GetCurrentBossRemainHp(slot0)
	return math.max(ClubBossCfg[GuildData:GetBossDifficulty()].boss_hp - slot0.bossData_.challengeInfo.total_damage, 0)
end

function slot0.HaveGetGuildBossPersonalReward(slot0, slot1)
	if table.indexof(slot0.bossData_.challengeInfo.personal_score_award_admitted, slot1) then
		return true
	end

	return false
end

function slot0.OnGuildBossPersonalRewardGet(slot0, slot1)
	table.insert(slot0.bossData_.challengeInfo.personal_score_award_admitted, slot1)
	manager.notify:Invoke(GUILD_BOSS_PERSONAL_REWARD_GET, slot1)
end

function slot0.HaveGetGuildBossCommonReward(slot0, slot1)
	if table.indexof(slot0.bossData_.challengeInfo.collective_damage_award_admitted, slot1) then
		return true
	end

	return false
end

function slot0.OnGuildBossCommonRewardGet(slot0, slot1)
	table.insert(slot0.bossData_.challengeInfo.collective_damage_award_admitted, slot1)
	manager.notify:Invoke(GUILD_BOSS_COMMON_REWARD_GET, slot1)
end

function slot0.GetRecommendList(slot0)
	return slot0.recommendList_
end

function slot0.InitSearceList(slot0, slot1)
	slot0.searchList_ = {}

	table.insert(slot0.searchList_, slot0:ParseRecommendData(slot1))
end

function slot0.GetSearchList(slot0)
	return slot0.searchList_
end

function slot0.InitGuildInfo(slot0, slot1)
	slot0.guildInfo_ = {
		id = slot1.id,
		icon = slot1.icon,
		name = slot1.name,
		level = slot1.level,
		exp = slot1.club_exp,
		curWeekExp = slot1.weekly_gain_exp or 0,
		curWeekCoin = slot1.weekly_gain_coin or 0,
		memberCnt = slot1.member_count,
		maxMemberCnt = slot1.member_count_limit,
		notice = slot1.notice,
		captain = slot1.leader.name,
		post = slot1.post,
		impeachTime = slot1.impeach_timestamp + 172800,
		reviewFlag = slot1.club_setting.examine_recruit_join_request_switch,
		limitLevel = slot1.club_setting.join_request_limit,
		isCandidate = slot1.is_candidate == 1
	}

	if slot0.guildInfo_.post == GuildConst.GUILD_POST.CAPTAIN and slot0.guildInfo_.impeachTime - manager.time:GetServerTime() > 0 then
		manager.redPoint:setTip(RedPointConst.GUILD_IMPEACH, 1)
	end

	saveData("guildInfo", "guildID", slot1.id)
end

function slot0.SetShareTimestamp(slot0, slot1)
	slot0.shareRefreshTimestamp_ = slot1.last_share_timestamp + GameSetting.club_share_colddown.value[1]
end

function slot0.GetShareTimestamp(slot0)
	return slot0.shareRefreshTimestamp_ or 0
end

function slot0.SetAssistHero(slot0, slot1)
	slot0.bossData_.currentAssistHeroId = slot1

	manager.notify:Invoke(GUILD_BOSS_ASSISTANT_HERO_CHANGE, slot1)
end

function slot0.GetGuildInfo(slot0)
	return slot0.guildInfo_
end

function slot0.SetGuildName(slot0, slot1)
	slot0.guildInfo_.name = slot1
end

function slot0.GetRenameFreeCnt(slot0)
	return slot0.renameFreeCnt_
end

function slot0.SetRenameFreeCnt(slot0, slot1)
	slot0.renameFreeCnt_ = slot1
end

function slot0.UseRenameFree(slot0)
	slot0.renameFreeCnt_ = slot0.renameFreeCnt_ - 1
end

function slot0.SetGuildNotice(slot0, slot1)
	slot0.guildInfo_.notice = slot1
end

function slot0.SetGuildIcon(slot0, slot1)
	slot0.guildInfo_.icon = slot1
end

function slot0.RefreshWeekResources(slot0)
	slot0.guildInfo_.curWeekExp = 0
	slot0.guildInfo_.curWeekCoin = 0
end

function slot0.ModifyEXP(slot0, slot1)
	if slot0.guildInfo_.id == nil then
		return
	end

	if GameSetting.club_max_level.value[1] <= slot0.guildInfo_.level then
		return
	end

	slot3 = slot0.guildInfo_.exp

	for slot7 = slot2 - 1, 1, -1 do
		slot3 = slot3 - ClubLevelCfg[slot7].club_level_exp
	end

	slot4 = ClubLevelCfg[slot2].club_level_exp - slot3

	if ClubLevelCfg[slot2].max_exp_per_week - slot0.guildInfo_.curWeekExp <= 0 and slot1 < slot4 then
		return
	end

	slot6 = 0
	slot6 = slot4 < slot5 and slot4 < slot1 and slot4 or slot5 < slot1 and slot5 or slot1
	slot0.guildInfo_.exp = slot0.guildInfo_.exp + slot6
	slot0.guildInfo_.curWeekExp = slot0.guildInfo_.curWeekExp + slot6
	slot7 = slot0.guildInfo_.exp

	for slot11 = 1, GameSetting.club_max_level.value[1] do
		if slot7 - ClubLevelCfg[slot11].club_level_exp < 0 then
			slot0.guildInfo_.level = slot11

			return
		end
	end

	slot0.guildInfo_.level = GameSetting.club_max_level.value[1]
end

function slot0.GetMaxWeekExp(slot0)
	if slot0.guildInfo_.level == nil then
		return 0
	end

	return ClubLevelCfg[slot1].max_exp_per_week
end

function slot0.ModifyCoin(slot0, slot1)
	if slot0.guildInfo_.id == nil then
		return
	end

	if ClubLevelCfg[slot0.guildInfo_.level].max_currency_per_week - slot0.guildInfo_.curWeekCoin <= 0 then
		return
	end

	if slot3 < slot1 then
		slot0.guildInfo_.curWeekCoin = slot0.guildInfo_.curWeekCoin + slot3
	else
		slot0.guildInfo_.curWeekCoin = slot0.guildInfo_.curWeekCoin + slot1
	end
end

function slot0.GetMaxWeekCoin(slot0)
	if slot0.guildInfo_.level == nil then
		return 0
	end

	return ClubLevelCfg[slot1].max_currency_per_week
end

function slot0.UpdateMemberCnt(slot0, slot1)
	slot0.guildInfo_.memberCnt = (slot0.guildInfo_.memberCnt or 0) + slot1
end

function slot0.SetGuildSetting(slot0, slot1, slot2)
	slot0.guildInfo_.reviewFlag = slot1
	slot0.guildInfo_.limitLevel = slot2
end

function slot0.ExitGuild(slot0)
	slot0.guildInfo_ = {}
	slot0.guildRequestList_ = {}
	slot0.guildMemberList_ = {}
	slot0.bossData_ = {
		day_clear_prepose_times = 0,
		buff_index = 1,
		personal_score = 0,
		currentAssistHeroId = 0,
		initedFromServer = false,
		day_first_clear_prepose = 0,
		preInfo = {},
		challengeInfo = {
			total_damage = 0,
			boss_id = 1,
			damage = 0,
			damage_level = 0,
			difficulty = 1,
			collective_damage_award_admitted = {},
			personal_score_award_admitted = {},
			cleared_difficulty_list = {}
		},
		assist_info_list = {},
		rank_list = {}
	}
	slot0.requiredMemberStamptime_ = 0

	manager.redPoint:setTip(RedPointConst.GUILD_IMPEACH, 0)
	manager.redPoint:setTip(RedPointConst.GUILD_REQUEST, 0)
	manager.redPoint:setTip(RedPointConst.CLUB_TASK, 0)
	manager.redPoint:setTip(RedPointConst.GUILD_WELFARE, 0)
	saveData("guildInfo", "guildID", nil)
end

function slot0.GetExitTime(slot0)
	return slot0.exitGuildTime_
end

function slot0.SetExitTime(slot0, slot1)
	slot0.exitGuildTime_ = slot1
end

function slot0.InitGuildMember(slot0, slot1)
	slot0.guildMemberList_ = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0.guildMemberList_[slot6.id] = slot0:ParseMemberData(slot6)
	end
end

function slot0.AddMember(slot0, slot1)
	slot2 = slot1.member
	slot0.guildMemberList_[slot2.id] = slot0:ParseMemberData(slot2)

	if slot2.id ~= USER_ID then
		slot0:UpdateMemberCnt(1)
	end
end

function slot0.RemoveMember(slot0, slot1)
	slot0.guildMemberList_[slot1.Id] = nil
	slot0.requiredMemberStamptime_ = 0

	if slot1.Id ~= USER_ID then
		slot0:UpdateMemberCnt(-1)
	end
end

function slot0.GetGuildMemberData(slot0, slot1)
	return slot0.guildMemberList_[slot1]
end

function slot0.GetGuildMemberIDList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.guildMemberList_) do
		table.insert(slot1, slot5)
	end

	if #slot1 > 1 then
		table.sort(slot1, function (slot0, slot1)
			if uv0.guildMemberList_[slot0].post < uv0.guildMemberList_[slot1].post then
				return true
			elseif slot2.post == slot3.post then
				if slot2.offlineStamptime == 0 and slot3.offlineStamptime ~= 0 or slot3.offlineStamptime ~= 0 and slot3.offlineStamptime < slot2.offlineStamptime then
					return true
				elseif slot2.offlineStamptime == slot3.offlineStamptime then
					if slot3.weekContribute < slot2.weekContribute then
						return true
					elseif slot2.weekContribute == slot3.weekContribute then
						if slot2.contribute < slot2.contribute then
							return true
						elseif slot2.contribute < slot2.contribute and tonumber(slot2.id) < tonumber(slot3.id) then
							return true
						end
					end
				end
			end

			return false
		end)
	end

	return slot1
end

function slot0.GetGuildContributeList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.guildMemberList_) do
		table.insert(slot1, slot5)
	end

	if #slot1 > 1 then
		table.sort(slot1, function (slot0, slot1)
			if uv0.guildMemberList_[slot1].contribute < uv0.guildMemberList_[slot0].contribute then
				return true
			elseif slot2.contribute == slot3.contribute then
				if slot2.weekContribute < slot2.weekContribute then
					return true
				elseif slot2.weekContribute == slot2.weekContribute then
					if slot2.post < slot3.post then
						return true
					elseif slot2.post == slot3.post and tonumber(slot2.id) < tonumber(slot3.id) then
						return true
					end
				end
			end

			return false
		end)
	end

	return slot1
end

function slot0.GetGuildWeekContributeList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.guildMemberList_) do
		table.insert(slot1, slot5)
	end

	if #slot1 > 1 then
		table.sort(slot1, function (slot0, slot1)
			if uv0.guildMemberList_[slot1].weekContribute < uv0.guildMemberList_[slot0].weekContribute then
				return true
			elseif slot2.weekContribute == slot3.weekContribute then
				if slot2.contribute < slot2.contribute then
					return true
				elseif slot2.contribute == slot2.contribute then
					if slot2.post < slot3.post then
						return true
					elseif slot2.post == slot3.post and tonumber(slot2.id) < tonumber(slot3.id) then
						return true
					end
				end
			end

			return false
		end)
	end

	return slot1
end

function slot0.InitGuildRequestMember(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0.guildRequestList_[slot6.id] = slot0:ParseRequestMemberData(slot6)
	end

	manager.redPoint:setTip(RedPointConst.GUILD_REQUEST, table.length(slot0.guildRequestList_))
end

function slot0.GetGuildRequestData(slot0, slot1)
	return slot0.guildRequestList_[slot1]
end

function slot0.GetGuildRequestIDList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.guildRequestList_) do
		table.insert(slot1, slot5)
	end

	return slot1
end

function slot0.UpdateRequestMember(slot0, slot1)
	slot2 = slot1.member

	if slot1.type == 1 then
		slot0.guildRequestList_[slot1.Id] = slot0:ParseRequestMemberData(slot1.member)
	elseif slot1.type == 2 then
		slot0.guildRequestList_[slot1.Id] = nil
	elseif slot1.type == 3 then
		slot0.guildRequestList_[slot1.Id] = nil
	end

	manager.redPoint:setTip(RedPointConst.GUILD_REQUEST, table.length(slot0.guildRequestList_))
end

function slot0.RemoveAllRequestMember(slot0)
	slot0.guildRequestList_ = {}

	manager.redPoint:setTip(RedPointConst.GUILD_REQUEST, 0)
end

function slot0.GetCaptainID(slot0)
	for slot4, slot5 in pairs(slot0.guildMemberList_) do
		if slot5.post == GuildConst.GUILD_POST.CAPTAIN then
			return slot5.id
		end
	end
end

function slot0.IsCaptainOrDeputy(slot0)
	return slot0.guildInfo_.post == GuildConst.GUILD_POST.CAPTAIN or slot1 == GuildConst.GUILD_POST.DEPUTY
end

function slot0.ChangedCaptain(slot0, slot1)
	slot0.guildInfo_.captain = slot1.nick

	if slot0:GetCaptainID() then
		slot3 = slot0.guildMemberList_[slot2]
		slot3.post = GuildConst.GUILD_POST.MEMBER

		if slot3.id == USER_ID then
			slot0.guildInfo_.post = GuildConst.GUILD_POST.MEMBER
		end

		slot0:RemoveAllRequestMember()
	end

	if slot0.guildMemberList_[slot1.Id] then
		slot0.guildMemberList_[slot1.Id].post = GuildConst.GUILD_POST.CAPTAIN
	end

	if slot1.Id == USER_ID then
		slot0.guildInfo_.post = GuildConst.GUILD_POST.CAPTAIN
	end
end

function slot0.ChangedDeputy(slot0, slot1)
	if slot0.guildMemberList_[slot1.Id] then
		slot0.guildMemberList_[slot1.Id].post = GuildConst.GUILD_POST.DEPUTY
	end

	if slot1.Id == USER_ID then
		slot0.guildInfo_.post = GuildConst.GUILD_POST.DEPUTY
	end
end

function slot0.DismissDeputy(slot0, slot1)
	if slot0.guildMemberList_[slot1.Id] then
		slot0.guildMemberList_[slot1.Id].post = GuildConst.GUILD_POST.MEMBER
	end

	if slot1.Id == USER_ID then
		slot0.guildInfo_.post = GuildConst.GUILD_POST.MEMBER
	end
end

function slot0.GetCaptainOfflineTime(slot0)
	if slot0.guildMemberList_[slot0:GetCaptainID()].offlineStamptime == 0 then
		return manager.time:GetServerTime()
	end

	return slot0.guildMemberList_[slot1].offlineStamptime
end

function slot0.ImpeachCaptain(slot0, slot1)
	slot0.guildInfo_.impeachTime = slot1.time_stamp + 172800
end

function slot0.CancelImpeach(slot0)
	slot0.guildInfo_.impeachTime = 0
end

function slot0.ApplyCaptain(slot0)
	slot0.guildInfo_.isCandidate = true
end

function slot0.Trainee2Member(slot0)
	slot0.guildInfo_.post = GuildConst.GUILD_POST.MEMBER
end

function slot0.GetCacheGuildInfo(slot0, slot1)
	return slot0.cacheGuildListInfo_[slot1]
end

function slot0.SetCacheGuildInfo(slot0, slot1)
	slot0.cacheGuildListInfo_[slot1.id] = {
		id = slot1.id,
		icon = slot1.icon,
		name = slot1.name,
		level = slot1.level,
		exp = slot1.club_exp,
		memberCnt = slot1.member_count,
		maxMemberCnt = slot1.member_count_limit,
		contribute = slot1.last_week_total_vitality,
		notice = slot1.notice,
		captain = slot1.leader.name,
		isFree = slot1.club_setting.examine_recruit_join_request_switch == 1,
		limitLevel = slot1.club_setting.join_request_limit
	}
end

function slot0.GetImpeachFlag(slot0)
	return slot0.showImpeachFlag_
end

function slot0.SetImpeachFlag(slot0)
	slot0.showImpeachFlag_ = true
end

function slot0.GetRecommendRefreshStamptime(slot0)
	return slot0.recommendRefershStamptime_
end

function slot0.SetRecommendRefreshStamptime(slot0)
	slot0.recommendRefershStamptime_ = manager.time:GetServerTime()
end

function slot0.SetRequiredMemberStamptime(slot0)
	slot0.requiredMemberStamptime_ = manager.time:GetServerTime()
end

function slot0.GetRequiredMemberStamptime(slot0)
	return slot0.requiredMemberStamptime_
end

return slot0
