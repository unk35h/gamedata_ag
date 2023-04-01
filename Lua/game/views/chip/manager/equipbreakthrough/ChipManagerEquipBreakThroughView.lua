slot0 = class("ChipManagerEquipBreakThroughView", import("..ChipManagerView"))

function slot0.GetChipManagerList(slot0)
	return {
		EquipBreakThroughMaterialData:GetChipManagerID()
	}
end

function slot0.GetUnlockChipManagerList(slot0)
	return {
		EquipBreakThroughMaterialData:GetChipManagerID()
	}
end

function slot0.GetManagerUnlockView(slot0)
	return ChipManagerUnlockEquipBreakThroughView
end

function slot0.GetChipManagerItem(slot0)
	return ChipManagerEquipBreakThroughItem
end

return slot0
