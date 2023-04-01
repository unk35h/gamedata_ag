slot0 = class("ReservesChipItem", ChipItem)

function slot0.SetChipID(slot0, slot1, slot2)
	slot0.chipID_ = slot1
	slot0.index_ = slot2
end

function slot0.GetManagerData(slot0)
	return BattleTeamData:GetReservesTempTeamList()[slot0.index_].chipInfo.list
end

return slot0
