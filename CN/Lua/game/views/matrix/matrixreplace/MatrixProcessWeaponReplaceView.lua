slot0 = class("MatrixProcessWeaponReplaceView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Matrix/Process/MatrixProcessWeaponReplaceUI"
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

	slot0.item_l = MatrixProcessRewardItem.New(slot0.m_item_l)
	slot0.item_r = MatrixProcessRewardItem.New(slot0.m_item_r)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_okBtn, nil, function ()
		if uv0.params_.callback then
			uv0.params_.callback()
		end

		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.m_cancelBtn, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0.heroId = slot0.params_.heroId

	slot0.item_r:Refresh(slot0:GetHeroData(slot0.heroId):GetWeaponServant())

	slot0.weaponId = slot0.params_.weaponId

	slot0.item_l:Refresh(slot0.weaponId)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.item_l:Dispose()
	slot0.item_r:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.GetHeroData(slot0, slot1)
	return MatrixData:GetHeroData(slot1)
end

return slot0
