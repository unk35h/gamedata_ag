slot0 = class("SectionComboSkillEquipBreakThroughView", import("..SectionComboSkillView"))

function slot0.ClickComboSkillBtn(slot0)
	JumpTools.OpenPageByJump("comboSkillSelectEquipBreakThrough", {
		stageType = slot0.stageType_,
		stageID = slot0.stageID_,
		bossIndex = slot0.bossIndex_,
		heroList = slot0.heroList_,
		comboSkillID = slot0.comboSkillID_
	})
end

function slot0.SetHeroList(slot0, slot1, slot2, slot3, slot4, slot5)
	uv0.super.SetHeroList(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:SetComboSkillID(slot0.comboSkillID_)
end

function slot0.GetComboSkillID(slot0)
	return EquipBreakThroughMaterialData:GetComboSkillID() ~= -1 and slot1 or uv0.super.GetComboSkillID(slot0)
end

return slot0
