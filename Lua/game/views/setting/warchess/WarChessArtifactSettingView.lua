slot0 = class("WarChessArtifactSettingView", MatrixArtifactSettingView)

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.ItemRenderers), slot0.uiListGo_, WarChessArtifactSettingItemView)

	slot0.uiList_:StartScroll(#slot0.artifactList_)
end

return slot0
