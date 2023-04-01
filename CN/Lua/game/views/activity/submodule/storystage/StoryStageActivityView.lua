slot0 = class("StoryStageActivityView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BranchlineUI/HellaSelectStageUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.switchController_ = ControllerUtil.GetController(slot0.goSwitch_.transform, "name")
	slot0.btnLockController_ = ControllerUtil.GetController(slot0.btnSwitch_.transform, "name")
	slot0.storyChapterView_ = {}
	slot0.stageItemList_ = {}
	slot0.scrollMoveView_ = ScrollMoveView.New(slot0, slot0.goScrollView_)
	slot0.scrollContenLineView_ = ScrollContentLineView.New(slot0.goLineItem_, slot0.goItemParent_, slot0:FindCom(typeof(RectTransform), nil, slot0.goStageItem_.transform).rect.width, 30, 4)
end

function slot0.OnEnter(slot0)
	slot5 = HOME_BAR

	manager.windowBar:SwitchBar({
		BACK_BAR,
		slot5
	})
	slot0:RefreshData()

	slot1 = slot0.activityIDList_

	for slot5, slot6 in ipairs(slot0.activityIDList_) do
		manager.redPoint:bindUIandKey(slot0[string.format("transformRedPoint%s_", slot5)], RedPointConst.ACTIVITY_STORY_STAGE .. slot6)
	end

	for slot5, slot6 in pairs(slot1) do
		if #ActivityStoryChapterCfg.get_id_list_by_activity_id[slot6] > 1 and slot0[string.format("goChapterPanel%s_", slot5)] then
			slot0.storyChapterView_[slot5] = slot0.storyChapterView_[slot5] or StoryChapterView.New(slot7, slot6)
		end
	end

	for slot5, slot6 in pairs(slot0.storyChapterView_) do
		slot6:OnEnter(slot0.selectChapterID_)
	end

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopTimer()
	slot0.scrollMoveView_:OnExit()

	for slot4, slot5 in ipairs(slot0.activityIDList_) do
		manager.redPoint:unbindUIandKey(slot0[string.format("transformRedPoint%s_", slot4)], RedPointConst.ACTIVITY_STORY_STAGE .. slot5)
	end

	for slot4, slot5 in pairs(slot0.storyChapterView_) do
		slot5:OnExit()
	end
end

function slot0.OnUpdate(slot0)
	slot0:RefreshData()
	slot0:RefreshUI()

	for slot4, slot5 in pairs(slot0.storyChapterView_) do
		slot5:OnUpdate(slot0.selectChapterID_)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.storyChapterView_) do
		slot5:Dispose()
	end

	for slot4, slot5 in pairs(slot0.stageItemList_) do
		slot5:Dispose()
	end

	slot0.stageItemList_ = nil

	slot0.scrollContenLineView_:Dispose()

	slot0.scrollContenLineView_ = nil

	slot0.scrollMoveView_:Dispose()

	slot0.scrollMoveView_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnSwitch_, nil, function ()
		slot0 = ActivityStoryChapterCfg[uv0.selectChapterID_]

		for slot4, slot5 in pairs(uv0.activityIDList_) do
			if slot0.activity_id ~= slot5 then
				if manager.time:GetServerTime() < ActivityData:GetActivityData(ActivityStoryChapterCfg[ActivityStoryChapterCfg.get_id_list_by_activity_id[slot5][1]].activity_id).startTime then
					ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot8)))
				else
					if ActivityData:GetActivityIsOpen(slot7.activity_id) == false then
						ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(manager.time:GetServerTime() + 1)))

						return
					end

					ActivityStoryAction.UpdateRedPoint(slot7.activity_id, 0)
					StoryStageActivityData:SaveDefaultActivityID(ActivityCfg[slot7.activity_id].activity_theme, slot7.activity_id)
					uv0:Go("/storyStageActivity", {
						chapterID = StoryStageActivityData:GetHistoryChapter(slot5) or slot6,
						theme = ActivityCfg[slot7.activity_id].activity_theme
					})
				end

				return
			end
		end
	end)
end

function slot0.RefreshData(slot0)
	slot1 = slot0.params_.theme
	slot0.activityIDList_ = ActivityTools.GetStoryActivityIDList(slot1)
	slot0.selectChapterID_ = slot0.params_.chapterID or StoryStageActivityData:GetHistoryChapter(StoryStageActivityData:GetDefaultActivityID(slot1) or slot0.activityIDList_[1])
	slot0.selectStageIndex_ = table.keyof(ActivityStoryChapterCfg[slot0.selectChapterID_].stage_list, StoryStageActivityData:GetHistoryStage(slot0.selectChapterID_)) or 1
	slot5 = slot3.activity_id
	slot0.stageData_ = StoryStageActivityData:GetStageData(slot0.selectChapterID_)
	slot0.stageList_ = slot3.stage_list
end

function slot0.RefreshUI(slot0)
	slot1 = ActivityStoryChapterCfg[slot0.selectChapterID_].activity_id

	slot0:RefreshStageList()
	slot0.scrollMoveView_:RefreshUI(slot0:GetScrollPos(), slot0:GetScrollWidth())
	slot0:RefreshSwitchBtn()
	slot0:AddTimer()
	slot0:RefreshSelectItem()
end

function slot0.RefreshSwitchBtn(slot0)
	if ActivityStoryChapterCfg[slot0.selectChapterID_].activity_id == slot0.activityIDList_[1] then
		slot0.switchController_:SetSelectedState("1")
	else
		slot0.switchController_:SetSelectedState("2")
	end

	slot2 = ActivityStoryChapterCfg[slot0.selectChapterID_]

	for slot6, slot7 in pairs(slot0.activityIDList_) do
		if slot2.activity_id ~= slot7 then
			slot8 = ActivityStoryChapterCfg.get_id_list_by_activity_id[slot7][1]
			slot0.textTime_.text = manager.time:STimeDescS(ActivityData:GetActivityData(slot7).startTime, "!%m/%d %H:%M")

			break
		end
	end
end

function slot0.AddTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()
	end

	slot1 = nil
	slot2 = 0
	slot3 = ActivityStoryChapterCfg[slot0.selectChapterID_]

	for slot7, slot8 in pairs(slot0.activityIDList_) do
		if slot3.activity_id ~= slot8 then
			slot1 = slot8
			slot9 = ActivityStoryChapterCfg.get_id_list_by_activity_id[slot8][1]

			if manager.time:GetServerTime() < ActivityData:GetActivityData(slot8).startTime then
				slot0.btnLockController_:SetSelectedState("false")

				break
			end

			slot0.btnLockController_:SetSelectedState("true")

			return

			break
		end
	end

	slot0.timer_ = Timer.New(function ()
		if ActivityData:GetActivityIsOpen(uv0) == false then
			return
		end

		if uv1 <= manager.time:GetServerTime() then
			uv2.btnLockController_:SetSelectedState("true")
			uv2:StopTimer()
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
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
	return BattleActivityStoryStageCfg[ActivityStoryChapterCfg[slot0.selectChapterID_].stage_list[slot0.selectStageIndex_]] and slot2.position[1] or 0
end

function slot0.RefreshStageList(slot0)
	slot0.lastChapterID_ = slot0.selectChapterID_

	for slot4 = 1, #slot0.stageItemList_ do
		slot0.stageItemList_[slot4]:Show(false)
	end

	slot5 = StoryStageActivityData:GetStageData(slot0.selectChapterID_)

	for slot5 = 1, table.length(slot5) do
		if not slot0.stageItemList_[slot5] then
			slot0.stageItemList_[slot5] = slot0:GetStageItemClass().New(slot0.goStageItem_, slot0.goItemParent_)
		end

		slot0.stageItemList_[slot5]:SetData(slot0.stageList_[slot5], slot0.selectChapterID_)
	end

	slot0.scrollContenLineView_:CreateLineItemList(slot0.stageData_, slot0.stageList_, slot0.stageItemList_)
end

function slot0.RefreshSelectItem(slot0)
	slot1 = ActivityStoryChapterCfg[slot0.selectChapterID_].stage_list[slot0.selectStageIndex_]

	for slot5, slot6 in pairs(slot0.stageItemList_) do
		slot6:SelectorItem(slot1)
	end
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("storyStageInfoActivity")
end

function slot0.GetStageItemClass(slot0)
	return StoryStageItemView
end

return slot0
