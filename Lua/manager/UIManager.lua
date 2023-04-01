slot0 = class("UIManager")
slot1 = "adv"

function slot0.Ctor(slot0)
	slot0.uiMain = GameObject.Find("UICamera/Canvas/UIMain")
	slot0.uiStory = GameObject.Find("UICamera/Canvas/UIStory/Canvas")
	slot0.uiPop = GameObject.Find("UICamera/Canvas/UIPop/Canvas")
	slot0.uiMessage = GameObject.Find("UICamera/Canvas/UIMessage/Canvas")
	slot0.uiTips = GameObject.Find("UICamera/Canvas/UITips/Canvas")
	slot0.uiLoad = GameObject.Find("UICamera/Canvas/UILoad/Canvas")
	slot0.uiHPPanel = GameObject.Find("UICamera/Canvas/UIMain/HPPanel")
	slot0.mainCamera = GameObject.Find("MainCamera")
	slot0.canvas = GameObject.Find("UICamera/Canvas")
	slot0.dontDestroyCanvas = GameObject.Find("UICamera_DontDestroy/Canvas")
	slot0.uiCanvasGroup = slot0.canvas:GetComponent("CanvasGroup")
	slot0.canvasSize_ = slot0.canvas:GetComponent("RectTransform").sizeDelta
	slot1 = slot0.mainCamera.transform
	slot1.localPosition = Vector3(0, 0, 2)
	slot1.localEulerAngles = Vector3(0, 180, 0)
	slot0.mainCameraPos_ = Vector3(0, 0, 2)
	slot0.mainCameraRot_ = Vector3(0, 180, 0)
	slot0.mainCameraCom_ = slot0.mainCamera:GetComponent("Camera")
	slot0.cameraExtension = slot0.mainCamera:GetComponent(typeof(UnityEngine.Pipelines.SimPipeline.CameraExtension))
	slot0.sceneObject_ = {}
	slot0.canvasRate = slot0.canvas:GetComponent("RectTransform").sizeDelta.x / Screen.width
	slot0.UIDGo_ = GameObject.Find("UICamera_DontDestroy/Canvas/UIMessage/UIDText")
	slot0.UIDText_ = slot0.UIDGo_:GetComponent(typeof(Text))
	slot0.UIDMarkGo_ = GameObject.Find("UICamera_DontDestroy/Canvas/UIMessage/Canvas/UIDMarkText")
	slot0.UIDEncodeGo_ = GameObject.Find("UICamera_DontDestroy/Canvas/UIMessage/Canvas/UIDEncodeText")

	if not isNil(slot0.UIDMarkGo_) then
		if GameToSDK.clientInfo.env == uv0 then
			SetActive(slot0.UIDMarkGo_, true)
			SetActive(slot0.UIDEncodeGo_, true)
		end

		slot0.UIDMarkText_ = slot0.UIDMarkGo_:GetComponent(typeof(Text))
		slot0.UIDEncodeTrs_ = slot0.UIDEncodeGo_:GetComponent(typeof(RectTransform))
		slot0.UIDEncodeText_ = slot0.UIDEncodeGo_:GetComponent(typeof(Text))
	end

	slot0.tipImageRect_ = GameObject.Find("UICamera_DontDestroy/Canvas/UIMessage/TipImage"):GetComponent(typeof(RectTransform))
end

slot2 = 175

function slot0.SetUIDText(slot0, slot1, slot2)
	if slot0.UIDText_ then
		slot0.UIDText_.text = slot1
	end

	if slot0.UIDMarkText_ and GameToSDK.clientInfo.env == uv0 then
		if slot1 == "" then
			slot0.UIDMarkText_.text = ""
		else
			slot3 = slot1
			slot4 = "                        " .. slot1

			for slot8 = 1, uv1 do
				slot3 = slot3 .. slot4
			end

			slot0.UIDMarkText_.text = slot3
		end
	end

	if slot0.UIDEncodeText_ and GameToSDK.clientInfo.env == uv0 then
		if slot0.encodePosTimer_ then
			slot0.encodePosTimer_:Stop()
		end

		if slot1 == "" then
			slot0.UIDEncodeText_.text = ""
		else
			print("userId", slot2)

			slot0.UIDEncodeText_.text = encodeUID(slot2)
			slot0.encodePosTimer_ = Timer.New(function ()
				if uv0.UIDEncodeTrs_ then
					math.randomseed(os.time())

					uv0.UIDEncodeTrs_.anchoredPosition = Vector3(math.random(250, _G.SCREEN_WIDTH - 250), math.random(40, _G.SCREEN_HEIGHT - 40), 0)
				end
			end, 1, -1)

			slot0.encodePosTimer_:Start()
		end
	end

	CustomLog.SetUserID(slot1)
end

function slot0.ShowUID(slot0, slot1)
	SetActive(slot0.UIDGo_, slot1)

	if slot1 then
		slot0.tipImageRect_.localPosition = slot0.tipImageRect_.localPosition - Vector3(0, 20, 0)
	else
		slot0.tipImageRect_.localPosition = slot0.tipImageRect_.localPosition + Vector3(0, 20, 0)
	end
end

function slot0.SetMainActive(slot0, slot1)
	SetActive(slot0.uiMain, slot1)
end

function slot0.SetMainCameraPos(slot0, slot1)
	slot0.mainCamera.transform.localPosition = slot1 or slot0.mainCameraPos_
end

function slot0.SetMainCameraRot(slot0, slot1)
	slot0.mainCamera.transform.localEulerAngles = slot1 or slot0.mainCameraRot_
end

function slot0.SetMainCameraFieldOfView(slot0, slot1)
	slot0.mainCameraCom_.fieldOfView = slot1
end

function slot0.SetMainCamera(slot0, slot1, slot2)
	slot3 = CameraCfg[slot1]

	if not slot2 and slot3 == nil then
		print("没有配置对应的相机位置:", slot1)

		return
	end

	if not slot2 then
		slot0.mainCamera.transform.localPosition = Vector3(slot3.position[1], slot3.position[2], slot3.position[3])
		slot0.mainCamera:GetComponent("Camera").orthographic = false
		slot0.mainCamera.transform.localEulerAngles = Vector3(slot3.rotate[1], slot3.rotate[2], slot3.rotate[3])
		slot0.mainCameraCom_.fieldOfView = slot3.fieldOfView
	end

	if slot0.sceneGo_ then
		LuaForUtil.SetSceneSetting(slot0.sceneGo_, false)
		SetActive(slot0.sceneGo_, false)

		slot0.sceneGo_ = nil
	end

	slot4 = slot1

	if not slot2 then
		slot4 = (slot3.multiscene ~= 1 or manager.loadScene:GetHomeShouldLoadSceneName()) and slot3.sceneName
	end

	if slot4 and slot4 ~= "" then
		slot0.sceneGo_ = slot0:GetSceneByName(slot4)

		if slot0.sceneGo_ then
			LuaForUtil.SetSceneSetting(slot0.sceneGo_, true)
			SetActive(slot0.sceneGo_, true)
		end
	end
end

function slot0.GetSceneSetting(slot0)
	slot3, slot4 = nil

	if SceneManager.GetActiveScene():GetRootGameObjects() ~= nil then
		for slot8 = 0, slot2.Length - 1 do
			if slot2[slot8].name == slot1.name then
				slot3 = slot2[slot8]

				break
			end
		end
	end

	if slot3 and slot3:GetComponent("SceneSetting").enabled == true then
		return slot4
	end
end

function slot0.GetSceneByName(slot0, slot1)
	slot2 = nil

	if SceneManager.GetSceneByName(slot1).rootCount > 0 then
		slot2 = SceneManager.GetSceneByName(slot1):GetRootGameObjects()
	end

	if slot2 ~= nil then
		for slot6 = 0, slot2.Length - 1 do
			if slot2[slot6].name == slot1 then
				return slot2[slot6]
			end
		end
	end

	return nil
end

function slot0.ResetMainCamera(slot0)
	slot0:SetMainCamera("null")

	if slot0.sceneGo_ then
		LuaForUtil.SetSceneSetting(slot0.sceneGo_, false)
		SetActive(slot0.sceneGo_, false)

		slot0.sceneGo_ = nil
	end
end

function slot0.SetMainCameraCom(slot0, slot1, slot2)
	if slot0.mainCamera:GetComponent(slot1) then
		slot3.enabled = slot2
	end
end

function slot0.SetUISeparateRender(slot0, slot1)
	if slot0.cameraExtension then
		slot0.cameraExtension.uiSeparateRender = slot1
	end
end

function slot0.GetCanvasSize(slot0)
	return slot0.canvasSize_
end

function slot0.SetSceneObject(slot0, slot1, slot2)
	slot0.sceneObject_[slot1] = slot2
end

function slot0.GetSceneObject(slot0, slot1)
	if slot0.sceneObject_[slot1] == nil then
		slot0.sceneObject_[slot1] = GameObject.Find(slot1)
	end

	return slot0.sceneObject_[slot1]
end

function slot0.UIEventEnabled(slot0, slot1)
	if slot0.isForce_ then
		return
	end

	slot0:EventEnabled(slot1)
end

function slot0.UIEventEnabledByUI(slot0, slot1, slot2)
	slot0.isForce_ = slot2

	slot0:EventEnabled(slot1)
end

function slot0.EventEnabled(slot0, slot1)
	if slot0.uiCanvasGroup then
		slot0.uiCanvasGroup.blocksRaycasts = slot1
	end
end

function slot0.GetGuideUI(slot0)
	if slot0.guideUI_ == nil then
		slot0.guideUI_ = GameObject.Instantiate(Asset.Load("UI/Guide/GuideUI"), slot0.uiTips.transform)
	end

	return slot0.guideUI_
end

function slot0.Dispose(slot0)
	if slot0.guideUI_ then
		Object.Destroy(slot0.guideUI_)

		slot0.guideUI_ = nil
	end

	if slot0.encodePosTimer_ then
		slot0.encodePosTimer_:Stop()
	end

	if slot0.sceneGo_ then
		LuaForUtil.SetSceneSetting(slot0.sceneGo_, false)
		SetActive(slot0.sceneGo_, false)

		slot0.sceneGo_ = nil
	end

	slot0.uiCanvasGroup = nil
	slot0.uiMain = nil
	slot0.uiPop = nil
	slot0.uiMessage = nil
	slot0.uiTips = nil
	slot0.uiLoad = nil
	slot0.uiHPPanel = nil
	slot0.uiCamera = nil
	slot0.sceneObject_ = {}
end

function slot0.AdaptUIByFOV(slot0)
	slot1 = 1000000
	slot4 = math.deg(2 * math.atan(2 * slot1 * math.tan(math.rad(slot0.mainCameraCom_.fieldOfView * 0.5)) * slot0.mainCameraCom_.aspect * 0.5 / slot1))

	print("该界面的水平FOV为：", slot4)

	if slot4 < 46 then
		slot0.mainCameraCom_.fieldOfView = math.deg(2 * math.atan(2 * slot1 * math.tan(math.rad(46 * 0.5)) / slot0.mainCameraCom_.aspect * 0.5 / slot1))
	end
end

function slot0.ScreenToWorldPoint(slot0, slot1, slot2, slot3)
	slot4 = slot0.mainCameraCom_:ScreenToWorldPoint(Vector3(slot1, slot2, slot3))

	return slot4.x, slot4.z
end

function slot0.ShowScreenTap(slot0, slot1)
	if slot0.screenTapCanvas == nil then
		slot0.screenTap = GameObject.Find("UICamera/Canvas/UIScreenTap/ScreenTapUI")

		if slot0.screenTap then
			slot0.screenTapCanvas = slot0.screenTap:GetComponent("CanvasGroup")
		end
	end

	if slot0.screenTapCanvas then
		if slot1 then
			slot0.screenTapCanvas.alpha = 1
		else
			slot0.screenTapCanvas.alpha = 0
		end
	end

	slot0:ShowUID(slot1)
end

return slot0
