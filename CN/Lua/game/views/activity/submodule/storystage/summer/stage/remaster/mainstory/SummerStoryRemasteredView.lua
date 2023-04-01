slot1 = class("SummerStoryRemasterdView", import("game.views.activity.Submodule.storyStage.summer.stage.mainStory.SummerStageMainView"))

function slot1.GetStageItemClass(slot0)
	return SummerStoryRemasteredItem
end

function slot1.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("subPlotSectionInfo")
end

function slot1.Init(slot0)
	uv0.super.Init(slot0)

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "active")

	slot0.controller_:SetSelectedState("off")

	slot0.switchChapterView_ = SubPlotSwitchChapterView.New(slot0.chooseGo_)
	slot0.changeChapterHandler_ = handler(slot0, slot0.ChangeChapter)
	slot0.extraStoryView_ = SubPlotExtraStoryBtn.New(slot0.extraStoryGo_)
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0.switchChapterView_:OnEnter()
	manager.notify:RegistListener(CHANGE_CHAPTER, slot0.changeChapterHandler_)
	slot0.extraStoryView_:OnEnter()
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0.switchChapterView_:OnExit()
	manager.notify:RemoveListener(CHANGE_CHAPTER, slot0.changeChapterHandler_)
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
		slot0.chapterID_ = BattleFieldData:GetCacheChapter(ChapterClientCfg[slot0.params_.chapterClientID].id)
	else
		slot0.chapterID_ = slot0.params_.chapterID
	end

	slot0.stageData_ = BattleStageData:GetStageData()
	slot0.stageList_ = ChapterCfg[slot0.chapterID_].section_id_list

	slot0.switchChapterView_:SetData(slot0.chapterID_)
	slot0.extraStoryView_:SetData(slot0.chapterID_)
end

function slot1.RefreshUI(slot0)
	slot0.selectStageID_ = BattleFieldData:GetCacheStage(slot0.chapterID_) or ChapterCfg[slot1].section_id_list[1]

	slot0.scrollMoveView_:RefreshUI(slot0:GetScrollPos(), slot0:GetScrollWidth())
	slot0:RefreshSelectItem()
	slot0.switchChapterView_:RefreshUI()
end

function slot1.RefreshStageList(slot0)
	for slot4 = 1, #slot0.stageItem_ do
		slot0.stageItem_[slot4]:Show(false)
	end

	slot1 = BattleStageData:GetStageData()

	for slot5 = 1, #slot0.stageList_ do
		if slot5 == 1 or slot1[slot0.stageList_[slot5]] then
			if not slot0.stageItem_[slot5] then
				slot0.stageItem_[slot5] = slot0:GetStageItemClass().New(slot0.itemGo_, slot0.content_)
			end

			slot0.stageItem_[slot5]:SetData(slot0.stageList_[slot5], slot0.chapterID_)
		end
	end
end

function slot1.ChangeChapter(slot0, slot1)
	slot2 = getChapterClientCfgByChapterID(slot1)

	if slot0.params_.section == (BattleFieldData:GetCacheStage(slot1) or ChapterCfg[slot1].section_id_list[1]) then
		return
	end

	BattleFieldData:SetStageByClientID(slot2.id, slot3)
	BattleFieldData:SetCacheChapterClient(getChapterToggle(slot2.id), slot2.id)
	JumpTools.Jump2SubPlot(slot2.id, true)
end

return slot1
