slot0 = class("ThreeButtonBoxView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/PopupmationUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transformPanel_, "screenOrientation")
end

function slot0.OnEnter(slot0)
	slot0.textContent_.text = slot0.params_.content

	if getScreenOrientation() then
		slot0.controller_:SetSelectedState("horizontal")
	else
		slot0.controller_:SetSelectedState("vertical")
	end
end

function slot0.OnExit(slot0)
end

function slot0.OnTop(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.OnBehind(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonMask_, nil, function ()
		uv0.params_.cancelFun()
	end)
	slot0:AddBtnListener(slot0.buttonCancel_, nil, function ()
		uv0.params_.cancelFun()
	end)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
		uv0.params_.closeFun()
	end)
	slot0:AddBtnListener(slot0.buttonOk_, nil, function ()
		uv0.params_.okFun()
	end)
end

return slot0
