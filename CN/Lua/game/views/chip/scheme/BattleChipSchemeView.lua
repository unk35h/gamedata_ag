slot1 = class("BattleChipSchemeView", import("game.views.chip.scheme.ChipSchemeView"))

function slot1.OnEnter(slot0)
	slot0.stageType_ = slot0.params_.stageType
	slot0.activityID_ = slot0.params_.activityID
	slot0.cont_id_ = slot0.params_.cont_id
	slot0.team_id_ = slot0.params_.team_id

	uv0.super.OnEnter(slot0)
end

function slot1.RefreshSchemeItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.chipManagerID_, slot1, slot0.sortSchemeList_[slot1])
	slot2:SetTeamInfo(slot0.stageType_, slot0.activityID_, slot0.cont_id_, slot0.team_id_)
end

function slot1.GetChipSchemeItem(slot0)
	return BattleChipSchemeItem
end

function slot1.GetSchemeList(slot0)
	slot1, slot2 = BattleTeamData:GetMimirInfo(slot0.stageType_, slot0.activityID_, slot0.cont_id_, slot0.team_id_)
	slot4 = {
		{
			id = 0,
			name = GetTips(slot8),
			chipList = slot2
		}
	}
	slot8 = "CURRENT_SCHEME"

	for slot8, slot9 in pairs(ChipData:GetSchemeList()) do
		slot10 = #slot2 == #slot9.chipList

		for slot14, slot15 in ipairs(slot9.chipList) do
			if not table.keyof(slot2, slot15) then
				slot10 = false

				break
			end
		end

		if slot10 then
			slot4[1] = clone(slot9)
		else
			table.insert(slot4, clone(slot9))
		end
	end

	for slot8 = #slot4 + 1, GameSetting.ai_chip_proposal_num_max.value[1] do
		table.insert(slot4, {
			id = -1
		})
	end

	return slot4
end

return slot1
