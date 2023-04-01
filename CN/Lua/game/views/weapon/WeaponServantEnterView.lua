slot0 = class("WeaponServantEnterView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Weapon/WeaponServantEnterUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.listBtn_, nil, function ()
		JumpTools.OpenPageByJump("/weaponServantList")
	end)
	slot0:AddBtnListener(slot0.mergeBtn_, nil, function ()
		JumpTools.OpenPageByJump("/weaponServantSleepySelect")
		ServantAction.TouchRedPoint()
	end)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function slot0.OnEnter(slot0)
	slot0:UpdateBar()
	manager.redPoint:bindUIandKey(slot0.mergeBtn_.gameObject.transform, RedPointConst.WEAPON_SERVANT_MERGE, {
		x = 312,
		y = 385
	})
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.mergeBtn_.gameObject.transform, RedPointConst.WEAPON_SERVANT_MERGE)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
