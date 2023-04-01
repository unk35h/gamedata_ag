slot0 = class("ClickButtonNoMaskStep", ComponentStep)

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.disableBtnEvent = GuideStepCfg[slot0._stepId].params[1]
end

function slot0.GetShowMask(slot0)
	return false
end

function slot0.Play(slot0)
	slot1 = slot0:Component()

	if slot0.disableBtnEvent then
		slot2 = slot1.gameObject
		slot0.eventTriggerListener = slot2:AddComponent(typeof(EventTriggerListener))
		slot2 = slot0.eventTriggerListener

		slot2:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function (slot0, slot1)
			uv0:OnStepEnd()
		end))

		slot1.enabled = false
	else
		function slot0.btnCallBack()
			uv0:OnStepEnd()
		end

		slot1.onClick:AddListener(slot0.btnCallBack)
	end
end

function slot0.OnStepEnd(slot0)
	if slot0.eventTriggerListener then
		slot0.eventTriggerListener:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerClick)
		Object.Destroy(slot0.eventTriggerListener)

		slot0.eventTriggerListener = nil
	end

	slot1 = slot0:Component()

	if slot0.btnCallBack then
		slot1.onClick:RemoveListener(slot0.btnCallBack)

		slot0.btnCallBack = nil
	end

	if not slot0._guideComponentCfg or slot0._guideComponentCfg[2] ~= "settlement" then
		slot1.enabled = true
	end

	uv0.super.OnStepEnd(slot0)
end

return slot0
