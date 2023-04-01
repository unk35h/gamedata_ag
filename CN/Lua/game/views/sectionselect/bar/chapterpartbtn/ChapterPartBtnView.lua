slot0 = class("ChapterPartBtnView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.partBtnItemList_ = {}

	for slot5 = 1, 2 do
		slot0.partBtnItemList_[slot5] = ChapterPartBtnItem.New(slot0[string.format("chapterPart%sGo_", slot5)], slot5)
	end
end

function slot0.OnEnter(slot0)
	for slot4, slot5 in ipairs(slot0.partBtnItemList_) do
		slot5:OnEnter()
	end
end

function slot0.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.partBtnItemList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.partBtnItemList_) do
		slot5:Dispose()
	end

	slot0.partBtnItemList_ = nil
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.RefreshUI(slot0, slot1)
	if #getChapterClientCfgByChapterID(slot1).chapter_list > 1 and slot2.id ~= ChapterConst.CHAPTER_CLIENT_EMPTY_DREAM then
		slot6 = true

		SetActive(slot0.gameObject_, slot6)

		for slot6 = 1, 2 do
			slot0.partBtnItemList_[slot6]:SetChapterID(slot2.chapter_list[slot6], slot1)
		end
	else
		SetActive(slot0.gameObject_, false)
	end
end

return slot0
