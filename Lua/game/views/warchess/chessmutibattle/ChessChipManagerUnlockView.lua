slot0 = class("ChessChipManagerUnlockView", ChipManagerUnlockView)

function slot0.OnClickUseBtn(slot0)
	if slot0.enableIDFunc_ then
		slot0.enableIDFunc_(slot0.chipManagerID_)
	end

	manager.notify:Invoke(ENABLED_CHIP_MANAGER)
end

function slot0.OnClickUnloadBtn(slot0)
	if slot0.enableIDFunc_ then
		slot0.enableIDFunc_(0)
	end

	manager.notify:Invoke(ENABLED_CHIP_MANAGER)
end

function slot0.GetEnabledManagerID(slot0)
	return BattleTeamData:GetMimirInfo(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS, slot0.activityID_, slot0.cont_id_, slot0.teamID_)
end

function slot0.RegistEnableIDFunc(slot0, slot1)
	slot0.enableIDFunc_ = slot1
end

function slot0.OnSelectChipBtn(slot0, slot1)
	slot0:Go("/battleChipInfo", {
		chipManagerID = slot0.chipManagerID_,
		selectChipIndex = slot1,
		stageType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS,
		team_id = slot0.teamID_
	})
end

function slot0.GetChipData(slot0)
	slot1, slot2 = BattleTeamData:GetMimirInfo(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS, slot0.activityID_, slot0.cont_id_, slot0.teamID_)

	return slot2
end

function slot0.OnSchemeBtn(slot0)
	slot0:Go("/battleChipScheme", {
		chipManagerID = slot0.chipManagerID_,
		stageType = slot0.stageType_,
		activityID = slot0.activityID_,
		cont_id = slot0.cont_id_,
		team_id = slot0.teamID_
	})
end

function slot0.SetTeamInfo(slot0, slot1, slot2, slot3, slot4)
	slot0.stageType_ = slot1
	slot0.activityID_ = slot2
	slot0.cont_id_ = slot3
	slot0.teamID_ = slot4
end

return slot0
