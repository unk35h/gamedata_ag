slot0 = class("MythicChipManagerView", ChipManagerView)

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot1 = slot0.chipManagerUnlockView_

	slot1:RegistEnableIDFunc(function (slot0)
		uv0:EnableChipIDFunc(slot0)
	end)
end

function slot0.OnEnter(slot0)
	slot0.stageType_ = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL
	slot0.teamID_ = slot0.params_.chessTeamID
	slot0.activityID_ = slot0.params_.activityID

	slot0.chipManagerUnlockView_:SetTeamInfo(slot0.stageType_, slot0.activityID_, nil, slot0.teamID_)
	uv0.super.OnEnter(slot0)
end

function slot0.GetManagerUnlockView(slot0)
	return MythicChipManagerUnlockView
end

function slot0.RefreshChipManagerItem(slot0, slot1, slot2)
	slot2:SetTeamID(slot0.teamID_)
	uv0.super.RefreshChipManagerItem(slot0, slot1, slot2)
end

function slot0.GetChipManagerItem(slot0)
	return MythicChipManagerItem
end

function slot0.GetChipManagerList(slot0)
	return ChipTools.SortChipManager(BattleTeamData:GetMimirInfo(slot0.stageType_, slot0.activityID_, nil, slot0.teamID_))
end

function slot0.EnableChipIDFunc(slot0, slot1)
	BattleTeamData:SetMimirIDInfo(slot0.stageType_, slot0.activityID_, slot1, nil, slot0.teamID_)
end

return slot0
