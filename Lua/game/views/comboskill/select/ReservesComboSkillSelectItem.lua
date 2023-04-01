slot0 = class("ReservesComboSkillSelectItem", ComboSkillSelectItem)

function slot0.RefreshUI(slot0, slot1, slot2, slot3, slot4)
	slot0.comboSkillID_ = slot1
	slot0.heroList_ = slot3
	slot0.index_ = slot4

	if not (slot1 == 0) then
		slot0:RefreshInfo()
	end

	slot0.canUse_ = slot0:CanUse()

	SetActive(slot0.goEmpty_, slot5)
	SetActive(slot0.goInfo_, not slot5)
	slot0:ShowSelect(slot2)
end

function slot0.ClickBtn(slot0)
	BattleTeamData:ChangeComboSkillID(slot0.index_, slot0.comboSkillID_)
end

return slot0
