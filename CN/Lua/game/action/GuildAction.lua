slot1 = manager.net

slot1:Bind(31001, function (slot0)
	GuildData:InitGuildInfo(slot0.club)
	GuildData:SetShareTimestamp(slot0)
	GuildData:SetAssistHero(slot0.assist_hero_id)
	manager.notify:Invoke(GUILD_ENTER)
	TaskAction:UpdateClubTaskRedTip()
end)

slot1 = manager.net

slot1:Bind(31999, function (slot0)
	GuildData:UpdateRequestMember(slot0)
	manager.notify:Invoke(GUILD_REFRESH_REQUEST)
end)

slot1 = manager.net

slot1:Bind(31997, function (slot0)
	GuildData:ChangedCaptain(slot0)
	manager.notify:Invoke(GUILD_REFRESH_MEMBER)
end)

slot1 = manager.net

slot1:Bind(31995, function (slot0)
	GuildData:ChangedDeputy(slot0)
	manager.notify:Invoke(GUILD_REFRESH_MEMBER)
end)

slot1 = manager.net

slot1:Bind(31993, function (slot0)
	GuildData:DismissDeputy(slot0)
	manager.notify:Invoke(GUILD_REFRESH_MEMBER)
end)

slot1 = manager.net

slot1:Bind(31989, function (slot0)
	GuildData:RemoveMember(slot0)

	if slot0.Id == USER_ID then
		uv0.GuildExitFun()

		return
	end

	manager.notify:Invoke(GUILD_REFRESH_MEMBER)
end)

slot1 = manager.net

slot1:Bind(31985, function (slot0)
	GuildData:AddMember(slot0)
	manager.notify:Invoke(GUILD_REFRESH_MEMBER)
end)

slot1 = manager.net

slot1:Bind(31983, function (slot0)
	GuildData:ImpeachCaptain(slot0)
	manager.notify:Invoke(GUILD_CAPTAIN_IMPEACH)
end)

slot1 = manager.net

slot1:Bind(31981, function (slot0)
	GuildData:CancelImpeach()
	manager.notify:Invoke(GUILD_CAPTAIN_IMPEACH)
end)

slot1 = manager.net

slot1:Bind(31979, function (slot0)
	GuildData:InitGuildRequestMember(slot0.join_list)
	manager.notify:Invoke(GUILD_REFRESH_MEMBER)
end)

slot1 = manager.net

slot1:Bind(31977, function (slot0)
	GuildData:SetExitTime(slot0.time_stamp)
end)

slot1 = manager.net

slot1:Bind(31211, function (slot0)
	if GuildConst.GUILD_POST.TRAINEE <= GuildData:GetGuildInfo().post then
		GuildData:Trainee2Member()
		CommunityAction:RefreshWelfare()
	end
end)

slot1 = manager.net

slot1:Bind(31975, function (slot0)
	GuildData:SetRenameFreeCnt(slot0.chance)
end)

slot1 = manager.net

slot1:Bind(33001, function (slot0)
	if isSuccess(slot0.result) then
		GuildData:InitBossDataFromServer(slot0)
		uv0.UpdateGuildBossRedPoint()
	else
		ShowTips(GetTips(slot0.result))
	end
end)

slot1 = manager.net

slot1:Bind(33999, function (slot0)
	GuildData:UpdateBossDamage(slot0.boss_challenge_total_damage)
	uv0.UpdateGuildBossRedPoint()
end)

slot1 = manager.net

slot1:Bind(27405, function (slot0)
	GuildData:SetShareTimestamp(slot0)
	manager.notify:Invoke(GUILD_SHARE)
end)

slot1 = manager.notify

slot1:RegistListener(WEEK_ZERO_REFRESH, function ()
	if GuildData:GetGuildInfo().id == nil then
		return
	end

	GuildData:RefreshWeekResources()
end)

return {
	GuildRequestJoin = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(31010, {
			id = slot0
		}, 31011, function (slot0)
			if isSuccess(slot0.result) then
				ShowTips(slot0.result)
				ChatGuildRecruitData:AddRequireGuild(uv0)
				manager.notify:Invoke(GUILD_REQUIRE)
			elseif slot0.result == TipsCfg.get_id_list_by_define.ERROR_USER_JOIN_COOL_DOWN then
				if slot0.remain_time > 0 then
					slot4 = nil

					ShowTips(string.format(GetTips("CLUB_REQUEST_CD"), (slot2 >= 60 or string.format("%s%s", slot2, GetTips("SECOND"))) and (slot2 >= 3600 or string.format("%s%s", math.floor(slot2 / 60), GetTips("MINUTE"))) and string.format("%s%s", math.floor(slot2 / 3600), GetTips("HOUR"))))
				end
			else
				if slot0.result == TipsCfg.get_id_list_by_define.ERROR_CLUB_REQUEST_TWICE or slot0.result == TipsCfg.get_id_list_by_define.USER_REQUEST_JOIN_CLUB_SUCCESS then
					ChatGuildRecruitData:AddRequireGuild(uv0)
					manager.notify:Invoke(GUILD_REQUIRE)
				end

				ShowTips(slot0.result)
			end

			uv1()
		end)
	end,
	SearchGuild = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(31028, {
			Id = slot0
		}, 31029, function (slot0)
			if isSuccess(slot0.result) then
				GuildData:InitSearceList(slot0.club_base_info)
			end

			uv0(slot0)
		end)
	end,
	FoundedGuild = function (slot0, slot1, slot2, slot3)
		slot4 = manager.net

		slot4:SendWithLoadingNew(31008, {
			name = slot0,
			icon = slot2,
			notice = slot1
		}, 31009, function (slot0)
			uv0(slot0)
			SendMessageManagerToSDK("guild_join")
		end)
	end,
	RequiredGuildInfo = function (slot0)
		slot1 = manager.net

		slot1:SendWithLoadingNew(31002, {
			nothing = 1
		}, 31003, function (slot0)
			GuildData:InitGuildInfo(slot0.club_base_info)
			GuildData:SetShareTimestamp(slot0)
			uv0(slot0)
		end)
	end,
	RequiredGuildMemberList = function (slot0)
		if manager.time:GetServerTime() - GuildData:GetRequiredMemberStamptime() < 60 then
			slot0({
				result = 0
			})

			return
		end

		slot1 = manager.net

		slot1:SendWithLoadingNew(31004, {
			nothing = 1
		}, 31005, function (slot0)
			GuildData:InitGuildMember(slot0.members)
			GuildData:SetRequiredMemberStamptime()
			uv0(slot0)
		end)
	end,
	RequiredGuildRecommendList = function (slot0)
		slot1 = manager.net

		slot1:SendWithLoadingNew(31006, {
			nothing = 1
		}, 31007, function (slot0)
			if GuildData:GetGuildInfo().id ~= nil then
				return
			end

			GuildData:InitGuildRecommendList(slot0.club_list)
			uv0(slot0)
		end)
	end,
	GuildRename = function (slot0, slot1, slot2)
		slot3 = manager.net

		slot3:SendWithLoadingNew(31022, {
			name = slot0,
			type = slot1
		}, 31023, function (slot0)
			if isSuccess(slot0.result) then
				GuildData:SetGuildName(uv0)
				manager.notify:Invoke(GUILD_RENAME, uv0)
			end

			uv1(slot0)
		end)
	end,
	GuildChangeNotice = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(31024, {
			notice = slot0
		}, 31025, function (slot0)
			if isSuccess(slot0.result) then
				GuildData:SetGuildNotice(uv0)
				manager.notify:Invoke(GUILD_NOTICE, uv0)
			end

			uv1(slot0)
		end)
	end,
	GuildSwitchIcon = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(31026, {
			icon = slot0
		}, 31027, function (slot0)
			if isSuccess(slot0.result) then
				GuildData:SetGuildIcon(uv0)
				manager.notify:Invoke(GUILD_SWITCH_ICON_SERVER, uv0)
			end

			uv1(slot0)
		end)
	end,
	GuildRequestSetting = function (slot0, slot1, slot2)
		slot3 = manager.net

		slot3:SendWithLoadingNew(31018, {
			setting = {
				examine_recruit_join_request_switch = slot0,
				join_request_limit = slot1
			}
		}, 31019, function (slot0)
			uv0(slot0)
		end)
	end,
	GuildExit = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(31012, {
			id = slot0
		}, 31013, function (slot0)
			if isSuccess(slot0.result) then
				uv0.GuildExitFun()
			end

			uv1(slot0)
		end)
	end,
	GuildRemoveMember = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(31014, {
			id = slot0
		}, 31015, function (slot0)
			uv0(slot0)
		end)
	end,
	GuildMobilityCaptain = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(31016, {
			id = slot0,
			post = GuildConst.GUILD_POST.CAPTAIN
		}, 31017, function (slot0)
			uv0(slot0)
		end)
	end,
	GuildMobilityDeputy = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(31016, {
			id = slot0,
			post = GuildConst.GUILD_POST.DEPUTY
		}, 31017, function (slot0)
			uv0(slot0)
		end)
	end,
	GuildDismiss = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(31016, {
			id = slot0,
			post = GuildConst.GUILD_POST.MEMBER
		}, 31017, function (slot0)
			uv0(slot0)
		end)
	end,
	GuildImpeach = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(31020, {
			nothing = 1
		}, 31021, function (slot0)
			uv0(slot0)
		end)
	end,
	GuildCancelImpeach = function (slot0)
		slot1 = manager.net

		slot1:SendWithLoadingNew(31030, {
			nothing = 1
		}, 31031, function (slot0)
			if isSuccess(slot0.result) then
				manager.redPoint:setTip(RedPointConst.GUILD_IMPEACH, 0)
			end

			uv0(slot0)
		end)
	end,
	GuildAgreeRequest = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(31032, {
			type = 1,
			Id = slot0
		}, 31033, function (slot0)
			uv0(slot0)
			SendMessageManagerToSDK("guild_join")
		end)
	end,
	GuildRefuseRequest = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(31032, {
			type = 2,
			Id = slot0
		}, 31033, function (slot0)
			uv0(slot0)
		end)
	end,
	ApplyCaptain = function (slot0)
		slot1 = manager.net

		slot1:SendWithLoadingNew(31034, {
			nothing = 1
		}, 31035, function (slot0)
			if isSuccess(slot0.result) then
				GuildData:ApplyCaptain()
				manager.notify:Invoke(GUILD_CAPTAIN_IMPEACH)
			end

			uv0(slot0)
		end)
	end,
	EnterGuild = function ()
		if table.length(GuildData:GetRecommendList()) <= 0 then
			GuildAction.RequiredGuildRecommendList(function (slot0)
				if isSuccess(slot0.result) then
					JumpTools.OpenPageByJump("/guildEntrace/guildFounded")
				else
					ShowTips(slot0.result)
				end
			end)
		else
			JumpTools.OpenPageByJump("/guildEntrace/guildFounded")
		end
	end,
	GuildExitFun = function ()
		GuildData:ExitGuild()
		ChatGuildData:RemoveChatData()
		CommunityData:CommunityExit()
		ChatGuildRecruitData:RemoveRequireData()
		manager.notify:Invoke(GUILD_EXIT)
		uv0.UpdateGuildBossRedPoint()
	end,
	GuildShare = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(27400, {
			recommend = slot0
		}, 27401, function (slot0)
			uv0(slot0)
		end)
	end,
	RequestClubBossInfo = function (slot0)
		manager.net:SendWithLoadingNew(33000, {
			club_id = slot0
		}, 33001, uv0.OnRequestClubBossInfoCallback)
	end,
	OnRequestClubBossInfoCallback = function (slot0, slot1)
	end,
	GetAssistBriefInfo = function (slot0)
		manager.net:SendWithLoadingNew(33002, {
			club_id = slot0
		}, 33003, uv0.OnGetAssistBriefInfoCallback)
	end,
	OnGetAssistBriefInfoCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			GuildData:InitAssistInfoListFromServer(slot0.assist_info_list)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	GuildBossChangeDifficulty = function (slot0)
		manager.net:SendWithLoadingNew(33004, {
			difficulty = slot0
		}, 33005, uv0.OnGuildBossChangeDifficultyCallback)
	end,
	OnGuildBossChangeDifficultyCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			GuildData:OnBossDifficultlyChange(slot1.difficulty)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	GuildBossGetRankInfo = function (slot0)
		manager.net:SendWithLoadingNew(33006, {
			club_id = slot0
		}, 33007, uv0.OnGuildBossGetRankInfoCallback)
	end,
	OnGuildBossGetRankInfoCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			GuildData:InitGuildBossRankFromServer(slot0.info_list)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	GetGuildBossReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(33008, {
			club_id = slot0,
			type = slot1,
			award_id = slot2
		}, 33009, uv0.OnGetGuildBossRewardCallback)
	end,
	OnGetGuildBossRewardCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if slot1.type == 1 then
				slot5 = GuildData:GetBossDifficulty()

				for slot5, slot6 in ipairs(ClubBossCfg[slot5].personal_reward) do
					if slot6[1] == slot1.award_id then
						getReward(mergeReward(slot6[2]))

						break
					end
				end

				GuildData:OnGuildBossPersonalRewardGet(slot1.award_id)
				uv0.UpdateGuildPersonRedPoint()
			elseif slot1.type == 2 then
				slot5 = GuildData:GetBossDifficulty()

				for slot5, slot6 in ipairs(ClubBossCfg[slot5].reward) do
					if slot6[1] == slot1.award_id then
						getReward(mergeReward(slot6[2]))

						break
					end
				end

				GuildData:OnGuildBossCommonRewardGet(slot1.award_id)
				uv0.UpdateGuildCommonRedPoint()
			elseif slot1.type == 3 then
				getReward(ClubBossPreposeCfg[1].personal_reward)
				GuildData:OnGetGuildBossFirstBonus()
				uv0.UpdateGuildBossPreposeFirstRedPoint()
			end

			manager.notify:Invoke(GUILD_BOSS_BONUS_GET, {})
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	SetAssistHero = function (slot0, slot1)
		manager.net:SendWithLoadingNew(33010, {
			club_id = slot0,
			hero_id = slot1
		}, 33011, uv0.OnSetAssistHeroCallback)
	end,
	OnSetAssistHeroCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			GuildData:SetAssistHero(slot1.hero_id)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	UpdateGuildBossRedPoint = function ()
		uv0.UpdateGuildBossFirstOpenRedPoint()
		uv0.UpdateGuildPersonRedPoint()
		uv0.UpdateGuildCommonRedPoint()
		uv0.UpdateGuildBossPreposeFirstRedPoint()
	end,
	UpdateGuildBossPreposeFirstRedPoint = function ()
		if not GuildData:GetBossData().initedFromServer then
			manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PREPOSE_FIRST_BONUS, 0)

			return
		end

		manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PREPOSE_FIRST_BONUS, GuildData:CanGetBonus() and 1 or 0)
	end,
	UpdateGuildPersonRedPoint = function ()
		if not GuildData:GetBossData().initedFromServer then
			manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PERSONAL_BONUS, 0)

			return
		end

		slot1 = false

		for slot5, slot6 in ipairs(ClubBossCfg[GuildData:GetBossDifficulty()].personal_reward) do
			slot8 = slot6[1] <= GuildData:GetBossPersonalScore()

			if not GuildData:HaveGetGuildBossPersonalReward(slot6[1]) then
				slot1 = slot8

				break
			end

			slot1 = false

			break
		end

		manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PERSONAL_BONUS, slot1 and 1 or 0)
	end,
	UpdateGuildCommonRedPoint = function ()
		if not GuildData:GetBossData().initedFromServer then
			manager.redPoint:setTip(RedPointConst.GUILD_BOSS_COMMON_BONUS, 0)

			return
		end

		slot1 = false

		for slot5, slot6 in ipairs(ClubBossCfg[GuildData:GetBossDifficulty()].reward) do
			if not GuildData:HaveGetGuildBossCommonReward(slot6[1]) and ClubBossCfg[GuildData:GetBossDifficulty()].boss_hp * (100 - slot6[1]) / 100 >= ClubBossCfg[GuildData:GetBossDifficulty()].boss_hp - GuildData:GetCurrentBossDamage() then
				break
			end
		end

		manager.redPoint:setTip(RedPointConst.GUILD_BOSS_COMMON_BONUS, slot1 and 1 or 0)
	end,
	UpdateGuildBossFirstOpenRedPoint = function ()
		if not GuildData:GetBossData().initedFromServer then
			manager.redPoint:setTip(RedPointConst.GUILD_BOSS_CHALLENGE_OPEN, 0)
			manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PREPOSE_OPEN, 0)

			return
		end

		slot0, slot1 = GuildData:GetLastTime()

		if slot0 == "prepose" then
			saveData("guild_boss", "challenge", 1)

			if (getData("guild_boss", "prepose") or 1) == 1 then
				manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PREPOSE_OPEN, 1)
			else
				manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PREPOSE_OPEN, 0)
			end

			manager.redPoint:setTip(RedPointConst.GUILD_BOSS_CHALLENGE_OPEN, 0)
		else
			saveData("guild_boss", "prepose", 1)

			if (getData("guild_boss", "challenge") or 1) == 1 then
				manager.redPoint:setTip(RedPointConst.GUILD_BOSS_CHALLENGE_OPEN, 1)
			else
				manager.redPoint:setTip(RedPointConst.GUILD_BOSS_CHALLENGE_OPEN, 0)
			end

			manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PREPOSE_OPEN, 0)
		end
	end
}
