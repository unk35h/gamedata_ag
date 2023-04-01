slot1 = class("BattleChipManagerView", import("game.views.chip.manager.ChipManagerView"))

function slot1.Init(slot0)
	uv0.super.Init(slot0)

	slot1 = slot0.chipManagerUnlockView_

	slot1:RegistEnableIDFunc(function (slot0)
		uv0:EnableChipIDFunc(slot0)
	end)
end

function slot1.OnEnter(slot0)
	slot0.stageType_ = slot0.params_.stageType
	slot0.activityID_ = slot0.params_.activityID
	slot0.cont_id_ = slot0.params_.cont_id
	slot0.team_id_ = slot0.params_.team_id
	slot1 = slot0.chipManagerUnlockView_

	slot1:SetTeamInfo(slot0.stageType_, slot0.activityID_, slot0.cont_id_, slot0.team_id_)
	uv0.super.OnEnter(slot0)

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		uv0:Back()
	end)
end

function slot1.RefreshChipManagerItem(slot0, slot1, slot2)
	slot3 = slot0.chipManagerList_[slot1]

	slot2:SetTeamInfo(slot0.stageType_, slot0.activityID_, slot0.cont_id_, slot0.team_id_)
	slot2:SetChipManagerID(slot3)
	slot2:RefreshUI(slot3 == slot0.defaultSelectID_)
end

function slot1.GetManagerUnlockView(slot0)
	return BattleManagerUnlockView
end

function slot1.GetChipManagerList(slot0)
	return ChipTools.SortChipManager(BattleTeamData:GetMimirInfo(slot0.stageType_, slot0.activityID_, slot0.cont_id_, slot0.team_id_))
end

function slot1.GetChipManagerItem(slot0)
	return BattleChipManagerItem
end

function slot1.EnableChipIDFunc(slot0, slot1)
	BattleFieldAction.SetMimirIDInfo(slot0.stageType_, slot0.activityID_, slot1, slot0.cont_id_, slot0.team_id_)
end

return slot1
