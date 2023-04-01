slot0 = class("ReservesChipSchemeItem", ChipSchemeItem)

function slot0.SetIndex(slot0, slot1)
	slot0.teamIndex_ = slot1
end

function slot0.OnEnabledBtn(slot0)
	BattleTeamData:ReservesTempTeamEnabledSchemeID(slot0.teamIndex_, slot0.schemeData_.chipList)
end

return slot0
