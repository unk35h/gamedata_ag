slot0 = class("ChessBattlePopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/WarChess/WarChessBattlePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
		uv0.info_.MaskCallback()
	end)
	slot0:AddBtnListener(slot0.btnOK_, nil, function ()
		uv0:Back()
		uv0.info_.OkCallback()
	end)
	slot0:AddBtnListener(slot0.btnCancel_, nil, function ()
		uv0:Back()
		uv0.info_.CancelCallback()
	end)
end

function slot0.RefreshUI(slot0)
	slot0.contentText_.text = slot0.info_.content
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera(WarchessLevelCfg[WarChessData:GetCurrentWarChessMapData().mapId].scene_id, true)

	slot0.info_ = slot0.params_

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
