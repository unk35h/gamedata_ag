slot1 = class("ReservesChipItem", import("game.views.chip.info.ChipItem"))

function slot1.GetManagerData(slot0, slot1)
	return ChipData:GetCurChipManagerList(slot1)
end

function slot1.RefreshUI(slot0, slot1, slot2)
	slot0.gameObject_.name = slot0.chipID_
	slot0.chipList_ = slot2
	slot3 = ChipCfg[slot0.chipID_]
	slot0.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", slot3.picture_id)
	slot0.name_.text = slot3.suit_name

	SetActive(slot0.lockGo_, table.keyof(slot0:GetUnlockChipIDList(), slot0.chipID_) == nil)
	SetActive(slot0.useGo_, table.keyof(slot0:GetManagerData(), slot0.chipID_) ~= nil)
	SetActive(slot0.selectGo_, slot0.chipID_ == slot1)

	slot6 = false

	for slot10, slot11 in ipairs(slot5) do
		if ChipCfg[slot11].spec_char ~= 0 and slot11 ~= slot0.chipID_ then
			slot6 = slot6 or slot3.spec_char == slot12
		end
	end

	SetActive(slot0.prohibitGo_, slot6)
	slot0:BindRedPoint()
end

function slot1.GetManagerData(slot0)
	return slot0.chipList_
end

return slot1
