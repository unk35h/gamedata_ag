slot0 = class("ChipManagerSequentialBattleItem", import("..ChipManagerItem"))

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot1
	slot0.stageID_ = slot2
	slot0.stageIndex_ = table.keyof(SequentialBattleChapterCfg[slot1].stage_id, slot2)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:Go("/chipManagerSequentialBattle", {
			chipManagerID = uv0.chipManagerID_,
			activityID = uv0.activityID_,
			stageID = uv0.stageID_
		})
	end)
end

function slot0.GetEnabledChipManagerID(slot0)
	return SequentialBattleData:GetHeroTeamData(slot0.activityID_)[slot0.stageIndex_].chipID or 0
end

return slot0
