return {
	IsFinishPreChapter = function (slot0)
		if ChapterCfg[slot0] == nil then
			return false, slot0
		end

		slot2 = slot1.pre_chapter

		if ActivityData:GetActivityIsOpen(slot1.activity_id) then
			for slot7, slot8 in pairs(slot2) do
				if slot3 == ChapterCfg[slot8].activity_id and (BattleStageData:GetStageData()[slot9.section_id_list[#slot9.section_id_list]] == nil or slot11.clear_times <= 0) then
					return false, slot8
				end
			end

			if PlayerData:GetPlayerInfo().userLevel < GameSetting.activity_main_plot_unlock_level.value[1] then
				return false, -1
			end

			return true
		end

		return uv0.IsFinishAllPreChapter(slot0)
	end,
	IsFinishAllPreChapter = function (slot0)
		for slot6, slot7 in pairs(ChapterCfg[slot0].pre_chapter) do
			if type(ChapterCfg[slot7].pre_chapter) ~= "table" then
				return true
			end

			if not uv0.IsFinishPreChapterWithoutActivity(slot7) then
				return false, slot7
			end

			if BattleStageData:GetStageData()[slot8.section_id_list[#slot8.section_id_list]] == nil or slot11.clear_times <= 0 then
				return false, slot7
			end
		end

		return true
	end,
	IsFinishPreChapterWithoutActivity = function (slot0)
		if ChapterCfg[slot0] == nil then
			return false, slot0
		end

		slot2 = slot1.pre_chapter
		slot3 = slot1.activity_id

		return uv0.IsFinishAllPreChapter(slot0)
	end,
	GetClearMaxChapterClientID = function ()
		slot0 = getChapterClientList()[1]
		slot1 = slot0[1]

		for slot5, slot6 in ipairs(slot0) do
			if BattleStageData:GetStageData()[ChapterCfg[ChapterClientCfg[slot6].chapter_list[1]].section_id_list[1]] and uv0.IsClearChapterClient(slot1) and uv0.IsUnlockChapter(slot7) then
				slot1 = slot6
			else
				return slot1
			end
		end

		return slot0[#slot0]
	end,
	GetChapterByActivityID = function (slot0)
		slot2 = {}

		for slot6, slot7 in ipairs(ChapterCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT]) do
			if ChapterCfg[slot7].activity_id == slot0 then
				table.insert(slot2, slot7)
			end
		end

		for slot6, slot7 in ipairs(slot2) do
			if not uv0.IsClearChapter(slot7) then
				return slot7
			end
		end

		return slot2[1]
	end,
	IsClearChapterClient = function (slot0)
		slot1 = ChapterClientCfg[slot0].chapter_list

		return uv0.IsClearChapter(slot1[#slot1])
	end,
	IsClearChapter = function (slot0)
		slot1 = ChapterCfg[slot0].section_id_list

		return uv0.IsClearStage(slot1[#slot1])
	end,
	IsClearFirstStage = function (slot0)
		return uv0.IsClearStage(ChapterCfg[slot0].section_id_list[1])
	end,
	IsClearStage = function (slot0)
		if BattleStageData:GetStageData()[slot0] == nil or slot1.clear_times <= 0 then
			return false
		end

		return true
	end,
	HasChapterStage = function (slot0)
		return #ChapterCfg[ChapterClientCfg[slot0].chapter_list[1]].section_id_list > 0
	end,
	IsUnlockChapter = function (slot0)
		slot1 = ChapterCfg[slot0]
		slot2 = slot1.sub_type

		if slot1.unlock_activity_id ~= 0 and manager.time:GetServerTime() < ActivityData:GetActivityData(slot3).startTime then
			return false
		end

		if slot2 == 13 and slot0 == 11112 and not SkuldTravelData:IsCollectAllPhoto() then
			return false
		end

		return true
	end,
	GetNeighborClientID = function (slot0, slot1)
		slot4 = table.keyof(getChapterClientList()[ChapterClientCfg[slot0].difficulty], slot0)

		if slot1 then
			if slot4 >= #slot3 then
				return slot0
			else
				return slot3[slot4 + 1]
			end
		elseif slot4 <= 1 then
			return slot0
		else
			return slot3[slot4 - 1]
		end
	end,
	GetActivityChapterIndex = function (slot0)
		slot1, slot2, slot3 = nil
		slot4 = 1

		for slot8 = #slot0, 1, -1 do
			slot10, slot11, slot12 = uv0.GetDeltaTime(slot0[slot8][2])

			if slot1 == nil then
				slot3 = slot12
				slot2 = slot11
				slot1 = slot10
				slot4 = slot8
			elseif slot12 == true and slot3 == false then
				slot1 = slot10
				slot2 = slot11
				slot3 = slot12
				slot4 = slot8
			elseif slot12 == false and slot3 == true then
				-- Nothing
			elseif slot3 == true and slot12 == true then
				if slot2 > 0 and slot11 > 0 and slot11 < slot2 then
					slot1 = slot10
					slot2 = slot11
					slot3 = slot12
					slot4 = slot8
				end
			elseif slot1 < 0 and slot10 < 0 and slot2 > 0 and slot11 > 0 then
				slot1 = slot10
				slot2 = slot11
				slot3 = slot12
				slot4 = slot8
			elseif slot1 > 0 and slot10 > 0 and slot2 < 0 and slot11 < 0 then
				-- Nothing
			elseif slot10 > 0 then
				slot1 = slot10
				slot2 = slot11
				slot3 = slot12
				slot4 = slot8
			end
		end

		return slot4
	end,
	GetDeltaTime = function (slot0)
		slot1 = ActivityData:GetActivityData(slot0)
		slot2 = manager.time:GetServerTime()

		return slot2 - slot1.startTime, slot1.stopTime - slot2, slot1.startTime <= slot2 and slot2 <= slot1.stopTime
	end,
	GotoChapterStagePage = function (slot0)
		slot2 = slot0[uv0.GetActivityChapterIndex(slot0)]
		slot3 = slot2[4]

		if slot2[1] == 1 then
			BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, slot3)
			gameContext:Go("/chapterMap", {
				chapterToggle = BattleConst.TOGGLE.PLOT
			})
		else
			BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT, slot3)
			gameContext:Go("/chapterMap", {
				chapterToggle = BattleConst.TOGGLE.SUB_PLOT
			})
		end
	end,
	GotoMaxChapterClient = function ()
		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, uv0.GetClearMaxChapterClientID())
		gameContext:Go("/chapterMap", {
			chapterToggle = BattleConst.TOGGLE.PLOT
		})
	end
}
