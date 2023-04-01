slot0 = class("OsirisStoryStageItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.transform_.name = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.clearController_ = ControllerUtil.GetController(slot0.transform_, "clear")

	slot0:SetData(slot2, slot3)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		uv0:OnClick()
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.stageID_ = slot1
	slot0.chapterID_ = slot2
	slot0.preStageID_ = nil

	for slot6, slot7 in pairs(GameSetting.activity_plot_unlock.value) do
		if slot7[1][1] == slot2 and slot7[1][2] == slot1 then
			slot0.preStageID_ = slot7[2][1]
		end
	end

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("osirisStoryStageInfo")
end

function slot0.GetPosition(slot0)
	return BattleActivityStoryStageCfg[slot0.stageID_] and slot1.position or {
		0,
		0
	}
end

function slot0.RefreshData(slot0)
	if StoryStageActivityData:GetStageData(slot0.chapterID_)[slot0.stageID_] then
		slot2 = 100

		if slot0.preStageID_ then
			slot2 = ChessTools.GetChapterProgress(slot0.preStageID_)
		end

		slot0.isLock_ = false
		slot0.isOpen_ = slot2 >= 100

		if slot1.clear_times > 0 then
			slot0.isClear_ = true
		else
			slot0.isClear_ = false
		end
	else
		slot0.isLock_ = true
		slot0.isOpen_ = false
		slot0.isClear_ = false
	end
end

function slot0.OnClick(slot0)
	if not slot0.isOpen_ then
		ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityCfg[WarchessLevelCfg[slot0.preStageID_].activity].name, WarchessLevelCfg[slot0.preStageID_].name_level))
	else
		StoryStageActivityData:SaveHistoryStage(slot0.chapterID_, slot0.stageID_)
		slot0:Go("osirisStoryStageInfo", {
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY,
			section = slot0.stageID_,
			chapterID = slot0.chapterID_
		})
	end
end

function slot0.RefreshUI(slot0)
	slot1 = slot0:GetPosition()
	slot0.transform_.localPosition = Vector3(slot1[1], slot1[2], 0)
	slot2 = ActivityStoryChapterCfg[slot0.chapterID_]
	slot3 = slot2.activity_id
	slot0.textIndex_.text = string.format("%02d", table.keyof(slot2.stage_list, slot0.stageID_))
	slot5 = BattleActivityStoryStageCfg[slot0.stageID_]
	slot0.textName_.text = slot5.name
	slot0.imageBg_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot5.background_1))

	slot0:Show(not slot0.isLock_)
	slot0:RefreshClear()
end

function slot0.GetLocalPosition(slot0)
	return slot0.transform_.localPosition
end

function slot0.SelectorItem(slot0, slot1)
	if slot0.stageID_ == slot1 and slot0:IsOpenSectionInfo() then
		SetActive(slot0.selectGo_, true)
	else
		SetActive(slot0.selectGo_, false)
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

return slot0
