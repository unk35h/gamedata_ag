slot0 = class("ComboSkillSelectEquipBreakThroughItem", import("..ComboSkillSelectItem"))

function slot0.ClickBtn(slot0)
	ComboSkillAction.ChangeComboSkillID(slot0.stageType_, slot0.activityID_, 1, slot0.comboSkillID_)
	EquipBreakThroughMaterialAction.SaveComboSkillID(slot0.comboSkillID_, function ()
	end)
end

return slot0
