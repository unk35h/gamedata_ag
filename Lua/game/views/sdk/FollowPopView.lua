slot0 = class("FollowPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Main/SubscribeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.okbtnBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
