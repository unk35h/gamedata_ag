return {
	ChangeComboSkillID = function (slot0, slot1, slot2, slot3, slot4)
		slot5 = GetHeroTeamActivityID(slot0, slot1)

		ComboSkillData:SetComboSkillID(slot5, slot2, slot3)
		manager.net:Push(12022, {
			cooperate_unique_skill = {
				type = slot5,
				difficulty = slot2,
				cooperate_unique_skill_id = slot3
			}
		})
		manager.notify:Invoke(COMBO_SKILL_SELECT, slot3)
	end
}
