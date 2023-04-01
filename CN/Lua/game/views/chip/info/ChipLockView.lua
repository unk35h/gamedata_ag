slot0 = class("ChipLockView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.SetChipID(slot0, slot1, slot2)
	slot0.chipID_ = slot1
	slot3 = ChipCfg[slot1]
	slot4, slot5, slot6 = IsConditionAchieved(slot3.new_condition)
	slot0.requireText_.text = ConditionCfg[slot3.new_condition].desc
	slot0.requireNumText_.text = GetConditionProgressText(slot3.new_condition, slot5, slot6)
	slot0.isUnlock_ = slot4

	SetActive(slot0.selectGo_, slot4)
	SetActive(slot0.goSatisfy_, not slot4)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
