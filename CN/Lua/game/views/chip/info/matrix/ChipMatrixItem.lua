slot0 = class("ChipMatrixItem", import("..ChipItem"))

function slot0.GetUnlockChipIDList(slot0)
	return MatrixData:GetChipList()
end

function slot0.GetManagerData(slot0, slot1)
	return MatrixData:GetChipList()
end

function slot0.BindRedPoint(slot0)
end

function slot0.UnbindRedPoint(slot0)
end

return slot0
