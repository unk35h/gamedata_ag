slot0 = class("ActivityFactoryStoryItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.clearController_ = ControllerUtil.GetController(slot0.transform_, "clear")
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.lineController_ = ControllerUtil.GetController(slot0.transform_, "line")
end

function slot0.OnExit(slot0)
	if slot0.archiveView_ then
		slot0.archiveView_:OnExit()
	end

	slot0:Show(false)
end

function slot0.Dispose(slot0)
	if slot0.archiveView_ then
		slot0.archiveView_:Dispose()

		slot0.archiveView_ = nil
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		BattleFieldData:SetCacheStage(uv0.chapterID_, uv0.stageID_)
		uv0:Go("subPlotSectionInfo", {
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT,
			chapterID = uv0.chapterID_,
			section = uv0.stageID_
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.stageID_ = slot1
	slot0.chapterID_ = slot2
	slot0.isClear_ = false

	if BattleStageData:GetStageData()[slot0.stageID_] and slot3.clear_times > 0 then
		slot0.isClear_ = true
	end

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot1 = slot0:GetPosition()
	slot0.transform_.localPosition = Vector3(slot1[1], slot1[2], 0)
	slot2 = ChapterCfg[slot0.chapterID_]
	slot3 = slot2.activity_id
	slot0.textIndex_.text = string.format("%02d", table.keyof(slot2.section_id_list, slot0.stageID_))
	slot0.textName_.text = BattleActivityStoryStageCfg[slot0.stageID_].name

	slot0:RefreshClear()
	slot0:RefreshArchive()
	slot0:Show(true)
end

function slot0.GetPosition(slot0)
	return BattleActivityStoryStageCfg[slot0.stageID_] and slot1.position or {
		0,
		0
	}
end

function slot0.SelectorItem(slot0, slot1)
	if slot0.stageID_ == slot1 and slot0:IsOpenSectionInfo() then
		slot0.selectController_:SetSelectedState("on")
	else
		slot0.selectController_:SetSelectedState("off")
	end
end

function slot0.RefreshClear(slot0)
	if slot0.isClear_ then
		slot0.clearController_:SetSelectedState("on")
	else
		slot0.clearController_:SetSelectedState("off")
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("subPlotSectionInfo")
end

function slot0.RefreshArchive(slot0)
	if BattleActivityStoryStageCfg[slot0.stageID_].stage_archive_id == 0 then
		slot0.lineController_:SetSelectedState("hide")

		return
	end

	if StageArchiveCfg[slot1].position[2] > 0 then
		slot0.lineController_:SetSelectedState("top")
	else
		slot0.lineController_:SetSelectedState("bottom")
	end

	slot0.archiveView_ = slot0.archiveView_ or ActivityFactoryArchiveView.New(slot0.archiveGo_)

	slot0.archiveView_:SetData(slot0.stageID_, slot1, BattleStageData:GetStageData()[slot0.stageID_].clear_times <= 0)
end

function slot0.GetLocalPosition(slot0)
	return slot0.transform_.localPosition
end

return slot0
