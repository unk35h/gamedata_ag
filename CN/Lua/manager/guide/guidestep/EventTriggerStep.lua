slot0 = class("EventTriggerStep", ComponentStep)

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0._eventName = GuideStepCfg[slot0._stepId].params[1]
end

function slot0.EventTrigger(slot0, slot1, slot2)
	if slot0._eventName == slot1 and slot0:Component() ~= nil and slot0:CheckTarget(slot3, slot1, slot2) then
		slot0:OnStepEnd()
	end
end

function slot0.CheckTarget(slot0, slot1, slot2, slot3)
	if slot1:GetType() == typeof(EventTriggerListener) then
		if slot2 == "pointerClick" then
			slot1:OnPointerClick(slot3)
		elseif slot2 == "pointerUp" then
			slot3.dragging = false

			slot1:OnPointerUp(slot3)
		elseif slot2 == "pointerDown" then
			slot3.dragging = false

			slot1:OnPointerDown(slot3)
			slot1:OnPointerUp(slot3)
		elseif slot2 == "beginDrag" then
			slot1:OnBeginDrag(slot3)
		elseif slot2 == "drag" then
			slot1:OnDrag(slot3)
		elseif slot2 == "endDrag" then
			slot1:OnEndDrag(slot3)
		elseif slot2 == "onPointerEnter" then
			slot3.enter = true

			slot1:OnPointerEnter(slot3)
		elseif slot2 == "onPointerOn" then
			slot3.enter = false

			slot1:OnPointerExit(slot3)
		elseif slot2 == "onPointerExit" then
			slot3.enter = false

			slot1:OnPointerExit(slot3)
		else
			print("未知的触发类型", slot2)
		end

		return true
	end

	error("EventTriggerStep CheckTarget Component Type Error")

	return false
end

return slot0
