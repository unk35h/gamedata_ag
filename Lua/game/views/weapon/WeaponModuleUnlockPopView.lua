slot0 = class("weaponModuleUnlockPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Hero/HeroModuleUI/HeroModuleUnlockPopUI"
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
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		gameContext:Go("/weaponModuleView", {
			heroID = uv0.params_.heroID
		})
	end)
end

function slot0.OnEnter(slot0)
	slot1 = WeaponModuleCfg[slot0.params_.heroID]
	slot0.nameText_.text = slot1.name

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.titleTrans_)

	slot0.stroyText_.text = slot1.story

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)

	slot0.moduleImage_.sprite = getSpriteWithoutAtlas("Textures/WeaponModule/" .. slot0.params_.heroID)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
