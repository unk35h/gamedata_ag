slot0 = class("ChessHome", ReduxView)

function slot0.UIName(slot0)
	return "UI/IllustratedHandbook/IlluInformation"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
end

function slot0.AddUIListener(slot0)
end

function slot0.OnEnter(slot0)
	slot0:ShowDefaultBar()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
