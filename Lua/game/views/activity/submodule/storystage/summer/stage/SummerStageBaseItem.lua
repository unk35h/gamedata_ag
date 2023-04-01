slot0 = class("SummerStageBaseItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.controllerTransform_, "name")
	slot0.clearController_ = ControllerUtil.GetController(slot0.controllerTransform_, "getn")
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

function slot0.SetData(slot0, slot1, slot2)
	slot0.stageID_ = slot1
	slot0.chapterID_ = slot2

	slot0:RefreshLockData(slot1, slot2)
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.RefreshLockData(slot0, slot1, slot2)
	slot0.isLock_ = false

	for slot6, slot7 in pairs(GameSetting.activity_plot_unlock.value) do
		if slot7[1][1] == slot2 and slot7[1][2] == slot1 then
			for slot11, slot12 in ipairs(slot7[2]) do
				slot0.isLock_ = ChessTools.GetChapterProgress(slot12) < 100

				if slot0.isLock_ then
					slot0.preStageID_ = slot12

					return
				end
			end

			return
		end
	end
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("storyStageInfoActivity")
end

function slot0.GetPosition(slot0)
	return BattleActivityStoryStageCfg[slot0.stageID_] and slot1.position or {
		0,
		0
	}
end

function slot0.RefreshData(slot0)
	if StoryStageActivityData:GetStageData(slot0.chapterID_)[slot0.stageID_] then
		slot0.clearTimes_ = slot1.clear_times
	else
		slot0.clearTimes_ = 0
	end
end

function slot0.OnClick(slot0)
	if slot0.isLock_ then
		ShowTips("ACTIVITY_FINISH_ALL_SUMMER_CHESS")
	else
		StoryStageActivityData:SaveHistoryStage(slot0.chapterID_, slot0.stageID_)
		slot0:Go("storyStageInfoActivity", {
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY,
			section = slot0.stageID_,
			chapterID = slot0.chapterID_
		})
	end
end

function slot0.RefreshUI(slot0)
	slot1 = slot0:GetPosition()
	slot0.transform_.localPosition = Vector3(slot1[1], slot1[2], 0)

	slot0:RefreshText()

	if slot0.isLock_ then
		slot0.controller_:SetSelectedState("off")
	else
		slot0.controller_:SetSelectedState("on")
	end

	if slot0.clearTimes_ > 0 then
		slot0.clearController_:SetSelectedState("get")
	else
		slot0.clearController_:SetSelectedState("nor")
	end

	slot0:Show(true)
end

function slot0.GetLocalPosition(slot0)
	return slot0.transform_.localPosition
end

function slot0.SelectorItem(slot0, slot1)
	if slot0.stageID_ == slot1 and slot0:IsOpenSectionInfo() then
		slot0.controller_:SetSelectedState("selected")
	elseif slot0.isLock_ then
		slot0.controller_:SetSelectedState("off")
	else
		slot0.controller_:SetSelectedState("on")
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.RefreshText(slot0)
end

return slot0
