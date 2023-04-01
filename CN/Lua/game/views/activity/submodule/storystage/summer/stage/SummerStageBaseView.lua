slot0 = class("SummerStageBaseView", ReduxView)

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.scrollMoveView_ = ScrollMoveView.New(slot0, slot0.scrollView_)
	slot0.stageItem_ = {}
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		if uv0:IsOpenSectionInfo() then
			uv0.isOpenInfoView_ = false
		end

		JumpTools.Back()
	end)

	slot0.stopTime_ = ActivityData:GetActivityData(slot0:GetActivityID()).stopTime

	slot0:AddTimer()
	slot0:RefreshData()
	slot0:RefreshStageList()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0.scrollMoveView_:OnExit()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.stageItem_) do
		slot5:Dispose()
	end

	slot0.stageItem_ = nil

	slot0.scrollMoveView_:Dispose()

	slot0.scrollMoveView_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if uv0:IsOpenSectionInfo() then
			uv0.isOpenInfoView_ = false

			JumpTools.Back()
		end
	end)
end

function slot0.OnUpdate(slot0)
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.GetActivityID(slot0)
end

function slot0.RefreshData(slot0)
	slot0.chapterID_ = slot0.params_.chapterID or 5
	slot0.stageData_ = StoryStageActivityData:GetStageData(slot0.chapterID_)
	slot0.stageList_ = ActivityStoryChapterCfg[slot0.chapterID_].stage_list
end

function slot0.RefreshUI(slot0)
	slot0.selectStageID_ = slot0.params_.section or StoryStageActivityData:GetHistoryStage(slot0.chapterID_) or slot0.stageList_[1]

	slot0.scrollMoveView_:RefreshUI(slot0:GetScrollPos(), slot0:GetScrollWidth())
	slot0:RefreshSelectItem()
end

function slot0.RefreshSelectItem(slot0)
	for slot4, slot5 in pairs(slot0.stageItem_) do
		slot5:SelectorItem(slot0.selectStageID_)
	end
end

function slot0.RefreshStageList(slot0)
	for slot4 = 1, #slot0.stageItem_ do
		slot0.stageItem_[slot4]:Show(false)
	end

	slot5 = StoryStageActivityData:GetStageData(slot0.chapterID_)

	for slot5 = 1, table.length(slot5) do
		if not slot0.stageItem_[slot5] then
			slot0.stageItem_[slot5] = slot0:GetStageItemClass().New(slot0.itemGo_, slot0.content_)
		end

		slot0.stageItem_[slot5]:SetData(slot0.stageList_[slot5], slot0.chapterID_)
	end
end

function slot0.GetStageItemClass(slot0)
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
	return BattleActivityStoryStageCfg[slot0.selectStageID_] and slot1.position[1] or 0
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("storyStageInfoActivity")
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.timeText_.text = GetTips("TIME_OVER")

		return
	end

	slot0.timeText_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.timeText_.text = GetTips("TIME_OVER")

			return
		end

		uv0.timeText_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
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
