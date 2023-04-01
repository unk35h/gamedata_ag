slot0 = class("ActivityNewbieRebateIllustrateView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Activity/NewbieRechargeIllustrateUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnEnter(slot0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_7)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_6)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_5)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_4)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_2)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_1)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnBack_, nil, function ()
		uv0:Back()
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
