slot0 = class("MoonBoIntroduceView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/VolumeBocakeRuleUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
