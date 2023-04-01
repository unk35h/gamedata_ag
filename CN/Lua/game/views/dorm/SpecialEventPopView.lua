slot0 = class("SpecialEventPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HouseUI/SpecialEventPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.cancelbtnBtn_, nil, function ()
		uv0.params_.cancelCallback()
	end)
	slot0:AddBtnListener(slot0.okbtnBtn_, nil, function ()
		uv0.params_.okCallback()
	end)
end

function slot0.OnEnter(slot0)
	slot0.tex_contentText_.text = slot0.params_.content
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
