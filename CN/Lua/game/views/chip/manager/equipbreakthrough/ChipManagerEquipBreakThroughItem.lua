slot0 = class("ChipManagerEquipBreakThroughItem", import("..ChipManagerItem"))

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
	end)
end

function slot0.GetUnlockChipManagerList(slot0)
	return {}
end

function slot0.GetEnabledChipManagerID(slot0)
	return EquipBreakThroughMaterialData:GetChipManagerID()
end

function slot0.BindRedPoint(slot0)
end

function slot0.UnbindRedPoint(slot0)
end

function slot0.RefreshUI(slot0, slot1)
	uv0.super.RefreshUI(slot0, slot1)
	SetActive(slot0.lockGo_)
end

return slot0
