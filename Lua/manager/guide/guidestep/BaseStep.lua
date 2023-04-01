slot0 = class("BaseStep")

function slot0.Ctor(slot0, slot1, slot2)
	slot0._starTime = 0
	slot0._guide = slot1
	slot0._stepId = slot2
	slot0._isFinish = GuideStepCfg[slot0._stepId].is_finish or false

	slot0:Init()
end

function slot0.Init(slot0)
end

function slot0.Check(slot0)
	return true
end

function slot0.Play(slot0)
end

function slot0.OnStepEnd(slot0)
	if slot0._guide ~= nil then
		slot0._guide:OnStepEnd(slot0)
	end

	slot0._guide = nil
end

function slot0.Guide(slot0)
	return slot0._guide
end

function slot0.IsFinish(slot0)
	return slot0._isFinish
end

function slot0.GetStepId(slot0)
	return slot0._stepId
end

function slot0.GetShowMask(slot0)
	return false
end

function slot0.Click(slot0)
end

function slot0.EventTrigger(slot0, slot1, slot2)
end

function slot0.BattleFinish(slot0, slot1)
end

function slot0.UpdateStarTime(slot0)
	slot0._starTime = Time.realtimeSinceStartup
end

function slot0.GetStarTime(slot0)
	return slot0._starTime
end

return slot0
