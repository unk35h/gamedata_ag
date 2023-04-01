slot0 = class("JumpToStep", BaseStep)

function slot0.Init(slot0, slot1)
	slot0.team = GuideStepCfg[slot0._stepId].params
end

function slot0.Play(slot0)
	BattleTeamData:SetSingleTeam(1, 0, slot0.team, {
		0,
		0,
		0
	}, ComboSkillTools.GetRecommendSkillID(slot0.team, true))
	slot0:OnStepEnd()
end

return slot0
