slot0 = class("BaseGuide")

function slot0.Ctor(slot0, slot1)
	slot0:Init(slot1)
end

function slot0.Init(slot0, slot1)
	slot0._starTime = 0
	slot0._guideId = slot1
	slot0._cfg = GuideBaseCfg[slot1]
	slot0.open_condition = slot0._cfg.open_condition
	slot0.is_no_home = slot0._cfg.is_no_home
	slot0.narrator_name = slot0._cfg.narrator_name or ""
	slot0.narrator_icon = slot0._cfg.narrator_icon or ""
end

function slot0.ProduceStep(slot0, slot1)
	if GuideStepCfg[slot1] then
		if slot2.type == "EnterStage" then
			return EnterStageStep.New(slot0, slot1)
		elseif slot3 == "WaitBattleResult" then
			return WaitBattleResultStep.New(slot0, slot1)
		elseif slot3 == "ClickButton" then
			return ClickButtonStep.New(slot0, slot1)
		elseif slot3 == "ClickCToggle" then
			return ClickCToggleStep.New(slot0, slot1)
		elseif slot3 == "EventTrigger" then
			return EventTriggerStep.New(slot0, slot1)
		elseif slot3 == "ClickButtonNoMask" then
			return ClickButtonNoMaskStep.New(slot0, slot1)
		elseif slot3 == "HighLight" then
			return HighLightStep.New(slot0, slot1)
		elseif slot3 == "JumpTo" then
			return JumpToStep.New(slot0, slot1)
		elseif slot3 == "SetTeam" then
			return SetTeamStep.New(slot0, slot1)
		end
	end

	error("Guide Produce Step Error by Id : " .. slot1)

	return nil
end

function slot0.InitSteps(slot0)
	slot0._steps = {}

	slot0:OnGuideStart()

	slot1 = slot0._cfg.steps
	slot2 = 1

	for slot7, slot8 in ipairs(slot0._cfg.leaps) do
		slot10 = slot8[2]

		if GuideTool.SatisfyCondition({
			{
				"uiName",
				slot8[1]
			}
		}) then
			slot2 = slot10
		end
	end

	for slot8 = slot2, #slot1 do
		if slot0:ProduceStep(slot1[slot8]) then
			table.insert(slot0._steps, slot10)
		end
	end
end

function slot0.OnGuideStart(slot0)
	slot0._starTime = Time.realtimeSinceStartup
end

function slot0.CheckGuide(slot0)
	return GuideTool.SatisfyCondition(slot0.open_condition)
end

function slot0.Check(slot0)
	if slot0:IsPlaying() then
		return slot0._steps[1]:Check()
	else
		return slot0:CheckGuide()
	end
end

function slot0.Play(slot0)
	slot0._steps[1]:UpdateStarTime()
	GuideTool.Log("Guide Start Step :" .. slot0._steps[1]:GetStepId())
	slot0._steps[1]:Play()
end

function slot0.OnStepEnd(slot0, slot1)
	slot2 = slot1:GetStepId()

	SDKTools.SendMessageToSDK("guide_complete", {
		guide_id = slot2,
		use_time = Time.realtimeSinceStartup - slot1:GetStarTime()
	})
	GuideTool.Log("Guide End Step :" .. slot2)

	if table.indexof(slot0._steps, slot1) then
		table.remove(slot0._steps, slot5)
	end

	manager.guide:OnStepEnd(slot0, table.length(slot0._steps) <= 0 or slot0._steps[1]:GetShowMask() ~= true)

	if slot1:IsFinish() then
		manager.guide:OnGuideFinish(slot0)
	end
end

function slot0.AddSteps(slot0, slot1)
	for slot6 = #slot1, 1, -1 do
		if slot0:ProduceStep(slot1[slot6]) then
			table.insert(slot0._steps, 2, slot8)
		end
	end
end

function slot0.IsPlaying(slot0)
	return slot0._steps ~= nil and table.length(slot0._steps) > 0
end

function slot0.GetNarratorInfo(slot0)
	return slot0.narrator_name, slot0.narrator_icon
end

function slot0.GetId(slot0)
	return slot0._guideId
end

function slot0.IsGoToHome(slot0)
	return not slot0.is_no_home
end

function slot0.GetStarTime(slot0)
	return slot0._starTime
end

function slot0.Click(slot0)
	if slot0._steps[1] ~= nil then
		slot1:Click()
	end
end

function slot0.EventTrigger(slot0, slot1, slot2)
	if slot0._steps[1] ~= nil then
		slot3:EventTrigger(slot1, slot2)
	end
end

function slot0.BattleFinish(slot0, slot1)
	if slot0._steps[1] ~= nil then
		slot2:BattleFinish(slot1)
	end
end

function slot0.Dispose(slot0)
end

return slot0
