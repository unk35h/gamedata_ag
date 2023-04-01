slot1 = class("OsirisStoryStageRemasteredView", import("game.views.osiris.storyStage.section.OsirisStoryStageView"))

function slot1.Init(slot0)
	uv0.super.Init(slot0)

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "active")

	slot0.controller_:SetSelectedState("off")

	slot0.switchChapterView_ = SubPlotSwitchChapterView.New(slot0.chooseGo_, slot0.extraStoryBtn_)
	slot0.extraStoryView_ = SubPlotExtraStoryBtn.New(slot0.extraStoryGo_)
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0.switchChapterView_:OnEnter()
	slot0.extraStoryView_:OnEnter()
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0.switchChapterView_:OnExit()
	slot0.extraStoryView_:OnExit()
end

function slot1.Dispose(slot0)
	slot0.switchChapterView_:Dispose()

	slot0.switchChapterView_ = nil

	slot0.extraStoryView_:Dispose()

	slot0.extraStoryView_ = nil

	uv0.super.Dispose(slot0)
end

function slot1.RefreshData(slot0)
	if slot0.params_.chapterID == nil then
		slot0.chapterID_ = BattleFieldData:GetCacheChapter(slot0.params_.chapterClientID)
	else
		slot0.chapterID_ = slot0.params_.chapterID
	end

	slot0.stageData_ = BattleStageData:GetStageData()
	slot0.stageList_ = ChapterCfg[slot0.chapterID_].section_id_list

	slot0.switchChapterView_:SetData(slot0.chapterID_)
	slot0.extraStoryView_:SetData(slot0.chapterID_)
end

function slot1.RefreshUI(slot0)
	slot0:RefreshMissionList()

	slot0.selectSection_ = BattleFieldData:GetCacheStage(slot0.chapterID_) or ChapterCfg[slot1].section_id_list[1]

	slot0.scrollMoveView_:RefreshUI(slot0:GetScrollPos(), slot0:GetScrollWidth())
	slot0:RefreshSelectItem()
	slot0.switchChapterView_:RefreshUI()
end

function slot1.GetSectionItemClass(slot0)
	return OsirisStoryStageRemasteredItem
end

function slot1.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("subPlotSectionInfo")
end

return slot1
