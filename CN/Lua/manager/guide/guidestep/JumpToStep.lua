slot0 = class("JumpToStep", BaseStep)

function slot0.Init(slot0, slot1)
	slot0._linkData = GuideStepCfg[slot0._stepId].params
end

function slot0.Play(slot0)
	if slot0._linkData[1] == 101 then
		gameContext:ClearHistory()
	end

	JumpTools.OpenPageUntilLoaded(JumpTools.GetLinkAndParams(slot0._linkData))
	slot0:OnStepEnd()
end

function slot0.Check(slot0)
	if whereami == "battleResult" then
		gameContext:SetUrlAndParams(JumpTools.GetLinkAndParams(slot0._linkData))
	elseif whereami == "home" then
		return true
	end

	return false
end

return slot0
