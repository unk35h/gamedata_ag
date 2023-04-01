slot0 = class("ComboSkillSelectMatrixView", import("..ComboSkillSelectView"))

function slot0.GetComboSkillList(slot0)
	return ComboSkillTools.GetComboSkillList(slot0.heroList_, false)
end

function slot0.GetComboSkillItemView(slot0)
	return ComboSkillSelectMatrixItem
end

return slot0
