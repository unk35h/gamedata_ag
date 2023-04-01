slot0 = class("EquipDetailView", EquipBaseView)

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/Equip/Culture/EquipDetailUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.GetEquipInfoViewItem(slot0)
	return EquipInfoView
end

function slot0.Init(slot0)
	slot0:InitUI()
	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.getButton_, nil, function ()
		ShowPopItemSource(uv0.equip.prefab_id, uv0.equip)
	end)
end

function slot0.OnEnter(slot0)
	slot0.equipId = slot0.params_.equipId
	slot0.equip = EquipData:GetEquipData(slot0.equipId)

	slot0:RefreshEquipInfo(slot0.equip)

	if ItemCfg[slot0.equip.prefab_id] and slot1.source and #slot1.source > 0 then
		SetActive(slot0.getButtonGo_, true)
	else
		SetActive(slot0.getButtonGo_, false)
	end
end

function slot0.OnEquipChange(slot0, slot1)
	slot0.equipId = slot1
	slot0.params_.equipId = slot1
	slot0.equip = EquipData:GetEquipData(slot0.equipId)

	slot0:RefreshEquipInfo(slot0.equip)

	if ItemCfg[slot0.equip.prefab_id] and slot2.source and #slot2.source > 0 then
		SetActive(slot0.getButtonGo_, true)
	else
		SetActive(slot0.getButtonGo_, false)
	end
end

function slot0.OnEquipLock(slot0, slot1)
	if slot0.params_.extra and slot0.params_.extra.skipLockTips == true then
		slot0:RefreshEquipInfo(slot0.equip)

		slot0.params_.extra.skipLockTips = false

		return
	end

	if slot1 then
		ShowTips("ERROR_EQUIP_LOCKED_SUCCESS")
	else
		ShowTips("ERROR_EQUIP_UNLOCKED_SUCCESS")
	end
end

function slot0.OnExit(slot0)
	slot0:HideMaskMessage()

	if slot0.params_.detail then
		manager.windowBar:HideBar()
	end
end

return slot0
