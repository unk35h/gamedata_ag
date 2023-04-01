slot0 = class("ComboSkillSelectBossView", import("..ComboSkillSelectView"))

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.bossIndex_ = slot0.params_.bossIndex
end

function slot0.GetComboSkillItemView(slot0)
	return ComboSkillSelectBossItem
end

function slot0.RefreshItemSelect(slot0, slot1, slot2)
	slot3 = slot0.comboSkillIDList_[slot1]

	slot2:RefreshUI(slot0.bossIndex_, slot0.stageType_, slot0.stageID_, slot0.activityID_, slot3, slot0.comboSkillID_ == slot3, slot0.heroList_)
end

return slot0
