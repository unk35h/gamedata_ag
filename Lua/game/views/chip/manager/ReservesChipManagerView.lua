slot0 = class("ReservesChipManagerView", ChipManagerView)

function slot0.OnEnter(slot0)
	slot0.index_ = slot0.params_.index
	slot1 = slot0.chipManagerUnlockView_

	slot1:SetReservesIndex(slot0.index_)
	uv0.super.OnEnter(slot0)

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		uv0:Back(1, {
			isInit = false
		})
	end)
end

function slot0.RefreshChipManagerItem(slot0, slot1, slot2)
	slot2:SetIndex(slot0.index_)
	uv0.super.RefreshChipManagerItem(slot0, slot1, slot2)
end

function slot0.GetManagerUnlockView(slot0)
	return ReservesManagerUnlockView
end

function slot0.GetChipManagerList(slot0)
	return ChipTools.SortChipManager(BattleTeamData:GetReservesTempTeamList()[slot0.index_].chipInfo.id)
end

function slot0.GetChipManagerItem(slot0)
	return ReservesChipManagerItem
end

return slot0
