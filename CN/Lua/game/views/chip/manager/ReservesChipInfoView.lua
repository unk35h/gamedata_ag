slot0 = class("ReservesChipInfoView", ChipInfoView)

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		BattleTeamData:SetReservesTempTeamChipList(uv0.params_.index, uv0.defaultSelectID_)
	end)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		ChipAction.UnlockChip(uv0.defaultSelectID_)
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		BattleTeamData:ResetReservesTempTeamChipList(uv0.params_.index, 0)
	end)
	slot0:AddBtnListener(slot0.unloadBtn_, nil, function ()
		BattleTeamData:UnloadReservesTempTeamChipList(uv0.params_.index, uv0.defaultSelectID_)
	end)
end

function slot0.OnClickItem(slot0, slot1)
	slot0:Go("/reservesChipInfo", {
		chipManagerID = slot0.params_.chipManagerID,
		selectChipID = slot1,
		selectChipIndex = slot0.params_.selectChipIndex,
		index = slot0.params_.index
	})
end

function slot0.RefreshChipItem(slot0, slot1, slot2)
	slot2:SetChipID(slot0.sortChipIDList_[slot1], slot0.params_.index)
	slot2:RefreshUI(slot0.defaultSelectID_, slot0.params_.chipManagerID)
end

function slot0.GetChipItem(slot0)
	return ReservesChipItem
end

function slot0.GetChipData(slot0)
	return BattleTeamData:GetReservesTempTeamList()[slot0.params_.index].chipInfo.list
end

return slot0
