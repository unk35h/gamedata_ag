return {
	GetStageName = function (slot0, slot1)
		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == slot0 then
			slot3 = MatrixTierCfg[MatrixData:GetTierID()]

			return ""
		end

		if uv0.GetStageCfg(slot0, slot1) then
			return slot2.name or ""
		else
			return ""
		end
	end,
	GetChapterByStageId = function (slot0, slot1)
		for slot6, slot7 in pairs(ChapterCfg.get_id_list_by_type[slot0]) do
			if table.keyof(ChapterCfg[slot7].section_id_list, slot1) then
				return slot7
			end
		end

		return 0
	end,
	GetChapterSectionIndex = function (slot0, slot1)
		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == slot0 then
			return ChapterCfg[ChapterCfg.get_id_list_by_type[slot0][1]].english, string.format("%d-%d", BattleInstance.GetEquipStageShowIndex(slot1), BattleInstance.GetHardLevel(slot1))
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT == slot0 then
			return ChapterCfg[ChapterCfg.get_id_list_by_type[slot0][1]].english, BattleInstance.GetEquipStageShowIndex(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY == slot0 then
			for slot6, slot7 in pairs(ChapterCfg.get_id_list_by_type[slot0]) do
				if table.keyof(ChapterCfg[slot7].section_id_list, slot1) then
					return slot8.english, slot9
				end
			end
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot0 then
			if BattleChapterStageCfg[slot1].stage_num ~= "" then
				slot5 = ""

				for slot9 = 1, #string.split(slot2.stage_num, "-") - 1 do
					slot5 = (slot9 ~= 1 or slot4[slot9]) and slot4[slot9] .. "-" .. slot4[slot9]
				end

				return slot5, slot4[#slot4]
			end

			slot4 = ChapterCfg[getChapterIDByStageID(slot1)]

			return slot4.english, table.keyof(slot4.section_id_list, slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT == slot0 then
			for slot6, slot7 in pairs(ChapterCfg.get_id_list_by_type[slot0]) do
				if table.keyof(ChapterCfg[slot7].section_id_list, slot1) then
					return slot8.english, slot9
				end
			end
		end

		return "", ""
	end,
	GetRestrictHeroList = function (slot0, slot1)
		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == slot0 or BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE == slot0 then
			return nil
		end

		if uv0.GetStageCfg(slot0, slot1) then
			return slot2.hero_list
		end

		return nil
	end,
	GetStageCfg = function (slot0, slot1)
		slot2 = nil

		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot0 then
			slot2 = BattleChapterStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT == slot0 then
			slot2 = BattleActivityStoryStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY == slot0 then
			slot2 = BattleDailyStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == slot0 then
			slot2 = BattleTowerStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT == slot0 then
			slot2 = BattleEnchantmentStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == slot0 then
			slot2 = BattleEquipStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL == slot0 then
			slot2 = BattleEquipBreakThroughMaterialStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == slot0 then
			slot2 = BattleBossStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE == slot0 then
			slot2 = BattleBossStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == slot0 then
			slot2 = BattleMythicStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING == slot0 then
			slot2 = BattleBaseTeachStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING == slot0 then
			slot2 = BattleHeroTeachStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == slot0 then
			slot2 = BattleMatrixStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS == slot0 then
			slot2 = BattleChessStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY == slot0 then
			slot2 = BattleActivityStoryStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON == slot0 then
			slot2 = BattleHeartDemonStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.NEW_DEMON == slot0 then
			slot2 = BattleNewHeartDemonStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.RACE_TRAIL == slot0 then
			slot2 = BattleRaceTrailStageCfg[ActivityRaceTrialCfg[slot1].stage_id]
		elseif BattleConst.STAGE_TYPE_NEW.HERO_TRIAL == slot0 then
			slot2 = BattleHeroTrialStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL == slot0 then
			slot2 = BattleSkinTrialStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.SLAYER == slot0 then
			slot2 = BattleSlayerStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.PARKOUR == slot0 then
			slot2 = BattleParkourStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.TOWER_DEFENCE == slot0 then
			slot2 = BattleShotStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE == slot0 then
			slot2 = BattleSoloChallengeStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.ARTIFACT == slot0 then
			slot2 = BattleArtifactCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION == slot0 then
			slot2 = BattleLimitedCalculationStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.LEVIATHAN_GAME == slot0 then
			slot2 = BattleLeviathanGamesCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.SKADI_GAME == slot0 then
			slot2 = BattleCrosswaveCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_GAME == slot0 then
			slot2 = BattleActivityPtStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == slot0 then
			slot2 = BattleActivityMatrixCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE == slot0 then
			slot2 = BattleClubBossPreposeCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE == slot0 then
			slot2 = BattleClubBossCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE == slot0 then
			slot2 = BattleActivityRaceStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX == slot0 then
			slot2 = BattleStrategyMatrixCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == slot0 then
			slot2 = BattleMythicFinalCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY == slot0 then
			slot2 = BattleClubActivityCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO == slot0 then
			slot2 = BattleCooperationDemoCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE == slot0 then
			slot2 = BattleSequentialBattleStageCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.MARDUK_GAME == slot0 then
			slot2 = BattleTowerGameCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO == slot0 then
			slot2 = BattleSoloSlayerCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL == slot0 then
			slot2 = BattleQuickTrainingCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS == slot0 then
			slot2 = BattleActivityWorldBossCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT == slot0 then
			slot2 = BattleActivityAffixSelectCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.DAMAGE_TEST == slot0 then
			slot2 = BattleDamageTestCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL == slot0 then
			slot2 = BattleActivityPtStageV2NormalCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE == slot0 then
			slot2 = BattleActivityPtStageV2ChallengeCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD == slot0 then
			slot2 = BattleActivityPtStageV2HardCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.ABYSS == slot0 then
			slot2 = BattleAbyssCfg[slot1]
		elseif BattleConst.STAGE_TYPE_NEW.POLYHEDRON == slot0 then
			slot2 = BattlePolyhedronStageCfg[slot1]
		end

		if slot2 == nil then
			print(string.format("配置表中没有关卡<color=#ff0000>%s</color>", slot1))
		end

		return slot2 or {}
	end
}
