slot0 = class("SectionChipSequentialBattleView", import("..SectionSelectHeroChip"))

function slot0.SetParams(slot0, slot1, slot2)
	slot0.activityID_ = slot1
	slot0.stageID_ = slot2
	slot0.stageIndex_ = table.keyof(SequentialBattleChapterCfg[slot1].stage_id, slot2)
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:Go("/chipManagerSequentialBattle", {
			activityID = uv0.activityID_,
			stageID = uv0.stageID_
		})
	end)
end

function slot0.GetChipManagerID(slot0)
	return SequentialBattleData:GetHeroTeamData(slot0.activityID_)[slot0.stageIndex_].chipID or 0
end

return slot0
