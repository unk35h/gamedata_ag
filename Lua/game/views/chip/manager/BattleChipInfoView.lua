slot1 = class("BattleChipInfoView", import("game.views.chip.info.ChipInfoView"))

function slot1.OnEnter(slot0)
	slot0.stageType_ = slot0.params_.stageType
	slot0.activityID_ = slot0.params_.activityID
	slot0.cont_id_ = slot0.params_.cont_id
	slot0.team_id_ = slot0.params_.team_id

	slot0.super.OnEnter(slot0)
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		BattleTeamData:InsertMimirChipInfo(uv0.stageType_, uv0.activityID_, uv0.defaultSelectID_, uv0.cont_id_, uv0.team_id_)
	end)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		ChipAction.UnlockChip(uv0.defaultSelectID_)
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		BattleTeamData:SetMimirChipInfo(uv0.stageType_, uv0.activityID_, {}, uv0.cont_id_, uv0.team_id_)
		manager.notify:Invoke(ENABLED_CHIP)
	end)
	slot0:AddBtnListener(slot0.unloadBtn_, nil, function ()
		BattleTeamData:RemoveMimirChipInfo(uv0.stageType_, uv0.activityID_, uv0.defaultSelectID_, uv0.cont_id_, uv0.team_id_)
	end)
end

function slot1.OnClickItem(slot0, slot1)
	slot0:Go("/battleChipInfo", {
		chipManagerID = slot0.params_.chipManagerID,
		selectChipID = slot1,
		selectChipIndex = slot0.params_.selectChipIndex,
		stageType = slot0.stageType_,
		activityID = slot0.activityID_,
		cont_id = slot0.cont_id_,
		team_id = slot0.team_id_
	})
end

function slot1.GetChipItem(slot0)
	return BattleChipItem
end

function slot1.GetChipData(slot0)
	slot1, slot2 = BattleTeamData:GetMimirInfo(slot0.stageType_, slot0.activityID_, slot0.cont_id_, slot0.team_id_)

	return slot2
end

function slot1.RefreshChipItem(slot0, slot1, slot2)
	slot2:SetChipID(slot0.sortChipIDList_[slot1])
	slot2:RefreshUI(slot0.defaultSelectID_, slot0:GetChipData())
end

function slot1.SortChip(slot0)
	return ChipTools.SortChipList(slot0:GetChipData(), slot0.chipTypeCntList_[slot0.filterID_])
end

return slot1
