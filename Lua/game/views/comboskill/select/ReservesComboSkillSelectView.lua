slot0 = class("ReservesComboSkillSelectView", ComboSkillSelectView)

function slot0.RefreshItemSelect(slot0, slot1, slot2)
	slot3 = slot0.comboSkillIDList_[slot1]

	slot2:RefreshUI(slot3, slot0.comboSkillID_ == slot3, slot0.heroList_, slot0.index_)
end

function slot0.OnEnter(slot0)
	slot0.index_ = slot0.params_.index
	slot0.heroList_ = slot0.params_.heroList
	slot0.comboSkillID_ = slot0.params_.comboSkillID
	slot0.comboSkillIDList_ = slot0:GetComboSkillList()

	slot0.comboSkillUIList_:StartScroll(#slot0.comboSkillIDList_, 1)
end

function slot0.GetComboSkillItemView(slot0)
	return ReservesComboSkillSelectItem
end

return slot0
