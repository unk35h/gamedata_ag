slot0 = class("MythicChipManagerItem", ChipManagerItem)

function slot0.SetTeamID(slot0, slot1)
	slot0.teamID_ = slot1
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:Go("/mythicChipManagerView", {
			chipManagerID = uv0.chipManagerID_,
			chessTeamID = uv0.teamID_
		})
	end)
end

function slot0.GetEnabledChipManagerID(slot0)
	return BattleTeamData:GetMimirInfo(BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL, nil, , slot0.teamID_)
end

return slot0
