slot0 = class("WeaponStrView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Weapon/WeaponStrSuccess"
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
	slot0:AddBtnListener(slot0.bgmask_, nil, function ()
		uv0:Back()
		uv0.params_.callback()
	end)
end

function slot0.OnEnter(slot0)
	slot1 = slot0.params_

	slot0:RefreshStrSuccess(slot1.oriLv, slot1.afterLv, slot1.breakthrough)
end

function slot0.OnExit(slot0)
end

function slot0.RefreshStrSuccess(slot0, slot1, slot2, slot3)
	slot0.desctextText_.text = slot2
	slot0.originText_.text = string.format("%d", WeaponTools.WeaponAtk(slot1, slot3))
	slot0.afterText_.text = string.format("%d", WeaponTools.WeaponAtk(slot2, slot3))
end

function slot0.Cacheable(slot0)
	return false
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
