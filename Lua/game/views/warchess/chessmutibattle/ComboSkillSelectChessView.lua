slot0 = class("ComboSkillSelectChessView", ComboSkillSelectView)

function slot0.GetComboSkillItemView(slot0)
	return ComboSkillSelectChessItem
end

function slot0.OnEnter(slot0)
	slot0.teamID_ = slot0.params_.teamID

	uv0.super.OnEnter(slot0)
end

function slot0.RefreshItemSelect(slot0, slot1, slot2)
	slot3 = slot0.comboSkillIDList_[slot1]

	slot2:RefreshUI(slot0.stageType_, slot0.stageID_, slot0.activityID_, slot3, slot0.comboSkillID_ == slot3, slot0.heroList_, nil, slot0.teamID_)
	slot2:SetTeamID(slot0.teamID_)
end

return slot0
