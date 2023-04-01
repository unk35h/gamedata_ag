slot1 = class("SummerSeabedStoryRemasteredItem", import("game.views.activity.Submodule.storyStage.summer.stage.seabed.SummerStageSeabedItem"))

function slot1.RefreshLockData(slot0)
	slot0.isLock_ = false
end

function slot1.RefreshData(slot0)
	if BattleStageData:GetStageData()[slot0.stageID_] then
		slot0.clearTimes_ = slot1.clear_times
	else
		slot0.clearTimes_ = 0
	end
end

function slot1.OnClick(slot0)
	BattleFieldData:SetCacheStage(slot0.chapterID_, slot0.stageID_)
	slot0:Go("subPlotSectionInfo", {
		section = slot0.stageID_,
		chapterID = slot0.chapterID_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
	})
end

function slot1.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("subPlotSectionInfo")
end

function slot1.RefreshText(slot0)
	slot2 = table.keyof(ChapterCfg[slot0.chapterID_].section_id_list, slot0.stageID_)
	slot0.text_.text = string.format("%d", slot2)

	if slot2 - 1 == 0 then
		slot0.lineController_:SetSelectedState("3-1")
	elseif slot2 == 1 then
		slot0.lineController_:SetSelectedState("0-1")
	else
		slot0.lineController_:SetSelectedState(tostring((slot2 - 1) % 4))
	end
end

return slot1
