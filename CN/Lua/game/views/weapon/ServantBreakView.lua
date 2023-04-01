slot0 = class("ServantBreakView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Weapon/ServantBreakSuccess"
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
	slot0:AddBtnListener("", nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshBreakSuccess(slot0.params_.stage)
end

function slot0.OnExit(slot0)
end

function slot0.RefreshBreakSuccess(slot0, slot1)
	slot0.beforeText_.text = slot1
	slot0.afterText_.text = slot1 + 1
end

function slot0.Cacheable(slot0)
	return false
end

return slot0
