return {
	Produce = function (slot0, slot1, slot2)
		slot3 = nil

		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot0 then
			slot3 = BattleChapterStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT == slot0 then
			slot3 = BattleSubPlotStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY == slot0 then
			slot3 = BattleDailyStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == slot0 then
			slot3 = BattleTowerStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT == slot0 then
			slot3 = BattleEnchantmentStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == slot0 then
			slot3 = BattleEquipStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL == slot0 then
			slot3 = BattleEquipBreakThroughMaterialStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == slot0 then
			slot3 = BattleBossStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE == slot0 then
			slot3 = BattleBossAdvanceStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == slot0 then
			slot3 = BattleMythicStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING == slot0 then
			slot3 = BattleBaseTeachStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING == slot0 then
			slot3 = BattleHeroTeachStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == slot0 then
			slot3 = BattleMatrixStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS == slot0 then
			slot3 = BattleChessStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY == slot0 then
			slot3 = BattleOsirisStoryStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON == slot0 then
			slot3 = BattleOsirisDemonStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.NEW_DEMON == slot0 then
			slot3 = BattleNewDemonStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.RACE_TRAIL == slot0 then
			slot3 = BattleRaceTrailStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.HERO_TRIAL == slot0 then
			slot3 = BattleHeroTrialStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL == slot0 then
			slot3 = BattleSkinTrialStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.SLAYER == slot0 then
			slot3 = BattleSlayerStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.TOWER_DEFENCE == slot0 then
			slot3 = BattleTowerDefenceStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.PARKOUR == slot0 then
			slot3 = BattleParkourStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE == slot0 then
			slot3 = BattleSoloChallengeStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ARTIFACT == slot0 then
			slot3 = BattleArtifactStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION == slot0 then
			slot3 = BattleLimitedCalculationStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.SKADI_GAME == slot0 then
			slot3 = BattleSkadiLittleGameTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_GAME == slot0 then
			slot3 = BattleActivityPtGameTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE == slot0 then
			slot3 = BattleGuildBossPrepareTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE == slot0 then
			slot3 = BattleGuildBossChallengeTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE == slot0 then
			slot3 = BattleActivityRaceStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == slot0 then
			slot3 = BattleMythicFinalTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY == slot0 then
			slot3 = BattleGuildActivityStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL == slot0 then
			slot3 = BattleMardukSpecialTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE == slot0 then
			slot3 = BattleSequentialBattleStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO == slot0 then
			slot3 = BattleSurviveSoloStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS == slot0 then
			slot3 = BattleActivityWorldBossTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT == slot0 then
			slot3 = BattleAffixSelectTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.DAMAGE_TEST == slot0 then
			slot3 = BattleDamageTestTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL == slot0 then
			slot3 = BattleActivityPt2NormalTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE == slot0 then
			slot3 = BattleActivityPt2ChallengeTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD == slot0 then
			slot3 = BattleActivityPt2HardTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ABYSS == slot0 then
			slot3 = BattleAbyssTemplate.New(slot1)
		end

		return slot3
	end,
	ProduceCooperation = function (slot0, slot1)
		slot2 = nil

		if BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO == slot0 then
			slot2 = BattleCooperationDemoTemplate.New(slot1)
		end

		return slot2
	end
}
