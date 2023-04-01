slot0 = class("SkuldTravelTipsView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelling"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		gameContext:Go("/skuldTravelView")
	end)
	slot0:AddBtnListener(slot0.bgbtn_, nil, function ()
		gameContext:Go("/skuldTravelView")
	end)
end

function slot0.Dispose(slot0)
	slot0.super.Dispose(slot0)
end

return slot0
