slot0 = class("HardLevelChapterItem", import("..HardLevelBaseItem"))

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_LEVEL, slot0.hardLevel_), {
		x = 184.7,
		y = -27.5
	})
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_LEVEL, slot0.hardLevel_))
	uv0.super.OnExit(slot0)
end

function slot0.IsLock(slot0)
	slot1 = 1

	if slot0.hardLevel_ ~= 1 then
		slot1 = 2
	end

	slot0.isLock_ = not ChapterTools.IsFinishPreChapter(getChapterNumList(slot1)[slot0.hardLevel_][1])
end

function slot0.LockTips(slot0)
	slot2 = BattleFieldData:GetCacheChapter(BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT))
	slot5, slot6 = ChapterTools.IsFinishPreChapter(getChapterNumList(1)[slot0.hardLevel_][1])

	if not slot5 then
		slot7 = ChapterCfg[slot6]

		ShowTips(string.format(GetTips("NEED_FINISH_PRE_STAGE"), GetTips(BattleConst.HARD_LANGUAGE[slot7.difficulty]), slot7.english))

		return
	end

	ShowTips("ERROR_FUNCTION_NOT_OPEN")
end

function slot0.ClickBtn(slot0)
	if slot0.hardLevel_ == BattleFieldData:GetPlotHardLevel() then
		return
	end

	BattleFieldAction.ChangePlotHardLevel(slot0.hardLevel_)

	if not slot0.isLock_ then
		BattleFieldAction.ChangeSelectChapterID(slot0:GetOpenMaxChapter())
	end
end

function slot0.GetOpenMaxChapter(slot0)
	slot1 = slot0.hardLevel_
	slot3 = BattleFieldData:GetCacheChapter(BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT))
	slot6 = getChapterList()

	for slot11 = table.keyof(getChapterListByDifficulty(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, ChapterCfg[slot3].difficulty), slot3), 1, -1 do
		if slot6[ChapterCfg[slot5[slot11]].sub_type][slot1] and ChapterCfg[slot6[slot12][slot1][1]].section_id_list[1] and BattleStageData:GetStageData()[slot14] then
			return slot13
		end
	end

	if slot0.hardLevel_ ~= 1 and slot7 <= 1 then
		slot7 = 2
	end

	return getChapterListByDifficulty(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot1)[slot7]
end

return slot0
