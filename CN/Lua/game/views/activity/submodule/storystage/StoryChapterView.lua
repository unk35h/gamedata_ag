slot0 = class("StoryChapterView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.activityID_ = slot2

	slot0:BindCfgUI()

	slot0.btnList_ = {}

	for slot6, slot7 in pairs(ActivityStoryChapterCfg.get_id_list_by_activity_id[slot2]) do
		slot0.btnList_[slot6] = StoryChapterBtnView.New(slot0[string.format("btnChapter%s_", slot6)], slot7)
	end
end

function slot0.OnEnter(slot0, slot1)
	for slot5, slot6 in pairs(slot0.btnList_) do
		slot6:OnEnter(slot1)
	end

	slot0:RefreshUI(slot1)
end

function slot0.OnExit(slot0)
	for slot4, slot5 in pairs(slot0.btnList_) do
		slot5:OnExit()
	end
end

function slot0.OnUpdate(slot0, slot1)
	for slot5, slot6 in pairs(slot0.btnList_) do
		slot6:OnUpdate(slot1)
	end

	slot0:RefreshUI(slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.btnList_) do
		slot5:Dispose()
	end

	slot0.btnList_ = nil
end

function slot0.RefreshUI(slot0, slot1)
	SetActive(slot0.gameObject_, ActivityStoryChapterCfg[slot1].activity_id == slot0.activityID_)
end

return slot0
