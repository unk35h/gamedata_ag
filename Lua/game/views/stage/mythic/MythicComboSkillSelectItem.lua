slot0 = class("MythicComboSkillSelectItem", ComboSkillSelectItem)

function slot0.SetTeamID(slot0, slot1)
	slot0.teamID_ = slot1
end

function slot0.ClickBtn(slot0)
	BattleTeamData:SetComboInfo(slot0.stageType_, slot0.activityID_, slot0.comboSkillID_, slot0.cont_id_, slot0.team_id_)
	manager.notify:Invoke(COMBO_SKILL_SELECT, slot0.comboSkillID_)
end

function slot0.ShowSelect(slot0, slot1)
	if MythicData:GetIsBattleIng() then
		slot0.selectBtnController_:SetSelectedState("unclick")
	elseif slot1 then
		slot0.selectBtnController_:SetSelectedState("current")
	elseif slot0.canUse_ then
		slot0.selectBtnController_:SetSelectedState("change_1")
	else
		slot0.selectBtnController_:SetSelectedState("unclick")
	end
end

return slot0
