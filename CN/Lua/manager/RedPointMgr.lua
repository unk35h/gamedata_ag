slot0 = class("RedPointMgr")

function slot0.Ctor(slot0)
	slot0._tipDic = {}
	slot0._groupTipDic = {}
	slot0._UIKeyList = {}

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:addGroup(RedPointConst.BULLETIN_UNREAD, {
		RedPointConst.BULLETIN_UNREAD_101,
		RedPointConst.BULLETIN_UNREAD_102,
		RedPointConst.BULLETIN_UNREAD_104
	})
	slot0:addGroup(RedPointConst.TASK, {
		RedPointConst.TASK_DAILY,
		RedPointConst.TASK_PLOT,
		RedPointConst.TASK_WEEK
	})

	slot6 = RedPointConst.COMBAT_EQUIP

	slot0:addGroup(RedPointConst.COMBAT, {
		RedPointConst.COMBAT_PLOT,
		RedPointConst.COMBAT_SUB_PLOT,
		RedPointConst.COMBAT_CHALLENGE,
		slot6
	})

	slot1 = {}
	slot2 = {}

	for slot6 = 1, BattleConst.HARD_CNT do
		slot2[slot6] = {}
	end

	slot6 = BattleConst.TOGGLE.PLOT

	for slot6, slot7 in pairs(ChapterClientCfg.get_id_list_by_toggle[slot6]) do
		slot8 = {}
		slot9 = 1

		for slot13, slot14 in pairs(ChapterClientCfg[slot7].chapter_list) do
			table.insert(slot8, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, slot14))

			if slot2[ChapterCfg[slot14].difficulty] then
				slot9 = slot15.difficulty

				if slot15.sub_type == 13 and slot15.difficulty == 1 then
					slot0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT, slot14), {
						RedPointConst.TRAVEL_SKULD_CHAPTER .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
					})
				end
			end
		end

		slot0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT, slot7), slot8)
		table.insert(slot1, string.format("%s_%s", RedPointConst.COMBAT_PLOT, slot7))
		table.insert(slot2[slot9], string.format("%s_%s", RedPointConst.COMBAT_PLOT, slot7))
	end

	slot6 = RedPointConst.COMBAT_PLOT

	slot0:addGroup(slot6, slot1)

	for slot6 = 1, BattleConst.HARD_CNT do
		slot0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT_LEVEL, slot6), slot2[slot6])
	end

	slot3 = {}
	slot4 = pairs
	slot6 = ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT] or {}

	for slot7, slot8 in slot4(slot6) do
		slot14 = "%s_%s"

		table.insert(slot3, string.format(slot14, RedPointConst.COMBAT_SUB_PLOT, slot8))

		slot9 = {}

		for slot13, slot14 in pairs(ChapterClientCfg[slot8].chapter_list) do
			table.insert(slot9, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot14))
		end

		slot0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER_LIST, slot8), slot9)
		slot0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, slot8), {
			string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER_LIST, slot8),
			string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_EXTRA_STORY, slot8)
		})
	end

	slot0:addGroup(RedPointConst.COMBAT_SUB_PLOT, slot3)
	slot0:addGroup(RedPointConst.BOSS_CHALLENGE, {
		RedPointConst.BOSS_CHALLENGE_NORMAL,
		RedPointConst.BOSS_CHALLENGE_ADVANCE
	})
	slot0:addGroup(RedPointConst.COMBAT_CHALLENGE, {
		RedPointConst.CHALLENGE_COMMON,
		RedPointConst.CHALLENGE_DEMO
	})
	slot0:addGroup(RedPointConst.CHALLENGE_COMMON, {
		RedPointConst.MYTHIC_TIMES_AWARD,
		RedPointConst.MYTHIC_FINAL_AWARD,
		RedPointConst.BOSS_CHALLENGE,
		RedPointConst.MATRIX_EXCHANGE_BONUS,
		RedPointConst.ABYSS,
		RedPointConst.TOWER,
		RedPointConst.WARCHESS,
		RedPointConst.TEACH
	})
	slot0:addGroup(RedPointConst.CHALLENGE_DEMO, {
		RedPointConst.COOPERATION_DEMO
	})
	slot0:addGroup(RedPointConst.TEACH, {
		RedPointConst.TEACH_BASE,
		RedPointConst.TEACH_CHARACTER
	})
	slot0:addGroup(RedPointConst.COMBAT_EQUIP, {
		RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL
	})

	slot8 = {
		slot9
	}
	slot9 = RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL_REWARD

	slot0:addGroup(RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL, slot8)

	slot4 = {}

	for slot8, slot9 in pairs(HeroCfg.get_id_list_by_private[0]) do
		table.insert(slot4, RedPointConst.HERO_ID .. slot9)
		slot0:addGroup(RedPointConst.HERO_WEAPON .. slot9, {
			RedPointConst.HERO_WEAPON_BREAK_ID .. slot9,
			RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. slot9
		})

		slot14 = RedPointConst.HERO_UNLOCK_ID .. slot9
		slot15 = RedPointConst.HERO_PROPERTY_PAGE .. slot9
		slot16 = RedPointConst.HERO_STAR_ID .. slot9
		slot17 = RedPointConst.HERO_SKIN_ID .. slot9
		slot18 = {}

		for slot22, slot23 in pairs(SkinCfg.get_id_list_by_hero[slot9]) do
			table.insert(slot18, RedPointConst.HERO_SKIN_ID_EXTEND .. slot23)
		end

		slot0:addGroup(slot17, slot18)
		slot0:addGroup(slot15, {
			heroBreakKey,
			slot16,
			slot17
		})
		slot0:addGroup(slot10, {
			slot15
		})
	end

	slot0:addGroup(RedPointConst.HERO, slot4)
	table.insert({}, RedPointConst.SIGN_DAILY)

	slot6 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_SIGN] or {}

	for slot10, slot11 in ipairs(slot6) do
		table.insert(slot5, string.format("%s_%s", RedPointConst.SIGN_SEVEN_DAY, slot11))
	end

	slot0:addGroup(RedPointConst.SIGN, slot5)

	slot7 = {}
	slot8 = {}
	slot12 = ChipConst.TYPE_MANAGER

	for slot12, slot13 in ipairs(ChipCfg.get_id_list_by_type_id[slot12]) do
		table.insert(slot8, string.format("%s_%s", RedPointConst.CHIP_MANAGER, slot13))
	end

	slot12 = ChipConst.TYPE_CHIP

	for slot12, slot13 in ipairs(ChipCfg.get_id_list_by_type_id[slot12]) do
		table.insert(slot7, string.format("%s_%s", RedPointConst.CHIP_CHIP, slot13))
	end

	slot0:addGroup(RedPointConst.CHIP_CHIP, slot7)
	table.insertto(slot8, slot7)

	slot12 = RedPointConst.CHIP_MANAGER
	slot13 = slot8

	slot0:addGroup(slot12, slot13)

	for slot12, slot13 in ipairs(HeroRecordCfg.all) do
		slot0:addGroup(RedPointConst.HERO_ARCHIVE_ID .. slot13, {
			RedPointConst.HERO_HEARTLINK_ID .. slot13
		})
	end

	slot0:addGroup(RedPointConst.FRIEND, {
		RedPointConst.FRIEND_MY_FRIENDS,
		RedPointConst.FRIEND_FRIEND_REQUESTS
	})
	slot0:addGroup(RedPointConst.FORUM_PLATFORM, {
		RedPointConst.FORUM,
		RedPointConst.FORUM_UNREAD
	})
	slot0:addGroup(RedPointConst.MAIN_HOME_FUNC, {
		RedPointConst.CHIP_MANAGER,
		RedPointConst.SETTING_NEW_FUNCTION,
		RedPointConst.WEAPON_SERVANT_MERGE,
		RedPointConst.SIGN,
		RedPointConst.BULLETIN_UNREAD
	})

	slot13 = {
		RedPointConst.MAIN_HOME_FUNC,
		slot14
	}
	slot14 = RedPointConst.MAIN_HOME_SDK

	slot0:addGroup(RedPointConst.MAIN_HOME_MENU, slot13)

	slot9 = {}

	for slot13, slot14 in pairs(AchievementCfg.get_id_list_by_type_id) do
		table.insert(slot9, string.format("%s_%s", RedPointConst.ACHIEVEMENT, slot13))
	end

	slot10 = {}

	for slot14, slot15 in pairs(AchievementStoryCfg.all) do
		table.insert(slot10, string.format("%s_%s", RedPointConst.ACHIEVEMENT_STORY, slot15))
	end

	slot0:addGroup(RedPointConst.ACHIEVEMENT_STORY, slot10)
	table.insertto(slot9, slot10)
	slot0:addGroup(RedPointConst.ACHIEVEMENT, slot9)

	slot11 = {}
	slot15 = ItemConst.ITEM_TYPE.STICKER_BG

	for slot15, slot16 in ipairs(ItemCfg.get_id_list_by_type[slot15]) do
		table.insert(slot11, RedPointConst.STICKER_BG .. "_" .. slot16)
	end

	slot0:addGroup(RedPointConst.STICKER_BG, slot11)
	slot0:addGroup(RedPointConst.PASSPORT_TASKS, {
		RedPointConst.PASSPORT_TASK_BONUS_7,
		RedPointConst.PASSPORT_TASK_BONUS_8,
		RedPointConst.PASSPORT_TASK_BONUS_9
	})
	slot0:addGroup(RedPointConst.PASSPORT, {
		RedPointConst.PASSPORT_BONUS,
		RedPointConst.PASSPORT_TASKS
	})
	slot0:addGroup(RedPointConst.SHOP, {
		RedPointConst.HERO_PIECE_EXCHANGE
	})
	slot0:addGroup(RedPointConst.CYCLE_BONUS, {
		RedPointConst.CYCLE_BONUS_FREE,
		RedPointConst.CYCLE_BONUS_UNLOCK
	})
	slot0:addGroup(RedPointConst.ACTIVITY_BONUS, {
		RedPointConst.ACTIVITY_BONUS_FREE,
		RedPointConst.ACTIVITY_BONUS_UNLOCK
	})
	slot0:addGroup(RedPointConst.NEWBIE_BONUS, {
		RedPointConst.NEWBIE_BONUS_FREE,
		RedPointConst.NEWBIE_BONUS_UNLOCK
	})
	slot0:addGroup(RedPointConst.NORMAL_BONUS, {
		RedPointConst.NORMAL_BONUS_FREE,
		RedPointConst.NORMAL_BONUS_UNLOCK
	})
	slot0:addGroup(RedPointConst.RECHARGE_BONUS, {
		RedPointConst.ACTIVITY_BONUS,
		RedPointConst.CYCLE_BONUS,
		RedPointConst.NEWBIE_BONUS,
		RedPointConst.NORMAL_BONUS
	})
	slot0:addGroup(RedPointConst.RECHARGE, {
		RedPointConst.RECHARGE_BONUS,
		RedPointConst.TOTAL_CHARGE_BONUS,
		RedPointConst.NOOB_FIRST_RECHARGE,
		RedPointConst.NOOB_MONTHLY_RECHARGE_SIGN,
		RedPointConst.NOOB_BP_RECHARGE,
		RED_POINT_ID.RECHARGE
	})
	slot0:addGroup(RedPointConst.RECHARGE_ENTER, {
		RedPointConst.RECHARGE,
		RedPointConst.SHOP
	})
	slot0:addGroup(RedPointConst.ILLU_ILLUSTRATION, {
		RedPointConst.ILLU_ILLUSTRATION1,
		RedPointConst.ILLU_ILLUSTRATION2,
		RedPointConst.ILLU_ILLUSTRATION3,
		RedPointConst.ILLU_ILLUSTRATION4
	})
	slot0:addGroup(RedPointConst.ILLU_USER, {
		RedPointConst.ILLU_ILLUSTRATION
	})
	slot0:addGroup(RedPointConst.ILLU_MAIN, {
		RedPointConst.ILLU_ILLUSTRATION,
		RedPointConst.ACHIEVEMENT,
		RedPointConst.STICKER_BG,
		RedPointConst.BRITHDAY
	})
	slot0:addGroup(RedPointConst.NEWBIE_POINT, {
		RedPointConst.NEWBIE_SIGN,
		RedPointConst.NEWBIE_TASK,
		RedPointConst.NEWBIE_UPGRADE,
		RedPointConst.NEWBIE_DAILY_TASK,
		RedPointConst.NOOB_FIRST_RECHARGE,
		RedPointConst.NOOB_MONTHLY_RECHARGE,
		RedPointConst.NOOB_BP_RECHARGE
	})

	slot17 = RedPointConst.NOOB_FIRST_RECHARGE_2

	slot0:addGroup(RedPointConst.NOOB_FIRST_RECHARGE, {
		RedPointConst.NOOB_FIRST_RECHARGE_1,
		slot17
	})

	slot13 = {}

	for slot17, slot18 in ipairs(GameSetting.advanced_task_tad.value) do
		slot13[#slot13 + 1] = string.format("%s_%d", RedPointConst.NOOB_ADVANCE, slot17)
		slot20 = {}

		for slot24, slot25 in ipairs(slot18[2]) do
			slot20[#slot20 + 1] = string.format("%s_%d_%d", RedPointConst.NOOB_ADVANCE, slot17, slot25[1])
		end

		slot0:addGroup(slot19, slot20)
	end

	slot0:addGroup(RedPointConst.NOOB_ADVANCE, slot13)
	slot0:addGroup(RedPointConst.GUILD, {
		RedPointConst.GUILD_REQUEST,
		RedPointConst.CLUB_TASK,
		RedPointConst.CLUB_WELFARE,
		RedPointConst.GUILD_MANAGER,
		RedPointConst.GUILD_BOSS
	})
	slot0:addGroup(RedPointConst.GUILD_MANAGER, {
		RedPointConst.GUILD_IMPEACH,
		RedPointConst.GUILD_REQUEST
	})
	slot0:addGroup(RedPointConst.DORM_MAIN, {
		RedPointConst.DORM_HERO_MOOD,
		RedPointConst.DORM_TOTAL_EARN,
		RedPointConst.DORM_SPECIAL_EVENT
	})

	slot18 = {
		RedPointConst.MATRIX_TERMINAL_GIFT_STRUGGLE,
		slot19
	}
	slot19 = RedPointConst.MATRIX_TERMINAL_GIFT_SHELTER

	slot0:addGroup(RedPointConst.MATRIX_TERMINAL_GIFT, slot18)

	slot14 = {}

	for slot18, slot19 in pairs(WarchessLevelCfg.get_id_list_by_activity) do
		if slot18 ~= 0 then
			slot20 = {}

			for slot24, slot25 in ipairs(slot19) do
				table.insert(slot20, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, slot18, slot25))
			end

			slot0:addGroup(string.format("%s_%s", RedPointConst.WAR_CHESS, slot18), slot20)
		end
	end

	slot15 = {}
	slot19 = BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON

	for slot19, slot20 in ipairs(StageGroupCfg.get_id_list_by_type[slot19]) do
		table.insert(slot15, DemonChallengeData:GetRedPointConst(slot19))
	end

	slot19 = RedPointConst.OSIRIS_DEMON
	slot20 = slot15

	slot0:addGroup(slot19, slot20)

	for slot19, slot20 in pairs(ActivityHeroTrialCfg.get_id_list_by_activity_id) do
		slot21 = {}

		for slot25, slot26 in ipairs(slot20) do
			table.insert(slot21, string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, slot19, slot26))
		end

		slot0:addGroup(string.format("%s_%s", RedPointConst.HERO_TRIAL, slot19), slot21)
	end

	slot20 = {
		string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.OSIRIS_TASK_DAILY),
		string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.OSIRIS_CHESS),
		RedPointConst.OSIRIS_DEMON,
		RedPointConst.OSIRIS_RACE_TRIAL,
		string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityConst.OSIRIS_HERO_TRIAL_STAGE)
	}

	slot0:addGroup(RedPointConst.OSIRIS_ACTIVITY, slot20)

	slot19 = ActivityTemplateConst.SKIN_TRIAL

	for slot19, slot20 in ipairs(ActivityCfg.get_id_list_by_activity_template[slot19]) do
		slot22 = {}

		for slot26, slot27 in pairs(ActivityCfg[slot20].sub_activity_list) do
			table.insert(slot22, string.format("%s_%s", RedPointConst.SKIN_TRIAL, slot27))
		end

		slot0:addGroup(string.format("%s_%s", RedPointConst.SKIN_TRIAL, slot20), slot22)
	end

	slot16 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SLAYER] or {}

	for slot20, slot21 in ipairs(slot16) do
		if #ActivityCfg[slot21].sub_activity_list > 0 then
			slot23 = {}

			for slot27, slot28 in ipairs(slot22) do
				slot0:addGroup(string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot28), {
					string.format("%s_%s_select", RedPointConst.SLYAER_REGIONS, slot28),
					string.format("%s_%s_reward", RedPointConst.SLYAER_REGIONS, slot28)
				})

				slot23[#slot23 + 1] = string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot28)
			end

			slot0:addGroup(string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot21), slot23)
		end

		slot0:addGroup(string.format("%s_%s", RedPointConst.SLAYER, slot21), {
			string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot21),
			string.format("%s_%s", RedPointConst.SLYAER_REWARD, slot21)
		})
	end

	slot17 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.PARKOUR] or {}

	for slot21, slot22 in ipairs(slot17) do
		slot0:addGroup(string.format("%s_%s", RedPointConst.PARKOUR, slot22), {
			string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_ALL, slot22)
		})

		slot29 = RedPointConst.PARKOUR_ENTRUST_ALL
		slot28 = string.format

		slot0:addGroup(string.format("%s_%s", slot29, slot22), {
			string.format("%s_%s", RedPointConst.PARKOUR_REWARD, slot22),
			slot28("%s_%s", RedPointConst.PARKOUR_ENTRUST, slot22)
		})

		slot24 = {}

		for slot28, slot29 in ipairs(ActivityCfg[slot22].sub_activity_list) do
			table.insert(slot24, string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, slot29))
		end

		slot0:addGroup(string.format("%s_%s", RedPointConst.PARKOUR_REWARD, slot22), slot24)
	end

	slot0:addGroup(RedPointConst.REGRESSION, {
		RedPointConst.REGRESSION_SIGN,
		RedPointConst.REGRESSION_SURVEY,
		RedPointConst.REGRESSION_TASK,
		RedPointConst.REGRESSION_BP,
		RedPointConst.REGRESSION_SUPPLY_FREE
	})
	slot0:addGroup(RedPointConst.REGRESSION_TASK, {
		string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY),
		string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK),
		string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE)
	})
	slot0:addGroup(RedPointConst.GUILD_BOSS, {
		RedPointConst.GUILD_BOSS_PREPOSE_FIRST_BONUS,
		RedPointConst.GUILD_BOSS_PERSONAL_BONUS,
		RedPointConst.GUILD_BOSS_COMMON_BONUS,
		RedPointConst.GUILD_BOSS_PREPOSE_OPEN,
		RedPointConst.GUILD_BOSS_CHALLENGE_OPEN
	})
	slot0:addGroup(RedPointConst.GUILD_BOSS_BOSS_BTN, {
		RedPointConst.GUILD_BOSS_PERSONAL_BONUS,
		RedPointConst.GUILD_BOSS_COMMON_BONUS,
		RedPointConst.GUILD_BOSS_CHALLENGE_OPEN
	})

	slot18 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SINGLE_MATRIX] or {}

	for slot22, slot23 in ipairs(slot18) do
		slot0:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX, slot23), {
			string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_REWARD, slot23),
			string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_CLUE, slot23),
			string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_READ, slot23)
		})
	end

	slot19 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_MUSIC] or {}

	for slot23, slot24 in ipairs(slot19) do
		slot0:addGroup(string.format("%s_%s", RedPointConst.MUSIC, slot24), {
			string.format("%s_%s", RedPointConst.MUSIC_OPEN, slot24),
			string.format("%s_%s", RedPointConst.MUSIC_REWARD, slot24)
		})
	end

	slot20 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRATEGY_MATRIX] or {}

	for slot24, slot25 in ipairs(slot20) do
		slot0:addGroup(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, slot25), {
			string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, slot25),
			string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, slot25)
		})
	end

	slot21 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.GUILD_ACTIVITY] or {}

	for slot25, slot26 in ipairs(slot21) do
		slot31 = {
			string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_RATE, slot26),
			RedPointConst.GUILD_ACTIVITY_UNREGISTER,
			slot32("%s_%s", RedPointConst.GUILD_ACTIVITY_UNGET_COIN, slot26)
		}
		slot32 = string.format

		slot0:addGroup(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY, slot26), slot31)

		slot27 = {}

		for slot31, slot32 in pairs(TalentTreeCfg.get_id_list_by_activity_id_and_race[slot26]) do
			slot38 = slot31
			slot27[#slot27 + 1] = string.format("%s_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, slot26, slot38)
			slot34 = {}

			for slot38, slot39 in pairs(slot32) do
				slot34[#slot34 + 1] = string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, slot26, slot31, slot39)
			end

			slot0:addGroup(slot33, slot34)
		end

		slot0:addGroup(string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, slot26), slot27)
	end

	slot27 = string.format

	slot0:addGroup(RedPointConst.COOPERATION_DEMO, {
		slot27("%s_%d", RedPointConst.COOPERATION_INVIT, BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO)
	})

	slot23 = {}

	for slot27, slot28 in ipairs(ActivityCfg[ActivityConst.FACTORY_MARDUK].sub_activity_list) do
		table.insert(slot23, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, slot28))
	end

	slot0:addGroup(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, ActivityConst.FACTORY_MARDUK), slot23)
	slot0:addGroup(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL, ActivityConst.FACTORY_MARDUK), {
		string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, ActivityConst.FACTORY_MARDUK),
		string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.FACTORY_MARDUK)
	})

	slot24 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.FIRE_WORK_MAIN] or {}

	for slot28, slot29 in ipairs(slot24) do
		slot31 = {}

		for slot35, slot36 in ipairs(ActivityCfg[slot29].sub_activity_list) do
			if ActivityCfg[slot36].activity_template == ActivityTemplateConst.FIRE_WORK then
				slot38 = string.format("%s_%s", RedPointConst.FIRE_WORK, slot36)

				slot0:addGroup(slot38, {
					string.format("%s_%s", RedPointConst.FIRE_WORK_OPEN, slot36),
					string.format("%s_%s", RedPointConst.FIRE_WORK_REWARD, slot36)
				})
				table.insert(slot31, slot38)
			end
		end

		slot0:addGroup(string.format("%s_%s", RedPointConst.FIRE_WORK_MAIN, slot29), slot31)
	end

	slot0:addGroup(RedPointConst.CANTEEN_DISPATCH, {
		RedPointConst.CANTEEN_DISPATCH_FINISHED,
		RedPointConst.CANTEEN_DISPATCH_NONE
	})
	slot0:addGroup(RedPointConst.CANTEEN, {
		RedPointConst.CANTEEN_DISPATCH,
		RedPointConst.CANTEEN_BUSINESS_STOPPED,
		RedPointConst.CANTEEN_JOB_AVAILABLE,
		RedPointConst.CANTEEN_UPGRADE_AVAILABLE
	})
	slot0:addGroup(ActivityTools.GetRedPointKey(ActivityConst.SPRING_CANTEEN) .. ActivityConst.SPRING_CANTEEN, {
		RedPointConst.CANTEEN
	})
	slot0:addGroup(RedPointConst.DORM, {
		RedPointConst.DORM_PLACEMENT
	})
	slot0:addGroup(RedPointConst.DORM_FURNITURE, {
		RedPointConst.DORM_FURNITURE_FLOOR,
		RedPointConst.DORM_FURNITURE_WALL,
		RedPointConst.DORM_FURNITURE_WINDOW,
		RedPointConst.DORM_FURNITURE_TABLE,
		RedPointConst.DORM_FURNITURE_BED,
		RedPointConst.DORM_FURNITURE_FLOOR_ITEM,
		RedPointConst.DORM_FURNITURE_WALL_ITEM
	})
	slot0:addGroup(RedPointConst.BACKHOME, {
		RedPointConst.DORM,
		RedPointConst.CANTEEN
	})

	slot31 = "ABYSS_CHALLENGE"
	slot30 = RedPointConst[slot31]

	slot0:addGroup(RedPointConst.ABYSS, {
		RedPointConst.ABYSS_REWARD,
		slot30
	})

	slot26 = {}

	for slot30, slot31 in pairs(MailSpecialLetterCfg.get_id_list_by_letter_belongs) do
		slot36 = slot30

		table.insert(slot26, RedPointConst.LETTER_SENDER_ID .. slot36)

		slot32 = {}

		for slot36, slot37 in pairs(slot31) do
			table.insert(slot32, RedPointConst.LETTER_ID .. slot37)
		end

		slot0:addGroup(RedPointConst.LETTER_SENDER_ID .. slot30, slot32)
	end

	slot0:addGroup(RedPointConst.LETTER_UNREAD, slot26)
	slot0:addGroup(RedPointConst.MAIL_UNREAD, {
		RedPointConst.LETTER_UNREAD
	})

	slot33 = "POLYHEDRON_TERMINAL_GIFT"

	slot0:addGroup(RedPointConst.POLYHEDRON, {
		RedPointConst.POLYHEDRON_BEACON_UNLOCK,
		RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD,
		RedPointConst.POLYHEDRON_HERO_UNLOCK,
		RedPointConst.POLYHEDRON_TASK,
		RedPointConst[slot33]
	})

	slot28 = {}
	slot29 = {}

	for slot33, slot34 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.POLYHEDRON_ACTIVITY]) do
		slot35 = ActivityCfg[slot34].season_task_activity_list or {}
		slot36 = ActivityCfg[slot34].achievement_task_activity_list or {}

		for slot40, slot41 in ipairs(slot35) do
			slot28[#slot28 + 1] = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot41)
		end

		for slot40, slot41 in ipairs(slot36) do
			slot29[#slot29 + 1] = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot41)
		end
	end

	slot0:addGroup(RedPointConst.POLYHEDRON_TASK_SEASON, slot28)
	slot0:addGroup(RedPointConst.POLYHEDRON_TASK_ACHIEVEMENT, slot29)
	slot0:addGroup(RedPointConst.POLYHEDRON_TASK, {
		RedPointConst.POLYHEDRON_TASK_SEASON,
		RedPointConst.POLYHEDRON_TASK_ACHIEVEMENT
	})
	slot0:addGroup(RedPointConst.RECALL, {
		RedPointConst.RECALL_SIGN,
		RedPointConst.RECALL_TASK,
		RedPointConst.RECALL_REWARD
	})
	slot0:addGroup(RedPointConst.SETTING_NEW_FUNCTION, {
		RedPointConst.HIGH_FPS_DEVICE_SURRPORT
	})
end

function slot0.InitData(slot0)
	slot0._tipDic = {}
end

function slot0.Dispose(slot0)
	slot0._UIKeyList = {}
end

function slot0.setTip(slot0, slot1, slot2)
	slot3 = 0

	if slot2 == (slot0._tipDic[slot1] == nil and 0 or slot0._tipDic[slot1]) then
		return
	end

	slot0._tipDic[slot1] = slot2

	slot0:updateKey(slot1)
end

function slot0.getTipValue(slot0, slot1)
	slot2 = slot0._tipDic[slot1] or 0

	if slot0._groupTipDic[slot1] then
		for slot7, slot8 in pairs(slot3) do
			slot2 = slot2 + slot0:getTipValue(slot8)
		end
	end

	return slot2
end

function slot0.getchildKeys(slot0, slot1)
	return slot0._groupTipDic[slot1]
end

function slot0.getTipBoolean(slot0, slot1)
	if slot0._tipDic[slot1] and slot0._tipDic[slot1] > 0 then
		return true
	end

	if slot0._groupTipDic[slot1] then
		for slot6, slot7 in pairs(slot2) do
			if slot0:getTipBoolean(slot7) == true then
				return true
			end
		end
	end

	return false
end

function slot0.addGroup(slot0, slot1, slot2, slot3)
	if slot3 == nil then
		slot3 = false
	end

	if slot0._groupTipDic[slot1] == nil then
		slot0._groupTipDic[slot1] = slot2
	else
		if slot3 == true then
			slot0._groupTipDic.put(slot1, {})
		end

		slot4 = slot0._groupTipDic[slot1]

		for slot8, slot9 in pairs(slot2) do
			if slot0:IsInTable(slot4, slot9) == false then
				table.insert(slot4, slot9)
			end
		end
	end

	slot0:updateRedPoint(slot1)
end

function slot0.delGroup(slot0, slot1, slot2)
	if slot0._groupTipDic[slot1] == nil then
		return
	end

	slot3 = slot0._groupTipDic[slot1]

	for slot7, slot8 in pairs(slot2) do
		if slot0:IsInTable(slot3, slot8) then
			table.remove(slot3, slot7)
		end
	end

	slot0:updateRedPoint(slot1)
end

function slot0.updateKey(slot0, slot1)
	slot5 = slot1

	slot0:updateRedPoint(slot5)

	for slot5, slot6 in pairs(slot0._groupTipDic) do
		for slot10, slot11 in pairs(slot6) do
			if slot11 == slot1 then
				slot0:updateKey(slot5)
			end
		end
	end

	manager.notify:Invoke(RED_POINT_UPDATE, slot1)
end

function slot0.updateRedPoint(slot0, slot1)
	if slot0._UIKeyList[slot1] ~= nil then
		for slot6, slot7 in pairs(slot0._UIKeyList[slot1]) do
			slot0:setRedPoint(slot7, slot0:getTipBoolean(slot1))
		end
	end
end

function slot0.bindUIandKey(slot0, slot1, slot2, slot3)
	if slot1 == nil then
		return
	end

	slot0:unbindUIandKey(slot1)

	slot4 = {}

	if slot0._UIKeyList[slot2] == nil then
		table.insert(slot4, {
			display = slot1,
			tProperty = slot3
		})

		slot0._UIKeyList[slot2] = slot4
	else
		table.insert(slot0._UIKeyList[slot2], {
			display = slot1,
			tProperty = slot3
		})
	end

	slot0:updateRedPoint(slot2)
end

function slot0.unbindUIandKey(slot0, slot1, slot2)
	if slot1 == nil then
		return
	end

	if slot2 then
		slot3 = -1

		if slot0._UIKeyList[slot2] then
			for slot8, slot9 in pairs(slot4) do
				if slot9.display == slot1 then
					slot3 = slot8

					break
				end
			end

			if slot3 ~= -1 then
				slot0:setRedPoint(slot4[slot3], false)
				table.remove(slot4, slot3)
			end
		else
			print("unbindUIandKey key is not exist! key = " .. slot2)
		end
	else
		for slot6, slot7 in pairs(slot0._UIKeyList) do
			slot8 = -1

			for slot12, slot13 in pairs(slot7) do
				if slot13.display == slot1 then
					slot8 = slot12

					break
				end
			end

			if slot8 ~= -1 then
				table.remove(slot7, slot8)

				break
			end
		end
	end
end

function slot0.setRedPoint(slot0, slot1, slot2)
	slot4 = slot1.tProperty or {}

	if slot1.display == nil then
		print("redpoint cant find parent transform")

		return
	end

	if not slot3:Find("notice_img") and slot2 == false then
		return
	end

	if not slot5 then
		if Asset.Load("UI/Common/CommonNotice") == nil then
			print("redpoint cant find current CommonNotice prefab")

			return
		end

		slot7 = Object.Instantiate(slot6, slot3):GetComponent("RectTransform")
		slot8 = slot3:GetComponent("RectTransform")
		slot9 = {
			x = slot8.rect.width,
			y = slot8.rect.height
		}
		slot10 = slot8.pivot
		slot7.localPosition = Vector3(slot4.x or slot9.x * (1 - slot10.x), slot4.y or slot9.y * (1 - slot10.y), 0)
		slot7.localScale = Vector3(slot4.scaleX or 1, slot4.scaleY or 1, 1)
		slot5.name = "notice_img"
	end

	if slot2 == false then
		SetActive(slot5.gameObject, false)

		return
	end

	SetActive(slot5.gameObject, true)
end

function slot0.ForceHideRedPoint(slot0, slot1)
	if slot1:Find("notice_img") then
		SetActive(slot2.gameObject, false)
	end
end

function slot0.SetRedPointIndependent(slot0, slot1, slot2, slot3, slot4)
	slot2 = slot2 or false
	slot3 = slot3 or {}

	if slot1 == nil then
		print("redpoint cant find parent transform")

		return
	end

	if not slot1:Find("notice_img") and not slot2 then
		return
	end

	if not slot5 then
		if Asset.Load("UI/Common/CommonNotice") == nil then
			print("redpoint cant find current CommonNotice prefab")

			return
		end

		slot7 = Object.Instantiate(slot6, slot1):GetComponent("RectTransform")
		slot8 = slot1:GetComponent("RectTransform")
		slot9 = slot8.sizeDelta
		slot10 = slot8.pivot
		slot11 = slot3.x or slot9.x * (1 - slot10.x)
		slot12 = slot3.y or slot9.y * (1 - slot10.y)

		if slot4 then
			slot11 = slot11 + slot4.x
			slot12 = slot12 + slot4.y
		end

		slot7.localPosition = Vector3(slot11, slot12, 0)
		slot7.localScale = Vector3(slot3.scaleX or 1, slot3.scaleY or 1, 1)
		slot5.name = "notice_img"
	end

	if slot2 == false then
		SetActive(slot5.gameObject, false)

		return
	end

	SetActive(slot5.gameObject, true)
end

function slot0.IsInTable(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		if slot7 == slot2 then
			return true, slot6
		end
	end

	return false
end

return slot0
