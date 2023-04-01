slot1 = manager.net

slot1:Bind(44007, function (slot0)
	MythicData:InitMythicData(slot0)
	manager.notify:CallUpdateFunc(MYTHIC_UPDATE)
end)

slot1 = manager.net

slot1:Bind(44039, function (slot0)
	MythicData:SetCurPoint(slot0.score)
end)

slot1 = manager.net

slot1:Bind(44019, function (slot0)
	MythicData:InitMythicUserPublicData(slot0)
	MythicAction:UpdateMythicRedTip()
	MythicAction:UpdateMythicFinalRedPoint()
	manager.notify:CallUpdateFunc(MYTHIC_UPDATE)
end)

slot1 = manager.net

slot1:Bind(44009, function (slot0)
	MythicData:InitMythicUserData(slot0)
	MythicAction:UpdateMythicRedTip()
	MythicAction:UpdateMythicFinalRedPoint()
end)

slot1 = manager.net

slot1:Bind(44021, function (slot0)
	MythicData:InitFinalMythicData(slot0)
end)

slot1 = manager.net

slot1:Bind(44023, function (slot0)
	MythicData:InitFinalMythicUserData(slot0)
	MythicAction.UpdateMythicFinalRedPoint()
	manager.notify:CallUpdateFunc(MYTHIC_FINAL_UPDATE)
end)

slot1 = {
	ALL = 1,
	GUILD = 2
}
slot2 = nil

return {
	QueryMythicInfo = function (slot0)
		slot1 = manager.net
		slot1 = slot1:SendWithLoading(44010, {}, 44011)

		slot1:next(function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("HAZARD_ZONE_REFRESH")
				MythicData:SetIsNew(true)
			else
				print("QueryMythicInfo error")
			end
		end)
	end,
	QueryMythicRead = function (slot0)
		slot1 = MythicData

		slot1:SetIsNewDifficulty(false)

		slot1 = manager.net
		slot1 = slot1:SendWithLoading(44014, {}, 44015)

		slot1:next(function (slot0)
			if isSuccess(slot0.result) then
				-- Nothing
			end
		end)
	end,
	QueryMythicFinalRead = function (slot0)
		slot1 = MythicData

		slot1:SetIsNewHotLevel(false)

		slot1 = manager.net
		slot1 = slot1:SendWithLoading(44032, {}, 44033)

		slot1:next(function (slot0)
			if isSuccess(slot0.result) then
				-- Nothing
			end
		end)
	end,
	QueryMythicStar = function (slot0)
		manager.net:SendWithLoadingNew(44012, {
			star = slot0
		}, 44013, uv0.MythicStarBack)
	end,
	MythicStarBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if MythicCfg[MythicData:GetDifficulty()] and MythicCfg[slot3].star_reward_list[slot1.star] or 0 then
				getReward(getRewardFromDropCfg(slot4, true))
			end

			MythicData:SetStarRewardState(slot2)
			MythicAction:UpdateMythicRedTip()
			manager.notify:CallUpdateFunc(MYTHIC_STAR_REWARD_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryChangeDifficulty = function (slot0)
		manager.net:SendWithLoadingNew(44016, {
			difficulty = slot0
		}, 44017, uv0.OnQueryChangeDifficulyuBack)
	end,
	OnQueryChangeDifficulyuBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			MythicData:SetDifficulty(slot1.difficulty)

			if slot1.difficulty == MythicData:GetFinalId() then
				gameContext:Go("/mythicUltimateView", nil, true)
				uv0.UpdateMythicFinalRedPoint()
			else
				gameContext:Go("/mythic", nil, true)
				uv0.UpdateMythicRedTip()
			end
		else
			ShowTips(slot0.result)
		end
	end,
	UpdateMythicRedTip = function (slot0)
		if MythicData:GetDifficulty() ~= MythicData:GetFinalId() then
			if MythicData:GetDifficulty() and slot1 ~= 0 then
				for slot6 = 1, MythicData:GetStarCount() do
					if not MythicData:GetStarRewardState(slot6) then
						manager.redPoint:setTip(RedPointConst.MYTHIC_TIMES_AWARD, 1)

						return
					end
				end
			end

			manager.redPoint:setTip(RedPointConst.MYTHIC_TIMES_AWARD, 0)
		end
	end,
	UpdateMythicFinalRedPoint = function ()
		if MythicData:GetFinalRewardNotGet() then
			manager.redPoint:setTip(RedPointConst.MYTHIC_FINAL_AWARD, 1)
		else
			manager.redPoint:setTip(RedPointConst.MYTHIC_FINAL_AWARD, 0)
		end
	end,
	GetFinalReward = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(44028, {
			difficulty_id = slot1
		}, 44029, function (slot0, slot1)
			if isSuccess(slot0.result) then
				getReward(MythicData:GetFinalReward(slot1.difficulty_id))
				MythicAction.UpdateMythicFinalRedPoint()
				manager.notify:CallUpdateFunc(MYTHIC_FINAL_GETREWARD)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	GetAllFinalReward = function (slot0)
		slot1 = manager.net

		slot1:SendWithLoadingNew(44030, {}, 44031, function (slot0, slot1)
			if isSuccess(slot0.result) then
				getReward(MythicData:GetAllFinalReward())
				MythicAction.UpdateMythicFinalRedPoint()
				manager.notify:CallUpdateFunc(MYTHIC_FINAL_GETREWARD)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	QuitBattle = function ()
		slot0 = manager.net

		slot0:SendWithLoadingNew(44026, {}, 44027, function (slot0)
			if isSuccess(slot0.result) then
				MythicData:ClearBattleData()
				manager.notify:CallUpdateFunc(MYTHIC_FINAL_QUITBATTLE)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	SelectLevel = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(44024, {
			difficulty_id = slot1
		}, 44025, function (slot0, slot1)
			if isSuccess(slot0.result) then
				MythicData:SetCurHotLevelId(slot1.difficulty_id)
				manager.notify:CallUpdateFunc(MYTHIC_FINAL_HOTITEM_CLICK)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ReSetTeam = function (slot0)
		slot1 = manager.net

		slot1:SendWithLoadingNew(44026, {}, 44027, function (slot0)
			if isSuccess(slot0.result) then
				MythicData:ReSetTeam()

				if uv0 then
					uv0()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	QueryCurRank = function ()
		slot0 = manager.net
		slot0 = slot0:Send(44036, {}, 44037)

		slot0:next(function (slot0)
			if isSuccess(slot0.result) then
				MythicData:InitCurRank(slot0)
				manager.notify:CallUpdateFunc(MYTHIC_RANK_CUR_UPDATE)
			end
		end)
	end,
	QueryRankList = function (slot0)
		slot1 = 1
		slot2 = 100
		slot3 = MythicData:GetRankVersion()

		if GuildData:GetGuildInfo().id == nil then
			MythicData:SetCurRankType(uv0.ALL)
		end

		if MythicData:GetCurRankType() == uv0.ALL then
			manager.net:SendWithLoadingNew(44034, {
				start = slot1,
				stop = slot2,
				version = slot3
			}, 44035, uv1.OnRankListCallBack)
		else
			uv2 = slot0

			manager.net:SendWithLoadingNew(33304, {}, 33305, uv1.OnRankListCallBack)
		end
	end,
	OnRankListCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if MythicData:GetCurRankType() == uv0.ALL then
				MythicData:InitRankData(slot0)
			else
				MythicData:InitGuildRankData(slot0, uv1)
			end
		elseif MythicData:GetCurRankType() == uv0.GUILD then
			MythicData:ResetGuildRankData()
		end

		JumpTools.OpenPageByJump("/mythicFinalRankView")
	end,
	SaveAllTeam = function (slot0)
		slot1 = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL
		slot4 = true
		slot5 = {}

		if #MythicData:GetCurLevelIdList() > 1 then
			for slot9 = 1, slot3 do
				slot16 = slot9
				slot11 = {
					id = slot9,
					hero_list = {}
				}

				for slot15, slot16 in ipairs(BattleTeamData:GetSingleTeam(BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL, nil, slot15, slot16)) do
					if slot16 ~= 0 then
						slot4 = false

						table.insert(slot11.hero_list, {
							hero_id = slot16,
							owner_id = 0,
							hero_type = 1
						})
					end
				end

				slot12, slot13 = BattleTeamData:GetMimirInfo(slot1, nil, , slot9)
				slot11.mimir_info = {
					mimir_id = slot12,
					chip_list = slot13
				}
				slot11.cooperate_unique_skill_id = BattleTeamData:GetComboInfo(slot1, nil, , slot9)

				table.insert(slot5, slot11)
			end
		else
			slot7 = {
				id = 1,
				hero_list = {}
			}

			for slot11, slot12 in ipairs(GetLocalHeroTeam(BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL, slot2[1])) do
				if slot12 ~= 0 then
					slot4 = false

					table.insert(slot7.hero_list, {
						hero_id = slot12,
						owner_id = 0,
						hero_type = 1
					})
				end
			end

			slot8, slot9 = BattleTeamData:GetMimirInfo(slot1, nil, , 1)
			slot7.mimir_info = {
				mimir_id = slot8,
				chip_list = slot9
			}
			slot7.cooperate_unique_skill_id = BattleTeamData:GetComboInfo(slot1, nil, , 1)

			table.insert(slot5, slot7)
		end

		if slot4 then
			return
		end

		slot7 = manager.net

		slot7:SendWithLoadingNew(63000, {
			activity_id = 0,
			stage_type = slot1,
			cont_teams = {
				teams = slot5
			},
			data = {
				chess_data_info_1 = {},
				chess_data_info_2 = {}
			}
		}, 63001, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 then
					uv0()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	SwapTeam = function (slot0, slot1, slot2)
		slot4 = GetHeroTeamActivityID(BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL)
		slot7 = {}

		for slot11 = 1, #MythicData:GetCurLevelIdList() do
			slot12 = BattleTeamData:GetSingleTeam(BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL, slot4, nil, slot11)
			slot13 = {}

			if slot11 == slot0 then
				slot13.id = slot1
			elseif slot11 == slot1 then
				slot13.id = slot0
			else
				slot13.id = slot11
			end

			slot13.hero_list = {}

			for slot17, slot18 in ipairs(slot12) do
				if slot18 ~= 0 then
					table.insert(slot13.hero_list, {
						hero_id = slot18,
						owner_id = 0,
						hero_type = 1
					})
				end
			end

			slot14, slot15 = BattleTeamData:GetMimirInfo(slot3, slot4, nil, 1)
			slot13.mimir_info = {
				mimir_id = slot14,
				chip_list = slot15
			}
			slot13.cooperate_unique_skill_id = BattleTeamData:GetComboInfo(slot3, slot4, nil, 1)

			table.insert(slot7, slot13)
		end

		slot9 = BattleTeamData

		slot9:SwapTeam(slot3, slot4, nil, slot0, slot1)

		slot9 = manager.net

		slot9:SendWithLoadingNew(63000, {
			stage_type = slot3,
			activity_id = slot4,
			cont_teams = {
				teams = slot7
			},
			data = {
				chess_data_info_1 = {},
				chess_data_info_2 = {}
			}
		}, 63001, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 then
					uv0()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end
}
