slot0 = class("ChipManagerUnlockSequentialBattleView", import("..ChipManagerUnlockView"))

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot1
	slot0.stageID_ = slot2
	slot0.stageIndex_ = table.keyof(SequentialBattleChapterCfg[slot1].stage_id, slot2)
end

function slot0.OnClickUseBtn(slot0)
	SequentialBattleData:SetChipID(slot0.activityID_, slot0.stageIndex_, slot0.chipManagerID_)
	manager.notify:Invoke(ENABLED_CHIP_MANAGER)
end

function slot0.OnClickUnloadBtn(slot0)
	SequentialBattleData:SetChipID(slot0.activityID_, slot0.stageIndex_, 0)
	manager.notify:Invoke(ENABLED_CHIP_MANAGER)
end

function slot0.GetEnabledManagerID(slot0)
	return SequentialBattleData:GetHeroTeamData(slot0.activityID_)[slot0.stageIndex_].chipID or 0
end

return slot0
