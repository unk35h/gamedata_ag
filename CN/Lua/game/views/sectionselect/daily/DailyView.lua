slot0 = class("DailyView", import("..SectionBaseView"))

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.switchChapterView_ = SubPlotSwitchChapterView.New(slot0.chooseGo_, slot0.extraStoryBtn_)
	slot0.changeChapterHandler_ = handler(slot0, slot0.SwitchDailyChapter)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0.switchChapterView_:OnEnter()
	manager.notify:RegistListener(CHANGE_CHAPTER, slot0.changeChapterHandler_)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0.switchChapterView_:OnExit()
	manager.notify:RemoveListener(CHANGE_CHAPTER, slot0.changeChapterHandler_)
	OperationRecorder.RecordStayView("STAY_VIEW_SECTION", slot0:GetStayTime(), slot0.chapterID_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.changeChapterHandler_ = nil

	slot0.switchChapterView_:Dispose()

	slot0.switchChapterView_ = nil
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("dailySectionInfo")
end

function slot0.GetSectionItemClass(slot0)
	return DailyItem
end

function slot0.RefreshCustomData(slot0)
	slot0.switchChapterView_:SetData(slot0.chapterID_)
end

function slot0.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)

	slot3 = #getChapterClientCfgByChapterID(slot0.chapterID_).chapter_list > 1

	if not slot0:IsOpenSectionInfo() and not slot0:IsOpenRoute("chapterSectionReward") and slot3 then
		SetActive(slot0.chooseGo_, true)
	else
		SetActive(slot0.chooseGo_, false)
	end

	if slot3 then
		slot0:RefreshChapterItemBtn()

		for slot7, slot8 in ipairs(slot2) do
			if slot0.chapterItem_[slot7] then
				slot0.chapterItem_[slot7]:SetData(slot8)
			else
				slot0.chapterItem_[slot7] = DailyChapterItemBtn.New(slot0, slot0.selectResourceItem_, slot0.selectResourcePanel_, slot8)
			end
		end
	end

	slot0.switchChapterView_:RefreshUI()
	slot0:SwitchBG()
end

function slot0.GetCfgName(slot0)
	return BattleDailyStageCfg
end

function slot0.RefreshChapterItemBtn(slot0)
	slot0.selectResourceText_.text = ChapterCfg[slot0.chapterID_].subhead
end

function slot0.SwitchDailyChapter(slot0, slot1)
	slot2 = getChapterClientCfgByChapterID(slot1)

	if slot0.params_.section == (BattleFieldData:GetCacheStage(slot1) or ChapterCfg[slot1].section_id_list[1]) then
		return
	end

	slot0.params_.chapterID = slot1
	slot0.params_.section = slot3

	BattleFieldData:SetStageByClientID(slot2.id, slot3)
	BattleFieldData:SetCacheChapterClient(getChapterToggle(slot2.id), slot2.id)
	slot0:RefreshData(slot1)
	uv0.super.RefreshUI(slot0)
	slot0:RefreshChapterItemBtn()
end

return slot0
