slot1 = class("BattleChipManagerItem", import("game.views.chip.manager.ChipManagerItem"))

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:Go("/battleChipManager", {
			chipManagerID = uv0.chipManagerID_,
			stageType = uv0.stageType_,
			activityID = uv0.activityID_,
			cont_id = uv0.cont_id_,
			team_id = uv0.team_id_
		})
	end)
end

function slot1.GetEnabledChipManagerID(slot0)
	return BattleTeamData:GetMimirInfo(slot0.stageType_, slot0.activityID_, slot0.cont_id_, slot0.team_id_)
end

function slot1.SetTeamInfo(slot0, slot1, slot2, slot3, slot4)
	slot0.stageType_ = slot1
	slot0.activityID_ = slot2
	slot0.cont_id_ = slot3
	slot0.team_id_ = slot4
end

return slot1
