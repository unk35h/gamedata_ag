slot0 = class("ChapterVariantBaseView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Stage/ChaptePlot/ChaptePlot12UI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.chapterItemList_ = {}
	slot0.skuldBtnController_ = ControllerUtil.GetController(slot0.skuldbtn_.transform, "isbreach")
end

function slot0.OnEnter(slot0)
	slot5 = HOME_BAR

	manager.windowBar:SwitchBar({
		BACK_BAR,
		slot5
	})

	slot0.chapterClientID_ = slot0.params_.chapterClientID
	slot4 = slot0.chapterClientID_

	for slot4, slot5 in ipairs(ChapterClientCfg[slot4].chapter_list) do
		if slot0.chapterItemList_[slot4] == nil then
			slot0.chapterItemList_[slot4] = ChapterVariantBaseItem.New(slot0[string.format("chapterBtn%s_", slot4)], slot5)
		end

		slot0.chapterItemList_[slot4]:OnEnter(slot5)
	end

	for slot4 = #slot0.chapterItemList_, #ChapterClientCfg[slot0.chapterClientID_].chapter_list + 1, -1 do
		slot0.chapterItemList_[slot4]:Dispose()

		slot0.chapterItemList_[slot4] = nil
	end

	SetActive(slot0.skuldbtn_.gameObject, SkuldTravelData:GetSkuldTravelIsOpen())
	slot0.skuldBtnController_:SetSelectedState(SkuldTravelData:GetSkuldBtnIsBreach() and "true" or "false")
	manager.redPoint:bindUIandKey(slot0.skuldbtn_.transform, RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in ipairs(slot0.chapterItemList_) do
		slot5:OnExit()
	end

	manager.redPoint:unbindUIandKey(slot0.skuldbtn_.transform, RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.chapterItemList_) do
		slot5:Dispose()
	end

	slot0.chapterItemList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.skuldbtn_, nil, function ()
		if SkuldTravelData:GetSkuldTravelIsOpen() then
			JumpTools.GoToSystem("/skuldTravelView")
		else
			slot0 = GameSetting.travel_skuld_unlock.value[1]
			slot2, slot3 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot0)

			ShowTips(string.format(GetTips("MISSION_PROGRESS_UNLOCK_EX"), getChapterDifficulty(slot0), slot2 .. "-" .. slot3))
		end
	end)
end

return slot0
