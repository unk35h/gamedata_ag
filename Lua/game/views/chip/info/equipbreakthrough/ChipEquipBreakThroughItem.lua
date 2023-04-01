slot0 = class("ChipEquipBreakThroughItem", import("..ChipItem"))

function slot0.GetUnlockChipIDList(slot0)
	return EquipBreakThroughMaterialData:GetChipList()
end

function slot0.GetManagerData(slot0, slot1)
	return EquipBreakThroughMaterialData:GetChipList()
end

function slot0.BindRedPoint(slot0)
end

function slot0.UnbindRedPoint(slot0)
end

return slot0
