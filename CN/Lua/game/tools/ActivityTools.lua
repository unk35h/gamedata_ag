slot1 = nil

return {
	GetVersionUIRoot = function (slot0)
		if math.floor(slot0 / 10000) == 13 then
			return "UI/VersionUI/DarkFlameUI/"
		end

		if slot1 == 14 then
			return "UI/VersionUI/XuHeng1stUI/"
		end

		return "UI/"
	end,
	GetCurrentAdvInfo = function ()
		slot0 = {}

		for slot4, slot5 in ipairs(MainAdvinfoCfg.all) do
			if ActivityTools.IsValidAdv(MainAdvinfoCfg[slot5].id) then
				table.insert(slot0, {
					id = slot6.id,
					image = getSpriteWithoutAtlas("Textures/Announcements/" .. (slot6.picture or "activity1") .. SettingData:GetCurrentLanguageKey())
				})
			end
		end

		table.sort(slot0, function (slot0, slot1)
			if MainAdvinfoCfg[slot0.id].order == MainAdvinfoCfg[slot1.id].order then
				return slot0.id < slot1.id
			else
				return slot2 < slot3
			end
		end)

		return slot0
	end,
	IsValidAdv = function (slot0)
		if MainAdvinfoCfg[slot0].activityId and slot2 ~= 0 then
			return ActivityData:GetActivityData(slot2) and slot3:IsActivitying() or false
		else
			if not slot1.time[1] or #slot3[1] < 3 or #slot3[2] < 3 then
				return false
			end

			if not slot1.time[2] or #slot4[1] < 3 or #slot4[2] < 3 then
				return false
			end

			return TimeMgr.GetInstance():GetServerTime() < TimeMgr.GetInstance():parseTimeFromConfig(slot1.time[2]) and TimeMgr.GetInstance():parseTimeFromConfig(slot1.time[1]) <= slot7
		end
	end,
	ClickAdv = function (slot0)
		if MainAdvinfoCfg[slot0.id].type == 1 then
			JumpTools.JumpToPage2(slot1.parameter)
		elseif slot1.type == 2 then
			Application.OpenURL(slot1.parameter[1])
		end
	end,
	GetActivityType = function (slot0)
		if ActivityCfg[slot0] then
			return slot1.activity_template
		end

		return ActivityData:GetActivityData(slot0).template
	end,
	GetActivityTheme = function (slot0)
		if ActivityCfg[slot0] then
			return slot1.activity_theme
		end

		return ActivityData:GetActivityData(slot0).theme
	end,
	JumpToSubmodulePage = function (slot0)
		slot2 = uv0.GetActivityTheme(slot0)

		if ActivityTemplateConst.STORY == uv0.GetActivityType(slot0) then
			if slot2 == ActivityConst.THEME.HELLA then
				JumpTools.OpenPageByJump("/storyStageActivity", {
					theme = slot2
				})
			elseif slot2 == ActivityConst.THEME.SUMMER then
				JumpTools.OpenPageByJump("/summerStoryMain")
			elseif slot2 == ActivityConst.THEME.FACTORY then
				JumpTools.Jump2SubPlot(6010004)
			elseif slot0 == ActivityConst.TYR_SUB_PLOT then
				JumpTools.Jump2SubPlot(6010006)
			end
		elseif ActivityTemplateConst.STORY_STAGE == slot1 then
			if slot0 == ActivityConst.THIRD_VOLUME_PART_2_SUB_PLOT then
				ActivityStoryAction.UpdateRedPoint(slot0, 0)
				JumpTools.OpenPageByJump("/activityAthenaStoryStage", {
					theme = slot2,
					chapterID = ActivityStoryChapterCfg.get_id_list_by_activity_id[slot0][1]
				})
			else
				print("未知的剧情活动" .. slot0)
				ActivityStoryAction.UpdateRedPoint(slot0, 0)
				JumpTools.OpenPageByJump("/activityStoryStageBase", {
					theme = slot2,
					chapterID = ActivityStoryChapterCfg.get_id_list_by_activity_id[slot0][1]
				})
			end
		elseif ActivityTemplateConst.DEMON == slot1 then
			if slot2 == ActivityConst.THEME.VOLUME_DOWN then
				JumpTools.OpenPageByJump("/volumeDemonChallengeMain", {
					activityId = slot0
				})
			elseif slot2 == ActivityConst.THEME.DREAM then
				JumpTools.OpenPageByJump("/dreamDemonChallengeMain", {
					activityId = slot0
				})
			else
				JumpTools.OpenPageByJump("/demonChallengeMain", {
					activityId = slot0
				})
			end
		elseif ActivityTemplateConst.NEW_DEMON == slot1 then
			JumpTools.OpenPageByJump("/newDemonChallengeMain", {
				activityId = slot0
			})
		elseif ActivityConst.SUBMODULE_TYPE.CHESS == slot1 then
			JumpTools.OpenPageByJump("/activityChessView", {
				activityId = slot0
			})
		elseif ActivityTemplateConst.TALENT_TREE == slot1 then
			JumpTools.OpenPageByJump("/talentTree", {
				activityId = slot0
			})
		elseif ActivityTemplateConst.BATTLE_FIRST_PASS == slot1 then
			JumpTools.OpenPageByJump("/battleFirstPass", {
				activityId = slot0
			})
		elseif slot1 == ActivityTemplateConst.HERO_TRIAL then
			if slot2 == ActivityConst.THEME.HELLA then
				JumpTools.OpenPageByJump("/hellaHeroTrialActivite", {
					activiteID = slot0
				})
			elseif slot2 == ActivityConst.THEME.SUMMER then
				JumpTools.OpenPageByJump("/summerHeroTrialActivite", {
					activiteID = slot0
				})
			elseif slot2 == ActivityConst.THEME.VOLUME or slot2 == ActivityConst.THEME.VOLUME_DOWN then
				JumpTools.OpenPageByJump("/thirdVolumeHeroTrial", {
					activiteID = slot0
				})
			elseif slot2 == ActivityConst.THEME.FACTORY then
				JumpTools.OpenPageByJump("/factoryHeroTrial", {
					activiteID = slot0
				})
			elseif slot2 == ActivityConst.THEME.DREAM then
				JumpTools.OpenPageByJump("/dreamHeroTrial", {
					activiteID = slot0
				})
			elseif slot2 == ActivityConst.THEME.TYR then
				JumpTools.OpenPageByJump("/heroTrialView_1_7", {
					activiteID = slot0
				})
			else
				JumpTools.OpenPageByJump("/hellaHeroTrialActivite", {
					activiteID = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.SKIN_TRIAL then
			if slot2 == ActivityConst.THEME.HELLA then
				JumpTools.OpenPageByJump("/skinTrialActivity", {
					activityID = slot0
				})
			elseif slot2 == ActivityConst.THEME.SUMMER then
				JumpTools.OpenPageByJump("/summerSkinTrialActivity", {
					activityID = slot0
				})
			elseif slot2 == ActivityConst.THEME.VOLUME or slot2 == ActivityConst.THEME.VOLUME_DOWN then
				JumpTools.OpenPageByJump("/volumeSkinTrialActivity", {
					activityID = slot0
				})
			elseif slot2 == ActivityConst.THEME.FACTORY then
				JumpTools.OpenPageByJump("/factorySkinTrialActivity", {
					activityID = slot0
				})
			elseif slot2 == ActivityConst.THEME.DREAM then
				JumpTools.OpenPageByJump("/dreamSkinTrialActivity", {
					activityID = slot0
				})
			else
				JumpTools.OpenPageByJump("/skinTrialActivity", {
					activityID = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.SLAYER then
			if slot2 == ActivityConst.THEME.HELLA then
				JumpTools.OpenPageByJump("/hellaSlayer", {
					slayer_activity_id = slot0
				})
			elseif slot2 == ActivityConst.THEME.VOLUME then
				JumpTools.OpenPageByJump("/volumeSlayerMain", {
					playerAnim = true,
					slayer_activity_id = slot0
				})
			elseif slot2 == ActivityConst.THEME.TYR then
				JumpTools.OpenPageByJump("/slayerMainView_1_7", {
					playerAnim = true,
					slayer_activity_id = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.PARKOUR then
			if slot2 == ActivityConst.THEME.HELLA then
				JumpTools.OpenPageByJump("/hellaParkour", {
					parkour_activity_id = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.SOLO_CHALLENGE then
			if slot2 == ActivityConst.THEME.SUMMER then
				JumpTools.OpenPageByJump("/soloChallengeMain", {
					activityID = slot0
				})
			elseif slot2 == ActivityConst.THEME.FACTORY then
				JumpTools.OpenPageByJump("/factorySoloChallengeMain", {
					activityID = slot0
				})
			elseif slot2 == ActivityConst.THEME.TYR then
				JumpTools.OpenPageByJump("/soloChallengeMainView_1_7", {
					activityID = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.ARTIFACT then
			if slot2 == ActivityConst.THEME.SUMMER then
				JumpTools.OpenPageByJump("/artifact", {
					activityID = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.LIMITED_CALCULATION then
			JumpTools.OpenPageByJump("/limitedCalculation", {
				activityId = slot0
			})
		elseif slot1 == ActivityTemplateConst.SKADI_LITTLE_GAME then
			JumpTools.OpenPageByJump("/skadiLittleGame", {
				activityId = slot0
			})
		elseif slot1 == ActivityTemplateConst.LEVIATHAN_LITTLE_GAME then
			JumpTools.OpenPageByJump("/leviathanLittleGame", {
				activityId = slot0
			})
		elseif slot1 == ActivityTemplateConst.FISHING then
			JumpTools.OpenPageByJump("/fishingEnter", {
				activityId = slot0
			})
		elseif slot1 == ActivityTemplateConst.SKIN_EXCHANGE then
			JumpTools.OpenPageByJump("/skinExchange", {
				activityId = slot0
			})
		elseif slot1 == ActivityTemplateConst.SUMMER_ACTIVITY_PT then
			JumpTools.OpenPageByJump("/activityPt", {
				activityId = slot0
			})
		elseif slot1 == ActivityTemplateConst.MAIN_STORY then
			slot3 = ChapterTools.GetChapterByActivityID(slot0)

			BattleFieldData:SetCacheChapterClient(ChapterClientCfg[slot3].toggle, getChapterClientCfgByChapterID(slot3).id)
			JumpTools.OpenPageByJump("/chapterMap", {
				chapterToggle = 1
			})
		elseif slot1 == ActivityTemplateConst.MOONBO then
			if slot2 == ActivityConst.THEME.VOLUME then
				JumpTools.OpenPageByJump("/moonBoView", {
					activityID = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.ACTIVITY_PUZZLE then
			JumpTools.OpenPageByJump("/puzzleMain", {
				activityID = slot0
			})
		elseif slot1 == ActivityTemplateConst.SINGLE_MATRIX then
			if slot2 == ActivityConst.THEME.VOLUME then
				JumpTools.OpenPageByJump("/matrixBlank/activityMatrix", {
					playerAnim = true,
					main_matrix_activity_id = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.COWBOY then
			JumpTools.OpenPageByJump("/cowboy", {
				activityId = slot0
			})
		elseif slot1 == ActivityTemplateConst.ACTIVITY_RACE then
			if slot2 == ActivityConst.THEME.VOLUME_DOWN then
				JumpTools.OpenPageByJump("/activityRaceMain", {
					activityID = slot0,
					rankID = ActivityConst.ACTIVITY_RACE_RANK
				})
			end
		elseif slot1 == ActivityTemplateConst.RACE_TRIAL then
			if slot2 == ActivityConst.THEME.VOLUME_DOWN then
				JumpTools.OpenPageByJump("/volumeRaceTrailMain", {
					activityID = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.ACTIVITY_MUSIC then
			if slot2 == ActivityConst.THEME.VOLUME_DOWN then
				JumpTools.OpenPageByJump("/volumeMusicMain", {
					activity_id = slot0
				})
			elseif slot2 == ActivityConst.THEME.VOLUME_DOWN then
				JumpTools.OpenPageByJump("/enternalMusicMain", {
					activity_id = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.STRATEGY_MATRIX then
			StrategyMatrixAction.GotoStrategyMatrix(slot0, true)
		elseif slot1 == ActivityTemplateConst.INFINITY_POOL_TASK then
			if slot2 == ActivityConst.THEME.FACTORY then
				JumpTools.OpenPageByJump("/infinityTaskFactory", {
					activityType = OsirisConst.ACTIVITY_TYPE.TASK,
					activityTaskID = ActivityConst.FACTORY_INFINITY_TASK,
					activityInfinityID = ActivityConst.FACTORY_INFINITY_POOL
				})
			end
		elseif slot1 == ActivityTemplateConst.SEQUENTIAL_BATTLE then
			if slot2 == ActivityConst.THEME.FACTORY then
				JumpTools.OpenPageByJump("/sequentialBattleFactory")
			end
		elseif slot1 == ActivityTemplateConst.SURVIVE_SOLO then
			JumpTools.OpenPageByJump("/surviveSolo", {
				activityId = slot0
			})
		elseif slot1 == ActivityTemplateConst.MARDUK_SPECIAL then
			JumpTools.OpenPageByJump("/mardukSpecialMain", {
				activityId = slot0
			})
		elseif slot1 == ActivityTemplateConst.MARDUK_GAME then
			JumpTools.OpenPageByJump("/towerGameView")
		elseif slot1 == ActivityTemplateConst.SPRING_FESTIVAL_RIDDLE then
			JumpTools.OpenPageByJump("/springFestivalRiddleMain")
		elseif slot1 == ActivityTemplateConst.SPRING_ANTITHETICAL_COUPLET then
			JumpTools.OpenPageByJump("/antitheticalCouplet", {
				activityId = slot0
			})
		elseif slot1 == ActivityTemplateConst.SPRING_CANTEEN then
			JumpTools.GoToCanteen()
		elseif slot1 == ActivityTemplateConst.ACTIVITY_WORLD_BOSS then
			JumpTools.OpenPageByJump("/nienWorldBoss")
		elseif slot1 == ActivityTemplateConst.PAPER_CUT then
			JumpTools.OpenPageByJump("/paperCutMain", {
				activityID = ActivityConst.PAPER_CUT_GAME
			})
		elseif slot1 == ActivityTemplateConst.SPRING_FESTIVAL_GREETING then
			JumpTools.OpenPageByJump("springFestivalGreetingEnvelop")
		elseif slot1 == ActivityTemplateConst.FIRE_WORK_MAIN then
			JumpTools.OpenPageByJump("/fireWorkMain")
		elseif slot1 == ActivityTemplateConst.VALENTINE_GAME then
			JumpTools.OpenPageByJump("/valentineGameMain", {
				activityId = slot0
			})
		elseif slot1 == ActivityTemplateConst.ACTIVITY_AFFIX_SELECT then
			JumpTools.OpenPageByJump("/affixSelectMain", {
				activityID = ActivityConst.ACTIVITY_1_7_AFFIX_SELECT
			})
		elseif slot1 == ActivityTemplateConst.ACTIVITY_CULTIVATE_HERO then
			JumpTools.OpenPageByJump("/activityCultivateHeroMain", {
				activityID = ActivityConst.ACTIVITY_CULTIVATE_HERO
			})
		end
	end,
	GetRedPointKey = function (slot0)
		if ActivityTemplateConst.DEMON == uv0.GetActivityType(slot0) then
			return RedPointConst.DEMON_CHALLENGE
		elseif ActivityTemplateConst.NEW_DEMON == slot1 then
			return RedPointConst.NEW_DEMON_CHALLENGE
		elseif ActivityTemplateConst.TALENT_TREE == slot1 then
			return RedPointConst.TALENT_TREE
		elseif ActivityTemplateConst.BATTLE_FIRST_PASS == slot1 then
			return RedPointConst.BATTLE_FIRST_PASS
		elseif ActivityTemplateConst.HERO_TRIAL == slot1 then
			return RedPointConst.HERO_TRIAL .. "_"
		elseif ActivityTemplateConst.SKIN_TRIAL == slot1 then
			return RedPointConst.SKIN_TRIAL .. "_"
		elseif ActivityTemplateConst.SLAYER == slot1 then
			return RedPointConst.SLAYER .. "_"
		elseif ActivityTemplateConst.STORY == slot1 then
			return RedPointConst.ACTIVITY_STORY_STAGE
		elseif ActivityTemplateConst.STORY_STAGE == slot1 then
			return RedPointConst.ACTIVITY_STORY_STAGE
		elseif ActivityTemplateConst.SUB_PLOT == slot1 then
			return RedPointConst.ACTIVITY_STORY_STAGE
		elseif ActivityTemplateConst.PARKOUR == slot1 then
			return RedPointConst.PARKOUR .. "_"
		elseif ActivityTemplateConst.CHESS == slot1 then
			return RedPointConst.WAR_CHESS .. "_"
		elseif ActivityTemplateConst.MAIN_ACTIVITY == slot1 then
			return RedPointConst.MAIN_ACTIVITY
		elseif ActivityTemplateConst.SOLO_CHALLENGE == slot1 then
			return RedPointConst.SOLO_CHALLENGE .. "_"
		elseif ActivityTemplateConst.LIMITED_CALCULATION == slot1 then
			return RedPointConst.LIMITED_CALCULATION
		elseif ActivityTemplateConst.ARTIFACT == slot1 then
			return RedPointConst.ARTIFACT .. "_"
		elseif ActivityTemplateConst.SKADI_LITTLE_GAME == slot1 then
			return RedPointConst.SKADI_LITTLE_GAME .. "_"
		elseif ActivityTemplateConst.LEVIATHAN_LITTLE_GAME == slot1 then
			return RedPointConst.LEVIATHAN_LITTLE_GAME .. "_"
		elseif ActivityTemplateConst.FISHING == slot1 then
			return RedPointConst.FISHING .. "_"
		elseif ActivityTemplateConst.SUMMER_ACTIVITY_PT == slot1 then
			return RedPointConst.SUMMER_ACTIVITY_PT_OPEN .. "_"
		elseif ActivityTemplateConst.SKIN_EXCHANGE == slot1 then
			return RedPointConst.ACTIVITY_SKIN_EXCHANGE .. "_"
		elseif ActivityTemplateConst.MOONBO == slot1 then
			return RedPointConst.MOONBO .. "_"
		elseif ActivityTemplateConst.ACTIVITY_PUZZLE == slot1 then
			return RedPointConst.ACTIVITY_PUZZLE .. "_"
		elseif slot1 == ActivityTemplateConst.SINGLE_MATRIX then
			return RedPointConst.ACTIVITY_MATRIX .. "_"
		elseif slot1 == ActivityTemplateConst.COWBOY then
			return RedPointConst.COWBOY .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_RACE then
			return RedPointConst.ACTIVITY_RACE .. "_"
		elseif slot1 == ActivityTemplateConst.RACE_TRIAL then
			return RedPointConst.ACTIVITY_RACE_TRIAL .. "_"
		elseif slot1 == ActivityTemplateConst.STRATEGY_MATRIX then
			return RedPointConst.STRATEGY_MATRIX .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_MUSIC then
			return RedPointConst.MUSIC .. "_"
		elseif slot1 == ActivityTemplateConst.GUILD_ACTIVITY then
			return RedPointConst.GUILD_ACTIVITY .. "_"
		elseif slot1 == ActivityTemplateConst.INFINITY_POOL_TASK then
			return RedPointConst.INFINITY_POOL_TASK .. "_"
		elseif slot1 == ActivityTemplateConst.SEQUENTIAL_BATTLE then
			return RedPointConst.SEQUENTIAL_BATTLE .. "_"
		elseif slot1 == ActivityTemplateConst.MARDUK_SPECIAL then
			return RedPointConst.MARDUK_SPECIAL .. "_"
		elseif slot1 == ActivityTemplateConst.SURVIVE_SOLO then
			return RedPointConst.SOLO_SURVIVE .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_WORLD_BOSS then
			return RedPointConst.ACTIVITY_WORLD_BOSS .. "_"
		elseif slot1 == ActivityTemplateConst.MARDUK_GAME then
			return RedPointConst.MARDUK_TOWERGAME .. "_"
		elseif slot1 == ActivityTemplateConst.SPRING_FESTIVAL_GREETING then
			return RedPointConst.SPRING_FESTIVAL_GREETING .. "_"
		elseif slot1 == ActivityTemplateConst.SPRING_FESTIVAL_RIDDLE then
			return RedPointConst.SPRING_FESTIVAL_RIDDLE .. "_"
		elseif slot1 == ActivityTemplateConst.SPRING_ANTITHETICAL_COUPLET then
			return RedPointConst.ANTITHETICAL_COUPLET .. "_"
		elseif slot1 == ActivityTemplateConst.PAPER_CUT then
			return RedPointConst.PAPER_CUT .. "_"
		elseif slot1 == ActivityTemplateConst.FIRE_WORK_MAIN then
			return RedPointConst.FIRE_WORK_MAIN .. "_"
		elseif slot1 == ActivityTemplateConst.SPRING_CANTEEN then
			return RedPointConst.CANTEEN .. "_"
		elseif slot1 == ActivityTemplateConst.TRAVEL_SKULD then
			return RedPointConst.TRAVEL_SKULD_ACTIVITY
		elseif slot1 == ActivityTemplateConst.VALENTINE_GAME then
			return RedPointConst.VALENTINE_GAME .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_AFFIX_SELECT then
			return RedPointConst.AFFIX_SELECT .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_CULTIVATE_HERO then
			return RedPointConst.CULTIVATE_HERO .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_2_0_SEAL then
			return RedPointConst.XH1ST_SEAL .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_PT_2 then
			return RedPointConst.ACTIVITY_PT_2 .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_SET then
			return RedPointConst.ACTIVITY_SET .. "_"
		elseif slot1 == ActivityTemplateConst.CHESS_ACTIVITY_CHINESE_ZONE then
			return RedPointConst.WARCHESS_CHINESE .. "_"
		else
			return ""
		end
	end,
	GetMainActivityId = function (slot0)
		for slot5, slot6 in pairs(ActivityData:GetAllActivityData()) do
			if slot6.subActivityIdList then
				for slot10, slot11 in ipairs(slot6.subActivityIdList) do
					if slot11 == slot0 then
						return slot6.id
					end
				end
			end
		end
	end,
	ActivityOpenCheck = function (slot0)
		if manager.time:GetServerTime() < ActivityData:GetActivityData(slot0).startTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot1.start_time)))

			return false
		end

		if slot1.stopTime <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return false
		end

		return true
	end,
	ActivityOpenCheckByMessageBox = function (slot0, slot1, slot2)
		if manager.time:GetServerTime() < ActivityData:GetActivityData(slot0).startTime then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				title = GetTips("PROMPT"),
				content = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot3.start_time)),
				OkCallback = slot1
			})

			return false
		end

		if slot3.stopTime <= manager.time:GetServerTime() then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				title = GetTips("PROMPT"),
				content = GetTips("TIME_OVER"),
				OkCallback = slot1
			})

			return false
		end

		if slot2 then
			slot2()
		end

		return true
	end,
	GetUIName = function (slot0)
		if ActivityConst.HELLA_TOWER_DEFENCE == slot0 then
			return "UI/VersionUI/HellaUI/HellabatteryUI"
		elseif ActivityConst.HELLA_CHESS == slot0 then
			return "UI/VersionUI/HellaUI/HellaWarChessUI"
		else
			error("未绑定对应预制体" .. slot0)
		end
	end,
	GetGameHelpKey = function (slot0)
		if ActivityConst.HELLA_TOWER_DEFENCE == slot0 then
			return "ACTIVITY_HELLA_TOWER_DESCRIPE"
		elseif ActivityConst.SIKADI_GAME == slot0 then
			return "ACTIVITY_CROSSWAVE_DESCRIPE"
		elseif ActivityConst.LEVIATHAN_GAME == slot0 then
			return "ACTIVITY_BUBBLES_DESCRIPE"
		end

		return ""
	end,
	GetSectionType = function (slot0)
		if ActivityConst.HELLA_TOWER_DEFENCE == slot0 then
			return BattleConst.STAGE_TYPE_NEW.TOWER_DEFENCE
		else
			error("未绑定战斗类型" .. slot0)
		end
	end,
	GetStoryActivityIDList = function (slot0)
		slot1 = {}
		slot5 = ActivityTemplateConst.STORY_STAGE

		for slot5, slot6 in ipairs(ActivityCfg.get_id_list_by_activity_template[slot5]) do
			if ActivityCfg[slot6].activity_theme == slot0 then
				table.insert(slot1, slot6)
			end
		end

		return slot1
	end,
	IsUnlockActivity = function (slot0)
		if type(ActivityCfg[slot0].unlock_condition) ~= "table" then
			return true
		end

		if slot1[1] == 100 then
			if StoryStageActivityData:GetStageData(slot1[2][1])[slot1[2][2]] == nil or slot4[slot3].clear_times <= 0 then
				return false
			else
				return true
			end
		elseif slot1[1] == 101 then
			return ChapterTools.IsClearChapter(slot1[2][1])
		end

		return true
	end,
	GetActivityChessProgress = function (slot0)
		slot1 = 0
		slot2 = 0

		for slot6, slot7 in pairs(WarchessLevelCfg.get_id_list_by_activity[slot0]) do
			slot2 = slot2 + ChessTools.GetChapterProgress(slot7)
			slot1 = slot1 + 1
		end

		return slot2, slot1
	end,
	GetActivityIsOpenWithTip = function (slot0, slot1)
		if slot1 == nil then
			slot1 = true
		end

		if ActivityData:GetActivityIsOpen(slot0) then
			return true
		else
			slot3 = manager.time:GetServerTime()

			if ActivityData:GetActivityData(slot0) and slot3 < slot2.startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot2.startTime)))
			else
				ShowTips("TIME_OVER")
			end

			return false
		end
	end,
	GetActivityStatus = function (slot0)
		if ActivityData:GetActivityIsOpen(slot0) then
			return 1
		else
			slot2 = manager.time:GetServerTime()

			if ActivityData:GetActivityData(slot0) and slot2 < slot1.startTime then
				return 0
			else
				return 2
			end
		end
	end,
	GetActivityView = function ()
		uv0 = uv0 or {
			[ActivityConst.THEME.ACTIVITY_2_0] = {
				[ActivityConst.ACTIVITY_2_0_CHAPTER_13] = ActivityChapterView_2_0,
				[ActivityConst.ACTIVITY_2_0_CHAPTER_14] = ActivityChapterView_2_0_3,
				[ActivityConst.ACTIVITY_CULTIVATE_HERO] = ActivityCultivateHeroMainView,
				[ActivityConst.XUHENG_PT2] = ActivityPt2EnterView,
				[ActivityConst.ACTIVITY_2_0_SEAL] = XH1stSealHomeView,
				[ActivityConst.ENTERNAL_MUSIC] = XH1stMusicHomeView,
				[ActivityConst.ACTIVITY_2_0_ANNIVERSARY] = AnniversaryFirstView,
				[ActivityConst.HERO_TRIAL_2_0_1] = HeroTrialView_2_0,
				[ActivityConst.HERO_TRIAL_2_0_2] = HeroTrialView_2_0,
				[ActivityConst.CHESS_ACTIVITY_CHINESE_ZONE] = ActivityChessChineseView,
				[ActivityConst.SKIN_TRIAL_2_0_1] = SkinTrialMainView_2_0,
				[ActivityConst.SKIN_TRIAL_2_0_2] = SkinTrialMainView_2_0,
				[ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK] = DrawFeedbackView_2_0,
				[ActivityConst.ACTIVITY_2_0_SKIN_ENCORE] = SkinEncoreView
			}
		}

		return uv0
	end,
	GetTogglePanelView = function (slot0)
		slot1 = uv0.GetActivityType(slot0)

		if uv0.GetActivityView()[uv0.GetActivityTheme(slot0)][slot0] then
			return slot3
		end
	end
}
