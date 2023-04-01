slot0 = class("EquipPrefabDetailView", EquipDetailView)

function slot0.UIBackCount(slot0)
	return 1
end

function slot0.UIName(slot0)
	return "UI/Equip/Culture/EquipPrebabDetailUI"
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:BindCfgUI(slot0.equipDetail_)
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0.equip = slot0.params_.equip

	slot0:RefreshEquipInfo(slot0.equip)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})

	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/Equip/Portrait/" .. ItemCfg[slot0.equip.prefab_id].icon)
	slot1 = ItemCfg[slot0.equip.prefab_id]

	if slot0.params_.source and slot1 and slot1.source and #slot1.source > 0 then
		SetActive(slot0.getButtonGo_, true)
	else
		SetActive(slot0.getButtonGo_, false)
	end
end

function slot0.OnExit(slot0)
	slot0:HideMaskMessage()
	manager.windowBar:HideBar()
end

return slot0
