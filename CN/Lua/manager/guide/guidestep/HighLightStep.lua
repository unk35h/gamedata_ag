slot0 = class("HighLightStep", ComponentStep)

function slot0.Click(slot0)
	if slot0:Component() ~= nil then
		slot0:OnStepEnd()
	end
end

return slot0
