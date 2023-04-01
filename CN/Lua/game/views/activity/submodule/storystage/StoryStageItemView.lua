slot0 = class("StoryStageItemView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.clearController_ = ControllerUtil.GetController(slot0.transform_, "clear")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.selectChapterID_ = slot2
	slot0.stageID_ = slot1

	slot0:RefreshLockData(slot1, slot2)
	slot0:RefreshClearData(slot1)
	slot0:RefreshUI()
end

function slot0.RefreshClearData(slot0, slot1, slot2)
	if StoryStageActivityData:GetStageData(slot2)[slot1] and slot3.clear_times > 0 then
		slot0.isClear_ = true
	else
		slot0.isClear_ = false
	end
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

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		uv0:OnClick()
	end)
end

function slot0.RefreshUI(slot0)
	slot1 = BattleActivityStoryStageCfg[slot0.stageID_]
	slot2 = slot1.position
	slot0.transform_.localPosition = Vector3(slot2[1], slot2[2], 0)
	slot0.textName_.text = slot1.name

	slot0:RefreshClear()
	slot0:Show(true)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.GetLocalPosition(slot0)
	return slot0.transform_.localPosition
end

function slot0.OnClick(slot0)
	if slot0.isLock_ then
		slot1 = WarchessLevelCfg[slot0.preStageID_]

		ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityCfg[slot1.activity].name, slot1.name_level))
	else
		StoryStageActivityData:SaveHistoryStage(slot0.selectChapterID_, slot0.stageID_)
		slot0:Go("storyStageInfoActivity", {
			chapterID = slot0.selectChapterID_,
			section = slot0.stageID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY
		})
	end
end

function slot0.SelectorItem(slot0, slot1)
	if slot0.stageID_ == slot1 and slot0:IsOpenSectionInfo() then
		slot0.controller_:SetSelectedState("Select")
	else
		slot0.controller_:SetSelectedState("normal")
	end
end

function slot0.RefreshClear(slot0)
	if slot0.isClear_ then
		slot0.clearController_:SetSelectedState("on")
	else
		slot0.clearController_:SetSelectedState("off")
	end
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("storyStageInfoActivity")
end

return slot0
