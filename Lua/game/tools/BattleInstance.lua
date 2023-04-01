slot1 = nil

return {
	OnceMoreBattle = function (slot0)
		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == slot0.GetType(slot0) or BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == slot1 then
			if not MythicData:GetIsNew() then
				BattleController.GetInstance():LaunchBattle(slot0)
			else
				ShowTips("MYTHIC_REFRESH")
			end
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == slot1 then
			slot2 = slot0:GetStageId()

			if slot4[(table.indexof(ChapterCfg[getChapterIDByStageID(slot2)].section_id_list, slot2) or 0) + 1] ~= nil then
				BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER, slot4[slot5 + 1]))
			else
				ShowTips("ERROR_BAD_TEMPLATE")
			end
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == slot1 then
			if BattleEquipData:GetBattleEquipData().next_refresh_time < manager.time:GetServerTime() then
				if uv0 ~= nil then
					return
				end

				ShowTips("STAGE_REFRESH_DATA")

				uv0 = Timer.New(function ()
					uv0.QuitBattle(uv1)

					uv2 = nil
				end, 1.2, 1)

				uv0:Start()
			else
				BattleController.GetInstance():LaunchBattle(slot0)
			end
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == slot1 then
			if MatrixData:GetGameState() == MatrixConst.STATE_TYPE.STARTED then
				BattleController.GetInstance():LaunchBattle(slot0)
			else
				ShowTips("STAGE_REFRESH_DATA")
			end
		elseif BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE == slot1 then
			slot3 = slot0:GetActivityID()

			BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE, SequentialBattleChapterCfg[slot3].stage_id[SequentialBattleData:GetCurrentFinishStageIndex(activityID) + 1], slot3))
		else
			BattleController.GetInstance():LaunchBattle(slot0)
		end
	end,
	TryNextBattle = function (slot0)
		if BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == slot0.GetType(slot0) then
			if slot0.GetNextStage and slot0.GetNextStage(slot0) ~= nil and not MythicData:GetIsNew() then
				BattleController.GetInstance():LaunchBattle(slot0:GetNextStage())

				return
			else
				BattleInstance.QuitBattle(slot0)
			end
		end
	end,
	GotoBattleReadyPage = function (slot0, slot1, slot2)
		if whereami == "battleResult" or whereami == "battle" then
			DestroyLua()
			LuaExchangeHelper.GoToMain()
		else
			gameContext:Back()
			BattleFieldData:SetStoryBackFlag(true)
			gameContext:Back()
		end

		if slot2 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT then
			gameContext:OverrideUrl("/chapterSection", "/chapterSection", {
				chapterID = slot0,
				section = slot1
			})
		elseif slot2 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
			BattleFieldData:SetCacheStage(slot0, slot1)
			JumpTools.Jump2SubPlot(getChapterClientCfgByChapterID(slot0).id)
		end

		if ChapterCfg[slot0].cue_sheet ~= "" then
			manager.audio:PlayBGM(slot3.cue_sheet, slot3.cue_name, slot3.awb)
		end

		OpenPageUntilLoaded("/sectionSelectHero", {
			section = slot1,
			sectionType = slot2
		})
	end,
	QuitBattle = function (slot0, slot1, slot2)
		slot3 = slot0.GetType(slot0)

		if slot0.GetIsStoryTag(slot0) and whereami ~= "battleResult" and whereami ~= "battle" then
			if slot3 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or slot3 == BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY or slot3 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
				gameContext:Back()
			end

			BattleFieldData:SetStoryBackFlag(true)
			gameContext:Back()

			return
		end

		slot4 = slot0.GetStageId(slot0)

		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS == slot3 then
			if not slot1 and slot0.GetNextStage and slot0.GetNextStage(slot0) ~= nil then
				BattleController.GetInstance():LaunchBattle(slot0:GetNextStage())

				return
			else
				DestroyLua()
				WarChessAction.EnterChessMap()
			end
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY == slot3 then
			StartGuildActivity(slot0.GetNodeId(slot0))

			return
		else
			DestroyLua()
			LuaExchangeHelper.GoToMain()
		end

		slot5 = getChapterIDByStageID(slot4)

		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot3 then
			if not slot1 then
				if getChapterClientCfgByChapterID(slot5).id == 10112 and table.keyof(slot6.chapter_list, slot5) < #slot6.chapter_list and slot4 == ChapterCfg[slot5].section_id_list[#ChapterCfg[slot5].section_id_list] and BattleStageData:GetStageData()[slot4].clear_times == 1 then
					gameContext:OverrideUrl("/chapterSection", "/chapterVariantBase")
					OpenPageUntilLoaded("/chapterVariantBase", {
						chapterClientID = slot6.id
					})

					return
				end

				slot5 = StageTools.GetAutoChapter(slot5, slot4)
			end

			OpenPageUntilLoaded("/chapterSection", {
				chapterID = slot5
			})
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT == slot3 then
			JumpTools.Jump2SubPlot(getChapterClientCfgByChapterID(slot5).id)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY == slot3 then
			OpenPageUntilLoaded("/daily", {
				chapterID = slot5
			})
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == slot3 then
			OpenPageUntilLoaded("/tower", {
				showInfo = true,
				chapterId = slot5
			})
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT == slot3 then
			OpenPageUntilLoaded("/enchantment")
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == slot3 then
			OpenPageUntilLoaded("/equipSection", {
				chapterID = slot5
			})
		elseif BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL == slot3 then
			if EquipBreakThroughMaterialData:GetSelectModeID() == 0 then
				gameContext:OverrideUrl("/equipBreakThroughMaterialMap", "/equipBreakThroughMaterialMode")
				OpenPageUntilLoaded("/equipBreakThroughMaterialMode")
			else
				OpenPageUntilLoaded("/equipBreakThroughMaterialMap")
			end
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == slot3 then
			if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
				if #BattleBossChallengeData:GetOpenModeList() >= 2 then
					gameContext:OverrideUrl("/bossSwitch", "/bossMode")
					gameContext:OverrideUrl("/bossAdvanceSwitch", "/bossMode")
					OpenPageUntilLoaded("/bossMode")
				else
					OpenPageUntilLoaded("/bossSwitch")
				end
			else
				OpenPageUntilLoaded("/bossChallenge")
			end
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE == slot3 then
			if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
				gameContext:OverrideUrl("/bossSwitch", "/bossMode")
				gameContext:OverrideUrl("/bossAdvanceSwitch", "/bossMode")
				OpenPageUntilLoaded("/bossMode")
			else
				OpenPageUntilLoaded("/bossAdvanceInfo", {
					bossIndex = slot0.GetBossIndex(slot0)
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == slot3 then
			OpenPageUntilLoaded("/mythic")
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING == slot3 or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING == slot3 then
			OpenPageUntilLoaded("/teachStage")
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == slot3 then
			if MatrixData:GetGameState() == MatrixConst.STATE_TYPE.SUCCESS or slot6 == MatrixConst.STATE_TYPE.FAIL then
				OpenPageUntilLoaded("/matrixBlank/matrixOver")
			elseif slot6 == MatrixConst.STATE_TYPE.STARTED then
				OpenPageUntilLoaded("/matrixBlank/matrixOrigin")
			else
				OpenPageUntilLoaded("/matrixBlank/matrixPrepare", {
					isTimeOut = true
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS == slot3 then
			OpenPageUntilLoaded("/warHome")
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY == slot3 then
			if slot0.GetActivityID(slot0) == ActivityConst.OSIRIS_STROY then
				OpenPageUntilLoaded("/osirisStoryStage")
			elseif slot6 == ActivityConst.HELLA_STORY_STAGE_HELLA or slot6 == ActivityConst.HELLA_STORY_STAGE_HERMES then
				OpenPageUntilLoaded("/storyStageActivity", {
					theme = ActivityConst.THEME.HELLA,
					chapterID = StoryStageActivityData:GetHistoryChapter(slot6)
				})
			elseif slot6 == ActivityConst.SUMMER_STORY_ISLAND then
				OpenPageUntilLoaded("/summerStageMain", {
					theme = ActivityConst.THEME.SUMMER,
					chapterID = StoryStageActivityData:GetHistoryChapter(slot6)
				})
			elseif slot6 == ActivityConst.SUMMER_STORY_SEABED then
				OpenPageUntilLoaded("/summerStageSeabed", {
					theme = ActivityConst.THEME.SUMMER,
					chapterID = StoryStageActivityData:GetHistoryChapter(slot6)
				})
			elseif slot6 == ActivityConst.THIRD_VOLUME_PART_2_SUB_PLOT then
				OpenPageUntilLoaded("/activityAthenaStoryStage", {
					theme = ActivityConst.THEME.SUMMER,
					chapterID = StoryStageActivityData:GetHistoryChapter(slot6)
				})
			elseif ActivityTools.GetActivityTheme(slot6) == ActivityConst.THEME.FACTORY then
				OpenPageUntilLoaded("/activityFactoryStoryStage", {
					theme = ActivityConst.THEME.FACTORY,
					chapterID = StoryStageActivityData:GetHistoryChapter(slot6)
				})
			else
				OpenPageUntilLoaded("/activityStoryStageBase", {
					theme = ActivityConst.THEME.SUMMER,
					chapterID = StoryStageActivityData:GetHistoryChapter(slot6)
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON == slot3 then
			if ActivityTools.GetActivityTheme(ActivityTools.GetMainActivityId(DemonChallengeCfg[slot0.GetActivityID(slot0)].activity_id)) == ActivityConst.THEME.VOLUME_DOWN then
				OpenPageUntilLoaded("/volumeDemonChallengeMain", {
					activityId = slot8,
					childId = slot7
				})
			elseif slot9 == ActivityConst.THEME.DREAM then
				OpenPageUntilLoaded("/dreamDemonChallengeMain", {
					activityId = slot8,
					childId = slot7
				})
			else
				OpenPageUntilLoaded("/demonChallengeMain", {
					activityId = slot8,
					childId = slot7
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.NEW_DEMON == slot3 then
			if ActivityTools.GetActivityTheme(ActivityTools.GetMainActivityId(NewDemonChallengeCfg[slot0.GetActivityID(slot0)].activity_id)) == ActivityConst.THEME.DREAM then
				OpenPageUntilLoaded("/newDemonChallengeMain", {
					activityId = slot8,
					childId = slot7
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.HERO_TRIAL == slot3 then
			if ActivityTools.GetActivityTheme(slot0.GetActivityID(slot0)) == ActivityConst.THEME.HELLA then
				OpenPageUntilLoaded("/hellaHeroTrialActivite", {
					activiteID = slot6
				})
			elseif slot7 == ActivityConst.THEME.SUMMER then
				OpenPageUntilLoaded("/summerHeroTrialActivite", {
					activiteID = slot6
				})
			elseif slot7 == ActivityConst.THEME.VOLUME or slot7 == ActivityConst.THEME.VOLUME_DOWN then
				OpenPageUntilLoaded("/thirdVolumeHeroTrial", {
					activiteID = slot6
				})
			elseif slot7 == ActivityConst.THEME.FACTORY then
				OpenPageUntilLoaded("/factoryHeroTrial", {
					activiteID = slot6
				})
			elseif slot7 == ActivityConst.THEME.DREAM then
				OpenPageUntilLoaded("/dreamHeroTrial", {
					activiteID = slot6
				})
			elseif slot7 == ActivityConst.THEME.TYR then
				OpenPageUntilLoaded("/heroTrialView_1_7", {
					activiteID = slot6
				})
			elseif slot7 == 14 then
				OpenPageUntilLoaded("/activityMain_2_0", {
					activityID = ActivityConst.ACTIVITY_2_0,
					subActivityID = slot6
				})
			else
				OpenPageUntilLoaded("/heroTrialActivite", {
					activiteID = slot6
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL == slot3 then
			slot6 = slot0.GetActivityID(slot0)

			if slot0.GetDest(slot0) <= 117 then
				OpenPageUntilLoaded(string.format("/skinTrialSelect%d", slot0.GetDest(slot0)), {
					activityID = slot6,
					skinTrialID = slot0.GetDest(slot0)
				})
			else
				OpenPageUntilLoaded("/skinTrialSelectView_2_0", {
					activityID = slot6,
					skinTrialID = slot0.GetDest(slot0)
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.RACE_TRAIL == slot3 then
			slot6 = slot0:GetActivityID()
			slot8 = ActivityRaceTrialCfg[slot6].main_activity_id

			if ActivityTools.GetActivityTheme(slot6) == ActivityConst.THEME.VOLUME_DOWN then
				OpenPageUntilLoaded("/volumeRaceTrailMain", {
					activityID = slot8
				})
			else
				OpenPageUntilLoaded("/raceTrail", {
					activityID = slot8
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.SLAYER == slot3 then
			slot7 = slot0.GetDest(slot0)

			if ActivityTools.GetActivityTheme(slot0.GetActivityID(slot0)) == ActivityConst.THEME.HELLA then
				OpenPageUntilLoaded("/hellaSlayer", {
					slayer_activity_id = slot6
				})
			elseif slot8 == ActivityConst.THEME.VOLUME then
				OpenPageUntilLoaded("/volumeSlayer", {
					slayer_activity_id = slot6,
					region_activity_id = slot7
				})
			elseif slot8 == ActivityConst.THEME.TYR then
				OpenPageUntilLoaded("/slayerStageView_1_7", {
					slayer_activity_id = slot6,
					region_activity_id = slot7
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.PARKOUR == slot3 then
			slot7 = slot0.GetDest(slot0)

			if ActivityTools.GetActivityTheme(slot0.GetActivityID(slot0)) == ActivityConst.THEME.HELLA then
				if ActivityData:GetActivityIsOpen(slot6) then
					OpenPageUntilLoaded("/hellaParkourEntrust", {
						parkour_activity_id = slot6,
						entrust_activity_id = slot7
					})
				else
					OpenPageUntilLoaded("/hellaParkour", {
						parkour_activity_id = slot6
					})
				end
			end
		elseif BattleConst.STAGE_TYPE_NEW.TOWER_DEFENCE == slot3 then
			if ActivityTools.GetActivityTheme(slot0.GetActivityID(slot0)) == ActivityConst.THEME.HELLA then
				OpenPageUntilLoaded("/battleFirstPass", {
					activityId = ActivityConst.HELLA_TOWER_DEFENCE
				})
			else
				print("未有绑定对应活动！", slot6)
			end
		elseif BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE == slot3 then
			slot6 = slot4
			slot7 = SoloChallengeData:GetActivityID(slot6)
			slot10 = ActivitySoloChallengeCfg[slot7].stage_id[SoloChallengeData:GetDifficultyIndex(slot6)][2]
			slot11 = slot10[#slot10] == slot6

			if ActivityTools.GetActivityTheme(slot7) == ActivityConst.THEME.SUMMER then
				if not slot1 and slot11 then
					OpenPageUntilLoaded("/soloChallengeMain", {
						activityID = ActivitySoloChallengeCfg[slot7].main_activity_id or ActivityConst.SUMMER_SOLO_CHALLENGE
					})
				else
					OpenPageUntilLoaded("/soloChallengeSelect", {
						activityID = slot7,
						difficultyIndex = slot8
					})
				end
			elseif slot9 == ActivityConst.THEME.FACTORY then
				if not slot1 and slot11 then
					OpenPageUntilLoaded("/factorySoloChallengeMain", {
						activityID = ActivitySoloChallengeCfg[slot7].main_activity_id
					})
				else
					OpenPageUntilLoaded("/factorySoloChallengeSelect", {
						activityID = slot7,
						difficultyIndex = slot8
					})
				end
			elseif slot9 == ActivityConst.THEME.TYR then
				if not slot1 and slot11 then
					OpenPageUntilLoaded("/soloChallengeMainView_1_7", {
						activityID = ActivitySoloChallengeCfg[slot7].main_activity_id
					})
				else
					OpenPageUntilLoaded("/soloChallengeSelectView_1_7", {
						activityID = slot7,
						difficultyIndex = slot8
					})
				end
			else
				print("未有绑定对应活动！", slot7)
			end
		elseif BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION == slot3 then
			OpenPageUntilLoaded("/limitedCalculation", {
				activityId = slot0.GetActivityID(slot0)
			})
		elseif BattleConst.STAGE_TYPE_NEW.ARTIFACT == slot3 then
			OpenPageUntilLoaded("/artifactLevel", {
				activityID = ActivityConst.SUMMER_ARTIFACT
			})
		elseif BattleConst.STAGE_TYPE_NEW.LEVIATHAN_GAME == slot3 then
			OpenPageUntilLoaded("/leviathanLittleGame", {
				activityID = ActivityConst.LEVIATHAN_GAME
			})
		elseif BattleConst.STAGE_TYPE_NEW.SKADI_GAME == slot3 then
			OpenPageUntilLoaded("/skadiLittleGame", {
				activityID = ActivityConst.SIKADI_GAME
			})
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_GAME == slot3 then
			OpenPageUntilLoaded("/activityPt", {
				activityId = slot0.GetActivityID(slot0)
			})
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE == slot3 then
			if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
				OpenPageUntilLoaded("/home", {})
			else
				OpenPageUntilLoaded("/guildBossMain", {
					isFailed = slot1 and true or false
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE == slot3 then
			if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
				OpenPageUntilLoaded("/home", {})
			else
				OpenPageUntilLoaded("/guildBossChallenge", {
					isFailed = slot1 and true or false
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == slot3 then
			if ActivityMatrixData:GetGameState(slot0:GetActivityID()) == MatrixConst.STATE_TYPE.SUCCESS or slot7 == MatrixConst.STATE_TYPE.FAIL then
				OpenPageUntilLoaded("/matrixBlank/activityMatrixOver", {
					matrix_activity_id = slot6
				})
			elseif slot7 == MatrixConst.STATE_TYPE.STARTED then
				OpenPageUntilLoaded("/matrixBlank/activityMatrixOrigin", {
					matrix_activity_id = slot6
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE == slot3 then
			if ActivityTools.GetActivityTheme(slot0.GetActivityID(slot0)) == ActivityConst.THEME.VOLUME_DOWN then
				OpenPageUntilLoaded("/activityRaceSwitch", {
					activityID = slot6,
					rankID = ActivityConst.ACTIVITY_RACE_RANK
				})
			else
				OpenPageUntilLoaded("/activityRaceSwitch", {
					activityID = slot6,
					rankID = ActivityConst.ACTIVITY_RACE_RANK
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX == slot3 then
			StrategyMatrixAction.GotoAfterBattleMatirx(slot0.GetActivityID(slot0))
		elseif BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == slot3 then
			OpenPageUntilLoaded("/mythicUltimateView")
		elseif BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO == slot3 then
			if CooperationData:GetRoomData() then
				CooperationTools.GotoCooperation()
			else
				CooperationTools.GotoCooperationEntry()
			end
		elseif BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE == slot3 then
			SequentialBattleData:ResetChapterTeamData(slot0:GetActivityID())

			if slot2 then
				OpenPageUntilLoaded("/sequentialBattleFactoryTeam", {
					activityID = slot6
				})
			else
				OpenPageUntilLoaded("/sequentialBattleFactory")
			end
		elseif BattleConst.STAGE_TYPE_NEW.MARDUK_GAME == slot3 then
			OpenPageUntilLoaded("/towerGameView", {})
		elseif BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL == slot3 then
			OpenPageUntilLoaded("/mardukSpecialMain", {
				activityId = ActivityConst.FACTORY_MARDUK
			})
		elseif BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO == slot3 then
			OpenPageUntilLoaded("/surviveSolo", {
				activityId = ActivitySoloSlayerCfg[slot0.GetActivityID(slot0)].main_activity_id
			})
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS == slot3 then
			OpenPageUntilLoaded("/nienWorldBoss")
		elseif BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT == slot3 then
			OpenPageUntilLoaded("/affixSelectMain", {
				activityId = slot0.GetActivityID(slot0)
			})
		elseif BattleConst.STAGE_TYPE_NEW.DAMAGE_TEST == slot3 then
			OpenPageUntilLoaded("/bossCombatSelect", {
				damageTestId = DamageTestCfg.get_id_list_by_stage_id[slot0.GetStageId(slot0)][1]
			})
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL == slot3 then
			OpenPageUntilLoaded("/activityPt2", {
				mainActivityId = ActivityPt2Tools:GetMainActivityID(slot0:GetActivityID()),
				activityID = slot0:GetActivityID()
			})
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE == slot3 then
			OpenPageUntilLoaded("/activityPt2", {
				mainActivityId = ActivityPt2Tools:GetMainActivityID(slot0:GetActivityID()),
				activityID = slot0:GetActivityID()
			})
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD == slot3 then
			OpenPageUntilLoaded("/activityPt2", {
				mainActivityId = ActivityPt2Tools:GetMainActivityID(slot0:GetActivityID()),
				activityID = slot0:GetActivityID()
			})
		elseif BattleConst.STAGE_TYPE_NEW.ABYSS == slot3 then
			OpenPageUntilLoaded("/abyssMain", {})
		elseif BattleConst.STAGE_TYPE_NEW.POLYHEDRON == slot3 then
			if PolyhedronConst.STATE_TYPE.SETTLEMENT == PolyhedronData:GetPolyhedronInfo():GetState() then
				OpenPageUntilLoaded("/polyhedronBlank/polyhedronOver", {})
			else
				OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
			end
		end
	end,
	hideBattlePanel = function ()
		if GameObject.Find("UICamera/Canvas/UIMain") == nil then
			return
		end

		if slot0.transform:Find("BattlePanel") ~= nil then
			SetActive(slot2.gameObject, false)
		end
	end,
	GetToSeverStarList = function (slot0)
		slot1 = {}

		for slot5 = 1, #slot0 do
			if slot0 and slot0[slot5] then
				table.insert(slot1, {
					star_id = slot5 + BattleConst.STAR,
					is_achieve = slot0[slot5].isComplete and 1 or 0
				})
			end
		end

		return slot1
	end,
	CaculateChapterStar = function (slot0)
		slot1 = 0

		for slot5, slot6 in ipairs(ChapterCfg[slot0].section_id_list) do
			slot1 = slot1 + #BattleChapterStageCfg[slot6].three_star_need
		end

		return slot1
	end,
	CaculateStarMission = function (slot0, slot1)
		slot3 = {}

		if slot0.GetThreeStar(slot0) then
			for slot7 = 1, #slot2 do
				table.insert(slot3, uv0.CaculateStar(slot0, slot2[slot7], slot1))
			end
		end

		return slot3
	end,
	CaculateStar = function (slot0, slot1, slot2)
		slot4 = {
			isComplete = false,
			total = 0,
			current = 0,
			id = slot1[1],
			xData = slot1[2],
			yData = slot1[3]
		}

		if ThreeStarConditionCfg[slot1[1]].id == BattleConst.STAR_TYPE.DEAD_NUM then
			slot4.total = slot1[2]
			slot4.current = slot2.totalDeadNum
			slot4.isComplete = slot2.totalDeadNum <= slot1[2]
		elseif slot3.id == BattleConst.STAR_TYPE.NO_DEAD then
			slot4.total = 1
			slot4.current = slot2.totalDeadNum > 0 and 0 or 1
			slot4.isComplete = slot4.current == 1
		elseif slot3.id == BattleConst.STAR_TYPE.HITTED_NUM then
			slot4.total = slot1[2]
			slot4.current = slot2.totalHittedNum
			slot4.isComplete = slot2.totalHittedNum <= slot1[2]
		elseif slot3.id == BattleConst.STAR_TYPE.USE_TIME then
			slot4.total = slot1[2]
			slot4.current = math.floor(slot2.battleTime)
			slot4.isComplete = slot2.battleTime <= slot1[2]
		elseif slot3.id == BattleConst.STAR_TYPE.COMBO then
			slot4.total = slot1[2]
			slot4.current = slot2.maxComboNum
			slot4.isComplete = slot4.total <= slot4.current
		elseif slot3.id == BattleConst.STAR_TYPE.SECOND_DAMAGE then
			slot4.total = slot1[3]
			slot4.current = uv0.CaculateSecondData(slot2.damagePerCount, slot1[3] * 2 + 1)
			slot4.isComplete = slot4.total <= slot4.current
		elseif slot3.id == BattleConst.STAR_TYPE.SECOND_KILL then
			slot4.total = slot1[3]
			slot4.current = uv0.CaculateSecondData(slot2.enemyKillPerCount, slot1[3] * 2 + 1)
			slot4.isComplete = slot4.total <= slot4.current
		elseif slot3.id == BattleConst.STAR_TYPE.SUCCESS then
			slot4.isComplete = whereami ~= "battle"
		elseif slot3.id == BattleConst.STAR_TYPE.INJURED_NUM then
			slot4.total = slot1[2]
			slot4.current = slot2.injuredNum
			slot4.isComplete = slot4.current <= slot4.total
		elseif slot3.id == BattleConst.STAR_TYPE.MY_FALL then
			slot4.total = slot1[2]
			slot4.current = slot2.fallDownNum
			slot4.isComplete = slot4.current <= slot4.total
		elseif slot3.id == BattleConst.STAR_TYPE.ENEMY_FALL then
			slot4.total = slot1[2]
			slot4.current = slot2.knockoutNum
			slot4.isComplete = slot4.total <= slot4.current
		elseif slot3.id == BattleConst.STAR_TYPE.HAVE_HERO then
			slot4.total = 1
			slot4.current = 0

			for slot9, slot10 in ipairs(slot0.GetHeroTeam(slot0)) do
				if slot1[2] == slot10 then
					slot4.current = 1
				end
			end

			slot4.isComplete = slot4.current == 1
		elseif slot3.id == BattleConst.STAR_TYPE.RESURGENCE_TIME then
			slot4.total = slot1[2]
			slot4.current = slot2.resurrectTimes
			slot4.isComplete = slot2.resurrectTimes <= slot1[2]
		elseif slot3.id == BattleConst.STAR_TYPE.NO_RESURGENCE then
			slot4.total = 1
			slot4.current = slot2.resurrectTimes > 0 and 0 or 1
			slot4.isComplete = slot4.current == 1
		elseif slot3.id == BattleConst.STAR_TYPE.PROP_MULTI then
			slot4.total = slot1[2]
			slot4.current = 0
			slot6 = slot2.items:GetEnumerator()

			while slot6.MoveNext(slot6) do
				if slot6.Current.Key == slot1[3] then
					slot4.current = slot6.Current.Value or 0
				end
			end

			slot4.isComplete = slot4.total <= slot4.current
		elseif slot3.id == BattleConst.STAR_TYPE.PROP_SINGLE then
			slot4.total = 1
			slot4.current = 0
			slot6 = slot2.items:GetEnumerator()

			while slot6.MoveNext(slot6) do
				if slot6.Current.Key == slot1[2] then
					slot4.current = slot6.Current.Value or 0
				end
			end

			slot4.isComplete = slot4.total <= slot4.current
		elseif slot3.id == BattleConst.STAR_TYPE.ENEMY_EXCUTE then
			slot4.total = slot1[2]
			slot4.current = LuaExchangeHelper.GetBattleStatisticsData().deathInfos.Count
			slot4.isComplete = slot4.total <= slot4.current
		end

		return slot4
	end,
	GetStarMissionText = function (slot0, slot1, slot2)
		slot3 = ThreeStarConditionCfg[slot0]
		slot4 = slot1
		slot5 = slot2

		if slot0 == BattleConst.STAR_TYPE.HAVE_HERO then
			slot4 = HeroCfg[tonumber(slot4)].name
		elseif slot0 == BattleConst.STAR_TYPE.PROP_MULTI then
			slot5 = ItemCfg[tonumber(slot5)].name
		elseif slot0 == BattleConst.STAR_TYPE.PROP_SINGLE then
			slot4 = ItemCfg[tonumber(slot4)].name
		end

		return System.String.Format(GetI18NText(slot3.desc), GetI18NText(slot4), GetI18NText(slot5))
	end,
	RecordThreeStar = function (slot0, slot1, slot2)
		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot0 then
			BattleStageAction.ClientModifyThreeStar(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == slot0 and manager.time:GetServerTime() < BattleBossChallengeData:GetNextRefreshTime() then
			BattleBossChallengeAction.ClientModifyThreeStar(slot1, slot2)
		end
	end,
	CaculateSecondData = function (slot0, slot1)
		slot3 = 0
		slot4 = 0

		if slot0.Count <= slot1 then
			for slot8 = 0, slot2 - 1 do
				slot4 = slot0[slot8] + slot4
			end

			return slot4
		else
			for slot8 = 0, slot1 - 1 do
				slot4 = slot0[slot8] + slot4
			end

			slot3 = slot4
		end

		for slot8 = 0, slot2 - slot1 - 1 do
			slot9 = slot4 - slot0[slot8] + slot0[slot1 + slot8]
			slot3 = math.max(slot3, slot9)
			slot4 = slot9
		end

		return slot3
	end,
	GetSumData = function (slot0)
		slot2 = 0

		for slot6 = 0, slot0.Count - 1 do
			slot2 = slot2 + slot0[slot6]
		end

		return slot2
	end,
	GetMapName = function (slot0)
		if not BattleChapterStageCfg[slot0] then
			return ""
		end

		slot2, slot3 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot0)

		if ChapterCfg[getChapterIDByStageID(slot0)].difficulty == 1 then
			return string.format("%s %s-%s", GetTips("HARDLEVEL_EASY"), slot2, slot3)
		elseif slot1.type == 2 then
			return string.format("%s %s-%s", GetTips("HARDLEVEL_HARD"), slot2, slot3)
		end
	end,
	GetCurrentBattleId = function ()
		slot0 = BattleChapterStageCfg.all[1]

		for slot5, slot6 in pairs(BattleStageData:GetStageData()) do
			if getChapterClientCfgByStageID(slot5) and getChapterToggle(slot7.id) == BattleConst.TOGGLE.PLOT and slot0 < slot5 then
				slot0 = slot5
			end
		end

		return slot0
	end,
	GetHardLevel = function (slot0)
		return slot0 % 10
	end,
	GetEquipStageShowIndex = function (slot0)
		return math.floor(slot0 / 10) % 10
	end
}
