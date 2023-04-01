slot0 = class("ChipInfoMatrixView", ChipInfoView)

function slot0.Init(slot0)
	uv0.super.Init(slot0)
	SetActive(slot0.goResetBtn_, false)
	SetActive(slot0.goFilterPanel_, false)
	SetActive(slot0.transformBtnPanel_.gameObject, false)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		ShowTips("CANNOT_CHANGE")
	end)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		ShowTips("CANNOT_CHANGE")
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		ShowTips("CANNOT_CHANGE")
	end)
	slot0:AddBtnListener(slot0.unloadBtn_, nil, function ()
		ShowTips("CANNOT_CHANGE")
	end)
end

function slot0.OnClickItem(slot0, slot1)
	slot0:Go("/chipMatrixInfo", {
		chipManagerID = slot0.params_.chipManagerID,
		selectChipID = slot1,
		selectChipIndex = slot0.params_.selectChipIndex
	})
end

function slot0.GetChipItem(slot0)
	return ChipMatrixItem
end

function slot0.GetChipTypeCntList(slot0)
	return ChipTools.GetChipTypeCntList(MatrixData:GetChipList())
end

function slot0.GetChipData(slot0)
	return MatrixData:GetChipList()
end

function slot0.SortChip(slot0)
	return ChipTools.SortChip(MatrixData:GetChipList(), slot0.params_.chipManagerID)
end

function slot0.GetUnlockChipIDList(slot0)
	return MatrixData:GetChipList()
end

return slot0
