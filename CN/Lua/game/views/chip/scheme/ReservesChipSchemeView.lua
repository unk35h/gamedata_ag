slot0 = class("ReservesChipSchemeView", ChipSchemeView)

function slot0.RefreshSchemeItem(slot0, slot1, slot2)
	slot2:SetIndex(slot0.params_.index)
	slot2:RefreshUI(slot0.chipManagerID_, slot1, slot0.sortSchemeList_[slot1])
end

function slot0.GetChipSchemeItem(slot0)
	return ReservesChipSchemeItem
end

function slot0.GetSchemeList(slot0)
	slot3 = {
		{
			id = 0,
			name = GetTips(slot7),
			chipList = BattleTeamData:GetReservesTempTeamList()[slot0.params_.index].chipInfo.list
		}
	}
	slot7 = "CURRENT_SCHEME"

	for slot7, slot8 in pairs(ChipData:GetSchemeList()) do
		slot9 = #slot1 == #slot8.chipList

		for slot13, slot14 in ipairs(slot8.chipList) do
			if not table.keyof(slot1, slot14) then
				slot9 = false

				break
			end
		end

		if slot9 then
			slot3[1] = clone(slot8)
		else
			table.insert(slot3, clone(slot8))
		end
	end

	for slot7 = #slot3 + 1, GameSetting.ai_chip_proposal_num_max.value[1] do
		table.insert(slot3, {
			id = -1
		})
	end

	return slot3
end

return slot0
