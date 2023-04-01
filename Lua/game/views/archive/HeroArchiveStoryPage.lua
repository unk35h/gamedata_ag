slot0 = class("HeroArchiveStoryPage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.itemlistGo_, HeroArchiveStoryItem)
end

function slot0.AddUIListener(slot0)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot1, slot0.archiveID_)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.archiveID_ = slot1
	slot0.itemList_ = HeroRecordCfg[slot0.archiveID_].plot_id

	slot0.scrollHelper_:StartScroll(#slot0.itemList_)
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
