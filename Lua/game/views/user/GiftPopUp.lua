slot0 = class("GiftPopUpView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/PopupUI"
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
	slot0:GetOrAddComponent(slot0.input_.gameObject, typeof(InputFieldHelper))
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnCancel_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.btnOK_, nil, function ()
		SettingAction.ExchangeCode(string.trim(uv0.input_.text), tostring(_G.TMP_CHANNELID))
	end)
end

function slot0.OnExchangeCode(slot0, slot1, slot2)
	if slot1 then
		ShowTips("SUCCESS_EXCHANGE_CODE")

		slot0.input_.text = ""
	else
		ShowTips(slot2 or "UNDEFINED_ERROR")
	end
end

function slot0.OnExit(slot0)
	slot0.input_.text = ""
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
