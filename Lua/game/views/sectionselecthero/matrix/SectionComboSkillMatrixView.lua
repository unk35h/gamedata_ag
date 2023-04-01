slot0 = class("SectionComboSkillMatrixView", import("..SectionComboSkillView"))

function slot0.ClickComboSkillBtn(slot0)
	JumpTools.OpenPageByJump("comboSkillSelectMatrix", {
		stageType = slot0.stageType_,
		stageID = slot0.stageID_,
		heroList = slot0.heroList_,
		comboSkillID = slot0.comboSkillID_
	})
end

function slot0.SetHeroList(slot0, slot1, slot2, slot3, slot4)
	SetActive(slot0.gameObject_, true)

	slot0.stageType_ = slot1
	slot0.stageID_ = slot2
	slot0.activityID_ = slot3
	slot0.heroList_ = slot4
	slot5 = slot0:GetComboSkillID()

	if ComboSkillTools.CheckError(slot5, slot4, false) ~= slot5 or slot0:GetNeedRefresh() == true then
		slot0:SetComboSkillID(ComboSkillTools.GetRecommendSkillID(slot4, false))
		slot0:SetNeedRefresh(false)
	end

	slot0.comboSkillID_ = slot6

	slot0:RefreshUI()
end

function slot0.GetComboSkillID(slot0)
	return ComboSkillData:GetComboSkillID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX, nil, 1)
end

function slot0.SetComboSkillID(slot0, slot1)
	ComboSkillAction.ChangeComboSkillID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX, nil, 1, slot1)
end

function slot0.GetNeedRefresh(slot0)
	return ComboSkillData:GetMatrixNeedRefresh()
end

function slot0.SetNeedRefresh(slot0, slot1)
	ComboSkillData:SetMatrixNeedRefresh(slot1)
end

return slot0
