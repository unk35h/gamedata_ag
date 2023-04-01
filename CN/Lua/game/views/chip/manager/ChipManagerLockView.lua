slot0 = class("ChipManagerLockView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		if uv0.isUnlock_ then
			ChipAction.UnlockChipManager(uv0.chipMnagerID_)
		else
			ShowTips("CHIP_MANAGER_UNLOCK_FAILED")
		end
	end)
end

function slot0.SetChipManagerID(slot0, slot1)
	slot0.chipMnagerID_ = slot1
	slot2 = ChipCfg[slot1]
	slot3, slot4, slot5 = IsConditionAchieved(slot2.new_condition)
	slot0.requireText_.text = ConditionCfg[slot2.new_condition].desc
	slot0.requireNumText_.text = GetConditionProgressText(slot2.new_condition, slot4, slot5)
	slot0.isUnlock_ = slot3

	SetActive(slot0.selectGo_, slot3)
	SetActive(slot0.goSatisfy_, not slot3)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
