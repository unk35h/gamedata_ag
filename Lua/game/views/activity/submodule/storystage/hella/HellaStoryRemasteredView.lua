slot0 = class("HellaStoryRemasteredView", ReduxView)

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
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "active")

	slot0.controller_:SetSelectedState("off")

	slot0.extraStoryView_ = SubPlotExtraStoryBtn.New(slot0.extraStoryGo_)
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
	slot0:RefreshData()

	slot2 = ChapterClientCfg[getChapterClientCfgByChapterID(slot0.selectChapterID_).id].chapter_list

	for slot6 = 1, 3 do
		slot0.storyChapterView_[slot6] = slot0.storyChapterView_[slot6] or HellaStoryChapterView.New(slot0[string.format("chapterBtn%s_", slot6)], slot2[slot6])
	end

	for slot6, slot7 in pairs(slot0.storyChapterView_) do
		slot7:OnEnter(slot0.selectChapterID_)
	end

	slot0:RefreshUI()
	BattleStageAction.ClickSubPlot(slot0.selectChapterID_)
	manager.notify:RegistListener(CHANGE_CHAPTER, slot0.changeChapterHandler_)
	slot0.extraStoryView_:OnEnter()
	manager.redPoint:bindUIandKey(slot0.transformRedPoint2_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot2[4]))
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.storyChapterView_) do
		slot5:OnExit()
	end

	slot0.scrollMoveView_:OnExit()
	manager.notify:RemoveListener(CHANGE_CHAPTER, slot0.changeChapterHandler_)
	slot0.extraStoryView_:OnExit()
	manager.redPoint:unbindUIandKey(slot0.transformRedPoint2_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, ChapterClientCfg[getChapterClientCfgByChapterID(slot0.selectChapterID_).id].chapter_list[4]))
end

function slot0.OnUpdate(slot0)
	slot0:RefreshData()
	slot0:RefreshUI()

	for slot4, slot5 in pairs(slot0.storyChapterView_) do
		slot5:OnUpdate(slot0.selectChapterID_)
	end
end

function slot0.Dispose(slot0)
	slot0.extraStoryView_:Dispose()

	slot0.extraStoryView_ = nil

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
		if table.keyof(getChapterClientCfgByChapterID(uv0.selectChapterID_).chapter_list, uv0.selectChapterID_) < 4 then
			if BattleStageData:GetStageData()[ChapterCfg[slot0.chapter_list[4]].section_id_list[1]] == nil then
				ShowTips(string.format(GetTips("NOTE_TASK_UNLOCK"), ChapterCfg[slot0.chapter_list[3]].subhead))

				return
			else
				BattleFieldData:SetStageByClientID(slot0.id, BattleFieldData:GetCacheStage(slot0.chapter_list[4]) or ChapterCfg[slot2].section_id_list[1])
				BattleFieldData:SetCacheChapterClient(getChapterToggle(slot0.id), slot0.id)
				BattleFieldData:SetSecondCacheChapter(getChapterToggle(slot0.id), uv0.selectChapterID_)
				BattleStageAction.ClickSubPlot(slot2)
				JumpTools.Jump2SubPlot(slot0.id, true)
			end
		else
			slot1 = BattleFieldData:GetSecondCacheChapter(getChapterToggle(slot0.id)) or slot0.chapter_list[1]

			BattleFieldData:SetStageByClientID(slot0.id, BattleFieldData:GetCacheStage(slot1) or ChapterCfg[slot1].section_id_list[1])
			BattleFieldData:SetCacheChapterClient(getChapterToggle(slot0.id), slot0.id)
			JumpTools.Jump2SubPlot(slot0.id, true)
		end
	end)
end

function slot0.RefreshData(slot0)
	if slot0.params_.chapterID == nil then
		slot2 = ChapterClientCfg[slot0.params_.chapterClientID]
		slot0.selectChapterID_ = BattleFieldData:GetCacheChapter(slot2.id)

		if table.keyof(slot2.chapter_list, slot0.selectChapterID_) < 4 then
			slot0.selectChapterID_ = BattleFieldData:GetSecondCacheChapter(getChapterToggle(slot2.id)) or slot2.chapter_list[1]
		end
	else
		slot0.selectChapterID_ = slot0.params_.chapterID
	end

	slot0.stageData_ = BattleStageData:GetStageData()
	slot0.stageList_ = ChapterCfg[slot0.selectChapterID_].section_id_list

	slot0.extraStoryView_:SetData(slot0.selectChapterID_)
end

function slot0.RefreshUI(slot0)
	slot0.selectStageID_ = BattleFieldData:GetCacheStage(slot0.selectChapterID_) or ChapterCfg[slot1].section_id_list[1]

	slot0:RefreshStageList()
	slot0.scrollMoveView_:RefreshUI(slot0:GetScrollPos(), slot0:GetScrollWidth())
	slot0:RefreshSwitchBtn()
	slot0:RefreshSelectItem()
	slot0:RefreshChapterPanel()
	slot0:RefreshRedPoint()
end

function slot0.RefreshSwitchBtn(slot0)
	if table.keyof(getChapterClientCfgByChapterID(slot0.selectChapterID_).chapter_list, slot0.selectChapterID_) < 4 then
		slot0.switchController_:SetSelectedState("1")
	else
		slot0.switchController_:SetSelectedState("2")
	end

	if BattleStageData:GetStageData()[ChapterCfg[slot1.chapter_list[4]].section_id_list[1]] == nil then
		slot0.btnLockController_:SetSelectedState("false")
	else
		slot0.btnLockController_:SetSelectedState("true")
	end
end

function slot0.RefreshChapterPanel(slot0)
	if table.keyof(ChapterClientCfg[getChapterClientCfgByChapterID(slot0.selectChapterID_).id].chapter_list, slot0.selectChapterID_) > 3 then
		SetActive(slot0.goChapterPanel1_, false)
	else
		SetActive(slot0.goChapterPanel1_, true)
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

function slot0.RefreshStageList(slot0)
	for slot4 = 1, #slot0.stageItemList_ do
		slot0.stageItemList_[slot4]:Show(false)
	end

	slot1 = BattleStageData:GetStageData()

	for slot5 = 1, #slot0.stageList_ do
		if slot5 == 1 or slot1[slot0.stageList_[slot5]] then
			if not slot0.stageItemList_[slot5] then
				slot0.stageItemList_[slot5] = slot0:GetStageItemClass().New(slot0.goStageItem_, slot0.goItemParent_)
			end

			slot0.stageItemList_[slot5]:SetData(slot0.stageList_[slot5], slot0.selectChapterID_)
		end
	end

	slot0.scrollContenLineView_:CreateLineItemList(slot0.stageData_, slot0.stageList_, slot0.stageItemList_)
end

function slot0.RefreshSelectItem(slot0)
	slot1 = slot0.selectStageID_

	for slot5, slot6 in pairs(slot0.stageItemList_) do
		slot6:SelectorItem(slot1)
	end
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("subPlotSectionInfo")
end

function slot0.GetStageItemClass(slot0)
	return HellaStoryRemasteredItem
end

function slot0.RefreshRedPoint(slot0)
	if table.keyof(getChapterClientCfgByChapterID(slot0.selectChapterID_).chapter_list, slot0.selectChapterID_) < 4 and manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot2[4])) == 1 and BattleStageData:GetSubPlotRedPointFlag(slot3) ~= 1 then
		SetActive(slot0.transformRedPoint2_.gameObject, true)

		return
	end

	SetActive(slot0.transformRedPoint2_.gameObject, false)
end

return slot0
