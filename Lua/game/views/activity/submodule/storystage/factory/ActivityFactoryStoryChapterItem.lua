slot0 = class("ActivityFactoryStoryChapterItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.chapterID_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.OnEnter(slot0, slot1)
	slot0.isLock_ = BattleStageData:GetStageData()[ChapterCfg[slot0.chapterID_].section_id_list[1]] == nil

	slot0:RefreshBtn(slot1)

	slot3 = ChapterCfg[slot0.chapterID_].activity_id

	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot0.chapterID_))
end

function slot0.OnExit(slot0)
	slot1 = ChapterCfg[slot0.chapterID_].activity_id

	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot0.chapterID_))
end

function slot0.OnUpdate(slot0, slot1)
	slot0:RefreshBtn(slot1)
end

function slot0.RefreshBtn(slot0, slot1)
	if slot0.chapterID_ == slot1 then
		slot0.selectController_:SetSelectedState("true")
		BattleStageAction.ClickSubPlot(slot0.chapterID_)
	else
		slot0.selectController_:SetSelectedState("false")
	end

	if slot0.isLock_ then
		slot0.controller_:SetSelectedState("false")
	else
		slot0.controller_:SetSelectedState("true")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.isLock_ then
			if manager.time:GetServerTime() < ActivityData:GetActivityRefreshTime(ChapterCfg[uv0.chapterID_].activity_id) then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot2)))

				return
			end

			slot7 = uv0.chapterID_

			for slot7, slot8 in ipairs(ChapterCfg[slot7].pre_chapter) do
				if not BattleStageData:GetStageData()[ChapterCfg[slot8].section_id_list[#ChapterCfg[slot8].section_id_list]] or slot10.clear_times <= 0 then
					ShowTips(string.format(GetTips("NOTE_TASK_UNLOCK"), ChapterCfg[slot8].subhead))

					return
				end
			end
		else
			slot0 = getChapterClientCfgByChapterID(uv0.chapterID_)

			BattleFieldData:SetStageByClientID(slot0.id, BattleFieldData:GetCacheStage(uv0.chapterID_) or ChapterCfg[uv0.chapterID_].section_id_list[1])
			BattleFieldData:SetCacheChapterClient(getChapterToggle(slot0.id), slot0.id)
			BattleFieldData:SetSecondCacheChapter(getChapterToggle(slot0.id), uv0.chapterID_)
			BattleStageAction.ClickSubPlot(uv0.chapterID_)
			JumpTools.Jump2SubPlot(slot0.id, true)
		end
	end)
end

return slot0
