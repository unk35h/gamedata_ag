slot0 = class("DailyChapterItemBtn", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4)
	slot0.parentView_ = slot1
	slot0.gameObject_ = Object.Instantiate(slot2, slot3.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.chapterID_ = slot4

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
	slot0:IsLock()
	slot0:RefreshItem()
end

function slot0.Dispose(slot0)
	slot0.parentView_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.btn_ = nil
	slot0.gameObject_ = nil
	slot0.text_ = nil
	slot0.canvasGroup_ = nil
	slot0.unsubscribeFun = nil
	slot0.selector_ = nil
	slot0.lockGo_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.chapterID_ = slot1

	slot0:IsLock()
	slot0:RefreshItem()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.isLock_ then
			ShowTips("NEED_FINISH_PRE_STAGE")

			return
		end

		uv0.parentView_:SwitchDailyChapter(uv0.chapterID_)
	end)
end

function slot0.RefreshItem(slot0)
	if slot0.isLock_ then
		SetActive(slot0.lockGo_, true)

		slot0.canvasGroup_.alpha = 0.5
	else
		SetActive(slot0.lockGo_, false)

		slot0.canvasGroup_.alpha = 1
	end

	slot0.text_.text = ChapterCfg[slot0.chapterID_].subhead
end

function slot0.SetSiblingIndex(slot0, slot1)
	slot0.transform_:SetSiblingIndex(slot1)
end

function slot0.IsLock(slot0)
	slot0.isLock_ = BattleStageData:GetStageData()[ChapterCfg[slot0.chapterID_].section_id_list[1]] == nil
end

return slot0
