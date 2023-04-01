slot0 = class("SubPlotBtnView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.chapterID_ = slot3

	slot0:Init()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "lock")

	slot0:IsLock()
	slot0:RefreshItem()
	slot0:Show(true)
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot0.chapterID_))
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot0.chapterID_))
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.btn_ = nil
	slot0.gameObject_ = nil
	slot0.text_ = nil
	slot0.canvasGroup_ = nil
	slot0.unsubscribeFun = nil
	slot0.selector_ = nil
	slot0.lockGo_ = nil
end

function slot0.SetData(slot0, slot1)
	slot0.chapterID_ = slot1

	slot0:IsLock()
	slot0:RefreshItem()
	slot0:Show(true)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.isLock_ then
			if table.keyof(getChapterClientCfgByChapterID(uv0.chapterID_).chapter_list, uv0.chapterID_) <= 1 then
				return
			end

			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), slot0.name, ChapterCfg[slot0.chapter_list[slot1 - 1]].subhead))

			return
		end

		BattleStageAction.ClickSubPlot(uv0.chapterID_)
		manager.notify:Invoke(CHANGE_CHAPTER, uv0.chapterID_)
	end)
end

function slot0.RefreshItem(slot0)
	if slot0.isLock_ then
		slot0.controller_:SetSelectedState("off")
	else
		slot0.controller_:SetSelectedState("on")
	end

	slot0.text_.text = ChapterCfg[slot0.chapterID_].subhead
	slot0.text2_.text = ChapterCfg[slot0.chapterID_].subhead
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetSiblingIndex(slot0, slot1)
	slot0.transform_:SetSiblingIndex(slot1)
end

function slot0.IsLock(slot0)
	slot0.isLock_ = BattleStageData:GetStageData()[ChapterCfg[slot0.chapterID_].section_id_list[1]] == nil

	if slot0.isLock_ then
		slot0.isLock_ = #slot1.pre_chapter > 0
	end
end

return slot0
