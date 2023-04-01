slot1 = class("SubPlotSectionItem", import("game.views.sectionSelect.SectionBaseItem"))

function slot1.InitCustom(slot0)
	SetActive(slot0.collectGo_, false)
end

function slot1.GetTag(slot0)
	return BattleActivityStoryStageCfg[slot0.stageID_] and slot1.tag or 0
end

function slot1.GetPosition(slot0)
	return BattleActivityStoryStageCfg[slot0.stageID_] and slot1.position or {
		0,
		0
	}
end

function slot1.RefreshData(slot0)
	slot2 = ChapterCfg[slot0.chapterID_]

	if BattleStageData:GetStageData()[slot0.stageID_] then
		slot0.isLock_ = false
		slot0.clearTimes_ = slot1.clear_times
	elseif table.keyof(slot2.section_id_list, slot0.stageID_) == 1 then
		slot0.isLock_ = false
		slot0.clearTimes_ = 0
	else
		slot0.isLock_ = true
		slot0.clearTimes_ = -1
	end

	slot3 = PlayerData:GetPlayerInfo().userLevel
	slot4 = BattleActivityStoryStageCfg[slot0.stageID_].level

	if ActivityData:GetActivityIsOpen(slot2.activity_id) then
		slot0.enoughLevel_ = true
	else
		slot0.enoughLevel_ = slot4 <= slot3
	end
end

function slot1.OnClick(slot0)
	if not slot0.isLock_ then
		slot0:Go("subPlotSectionInfo", {
			section = slot0.stageID_,
			chapterID = slot0.chapterID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
		})
	end
end

function slot1.RefreshText(slot0)
	slot1, slot2 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT, slot0.stageID_)
	slot0.text_.text = string.format("%s-%s", slot1, slot2)
end

function slot1.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("subPlotSectionInfo")
end

return slot1
