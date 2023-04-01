slot1 = class("OsirisStoryStageRemasteredItem", import("game.views.osiris.storyStage.section.OsirisStoryStageItem"))

function slot1.SetData(slot0, slot1, slot2)
	slot0.stageID_ = slot1
	slot0.chapterID_ = slot2

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot1.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("subPlotSectionInfo")
end

function slot1.RefreshData(slot0)
	if BattleStageData:GetStageData()[slot0.stageID_] and slot1.clear_times > 0 then
		slot0.isClear_ = true
	else
		slot0.isClear_ = false
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

function slot1.RefreshUI(slot0)
	slot1 = slot0:GetPosition()
	slot0.transform_.localPosition = Vector3(slot1[1], slot1[2], 0)
	slot3 = table.keyof(ChapterCfg[slot0.chapterID_].section_id_list, slot0.stageID_)
	slot0.textIndex_.text = string.format("%02d", slot3)
	slot4 = BattleActivityStoryStageCfg[slot0.stageID_]
	slot0.textName_.text = slot4.name
	slot0.imageBg_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot4.background_1))

	if slot3 == 1 or BattleStageData:GetStageData()[slot0.stageID_] then
		slot0:Show(true)
	else
		slot0:Show(false)
	end

	slot0:RefreshClear()
end

return slot1
