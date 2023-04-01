slot0 = class("ActivityFactoryStoryView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MardukUI/plot/MardukplotUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.GetItemClass(slot0)
	return ActivityFactoryStoryItem
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.stageItemList_ = {}
	slot0.scrollMoveView_ = ScrollMoveView.New(slot0, slot0.scrollViewGo_)
	slot0.storyChapterView_ = {}
	slot0.lineList_ = {}
end

function slot0.OnEnter(slot0)
	slot5 = NAVI_BAR

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		slot5
	})
	manager.windowBar:RegistBackCallBack(function ()
		if uv0:IsOpenSectionInfo() then
			uv0.isOpenInfoView_ = false
		end

		JumpTools.Back()
	end)
	manager.ui:SetMainCamera("null")
	slot0:RefreshData()
	slot0:RefreshUI()

	slot4 = 6010004

	for slot4, slot5 in ipairs(ChapterClientCfg[slot4].chapter_list) do
		if slot0[string.format("chapterGo%s_", slot4)] then
			slot0.storyChapterView_[slot4] = slot0.storyChapterView_[slot4] or ActivityFactoryStoryChapterItem.New(slot6, slot5)
		end
	end

	for slot4, slot5 in pairs(slot0.storyChapterView_) do
		slot5:OnEnter(slot0.chapterID_)
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()

	for slot4, slot5 in pairs(slot0.storyChapterView_) do
		slot5:OnExit()
	end

	slot0.scrollMoveView_:OnExit()

	slot0.stopMove_ = false
end

function slot0.OnTop(slot0)
	slot0.stopMove_ = false
end

function slot0.OnUpdate(slot0)
	if slot0:IsOpenRoute("stageArchive") then
		slot0.stopMove_ = true

		return
	end

	slot0:RefreshData()
	slot0:RefreshUI()

	for slot4, slot5 in pairs(slot0.storyChapterView_) do
		slot5:OnUpdate(slot0.chapterID_)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.lineList_) do
		slot5:Dispose()
	end

	slot0.lineList_ = nil

	for slot4, slot5 in pairs(slot0.stageItemList_) do
		slot5:Dispose()
	end

	slot0.stageItemList_ = nil

	slot0.scrollMoveView_:Dispose()

	slot0.scrollMoveView_ = nil

	for slot4, slot5 in pairs(slot0.storyChapterView_) do
		slot5:Dispose()
	end

	slot0.storyChapterView_ = nil
end

function slot0.AddListeners(slot0)
end

function slot0.RefreshData(slot0)
	if slot0.params_.chapterID == nil then
		slot2 = ChapterClientCfg[slot0.params_.chapterClientID]
		slot0.chapterID_ = BattleFieldData:GetCacheChapter(slot2.id)

		if table.keyof(slot2.chapter_list, slot0.chapterID_) < 4 then
			slot0.chapterID_ = BattleFieldData:GetSecondCacheChapter(getChapterToggle(slot2.id)) or slot2.chapter_list[1]
		end
	else
		slot0.chapterID_ = slot0.params_.chapterID
	end

	slot0.stageData_ = BattleStageData:GetStageData()
	slot0.stageList_ = ChapterCfg[slot0.chapterID_].section_id_list
	slot0.selectStageID_ = BattleFieldData:GetCacheStage(slot0.chapterID_) or slot0.stageList_[1]
end

function slot0.RefreshUI(slot0)
	slot1 = slot0:GetScrollPos()
	slot2 = slot0:GetScrollWidth()

	if not slot0.stopMove_ then
		slot0.scrollMoveView_:RefreshUI(slot1, slot2)
	end

	slot4 = 0
	slot5 = 0

	for slot9, slot10 in pairs(ChapterCfg[slot0.chapterID_].section_id_list) do
		if slot0.stageData_[slot10] then
			slot4 = slot4 + 1

			if slot11.clear_times > 0 then
				slot5 = slot5 + 1
			end
		end
	end

	for slot9 = #slot0.stageItemList_, slot4 + 1, -1 do
		slot0.stageItemList_[slot9]:OnExit()
	end

	for slot9 = 1, slot4 do
		if slot0.stageItemList_[slot9] == nil then
			slot0.stageItemList_[slot9] = slot0:GetItemClass().New(slot0.sectionItem_, slot0.content_)
		end

		slot0.stageItemList_[slot9]:SetData(slot0.stageList_[slot9], slot0.chapterID_)
	end

	slot0:RefreshSelectItem()

	slot0.nameText_.text = slot3.subhead
	slot0.finishCntText_.text = string.format("%s/%s", slot5, #slot3.section_id_list)

	slot0:CreateLineItemList(slot4)
end

function slot0.RefreshSelectItem(slot0)
	for slot4, slot5 in pairs(slot0.stageItemList_) do
		slot5:SelectorItem(slot0.selectStageID_)
	end
end

function slot0.GetScrollWidth(slot0)
	slot1 = slot0.stageList_[1]

	for slot5, slot6 in ipairs(slot0.stageList_) do
		if not slot0.stageData_[slot6] then
			break
		end

		slot1 = slot6
	end

	return BattleActivityStoryStageCfg[slot1] and slot2.position[1] or 0
end

function slot0.GetScrollPos(slot0)
	return BattleActivityStoryStageCfg[slot0.selectStageID_] and slot2.position[1] or 0
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("subPlotSectionInfo")
end

function slot0.AddTimer(slot0)
	slot0.stopTime_ = ActivityData:GetActivityData(ChapterCfg[slot0.chapterID_].activity_id).stopTime

	slot0:StopTimer()

	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	slot0.textTime_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		uv0.textTime_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.CreateLineItemList(slot0, slot1)
	for slot5, slot6 in pairs(slot0.lineList_) do
		slot6:Show(false)
	end

	slot2 = 1

	for slot6 = 2, slot1 do
		slot9 = BattleActivityStoryStageCfg[ChapterCfg[slot0.chapterID_].section_id_list[slot6]]
		slot0.lineList_[slot2] = slot0.lineList_[slot2] or slot0:GetLineClass().New(slot0.lineGo_, slot0.content_, 3)

		slot0.lineList_[slot2]:Show(true)
		slot0.lineList_[slot2]:RefreshUI(slot0.stageItemList_[slot6 - 1]:GetLocalPosition() + Vector3(130, 0, 0), slot0.stageItemList_[slot6]:GetLocalPosition() + Vector3(-130, 0, 0))

		slot2 = slot2 + 1
	end
end

function slot0.GetLineClass(slot0)
	return SectionSingleLineItem
end

return slot0
