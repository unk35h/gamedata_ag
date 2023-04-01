slot0 = class("MatrixArtifactSettingView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.artifactList_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.ItemRenderers), slot0.uiListGo_, MatrixArtifactSettingItemView)

	slot0.uiList_:StartScroll(#slot0.artifactList_)
end

function slot0.ItemRenderers(slot0, slot1, slot2)
	slot2:SetData(slot0.artifactList_[slot1].id)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
