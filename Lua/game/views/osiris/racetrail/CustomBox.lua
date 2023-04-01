slot0 = class("CustomBox", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.ListGo_, CustomItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.customList_[slot1], slot0.customList_[slot1] == slot0.selectID_)
	slot2:RegisterClickListener(slot0.clickFunc_)
end

function slot0.AddUIListeners(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.customIndex_ = slot1
	slot0.customList_ = slot2
	slot0.selectID_ = slot3

	slot0.scrollHelper_:StartScroll(#slot0.customList_)

	slot0.customText_.text = AffixTypeCfg[slot0.customIndex_].name
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
