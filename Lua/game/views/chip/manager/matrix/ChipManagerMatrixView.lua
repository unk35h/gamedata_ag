slot0 = class("ChipManagerMatrixView", import("..ChipManagerView"))

function slot0.GetChipManagerList(slot0)
	return {
		MatrixData:GetChipManagerID()
	}
end

function slot0.GetUnlockChipManagerList(slot0)
	return {
		MatrixData:GetChipManagerID()
	}
end

function slot0.GetManagerUnlockView(slot0)
	return ChipManagerUnlockMatrixView
end

function slot0.GetChipManagerItem(slot0)
	return ChipManagerMatrixItem
end

return slot0
