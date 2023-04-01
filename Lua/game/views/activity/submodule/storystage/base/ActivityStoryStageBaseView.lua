slot0 = class("ActivityStoryStageBaseView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BranchlineUI/OsirisPlotUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.stageItemList_ = {}
	slot0.scrollMoveView_ = ScrollMoveView.New(slot0, slot0.scrollViewGo_)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
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
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	slot0.scrollMoveView_:OnExit()
	slot0:StopTimer()
end

function slot0.OnUpdate(slot0)
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.stageItemList_) do
		slot5:Dispose()
	end

	slot0.stageItemList_ = nil

	slot0.scrollMoveView_:Dispose()

	slot0.scrollMoveView_ = nil
end

function slot0.AddListeners(slot0)
end

function slot0.RefreshData(slot0)
	if slot0.params_.chapterID == nil then
		slot1 = slot0.params_.theme
		slot0.activityIDList_ = ActivityTools.GetStoryActivityIDList(slot1)
		slot0.chapterID_ = slot0.params_.chapterID or StoryStageActivityData:GetHistoryChapter(StoryStageActivityData:GetDefaultActivityID(slot1) or slot0.activityIDList_[1])
	else
		slot0.chapterID_ = slot0.params_.chapterID
	end

	slot0.stageData_ = StoryStageActivityData:GetStageData(slot0.chapterID_)
	slot0.stageList_ = ActivityStoryChapterCfg[slot0.chapterID_].stage_list
	slot0.selectStageID_ = StoryStageActivityData:GetHistoryStage(slot0.chapterID_) or slot0.stageList_[1]
end

function slot0.RefreshUI(slot0)
	slot7 = slot0:GetScrollWidth()

	slot0.scrollMoveView_:RefreshUI(slot0:GetScrollPos(), slot7)

	for slot7 = #slot0.stageItemList_, table.length(slot0.stageData_) + 1, -1 do
		slot0.stageItemList_[slot7]:Dispose()

		slot0.stageItemList_[slot7] = nil
	end

	for slot7 = 1, slot3 do
		if slot0.stageItemList_[slot7] == nil then
			slot0.stageItemList_[slot7] = slot0:GetItemClass().New(slot0.sectionItem_, slot0.content_)
		end

		slot0.stageItemList_[slot7]:SetData(slot0.stageList_[slot7], slot0.chapterID_)
	end

	slot0:RefreshSelectItem()
end

function slot0.RefreshSelectItem(slot0)
	for slot4, slot5 in pairs(slot0.stageItemList_) do
		slot5:SelectorItem(slot0.selectStageID_)
	end
end

function slot0.GetItemClass(slot0)
	return ActivityStoryStageBaseItem
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
	return slot0:IsOpenRoute("storyStageInfoActivity")
end

function slot0.AddTimer(slot0)
	slot0.stopTime_ = ActivityData:GetActivityData(ActivityStoryChapterCfg[slot0.chapterID_].activity_id).stopTime

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

return slot0
