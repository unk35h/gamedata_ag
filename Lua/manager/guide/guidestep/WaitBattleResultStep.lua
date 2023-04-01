slot0 = class("WaitBattleResultStep", BaseStep)

function slot0.Init(slot0, slot1)
	slot0._failSteps = GuideStepCfg[slot0._stepId].params
end

function slot0.BattleFinish(slot0, slot1)
	if not isSuccess(slot1) then
		slot0._guide:AddSteps(slot0._failSteps)

		if slot0._isFinish then
			slot0._isFinish = false
		end
	end

	slot0:OnStepEnd()
end

function slot0.IsFinish(slot0)
	return slot0._isFinish
end

return slot0
