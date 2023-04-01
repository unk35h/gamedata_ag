slot0 = class("WeaponServantSleepySelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Weapon/WeaponServantWakeUI"
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
	slot0:AddBtnListener(slot0.btn_olympiasleepBtn_, nil, function ()
		uv0:Go("/weaponServantMerge", {
			race = 1
		})
	end)
	slot0:AddBtnListener(slot0.btn_nirosleepBtn_, nil, function ()
		uv0:Go("/weaponServantMerge", {
			race = 2
		})
	end)
	slot0:AddBtnListener(slot0.btn_sakurasleepBtn_, nil, function ()
		uv0:Go("/weaponServantMerge", {
			race = 3
		})
	end)
	slot0:AddBtnListener(slot0.btn_yggdrasillsleepBtn_, nil, function ()
		uv0:Go("/weaponServantMerge", {
			race = 4
		})
	end)
	slot0:AddBtnListener(slot0.btn_pantheonsleepBtn_, nil, function ()
		uv0:Go("/weaponServantMerge", {
			race = 5
		})
	end)
	slot0:AddBtnListener(slot0.btn_xuhengleepBtn_, nil, function ()
		uv0:Go("/weaponServantMerge", {
			race = 9
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0:ShowDefaultBar()

	for slot4, slot5 in ipairs(RaceEffectCfg.all) do
		slot0["sum" .. slot5 .. "Text_"].text = ServantTools.GetSleepyServantNum(slot5)
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

return slot0
