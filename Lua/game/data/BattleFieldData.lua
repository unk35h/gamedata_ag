slot0 = singletonClass("BattleFieldData")

function slot0.Init(slot0)
	slot0.currentSelectHeroID_ = 0
	slot0.trialID_ = 0
	slot0.cacheChapter_ = {}
	slot0.cacheToggle_ = {}
	slot0.cacheStage_ = {}
	slot0.secondCacheStage_ = {}
	slot0.clientIDAndStage_ = {}
	slot0.serverBattleID_ = nil
	slot0.battleServerIP_ = nil
	slot0.battleServerPort_ = nil
	slot0.battleResultData_ = {}
end

function slot0.GetCurrentSelectHeroID(slot0)
	return slot0.currentSelectHeroID_, slot0.trialID_
end

function slot0.SetCurrentSelectHeroData(slot0, slot1, slot2)
	slot0.currentSelectHeroID_ = slot1
	slot0.trialID_ = slot2
end

function slot0.SetCacheChapterClient(slot0, slot1, slot2)
	if slot2 and slot0.cacheToggle_[slot1] ~= slot2 then
		slot0.cacheToggle_[slot1] = slot2

		saveData("BattleField", "toggle_" .. slot1, slot2)
	end
end

function slot0.GetCacheChapterClient(slot0, slot1)
	if ChapterClientCfg[slot0.cacheToggle_[slot1] or getData("BattleField", "toggle_" .. slot1) or ChapterClientCfg.get_id_list_by_toggle[slot1][1]] == nil then
		slot2 = ChapterClientCfg.get_id_list_by_toggle[slot1][1]
	end

	return slot2
end

function slot0.SetCacheChapter(slot0, slot1, slot2)
	if slot2 and slot0.cacheChapter_[slot1] ~= slot2 then
		slot0.cacheChapter_[slot1] = slot2

		saveData("BattleField", "chapterClientID_" .. slot1, slot2)
	end
end

function slot0.GetCacheChapter(slot0, slot1)
	return slot0.cacheChapter_[slot1] or getData("BattleField", "chapterClientID_" .. slot1) or ChapterClientCfg[slot1].chapter_list[1]
end

function slot0.SetSecondCacheChapter(slot0, slot1, slot2)
	if slot2 and slot0.secondCacheStage_[slot1] ~= slot2 then
		slot0.secondCacheStage_[slot1] = slot2

		saveData("BattleField", "secondChapterID" .. slot1, slot2)
	end
end

function slot0.GetSecondCacheChapter(slot0, slot1)
	return slot0.secondCacheStage_[slot1] or getData("BattleField", "secondChapterID" .. slot1)
end

function slot0.SetCacheStage(slot0, slot1, slot2)
	if slot0.cacheStage_[slot1] ~= slot2 then
		slot0.cacheStage_[slot1] = slot2

		saveData("BattleField", "chapterID" .. slot1, slot2)
	end
end

function slot0.GetCacheStage(slot0, slot1)
	if slot1 then
		return slot0.cacheStage_[slot1] or getData("BattleField", "chapterID" .. slot1)
	end
end

function slot0.GetStageByClientID(slot0, slot1)
	if slot1 then
		return slot0.clientIDAndStage_[slot1] or getData("BattleField", "clientID" .. slot1)
	end
end

function slot0.SetStageByClientID(slot0, slot1, slot2)
	if slot0.clientIDAndStage_[slot1] ~= slot2 then
		slot0.clientIDAndStage_[slot1] = slot2

		saveData("BattleField", "clientID" .. slot1, slot2)
	end
end

function slot0.GetPlotHardLevel(slot0)
	return ChapterCfg[slot0:GetCacheChapter(slot0:GetCacheChapterClient(BattleConst.TOGGLE.PLOT))].difficulty
end

function slot0.ChangePlotHardLevel(slot0, slot1)
	slot6 = getChapterList()
	slot7 = getChapterClientList()[slot1]

	for slot11 = ChapterCfg[ChapterClientCfg[slot0:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)].chapter_list[1]].sub_type, 1, -1 do
		if slot6[slot11][slot1] and table.keyof(slot7, getChapterClientCfgByChapterID(slot6[slot11][slot1][1]).id) then
			slot0:SetCacheChapterClient(slot2, slot13)

			return
		end
	end

	for slot11 = slot5 + 1, #getChapterClientList()[ChapterCfg[slot4].difficulty] do
		if slot6[slot11][slot1] and table.keyof(slot7, getChapterClientCfgByChapterID(slot6[slot11][slot1][1]).id) then
			slot0:SetCacheChapterClient(slot2, slot13)

			return
		end
	end
end

function slot0.SetServerBattleParams(slot0, slot1, slot2, slot3)
	slot0.serverBattleID_ = slot1
	slot0.battleServerIP_ = slot2
	slot0.battleServerPort_ = slot3
	slot0.isInBattle_ = true
end

function slot0.FinishBattle(slot0, slot1)
	slot0.isInBattle_ = false
	slot3 = {}

	for slot7, slot8 in ipairs(slot1.battle_result.star_list) do
		slot3[slot7] = {
			starID = slot8.star_id,
			isComplete = slot8.is_achieve
		}
	end

	slot4 = {}

	for slot8, slot9 in ipairs(slot2.all_drop_list) do
		slot10 = {}

		for slot14, slot15 in ipairs(slot9.gain_list) do
			slot10[slot14] = {
				id = slot15.id,
				num = slot15.num
			}
		end

		slot4[slot8] = {
			battleTimes = slot9.battle_times,
			rewardItems = slot10
		}
	end

	slot0.battleResultData_ = {
		serverBattleID = slot2.dest,
		cleanTimes = slot2.clear_times,
		targetTimes = slot2.target_times,
		starList = slot3,
		dropList = slot4,
		useSecond = slot2.use_seconds,
		result = slot2.result,
		buffID = slot2.buff_id or 0
	}
end

function slot0.FishCooperationBattle(slot0, slot1)
	slot0.isInBattle_ = false
	slot3 = {}

	for slot7, slot8 in ipairs(slot1.battle_result.star_list) do
		slot3[slot7] = {
			starID = slot8.star_id,
			isComplete = slot8.is_achieve
		}
	end

	slot4 = {}

	for slot8, slot9 in ipairs(slot2.all_drop_list) do
		slot10 = {}

		for slot14, slot15 in ipairs(slot9.gain_list) do
			slot10[slot14] = {
				id = slot15.id,
				num = slot15.num
			}
		end

		slot4[slot8] = {
			battleTimes = slot9.battle_times,
			rewardItems = slot10
		}
	end

	slot0.battleResultData_ = {
		serverBattleID = slot2.dest,
		starList = slot3,
		dropList = slot4,
		useSecond = slot2.use_seconds,
		result = slot2.result
	}
end

function slot0.IsInBattle(slot0)
	return slot0.isInBattle_
end

function slot0.GetBattleResultData(slot0)
	return slot0.battleResultData_
end

function slot0.GetServerBattleID(slot0)
	return slot0.serverBattleID_
end

function slot0.GetBattleServerIPAndPort(slot0)
	return slot0.battleServerIP_, slot0.battleServerPort_
end

function slot0.SetStoryBackFlag(slot0, slot1)
	slot0.storyBackFlag_ = slot1
end

function slot0.GetStoryBackFlag(slot0)
	return slot0.storyBackFlag_
end

return slot0
