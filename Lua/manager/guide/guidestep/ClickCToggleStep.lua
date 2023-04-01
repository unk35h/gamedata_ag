slot0 = class("ClickCToggleStep", ComponentStep)

function slot0.Click(slot0)
	if slot0:Component() ~= nil and slot0:CheckTarget(slot1) then
		slot0:OnStepEnd()
	end
end

function slot0.CheckTarget(slot0, slot1)
	if slot1:GetType() == typeof(CToggle) then
		slot1.isOn = true

		return true
	end

	error("ClickCToggleStep CheckTarget Component Type Error")

	return false
end

return slot0
