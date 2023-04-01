slot0 = class("ChessMessageBtn", ReduxView)

function slot0.UIName(slot0)
	return "UI/WarChess/WarChessTextPopUI"
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

	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "conName")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
		uv0.cancelCallBack()
	end)
	slot0:AddBtnListener(slot0.checkBtn_, nil, function ()
		uv0:Back()
		uv0.checkCallBack()
	end)
end

function slot0.OnEnter(slot0)
	slot0.logId_ = slot0.params_.logId
	slot0.checkCallBack = slot0.params_.checkCallBack
	slot0.cancelCallBack = slot0.params_.cancelCallBack
	slot0.style_ = slot0.params_.style

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.controller_:SetSelectedState(slot0.style_)

	if slot0.style_ == "cantReach" then
		slot0.checkBtn_.interactable = false
		slot0.checkText_.text = GetTips("CAN_NOT_TEACH")
	elseif slot0.style_ == "no" then
		slot0.checkBtn_.interactable = true
		slot0.checkText_.text = GetTips("CONFIRM")
	else
		slot0.checkBtn_.interactable = true
		slot0.checkText_.text = GetTips("GO_UP_TO")
	end

	if not WarchessContentCfg[slot0.logId_] then
		error("不存在的Id :", slot0.logId_)
	end

	slot0.textinfoText_.text = WarchessContentCfg[slot0.logId_].content

	if WarchessContentCfg[slot0.logId_].icon ~= "" then
		slot0.itemiconImg_.sprite = getSpriteViaConfig("WarchessItem", slot1)
	end

	slot0.textnameText_.text = WarchessContentCfg[slot0.logId_].name
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
