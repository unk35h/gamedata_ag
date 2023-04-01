return {
	GetBossChallengeNextIndex = function (slot0)
		if BattleBossChallengeNormalData:GetBossChallengeCfg().level_amount < BattleBossChallengeNormalData:GetFinishIndex(slot0) then
			return slot2.level_amount
		end

		return slot1
	end,
	GetAutoChapter = function (slot0, slot1)
		if BattleStageData:GetStageData()[slot1].clear_times == 1 then
			return uv0.GetNextChapter(slot0, slot1)
		end

		return slot0
	end,
	GetNextChapter = function (slot0, slot1)
		slot3 = ChapterCfg[slot0].section_id_list

		if slot3[#slot3] == slot1 then
			slot4 = getChapterListByDifficulty(slot2.type, slot2.difficulty)

			if table.keyof(slot4, slot0) < #slot4 and ChapterTools.IsFinishPreChapter(slot4[slot5 + 1]) and ChapterTools.IsUnlockChapter(slot6) then
				return slot6
			end
		end

		return slot0
	end,
	GetChapterNextStageID = function (slot0, slot1)
		slot3 = ChapterCfg[slot0].section_id_list

		if table.keyof(slot3, slot1) < #slot3 then
			if slot3[slot4 + 1] == GameSetting.travel_skuld_new_ending_stage_id.value[1] and BattleStageData:GetStageData()[slot5].clear_times < 1 then
				return
			end

			return slot5
		end
	end,
	GetActivityStoryNextStageID = function (slot0, slot1)
		if manager.time:GetServerTime() < ActivityData:GetActivityData(ActivityStoryChapterCfg[slot0].activity_id).startTime or slot4.stopTime < slot5 then
			return
		end

		if slot3 == ActivityConst.OSIRIS_STROY then
			return uv0.GetOsirisNextStage(slot0, slot1)
		end
	end,
	GetOsirisNextStage = function (slot0, slot1, slot2)
		if StoryStageActivityData:GetStageData(slot1)[slot2] then
			slot4 = nil

			for slot8, slot9 in pairs(GameSetting.activity_plot_unlock.value) do
				if slot9[1][1] == slot1 and slot9[1][2] == slot2 then
					slot4 = slot9[2][1]
				end
			end

			slot5 = 100

			if slot4 then
				slot5 = ChessTools.GetChapterProgress(slot4)
			end

			if slot5 < 100 then
				return
			end

			slot7 = ActivityStoryChapterCfg[slot1].stage_list

			if table.keyof(slot7, slot2) < #slot7 then
				return slot7[slot8 + 1]
			end
		end
	end,
	CalcBossChallengeStar = function ()
		slot0 = 0
		slot3 = BattleBossChallengeNormalData
		slot5 = slot3

		for slot4, slot5 in pairs(slot3.GetThreeStarList(slot5)) do
			for slot9, slot10 in ipairs(slot5) do
				if slot10 == 1 then
					slot0 = slot0 + 1
				end
			end
		end

		return slot0
	end,
	GetSubPlotFinishRate = function (slot0)
		slot1 = 0
		slot2 = 0
		slot3 = BattleStageData:GetStageData()

		for slot7, slot8 in ipairs(ChapterClientCfg[slot0].chapter_list) do
			slot9 = ChapterCfg[slot8]
			slot1 = slot1 + #slot9.section_id_list

			for slot13, slot14 in ipairs(slot9.section_id_list) do
				if slot3[slot14] and slot3[slot14].clear_times > 0 then
					slot2 = slot2 + 1
				end
			end
		end

		return math.floor(slot2 / slot1 * 100)
	end
}
