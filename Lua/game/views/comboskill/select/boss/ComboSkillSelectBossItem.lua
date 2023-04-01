slot0 = class("ComboSkillSelectBossItem", import("..ComboSkillSelectItem"))

function slot0.ClickBtn(slot0)
	BattleFieldAction.SetComboInfo(slot0.stageType_, nil, slot0.comboSkillID_, BossTools.GetContID(slot0.stageType_, slot0.bossIndex_))
	manager.notify:Invoke(COMBO_SKILL_SELECT, slot0.comboSkillID_)
end

function slot0.RefreshUI(slot0, slot1, ...)
	uv0.super.RefreshUI(slot0, ...)

	slot0.bossIndex_ = slot1
end

return slot0
