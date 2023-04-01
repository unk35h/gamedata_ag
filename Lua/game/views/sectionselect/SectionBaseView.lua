slot0 = class("SectionBaseView", ReduxView)
slot1 = import("game.const.BattleConst")
slot2 = import("game.tools.JumpTools")

function slot0.UIName(slot0)
	return "UI/Stage/ChapterSectionUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0.lineList_ = {}
	slot0.lineArchiveList_ = {}
	slot0.customLineList_ = {}
	slot0.missionItem_ = {}
	slot0.lineType_ = nil
	slot0.archiveItemList_ = {}

	slot0:InitUI()
	slot0:AddListeners()
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

		uv1.Back()
	end)
	manager.ui:SetMainCamera("null")
	slot0:RefreshData()
	slot0:RefreshBGM()
	slot0:ShowPanel()
	slot0:RefreshText()
	slot0:RefreshUI()
end

function slot0.OnTop(slot0)
	slot0.stopMove_ = false
end

function slot0.OnUpdate(slot0)
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshMissionList()

	slot0.selectSection_ = slot0.params_.section or BattleFieldData:GetCacheStage(slot0.chapterID_) or slot0.stageList_[1]
	slot2 = slot0:GetScrollPos()
	slot3 = slot0:GetScrollWidth()

	if not slot0.stopMove_ then
		slot0.scrollMoveView_:RefreshUI(slot2, slot3)
	end

	slot0:RefreshSelectItem()
end

function slot0.RefreshBGM(slot0)
	if ChapterCfg[slot0.chapterID_].cue_sheet ~= "" then
		manager.audio:PlayBGM(slot1.cue_sheet, slot1.cue_name, slot1.awb)
	end
end

function slot0.GetScrollWidth(slot0)
	slot1 = 0

	for slot6, slot7 in ipairs(slot0.oepnStageList_) do
		if slot1 < slot0:GetCfgName()[slot7].position[1] then
			slot1 = slot8.position[1]
		end
	end

	return slot1
end

function slot0.GetScrollPos(slot0)
	return slot0:GetCfgName()[slot0.selectSection_] and slot1.position[1] or 0
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()

	for slot4, slot5 in ipairs(slot0.archiveItemList_) do
		slot5:OnExit()
	end

	slot0.scrollMoveView_:OnExit()

	slot0.lastChapterID_ = nil
	slot0.stopMove_ = false
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	slot0:RemoveAllListeners()

	slot0.lineType_ = nil

	for slot4, slot5 in ipairs(slot0.missionItem_) do
		slot5:Dispose()
	end

	slot0.missionItem_ = nil

	for slot4, slot5 in ipairs(slot0.archiveItemList_) do
		slot5:Dispose()
	end

	slot0.archiveItemList_ = nil

	slot0:DestroyLine()

	slot0.lineList_ = nil

	slot0:DestroyArchiveLine()

	slot0.lineArchiveList_ = nil

	for slot4, slot5 in pairs(slot0.customLineList_) do
		slot5:Dispose()
	end

	slot0.customLineList_ = nil

	if slot0.scene_ then
		Object.Destroy(slot0.scene_)

		slot0.scene_ = nil
	end

	slot0.selector_ = nil

	slot0.scrollMoveView_:Dispose()

	slot0.scrollMoveView_ = nil
	slot0.bgBtn_ = nil
	slot0.scrollView_ = nil
	slot0.scrollViewGo_ = nil
	slot0.content_ = nil
	slot0.contentRect_ = nil
	slot0.viewportRect_ = nil
	slot0.scrollViewEvent_ = nil
	slot0.selectDifficultGo_ = nil
	slot0.collectBtnGo_ = nil
	slot0.collectBtn_ = nil
	slot0.collectCurText_ = nil
	slot0.collectTotalText_ = nil
	slot0.collectProgress_ = nil
	slot0.sectionItem_ = nil
	slot0.lineGo_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollMoveView_ = ScrollMoveView.New(slot0, slot0.scrollViewGo_)

	slot0:InitCustom()
end

function slot0.InitCustom(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if uv0:IsOpenSectionInfo() then
			uv0.isOpenInfoView_ = false

			uv1.Back()
		end
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.bgBtn_.onClick:RemoveAllListeners()
end

function slot0.RefreshData(slot0)
	if slot0.params_.chapterID == nil then
		slot0.chapterID_ = BattleFieldData:GetCacheChapter(BattleFieldData:GetCacheChapterClient(ChapterClientCfg[slot0.params_.chapterClientID].toggle))
	else
		slot0.chapterID_ = slot0.params_.chapterID
	end

	slot0.stageData_ = BattleStageData:GetStageData()
	slot0.stageList_ = ChapterCfg[slot0.chapterID_].section_id_list

	BattleFieldData:SetStageByClientID(getChapterClientCfgByChapterID(slot0.chapterID_).id, slot0.params_.section or BattleFieldData:GetCacheStage(slot0.chapterID_) or ChapterCfg[slot0.chapterID_].section_id_list[1])
	BattleFieldAction.ChangeSelectChapterID(slot0.chapterID_)
	slot0:RefreshCustomData()

	slot0.oepnStageList_ = slot0:GetOpenStageList()
end

function slot0.RefreshCustomData(slot0)
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("challengeSectionInfo")
end

function slot0.GetCfgName(slot0)
end

function slot0.ShowPanel(slot0)
	SetActive(slot0.collectBtnGo_, false)
	SetActive(slot0.selectDifficultGo_, false)
end

function slot0.RefreshText(slot0)
end

function slot0.SwitchBG(slot0)
	if ChapterCfg[slot0.chapterID_].bg ~= "" then
		slot0.bgImage_.sprite = getSpriteWithoutAtlas("Textures/Background/" .. slot1.bg)
	end
end

function slot0.RefreshSelectItem(slot0)
	for slot4, slot5 in pairs(slot0.missionItem_) do
		slot5:SelectorItem(slot0.selectSection_)
	end
end

function slot0.RefreshMissionList(slot0)
	if slot0.lastChapterID_ == slot0.chapterID_ then
		return
	end

	slot0.lastChapterID_ = slot0.chapterID_

	for slot4 = 1, #slot0.missionItem_ do
		slot0.missionItem_[slot4]:Show(false)
	end

	for slot4 = 1, #slot0.stageList_ do
		if slot0.missionItem_[slot4] then
			slot0.missionItem_[slot4]:SetData(slot0.chapterID_, slot0.stageList_[slot4])
		else
			slot0.missionItem_[slot4] = slot0:GetSectionItemClass().New(slot0.sectionItem_, slot0.content_, slot0.stageList_[slot4], slot0.chapterID_)
		end
	end

	slot0:CreateLineItemList()
end

function slot0.CreateLineItemList(slot0)
	if slot0.lineType_ ~= ChapterCfg[slot0.chapterID_].line_type then
		slot0:DestroyLine()

		slot0.lineType_ = ChapterCfg[slot0.chapterID_].line_type
	end

	slot1 = 1

	for slot5 = 1, #slot0.archiveItemList_ do
		slot0.archiveItemList_[slot5]:Show(false)
	end

	for slot5, slot6 in pairs(slot0.lineList_) do
		slot6:Show(false)
	end

	for slot5, slot6 in pairs(slot0.lineArchiveList_) do
		slot6:Show(false)
	end

	for slot5, slot6 in pairs(slot0.customLineList_) do
		slot6:Show(false)
	end

	slot2 = 1
	slot3 = 1
	slot4 = 1

	for slot9, slot10 in ipairs(slot0.oepnStageList_) do
		slot12 = slot0.missionItem_[table.keyof(slot0.stageList_, slot10)]:GetLocalPosition() + Vector3(-137, -13.8, 0)
		slot14 = #(slot0:GetCfgName()[slot10].pre_show_id_list or {}) > 1

		for slot18, slot19 in ipairs(slot13) do
			if not slot0.stageData_[slot19] or slot0.stageData_[slot19].clear_times <= 0 then
				slot14 = false

				break
			end
		end

		for slot18, slot19 in ipairs(slot13) do
			if type(slot0:GetCfgName()[slot10].custom_line) == "table" and #slot20.custom_line[slot18] > 0 and (slot0.stageData_[slot10] and slot0.stageData_[slot10].clear_times > 0 or slot14) then
				slot0:DrawLine(slot2, slot20.custom_line[slot18])

				slot2 = slot2 + 1
			elseif type(slot20.custom_lock_line) == "table" and #slot20.custom_lock_line[slot18] > 0 then
				slot0:DrawLine(slot2, slot20.custom_lock_line[slot18])

				slot2 = slot2 + 1
			elseif table.keyof(slot5, slot19) then
				slot0.lineList_[slot2] = slot0.lineList_[slot2] or slot0:GetLineClass(slot0.lineType_).New(slot0:GetLineGo(slot0.lineType_), slot0.content_, slot0:GetPointGo(slot0.lineType_))

				slot0.lineList_[slot2]:Show(true)
				slot0.lineList_[slot2]:RefreshUI(slot0.missionItem_[table.keyof(slot0.stageList_, slot19)]:GetLocalPosition() + Vector3(173, -13.8, 0), slot12)

				slot2 = slot2 + 1
			end
		end

		if BattleStageTools.GetStageCfg(ChapterCfg[slot0.chapterID_].type, slot10).stage_archive_id and slot15.stage_archive_id ~= 0 then
			slot0.archiveItemList_[slot1] = slot0.archiveItemList_[slot1] or ChapterStageArchiveItem.New(slot0.stageExtraInfoGo_, slot0.content_)

			slot0.archiveItemList_[slot1]:SetData(slot0.chapterID_, slot10, slot15.stage_archive_id)

			slot17 = StageArchiveCfg[slot15.stage_archive_id].position
			slot0.lineArchiveList_[slot4] = slot0.lineArchiveList_[slot4] or SectionLineItem.New(slot0:GetLineGo(0), slot0.content_, slot0:GetPointGo(0))

			slot0.lineArchiveList_[slot4]:Show(true)
			slot0.lineArchiveList_[slot4]:RefreshUI(Vector3(slot15.position[1], slot15.position[2], 0) + Vector3(173, -13.8, 0), Vector3(slot17[1], slot17[2], 0))

			slot4 = slot4 + 1
			slot1 = slot1 + 1
		end
	end
end

function slot0.DrawLine(slot0, slot1, slot2)
	slot0.customLineList_[slot1] = slot0.customLineList_[slot1] or SectionCustomLineItem.New(slot0:GetLineGo(slot0.lineType_), slot0.content_, slot0:GetPointGo(slot0.lineType_))

	slot0.customLineList_[slot1]:Show(true)
	slot0.customLineList_[slot1]:RefreshUI(slot2)
end

function slot0.GetOpenStageList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.stageList_) do
		if slot0.stageData_[slot6] then
			if not table.keyof(slot1, slot6) then
				if slot6 ~= GameSetting.travel_skuld_new_ending_stage_id.value[1] or slot0.stageData_[slot6].clear_times >= 1 then
					table.insert(slot1, slot6)
				end
			end

			if slot0.stageData_[slot6].clear_times > 0 then
				for slot11, slot12 in ipairs(slot0:GetCfgName()[slot6].next_show_id_list) do
					if not table.keyof(slot1, slot12) then
						if slot12 == GameSetting.travel_skuld_new_ending_stage_id.value[1] then
							if slot0.stageData_[slot12] then
								if not slot0.stageData_[slot12] or slot0.stageData_[slot12].clear_times >= 1 then
									table.insert(slot1, slot12)
								end
							end
						else
							table.insert(slot1, slot12)
						end
					end
				end
			end
		end
	end

	return slot1
end

function slot0.GetLineClass(slot0, slot1)
	if slot1 == 0 then
		return SectionLineItem
	else
		return SectionBranchLineItem
	end
end

function slot0.GetLineGo(slot0, slot1)
	if slot1 == 2 then
		return slot0.lineGo2_
	else
		return slot0.lineGo_
	end
end

function slot0.GetPointGo(slot0, slot1)
	if slot1 == 2 then
		return slot0.pointGo2_
	else
		return slot0.pointGo_
	end
end

function slot0.DestroyLine(slot0)
	for slot4, slot5 in pairs(slot0.lineList_) do
		slot5:Dispose()
	end

	slot0.lineList_ = {}
end

function slot0.DestroyArchiveLine(slot0)
	for slot4, slot5 in pairs(slot0.lineArchiveList_) do
		slot5:Dispose()
	end

	slot0.lineArchiveList_ = {}
end

return slot0
