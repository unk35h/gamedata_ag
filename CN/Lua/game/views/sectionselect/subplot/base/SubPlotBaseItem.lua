slot0 = class("SubPlotBaseItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.clearController_ = ControllerUtil.GetController(slot0.transform_, "clear")
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.stageID_ = slot1
	slot0.chapterID_ = slot2

	if BattleStageData:GetStageData()[slot1] and slot3.clear_times > 0 then
		slot0.isClear_ = true
	else
		slot0.isClear_ = false
	end

	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		uv0:OnClick()
	end)
end

function slot0.OnClick(slot0)
	BattleFieldData:SetCacheStage(slot0.chapterID_, slot0.stageID_)
	slot0:Go("subPlotSectionInfo", {
		section = slot0.stageID_,
		chapterID = slot0.chapterID_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
	})
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("subPlotSectionInfo")
end

function slot0.RefreshUI(slot0)
	slot1 = slot0:GetPosition()
	slot0.transform_.localPosition = Vector3(slot1[1], slot1[2], 0)

	slot0:Show(true)
	slot0:RefreshCustomUI()
	slot0:RefreshClear()
end

function slot0.RefreshCustomUI(slot0)
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

function slot0.GetPosition(slot0)
	return BattleActivityStoryStageCfg[slot0.stageID_] and slot1.position or {
		0,
		0
	}
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
