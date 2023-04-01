slot0 = class("ComboSkillSelectChessItem", ComboSkillSelectItem)

function slot0.ClickBtn(slot0)
	BattleFieldAction.SetComboInfo(slot0.stageType_, slot0.activityID_, slot0.comboSkillID_, slot0.cont_id_, slot0.teamID_)
	manager.notify:Invoke(COMBO_SKILL_SELECT, slot0.comboSkillID_)
end

function slot0.SetTeamID(slot0, slot1)
	slot0.teamID_ = slot1
end

return slot0
