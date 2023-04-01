slot1 = manager.net

slot1:Bind(24009, function (slot0)
	slot4 = slot0.user_chapter_list

	BattleStageData:InitPlotData(slot4)

	for slot4, slot5 in ipairs(slot0.user_chapter_list) do
		if slot5.clear_times > 0 then
			slot6 = getChapterIDByStageID(slot5.id)
			slot7 = ChapterCfg[slot6]

			if BattleStageTools.GetStageCfg(ChapterCfg[slot6].type, slot5.id).stage_archive_id and slot9 ~= 0 and not RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_STAGE_ARCHIVE_RANGE + slot9) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_CHAPTER_ARCHIVE, slot9), 1)
			end
		end
	end

	TaskAction:UpdateDailyTaskRedTip()
	uv0.UpdateRedPoint()
	uv0.UpdateSubPlotRedPoint()
end)

slot1 = manager.net

slot1:Bind(24017, function (slot0)
	BattleStageData:InitChapterStarReward(slot0.gain_list)
	uv0.UpdateRedPoint()
end)

slot1 = nil

return {
	GetChapterStarReward = function (slot0, slot1, slot2)
		slot3 = manager.net

		slot3:SendWithLoadingNew(24014, {
			id = slot0,
			treasure_id = slot1
		}, 24015, function (slot0)
			uv0(slot0)
			uv1.UpdateChapterRedPoint(uv2)
		end)
	end,
	ClientModifyThreeStar = function (slot0, slot1)
		if GameSetting.newbie_unlock_level_id.value[1] == slot0 and BattleStageData:GetStageData()[slot0].clear_times <= 1 then
			ActivityNewbieData:SetNewbieOpenTime(manager.time:GetServerTime())
		end

		BattleStageData:ClientModifyThreeStar(slot0, slot1)
		uv0.UpdateChapterRedPoint(getChapterAndSectionID(slot0))
	end,
	ClickChapterArchive = function (slot0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_CHAPTER_ARCHIVE, slot0), 0)

		if not RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_STAGE_ARCHIVE_RANGE + slot0) then
			RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_STAGE_ARCHIVE_RANGE + slot0)
		end
	end,
	UpdateRedPoint = function ()
		slot2 = BattleStageData
		slot4 = slot2

		for slot3, slot4 in pairs(slot2.GetChapterStarList(slot4)) do
			uv0.UpdateChapterRedPoint(slot3)
		end
	end,
	UpdateSubPlotRedPoint = function ()
		if PlayerData:GetPlayerInfo().userLevel < GameSetting.sub_plot_unlock_level.value[1] then
			return
		end

		slot1 = pairs
		slot3 = ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT] or {}

		for slot4, slot5 in slot1(slot3) do
			for slot10, slot11 in pairs(ChapterClientCfg[slot5].chapter_list) do
				if not ChapterTools.IsClearChapter(slot11) then
					slot12 = ChapterCfg[slot11].section_id_list[1]

					if not ChapterTools.IsClearFirstStage(slot11) and BattleStageData:GetSubPlotRedPointFlag(slot11) ~= 1 and BattleStageData:GetStageData()[slot12] then
						manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot11), 1)

						if ChapterCfg[slot11].activity_id ~= 0 then
							manager.redPoint:setTip(ActivityTools.GetRedPointKey(slot13) .. slot13, 1)
						end
					end

					break
				end
			end

			uv0.UpdateExtraStoryRedPoint(slot5)
		end
	end,
	UpdateExtraStoryRedPoint = function (slot0)
		if ChapterClientCfg[slot0].extra_story_unlock_condition ~= "" and isMeetAllCondition(slot1.extra_story_unlock_condition) and not RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_EXTRA_STORY_RANGE + slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_EXTRA_STORY, slot0), 1)
		end
	end,
	ClickSubPlot = function (slot0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot0), 0)

		if ChapterCfg[slot0].activity_id ~= 0 then
			manager.redPoint:setTip(ActivityTools.GetRedPointKey(slot2) .. slot2, 0)
		end

		BattleStageData:SetSubPlotRedPointFlag(slot0)
	end,
	ClickSubPlotExtraStory = function (slot0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_EXTRA_STORY, slot0), 0)

		if ChapterClientCfg[slot0].extra_story_unlock_condition ~= "" and isMeetAllCondition(slot2.extra_story_unlock_condition) and not RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_EXTRA_STORY_RANGE + slot0) then
			RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_EXTRA_STORY_RANGE + slot0)
		end
	end,
	UpdateChapterRedPoint = function (slot0)
		if not ChapterTools.IsFinishPreChapter(slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, slot0), 0)

			return
		end

		if getChapterToggle(getChapterClientCfgByChapterID(slot0).id) == BattleConst.TOGGLE.PLOT then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, slot0), BattleStageData:GetChapterRedPointNotice(slot0) and 1 or 0)
		end
	end,
	AddActivityTimer = function ()
		uv0.UpdateRedPoint()

		slot1 = {}

		for slot5, slot6 in ipairs(ChapterCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT]) do
			if ChapterCfg[slot6].activity_id ~= 0 then
				slot1[slot7] = ActivityData:GetActivityData(slot7):IsActivitying()
			end
		end

		uv1 = Timer.New(function ()
			slot0 = false

			for slot4, slot5 in pairs(uv0) do
				if slot5 ~= ActivityData:GetActivityData(slot4):IsActivitying() then
					uv0[slot4] = slot7
					slot0 = true
				end
			end

			if slot0 then
				uv1.UpdateRedPoint()
			end
		end, 1, -1)

		uv1:Start()
	end,
	RemoveActivityTimer = function ()
		if uv0 then
			uv0:Stop()

			uv0 = nil
		end
	end
}
