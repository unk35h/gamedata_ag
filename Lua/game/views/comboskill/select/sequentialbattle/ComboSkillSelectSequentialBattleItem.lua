slot0 = class("ComboSkillSelectSequentialBattleItem", import("..ComboSkillSelectItem"))

function slot0.ClickBtn(slot0)
	SequentialBattleData:SetComboSkillID(slot0.activityID_, table.keyof(SequentialBattleChapterCfg[slot0.activityID_].stage_id, slot0.stageID_), slot0.comboSkillID_, false)
	manager.notify:Invoke(COMBO_SKILL_SELECT, slot0.comboSkillID_)
end

return slot0
