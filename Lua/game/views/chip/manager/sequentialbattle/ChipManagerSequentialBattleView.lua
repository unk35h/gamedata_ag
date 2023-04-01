slot0 = class("ChipManagerSequentialBattleView", import("..ChipManagerView"))

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.stageID_ = slot0.params_.stageID
	slot0.stageIndex_ = table.keyof(SequentialBattleChapterCfg[slot0.activityID_].stage_id, slot0.stageID_)

	slot0.chipManagerUnlockView_:SetData(slot0.activityID_, slot0.stageID_)
	uv0.super.OnEnter(slot0)
end

function slot0.GetManagerUnlockView(slot0)
	return ChipManagerUnlockSequentialBattleView
end

function slot0.GetChipManagerItem(slot0)
	return ChipManagerSequentialBattleItem
end

function slot0.GetChipManagerList(slot0)
	return ChipTools.SortChipManager(SequentialBattleData:GetHeroTeamData(slot0.activityID_)[slot0.stageIndex_].chipID or 0)
end

function slot0.RefreshChipManagerItem(slot0, slot1, slot2)
	slot2:SetData(slot0.activityID_, slot0.stageID_)
	uv0.super.RefreshChipManagerItem(slot0, slot1, slot2)
end

return slot0
