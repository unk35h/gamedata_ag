slot0 = class("ChessDebuffPop", ReduxView)

function slot0.UIName(slot0)
	return "UI/WarChess/WarChessDeBuffUI"
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

	slot0.showItem_ = ChessChooseItem.New(slot0.battleflagitemGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
		manager.ChessManager:DoNextEvent()
	end)
end

function slot0.RefreshUI(slot0)
	slot0.showItem_:RefreshUI(1, slot0.params_.data)
end

function slot0.OnEnter(slot0)
	slot0.data_ = slot0.params_.data

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.showItem_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
