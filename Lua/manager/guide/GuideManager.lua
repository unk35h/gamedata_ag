slot0 = class("GuideManager")

function slot0.Ctor(slot0)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0.view = GuideView.New()
	slot0._guides = {}
	slot0._timer = FrameTimer.New(handler(slot0, slot0.Process), 1, -1)
end

function slot0.IsPlaying(slot0)
	for slot4, slot5 in ipairs(slot0._guides) do
		if slot5:IsPlaying() then
			return true
		end
	end

	return false
end

function slot0.AddGuide(slot0, slot1)
	if not GuideBaseCfg[slot1] then
		return
	end

	if GuideData:IsFinish(slot1) then
		return
	end

	if slot2.skip_condition[1] ~= nil and GuideTool.SatisfyCondition(slot2.skip_condition) then
		return
	end

	slot3 = nil

	if ((slot1 ~= 3 or Guide_3.New(slot1)) and (slot1 ~= 8 or Guide_8.New(slot1)) and (slot1 ~= 11 or Guide_11.New(slot1)) and (slot1 ~= 14 or Guide_14.New(slot1)) and (slot1 ~= 15 or Guide_15.New(slot1)) and (slot1 ~= 19 or Guide_19.New(slot1)) and (slot1 ~= 27 and slot1 ~= 29 or Guide_skuld.New(slot1)) and (slot1 ~= 28 or Guide_28.New(slot1)) and (slot1 ~= 46 or Guide_46.New(slot1)) and BaseGuide.New(slot1)) ~= nil then
		table.insert(slot0._guides, slot3)
	end
end

function slot0.InitGuide(slot0)
	if PlayerPrefs.GetInt("OpenGuide", 0) == 1 then
		return true
	end

	slot0._guides = {}

	for slot4, slot5 in ipairs(GuideBaseCfg.all) do
		slot0:AddGuide(slot5)
	end

	if table.length(slot0._guides) > 0 then
		slot0:Process()
		slot0._timer:Start()
	end
end

function slot0.Process(slot0)
	for slot4, slot5 in ipairs(slot0._guides) do
		if slot5:IsPlaying() then
			if slot5:Check() then
				slot0:onStepStart(slot5)
				slot5:Play()
			end

			return
		end
	end

	for slot4, slot5 in ipairs(slot0._guides) do
		if slot5:Check() then
			slot5:InitSteps()
			GuideTool.Log("GuideBase Start id :" .. slot5:GetId())

			return
		end
	end
end

function slot0.onStepStart(slot0)
	slot0._timer:Stop()
end

function slot0.OnStepEnd(slot0, slot1, slot2)
	if slot2 then
		manager.guide.view:Hide()
	else
		manager.guide.view:HideButton()
	end

	if slot1:IsPlaying() then
		slot0._timer:Start()
	else
		slot0:OnGuideEnd(slot1)

		if table.indexof(slot0._guides, slot1) then
			table.remove(slot0._guides, slot3)
		end

		if table.length(slot0._guides) > 0 then
			slot0._timer:Start()
		else
			SendMessageManagerToSDK("tutorial_complete")
		end
	end
end

function slot0.OnGuideFinish(slot0, slot1)
	slot2 = slot1:GetId()

	NewPlayerGuideAction.GuideUpdateID(slot2)
	SendMessageManagerToSDK("tutorial", {
		guideId = slot2
	})

	if slot2 == 8 then
		SendMessageManagerToSDK("tutorial_complete")
	end

	GuideTool.Log("GuideBase Finish id :" .. slot1:GetId())
end

function slot0.OnGuideEnd(slot0, slot1)
	slot4 = Time.realtimeSinceStartup - slot1:GetStarTime()

	NewPlayerGuideAction.GuideUpdateIDEnd(slot1:GetId(), slot4)
	GuideTool.Log("GuideBase End id :" .. slot1:GetId() .. "  useTime : " .. slot4)
end

function slot0.SkipGuide(slot0, slot1)
	slot0:OnGuideFinish(slot1)

	if table.indexof(slot0._guides, slot1) then
		table.remove(slot0._guides, slot2)
	end
end

function slot0.PaseGuide(slot0, slot1)
	if table.indexof(slot0._guides, slot1) then
		table.remove(slot0._guides, slot2)
	end
end

function slot0.SkipAll(slot0)
end

function slot0.OnComponentClick(slot0)
	for slot4, slot5 in ipairs(slot0._guides) do
		if slot5:IsPlaying() then
			slot5:Click()
		end
	end
end

function slot0.OnEventTrigger(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0._guides) do
		if slot7:IsPlaying() then
			slot7:EventTrigger(slot1, slot2)
		end
	end
end

function slot0.OnBattleFinish(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._guides) do
		if slot6:IsPlaying() then
			slot6:BattleFinish(slot1)
		end
	end
end

function slot0.IsGoToHome(slot0)
	for slot4, slot5 in ipairs(slot0._guides) do
		if slot5:IsPlaying() then
			return slot5:IsGoToHome()
		end
	end

	return true
end

function slot0.OnLogout(slot0)
	slot0._timer:Stop()

	for slot4, slot5 in ipairs(slot0._guides) do
		slot5:Dispose()
	end

	slot0._guides = {}

	slot0.view:Dispose()
end

function slot0.Dispose(slot0)
	slot0:OnLogout()
end

return slot0
