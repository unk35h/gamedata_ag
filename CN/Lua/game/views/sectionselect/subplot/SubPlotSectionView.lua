slot0 = class("SubPlotSectionView", import("..SectionBaseView"))

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.switchChapterView_ = SubPlotSwitchChapterView.New(slot0.chooseGo_, slot0.extraStoryBtn_)
	slot0.changeChapterHandler_ = handler(slot0, slot0.ChangeChapter)
	slot0.extraStoryView_ = SubPlotExtraStoryBtn.New(slot0.extraStoryGo_)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0.switchChapterView_:OnEnter()
	manager.notify:RegistListener(CHANGE_CHAPTER, slot0.changeChapterHandler_)
	slot0.extraStoryView_:OnEnter()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0.switchChapterView_:OnExit()
	manager.notify:RemoveListener(CHANGE_CHAPTER, slot0.changeChapterHandler_)
	slot0.extraStoryView_:OnExit()
end

function slot0.ChangeChapter(slot0, slot1)
	slot2 = getChapterClientCfgByChapterID(slot1)

	if slot0.params_.section == (BattleFieldData:GetCacheStage(slot1) or ChapterCfg[slot1].section_id_list[1]) then
		return
	end

	slot0.params_.chapterID = slot1
	slot0.params_.section = slot3

	BattleFieldData:SetStageByClientID(slot2.id, slot3)
	BattleFieldData:SetCacheChapterClient(getChapterToggle(slot2.id), slot2.id)
	JumpTools.Jump2SubPlot(slot2.id, true)
end

function slot0.RefreshData(slot0)
	uv0.super.RefreshData(slot0)
	slot0.switchChapterView_:SetData(slot0.chapterID_)
	slot0.extraStoryView_:SetData(slot0.chapterID_)
end

function slot0.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)
	slot0.switchChapterView_:RefreshUI()
end

function slot0.GetSectionItemClass(slot0)
	return SubPlotSectionItem
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("subPlotSectionInfo")
end

function slot0.GetCfgName(slot0)
	return BattleActivityStoryStageCfg
end

function slot0.Dispose(slot0)
	slot0.changeChapterHandler_ = nil

	slot0.switchChapterView_:Dispose()

	slot0.switchChapterView_ = nil

	slot0.extraStoryView_:Dispose()

	slot0.extraStoryView_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
