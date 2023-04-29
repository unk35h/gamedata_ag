slot1 = import("game.const.BattleConst")
slot2 = import("game.tools.BattleInstance")
slot3 = import("game.const.ViewConst")
slot4 = {}

return {
	GetName = function (slot0)
		if SystemLinkCfg[slot0[1]].id == uv0.JUMP_SPECIAL_ID.BATTLE_MAIN then
			return uv1.GetMapName(slot0[3]), slot1.text_display_1
		elseif slot1.id == uv0.JUMP_SPECIAL_ID.BATTLE_DAILY or slot1.id == uv0.JUMP_SPECIAL_ID.BATTLE_ASTROLABE or slot1.id == uv0.JUMP_SPECIAL_ID.BATTLE_EQUIP then
			return ChapterCfg[slot0[2]].subhead, slot1.text_display_1
		else
			return slot1.text_display_2, slot1.text_display_1
		end
	end,
	OpenPageUntilLoaded = function (slot0, slot1, slot2)
		if LuaExchangeHelper.GetSceneIsHanding() then
			gameContext:SetUrlAndParams(slot0, slot1)
		else
			CheckManagers()
			uv0.OpenPageByJump(slot0, slot1, slot2)
		end
	end,
	OpenPageUntilLoadedByTable = function (slot0, slot1)
		slot2, slot3 = uv0.GetLinkAndParams(slot0)

		uv0.OpenPageUntilLoaded(slot2, slot3, slot1)
	end,
	IS_OPENING_PAGE = false,
	JumpToPage = function (slot0)
		uv0.JumpToPage2(slot0)
	end,
	JumpToPage2 = function (slot0)
		slot1 = SystemLinkCfg[slot0[1]]

		if uv0.GetSystemActivityID(slot0) and slot2 ~= 0 then
			slot3, slot4, slot5 = uv0.GetActivityTime(slot2)

			if manager.time:GetServerTime() < slot3 then
				ShowTips(string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(slot3)))

				return
			end

			if slot4 <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")

				return
			end

			if ActivityEntraceCfg[slot2] and slot6.story_id ~= 0 and not manager.story:IsStoryPlayed(slot6.story_id) then
				manager.notify:Invoke(MUTE_MAIN_AUDIO)

				if JumpTools.GetLinkIsLocked(slot0) then
					slot7, slot8 = JumpTools.GetSystemLockedText(slot0)

					ShowTips(slot8)

					return
				end

				slot7 = manager.story

				slot7:StartStoryById(slot6.story_id, function ()
					PlayerData:StoryModify(uv0.story_id)
					uv1.JumpToPage2(uv2)
				end)

				return
			end

			if slot0[1] ~= 11001 and not ActivityTools.IsUnlockActivity(slot2) then
				if ActivityCfg[slot2].unlock_condition[1] == 100 then
					ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityStoryChapterCfg[slot8[2][1]].name, BattleActivityStoryStageCfg[slot8[2][2]].name))

					return
				elseif slot8[1] == 101 then
					slot9 = ChapterCfg[slot8[2][1]]

					ShwoTips(string.format(GetTips("NEED_FINISH_PRE_STAGE"), GetTips(uv1.HARD_LANGUAGE[slot9.difficulty]), slot9.english))

					return
				end
			end

			if not slot5 then
				ShowTips("ERROR_ACTIVITY_NOT_EXIST")

				return
			end

			slot7 = GameSetting.activity_main_plot_unlock_level.value[1]

			if slot0[1] == uv2.JUMP_SPECIAL_ID.BATTLE_MAIN and PlayerData:GetPlayerInfo().userLevel < slot7 then
				ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), GameSetting.activity_main_plot_unlock_level.value[1]))

				return
			end
		end

		if slot0[1] == uv2.JUMP_SPECIAL_ID.BATTLE_MAIN then
			slot3, slot4 = nil
			slot5 = ChapterCfg[slot0[2]].section_id_list

			if slot0[3] == nil then
				slot0[3] = slot5[#slot5]
			end

			slot3, slot4 = getMaxOpenSection(slot0[3])

			if ChapterCfg[slot0[2]].unlock_activity_id ~= 0 and manager.time:GetServerTime() < ActivityData:GetActivityData(slot6).startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot7.startTime)))

				return
			end

			if slot0[2] == 11112 then
				if ChapterTools.IsClearChapter(10112) == false then
					uv0.JumpToPage2({
						slot0[1],
						10112
					})

					return
				end

				if not SkuldTravelData:IsCollectAllPhoto() then
					ShowTips(GetTips("TRAVEL_SKULD_COLLECT_ALL_PHOTO"))

					return
				end
			elseif slot0[2] == 12112 and BattleStageData:GetStageData()[slot5[1]] == nil then
				uv0.JumpToPage2({
					slot0[1],
					11112
				})

				return
			end

			uv0.OpenPageByJump(uv0.GetLinkAndParams({
				slot0[1],
				slot4,
				slot3
			}))

			return
		elseif slot0[1] == uv2.SYSTEM_ID.BUY_FATIGUE and slot0[2] == 2 then
			if uv0.GetLinkIsLocked(slot0) then
				slot3, slot4 = JumpTools.GetSystemLockedText(slot0)

				ShowTips(slot4)

				return
			end

			if GameSetting.fatigue_max_buy_time.value[1] <= CurrencyData:GetFatigueBuyTimes() then
				ShowTips("ERROR_ITEM_DIAMOND_FATIGUE_TIMES_OVER_LIMIT")

				return
			end
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.MATRIX then
			uv0.GoToMatrix()

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.CLUB_TASK then
			uv0.GoToGuildTask()

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.BOSS_CHALLENGE then
			if uv0.GetLinkIsLocked(slot0) then
				slot3, slot4 = JumpTools.GetSystemLockedText(slot0)

				ShowTips(slot4)

				return
			end

			BattleBossChallengeAction.EnterBossChallenge()

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.STRATEGY_MATRIX then
			StrategyMatrixAction.GotoStrategyMatrix(slot1.params[1])

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.THOR_MATRIX then
			StrategyMatrixAction.GotoStrategyMatrix(slot1.params[1])

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.POLYHEDRON then
			uv0.GoToPolyhedron()

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.BATTLE_EQUIP_BREAK_THROUGH_MATERIAL then
			if uv0.GetLinkIsLocked(slot0) then
				slot3, slot4 = JumpTools.GetSystemLockedText(slot0)

				ShowTips(slot4)

				return
			end

			EquipBreakThroughMaterialAction.EnterEquipBTMaterial()

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.MYTHIC then
			if uv0.GetLinkIsLocked(slot0) then
				slot3, slot4 = JumpTools.GetSystemLockedText(slot0)

				ShowTips(slot4)

				return
			else
				if MythicData:GetDifficulty() == MythicData:GetFinalId() then
					JumpTools.GoToSystem("/mythicUltimateView", nil, uv2.SYSTEM_ID.MYTHIC)
				else
					JumpTools.GoToSystem("/mythic", nil, uv2.SYSTEM_ID.MYTHIC)
				end

				return
			end
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.CANTEEN_MAP then
			if JumpTools.IsSystemLocked(uv2.SYSTEM_ID.DORM) then
				ShowTips(JumpTools.GetSystemLockedTip(uv2.SYSTEM_ID.DORM, slot3))

				return nil
			else
				uv0.GoToCanteen()

				return
			end
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.DORM_MAP then
			if JumpTools.IsSystemLocked(uv2.SYSTEM_ID.DORM) then
				ShowTips(JumpTools.GetSystemLockedTip(uv2.SYSTEM_ID.DORM, slot3))

				return nil
			else
				uv0.GoToDorm()

				return
			end
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.BACKHOME_MAP then
			if JumpTools.IsSystemLocked(uv2.SYSTEM_ID.DORM) then
				ShowTips(JumpTools.GetSystemLockedTip(uv2.SYSTEM_ID.DORM, slot3))

				return nil
			else
				JumpTools.OpenPageByJump("/backHomeEnterView")

				return
			end
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.HERO_TEACH then
			if slot0[2] ~= nil then
				if HeroData:GetHeroData(slot3).unlock ~= 1 then
					ShowTips("ERROR_HERO_NOT_UNLOCK")

					return
				end

				if HeroCfg[slot3] and slot5.study_stage and slot5.study_stage[1] then
					JumpTools.OpenPageByJump("/teachStage", {
						switchType = uv1.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
						heroID = slot3
					})
					JumpTools.OpenPageByJump("teachSectionInfo", {
						sectionType = uv1.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
						section = slot5.study_stage[1]
					})
				end
			else
				JumpTools.OpenPageByJump("/teachStage", {
					switchType = uv1.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING
				})
			end

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.CLUB_FOUNDED then
			GuildAction.EnterGuild()

			return
		elseif uv0.GetLinkIsLocked(slot0) then
			slot3, slot4 = JumpTools.GetSystemLockedText(slot0)

			ShowTips(slot4)

			return
		end

		uv0.OpenPageByJump(uv0.GetLinkAndParams(slot0))
	end,
	GoToMatrix = function ()
		if MatrixData:GetGameState() == MatrixConst.STATE_TYPE.SUCCESS or slot0 == MatrixConst.STATE_TYPE.FAIL then
			OpenPageUntilLoaded("/matrixBlank/matrixOver")
		else
			JumpTools.GoToSystem("/matrixBlank/matrixPrepare", nil, uv0.SYSTEM_ID.MATRIX)
		end
	end,
	GoToPolyhedron = function ()
		JumpTools.GoToSystem("/polyhedronBlank/polyhedronLobby", nil, uv0.SYSTEM_ID.MATRIX)
	end,
	GoToGuildTask = function ()
		if JumpTools.IsSystemOperationStoped(uv0.SYSTEM_ID.GUILD) then
			ShowTips("ERROR_FUNCTION_STOP")

			return nil
		end

		if JumpTools.IsSystemLocked(uv0.SYSTEM_ID.GUILD) then
			ShowTips(JumpTools.GetSystemLockedTip(uv0.SYSTEM_ID.GUILD, slot0))

			return
		end

		if GuildData:GetGuildInfo().id == nil then
			GuildAction.EnterGuild()
		else
			JumpTools.OpenPageByJump("/communityTask")
		end
	end,
	Jump2SubPlot = function (slot0, slot1)
		if not table.keyof(ChapterClientCfg[slot0].chapter_list, BattleFieldData:GetCacheChapter(slot0)) then
			BattleFieldData:SetCacheChapterClient(slot2.toggle, slot0)
			BattleFieldData:SetCacheChapter(slot0, slot2.chapter_list[1])
		end

		slot4 = nil
		slot5 = {
			chapterClientID = slot0
		}

		if slot3 == 6010101 then
			slot4 = "/osirisStoryRemastered"
		elseif slot3 == 6010102 or slot3 == 6010103 or slot3 == 6010104 then
			slot4 = "/hellaStoryRemastered"
		elseif slot3 == 6010105 then
			slot4 = "/hellaStoryRemastered"
		elseif slot3 == 6010106 then
			slot4 = "/summerStoryRemastered"
		elseif slot3 == 6010107 then
			slot4 = "/summerSeabedStoryRemastered"
		elseif slot3 == 6010109 then
			slot4 = "/subPlotHera"
		elseif slot3 == 6010110 or slot3 == 6010111 or slot3 == 6010112 then
			slot4 = "/activityFactoryStoryStage"
		elseif slot3 == 6010113 then
			slot4 = "/subPlotTyr"
		else
			print("未实现的支线跳转", slot3)

			slot4 = "/subPlotSection"
		end

		if LuaExchangeHelper.GetSceneIsHanding() then
			gameContext:SetUrlAndParams(slot4, slot5)
		else
			CheckManagers()
			gameContext:Go(slot4, slot5, slot1)
		end
	end,
	GetActivityTime = function (slot0)
		slot1 = ActivityData:GetActivityData(slot0)

		return slot1.startTime, slot1.stopTime, slot1:GetStateBool()
	end,
	GetLinkAndParams = function (slot0)
		slot2 = {}

		if SystemLinkCfg[slot0[1]].paramName and type(slot1.paramName) == "table" then
			slot3 = 0
			slot4 = #slot1.paramName

			if slot1.params and type(slot1.params) == "table" then
				slot3 = #slot1.params
			end

			slot5 = 2

			for slot9 = 1, slot4 do
				if slot9 <= slot3 then
					slot2[slot1.paramName[slot9]] = slot1.params[slot9]
				else
					slot2[slot1.paramName[slot9]] = slot0[slot5]
					slot5 = slot5 + 1
				end
			end
		end

		for slot6, slot7 in pairs(slot0) do
			if type(slot6) == "string" then
				slot2[slot6] = slot7
			end
		end

		return slot1.link, slot2, slot1.system_id
	end,
	GetLinkIsLocked = function (slot0)
		if uv0.IsSystemLocked(SystemLinkCfg[slot0[1]].system_id) then
			return true
		end

		slot2 = BattleStageData:GetStageData()

		if slot1.id == uv1.JUMP_SPECIAL_ID.BATTLE_MAIN and not slot2[slot0[2]] then
			return true
		end

		if slot1.id == uv1.JUMP_SPECIAL_ID.BATTLE_DAILY then
			return PlayerData:GetPlayerInfo().userLevel < BattleDailyStageCfg[ChapterCfg[slot0[2]].section_id_list[1]].level
		end

		if slot1.id == uv1.JUMP_SPECIAL_ID.BATTLE_ASTROLABE and not BattleStageData:IsOpenChapter(slot0[2]) then
			return true
		end

		if slot1.id == uv1.JUMP_SPECIAL_ID.BATTLE_EQUIP and not BattleStageData:IsOpenChapter(slot0[2]) then
			return true
		end

		if slot1.system_id == uv1.SYSTEM_ID.BATTLE and not uv0.IsChapterOpened(slot0).result then
			return true
		end

		if uv0.GetSystemActivityID(slot0) and slot3 ~= 0 then
			slot4, slot5, slot6 = uv0.GetActivityTime(slot3)

			if manager.time:GetServerTime() < slot4 then
				return true
			end

			if slot5 <= manager.time:GetServerTime() then
				return true
			end

			if slot0[1] ~= 11001 and not ActivityTools.IsUnlockActivity(slot3) then
				return true
			end

			if not slot6 then
				return true
			end
		end

		return false
	end,
	GetSystemLockedText = function (slot0)
		if SystemCfg[SystemLinkCfg[slot0[1]].system_id].id == uv0.SYSTEM_ID.BATTLE and not uv1.IsChapterOpened(slot0).result then
			return true, slot3.reason
		end

		if slot1 == uv0.JUMP_SPECIAL_ID.BATTLE_DAILY then
			return true, string.format(GetTips("PLAYER_LEVEL_UNLOCK"), BattleDailyStageCfg[ChapterCfg[slot0[2]].section_id_list[1]].level)
		end

		if slot2 and slot2.open_condition then
			for slot6, slot7 in ipairs(slot2.open_condition) do
				if slot7[1] == uv0.SYSTEM_LOCK_TYPE.LOCK then
					return true, GetTips("SYSTEM_LOCK")
				elseif slot7[1] == uv0.SYSTEM_LOCK_TYPE.LEVEL then
					if PlayerData:GetPlayerInfo().userLevel < slot7[2] then
						return true, string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot7[2])
					end
				elseif slot7[1] == uv0.SYSTEM_LOCK_TYPE.BATTLE then
					if BattleStageData:GetStageData()[slot7[2]] and slot10.clear_times > 0 then
						return false, ""
					elseif BattleChapterStageCfg[slot9] == nil then
						return true, "未知的关卡ID" .. slot9
					else
						slot14, slot15 = BattleStageTools.GetChapterSectionIndex(getChapterClientCfgByStageID(slot9).toggle, slot9)

						return true, string.format(GetTips("MISSION_PROGRESS_UNLOCK"), getChapterDifficulty(slot9), slot14, slot15)
					end
				elseif slot7[1] == uv0.SYSTEM_LOCK_TYPE.HERO_FAVORABILITY then
					slot10 = HeroRecordCfg[slot7[2]].name
					slot11 = slot7[3]

					if ArchiveData:GetArchive(slot7[2]).lv < slot7[3] then
						return true, string.format(GetTips("HERO_FAVORABILITY_UNLOCK"), slot10, slot11)
					end
				else
					print("未实现的系统解锁判断方式:", slot7[1])
				end
			end
		end

		if uv1.GetSystemActivityID(slot0) and slot3 ~= 0 then
			slot4, slot5, slot6 = uv1.GetActivityTime(slot3)

			if manager.time:GetServerTime() < slot4 then
				return true, string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot4))
			end

			if slot5 <= manager.time:GetServerTime() then
				return true, GetTips("TIME_OVER")
			end

			if slot0[1] ~= 11001 and not ActivityTools.IsUnlockActivity(slot3) then
				if ActivityCfg[slot3].unlock_condition[1] == 100 then
					return true, string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityStoryChapterCfg[slot8[2][1]].name, BattleActivityStoryStageCfg[slot8[2][2]].name)
				elseif slot8[1] == 101 then
					slot9 = ChapterCfg[slot8[2][1]]

					return true, string.format(GetTips("NEED_FINISH_PRE_STAGE"), GetTips(uv2.HARD_LANGUAGE[slot9.difficulty]), slot9.english)
				end
			end

			if not slot6 then
				return true, GetTips("TIME_OVER")
			end
		end

		return false, ""
	end,
	GetSystemActivityID = function (slot0)
		if uv0.GetSystemParamActivityID(slot0, "subActivityID") and slot1 ~= 0 then
			return slot1
		end

		if uv0.GetSystemParamActivityID(slot0, "activityId") and slot1 ~= 0 then
			return slot1
		end

		if uv0.GetSystemParamActivityID(slot0, "activityID") and slot1 ~= 0 then
			return slot1
		end
	end,
	GetSystemParamActivityID = function (slot0, slot1)
		slot3 = SystemLinkCfg[slot0[1]]
		slot4 = slot3.activity_id

		if type(slot3.paramName) == "table" and table.keyof(slot3.paramName, slot1) then
			slot4 = (type(slot3.params) ~= "table" or not slot3.params[slot5] or slot3.params[slot5]) and slot0[slot5 + 1]
		end

		return slot4
	end,
	IsSystemOperationStoped = function (slot0)
		if slot0 == nil then
			return false
		end

		if not SystemCfg[slot0] then
			return false
		end

		if slot1.operation_stop_id ~= 0 then
			if OperationData:IsFunctionStoped(slot1.operation_stop_id) then
				return true
			end

			return false
		end
	end,
	IsSystemLocked = function (slot0)
		if SystemCfg[slot0] and slot1.open_condition then
			for slot5, slot6 in ipairs(slot1.open_condition) do
				if uv0.IsConditionLocked(slot6) then
					return slot7
				end
			end
		end

		return false
	end,
	IsConditionLocked = function (slot0)
		if slot0[1] == uv0.SYSTEM_LOCK_TYPE.LOCK then
			return slot0
		elseif slot0[1] == uv0.SYSTEM_LOCK_TYPE.LEVEL then
			if PlayerData:GetPlayerInfo().userLevel < slot0[2] then
				return slot0
			end
		elseif slot0[1] == uv0.SYSTEM_LOCK_TYPE.BATTLE then
			if BattleStageData:GetStageData()[slot0[2]] and slot2.clear_times > 0 then
				return false
			else
				return slot0
			end
		elseif slot0[1] == uv0.SYSTEM_LOCK_TYPE.HERO_FAVORABILITY then
			if ArchiveData:GetArchive(slot0[2]).lv < slot0[3] then
				return slot0
			end
		else
			print("未实现的系统解锁判断方式:", slot0[1])
		end
	end,
	SetSystemOpenCheck = function (slot0, slot1)
		uv0[slot0] = slot1
	end,
	GoToSystem = function (slot0, slot1, slot2)
		if uv0.IS_OPENING_PAGE then
			return
		end

		if uv0.IsSystemOperationStoped(slot2) then
			ShowTips("ERROR_FUNCTION_STOP")

			return nil
		end

		slot3 = uv0.IsSystemLocked(slot2)

		if slot2 and slot3 then
			ShowTips(uv0.GetSystemLockedTip(slot2, slot3))

			return nil
		end

		if uv1[slot2] then
			slot4, slot5 = uv1[slot2]()

			if not slot4 then
				ShowTips(slot5)

				return nil
			end
		end

		gameContext:Go(slot0, slot1, nil, true)
	end,
	GoToCanteen = function ()
		if uv0.IsSystemLocked(uv1.SYSTEM_ID.DORM) then
			ShowTips(uv0.GetSystemLockedTip(uv1.SYSTEM_ID.DORM, slot0))

			return nil
		end

		CanteenAction:GetCanteenDetailInfo()
	end,
	GoToDorm = function ()
		if uv0.IsSystemLocked(uv1.SYSTEM_ID.DORM) then
			ShowTips(uv0.GetSystemLockedTip(uv1.SYSTEM_ID.DORM, slot0))

			return nil
		end

		DormAction:GetDormDetialInfo()
	end,
	GetSystemLockedTip = function (slot0, slot1)
		if slot0 and slot1 then
			if slot1[1] == uv0.SYSTEM_LOCK_TYPE.LEVEL then
				return string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot1[2])
			elseif slot1[1] == uv0.SYSTEM_LOCK_TYPE.BATTLE then
				slot2 = slot1[2]
				slot5, slot6 = BattleStageTools.GetChapterSectionIndex(getChapterClientCfgByStageID(slot2).toggle, slot2)

				return string.format(GetTips("MISSION_PROGRESS_UNLOCK"), getChapterDifficulty(slot2), slot5, slot6)
			elseif slot1[1] == uv0.SYSTEM_LOCK_TYPE.HERO_FAVORABILITY then
				return string.format(GetTips("HERO_FAVORABILITY_UNLOCK"), HeroRecordCfg[slot1[2]].name, slot1[3])
			end
		end

		return GetTips("SYSTEM_LOCK")
	end,
	Back = function (slot0, slot1)
		slot2 = gameContext

		slot2:Back(slot0, slot1)
		GlobalCall.register("AfterGo", function ()
			uv0.RefreshGaussianBg()
		end)
		uv0.RefreshGaussianBg()
	end,
	OpenPageByJump = function (slot0, slot1, slot2)
		if uv0.IS_OPENING_PAGE then
			return
		end

		slot5 = nil
		slot5 = (not (string.char(string.byte(slot0)) == "/") or string.split(string.sub(slot0, 2, #slot0), "/")) and string.split(slot0, "/")

		GlobalCall.register("AfterGo", function ()
			uv0.RefreshGaussianBg()
		end)
		uv0.GoToSystem(slot0, slot1, slot2)
	end,
	OpenPopUp = function (slot0, slot1, slot2, slot3)
		GlobalCall.register("AfterGo", function ()
			uv0.RefreshGaussianBg()

			if uv1 then
				uv1()
			end
		end)
		uv0.GoToSystem(slot0, slot1, slot2)
	end,
	GetRealPageName = function (slot0)
		if string.char(string.byte(slot0)) == "/" then
			return string.sub(slot0, 2, #slot0)
		else
			return slot0
		end
	end,
	RefreshGaussianBg = function ()
		slot2 = false

		for slot6 = #gameContext:GetAllOpenRoute(), 1, -1 do
			if uv0.NEED_GAUSSIAN_POPUP[slot0[slot6]] then
				uv1.SetGaussionBg(slot7, true)

				slot2 = true
			else
				uv1.SetGaussionBg(url, false)
			end
		end

		manager.ui:SetUISeparateRender(slot2)
	end,
	SetGaussionBg = function (slot0, slot1)
		if gameContext:GetOpenPageHandler(slot0) then
			slot2.SetGaussionBg(slot2, slot1)
		end
	end,
	JudgeIsHaveGaussian = function (slot0)
		for slot4, slot5 in ipairs(slot0) do
			if uv0.NEED_GAUSSIAN_POPUP[slot5] then
				return true
			end
		end

		return false
	end,
	IsChapterOpened = function (slot0)
		slot1 = slot0[1]

		if not slot0[2] then
			return {
				reason = "",
				result = true
			}
		end

		if table.indexof(ChapterCfg[slot0[2]].section_id_list, slot0[3]) then
			if slot6 == 1 then
				return {
					reason = "",
					result = true
				}
			elseif BattleStageData:GetStageData() == nil or not slot7[slot5] then
				return {
					reason = "关卡未解锁",
					result = false
				}
			else
				return {
					reason = "",
					result = true
				}
			end
		else
			return {
				reason = "找不到章节",
				result = false
			}
		end
	end
}
