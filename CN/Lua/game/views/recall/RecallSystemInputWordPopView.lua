slot0 = class("RecallSystemInputWordPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/RecallUI/RC1stRecallCodeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:GetOrAddComponent(slot0.codeInput_.gameObject, typeof(InputFieldHelper))
	dealEnter(slot0.codeInput_.gameObject)
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.sureBtn_, nil, function ()
		ActivityRecallAction.RequireWriteRecallCode(ActivityRecallData:GetDataByPara("recalledActivityID"), uv0.codeInput_.text)

		uv0.codeInput_.text = ""
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnReceivedCodeReward(slot0)
	slot0:Back()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
	manager.windowBar:SetAsLastSibling()
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.codeInput_.text = ""
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.codeInput_.onValueChanged:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
