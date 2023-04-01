slot0 = class("StoryHandler")
slot1 = Vector3(0, 1, -10)
slot2 = 25
slot3 = Vector3(0, -2000, 0)

function slot0.Ctor(slot0)
	uv0.fovChangeTime_ = 0
end

function slot0.OnCameraEnter(slot0)
	manager.ui:SetMainCameraCom("CinemachineBrain", false)

	manager.ui.mainCamera.transform.parent = slot0.transform
	manager.ui.mainCamera.transform.localPosition = uv0

	manager.ui:SetMainCameraRot(Vector3.zero)

	uv1.orignalFov = manager.ui.mainCameraCom_.fieldOfView
	manager.ui.mainCameraCom_.fieldOfView = uv2
	slot1 = LeanTween.value(uv1.orignalFov, uv2, uv1.fovChangeTime_)

	slot1:setOnUpdate(LuaHelper.FloatAction(function (slot0)
		manager.ui.mainCameraCom_.fieldOfView = slot0
	end))
	slot1:setOnComplete(System.Action(function ()
		uv0:setOnUpdate(nil):setOnComplete(nil)
	end))

	if manager.ui.mainCamera:GetComponent("CameraExtension") then
		uv1.originShadowRotationImmediately = slot2.shadowRotationImmediately
		slot2.shadowRotationImmediately = true
	end
end

function slot0.OnCameraExit()
	manager.ui:SetMainCameraCom("CinemachineBrain", true)

	manager.ui.mainCameraCom_.fieldOfView = uv0.orignalFov or 35

	SetActive(manager.ui.uiMain, true)

	manager.ui.mainCamera.transform.parent = nil

	manager.ui:SetMainCameraRot()
	manager.ui:SetMainCameraPos()

	if manager.ui.mainCamera:GetComponent("CameraExtension") then
		slot0.shadowRotationImmediately = uv0.originShadowRotationImmediately
	end
end

function slot0.OnStageEnter(slot0)
	slot0.transform.position = uv0
	slot0.transform.localEulerAngles = Vector3(0, 0, 0)
end

return slot0
