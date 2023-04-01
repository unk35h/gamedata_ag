slot1 = class("HellaStoryRemasteredItem", import("game.views.activity.Submodule.storyStage.StoryStageItemView"))

function slot1.RefreshLockData(slot0, slot1, slot2)
	slot0.selectChapterID_ = slot2
end

function slot1.RefreshClearData(slot0, slot1, slot2)
	if BattleStageData:GetStageData()[slot1] and slot3.clear_times > 0 then
		slot0.isClear_ = true
	else
		slot0.isClear_ = false
	end
end

function slot1.OnClick(slot0)
	BattleFieldData:SetCacheStage(slot0.selectChapterID_, slot0.stageID_)
	slot0:Go("subPlotSectionInfo", {
		chapterID = slot0.selectChapterID_,
		section = slot0.stageID_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
	})
end

function slot1.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("subPlotSectionInfo")
end

return slot1
