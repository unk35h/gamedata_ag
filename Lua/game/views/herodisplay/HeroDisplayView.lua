slot0 = class("HeroDisplayView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Hero/HeroDisplayUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.weaponController_ = ControllerUtil.GetController(slot0.transformWeapon_, "weaponState")
	slot0.scaleController_ = ControllerUtil.GetController(slot0.buttonScale_.transform, "select")
	slot0.touchView_ = TouchView.New()
	slot0.settingView_ = HeroDisplaySettingView.New(slot0.goSettingPanel_)
	slot0.snapView_ = HeroDisplaySnapView.New(slot0.goSnapPanel_)
	slot0.shareView_ = HeroDisplayShareView.New(slot0.goSharePanel_)
	slot0.expressionView_ = HeroDisplayExpressionView.New(slot0.goHeroExpressionPanel_)
	slot0.heroPoseView_ = HeroDisplayPoseView.New(slot0.goSelectPose_)
	slot0.clickHandler_ = handler(slot0, slot0.ClickTrigger)
	slot0.heroPoseSelectHandler_ = handler(slot0, slot0.HeroPoseSelect)
	slot0.scaleTable_ = GameSetting.model_scale_rate.value
	slot0.camera_ = manager.ui.mainCameraCom_
	slot0.rotateHandler_ = handler(slot0, slot0.RotateModel)
	slot0.upDownHandler_ = handler(slot0, slot0.UpDownModel)
	slot0.scaleHandler_ = handler(slot0, slot0.ScaleModel)
end

function slot0.OnEnter(slot0)
	slot0:ScreenAdapt()

	slot0.scaleIndex_ = 0
	slot0.scaleText_.text = slot0.scaleTable_[slot0.scaleIndex_ + 1][1]

	slot0.scaleController_:SetSelectedState("false")
	manager.ui:SetMainCamera("heroDisplay")

	slot0.screenOrientation_ = Screen.orientation
	slot2, slot3 = SettingTools.GetSettingScreenSize(tonumber(SettingData:GetSettingData().pic.resolution))

	if not HeroDisplayData.firstOrientation then
		ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

		Screen.autorotateToPortrait = true
		Screen.autorotateToPortraitUpsideDown = false
		Screen.autorotateToLandscapeLeft = false
		Screen.autorotateToLandscapeRight = false
	else
		ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.Portrait)
	end

	UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(true)
	setScreenOrientation(false)
	U3DHud.mInstance:SetWidthAndHeight(1080, 1920)

	if not HeroDisplayData.firstOrientation then
		SetActive(manager.ui.mainCamera, false)
	end

	FrameTimer.New(function ()
		Screen.SetResolution(uv0, uv1, true)

		if not HeroDisplayData.firstOrientation then
			FrameTimer.New(function ()
				ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

				Screen.autorotateToPortrait = false
				Screen.autorotateToPortraitUpsideDown = false
				Screen.autorotateToLandscapeLeft = true
				Screen.autorotateToLandscapeRight = true

				FrameTimer.New(function ()
					ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.Portrait)
					FrameTimer.New(function ()
						SetActive(manager.ui.mainCamera, true)
						UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(true)
						U3DHud.mInstance:SetWidthAndHeight(1080, 1920)
						Screen.SetResolution(uv0, uv1, true)

						HeroDisplayData.firstOrientation = true
					end, 1, 1):Start()
				end, 1, 1):Start()
			end, 1, 1):Start()
		else
			FrameTimer.New(function ()
				UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(true)
				U3DHud.mInstance:SetWidthAndHeight(1080, 1920)
				Screen.SetResolution(uv0, uv1, true)
			end, 1, 1):Start()
		end
	end, 1, 1):Start()

	slot0.isFirstShowTips_ = true
	slot0.heroID_ = slot0.params_.heroID
	slot4 = OperationData:IsOperationOpen(OperationConst.SHARE_FLAG)

	SetActive(slot0.buttonSnap_.gameObject, slot4)
	SetActive(slot0.buttonSetting_.gameObject, slot4)
	slot0:LoadModel()

	slot0.isShowPosePanel_ = false

	SetActive(slot0.goSelectPose_, slot0.isShowPosePanel_)
	SetActive(slot0.goSelect_, slot0.isShowPosePanel_)
	slot0.touchView_:OnEnter()
	slot0.expressionView_:OnEnter(slot0.heroID_)
	slot0.heroPoseView_:OnEnter(slot0.heroID_)
	slot0.shareView_:OnEnter()
	slot0:HeroPoseSelect(1)
	manager.notify:RegistListener(HERO_POSE_SELECT, slot0.heroPoseSelectHandler_)
	manager.notify:RegistListener(CLICK_TRIGGER, slot0.clickHandler_)
	manager.notify:RegistListener(TOUCH_HORIZONTAL, slot0.rotateHandler_)
	manager.notify:RegistListener(TOUCH_VERTICAL, slot0.upDownHandler_)
	manager.notify:RegistListener(MULTI_TOUCH_SCALE, slot0.scaleHandler_)
end

function slot0.OnBehind(slot0)
	slot0.expressionView_:OnBehind()
end

function slot0.OnTop(slot0)
	slot0.expressionView_:OnTop()
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(HERO_POSE_SELECT, slot0.heroPoseSelectHandler_)
	manager.notify:RemoveListener(CLICK_TRIGGER, slot0.clickHandler_)
	manager.notify:RemoveListener(TOUCH_HORIZONTAL, slot0.rotateHandler_)
	manager.notify:RemoveListener(TOUCH_VERTICAL, slot0.upDownHandler_)
	manager.notify:RemoveListener(MULTI_TOUCH_SCALE, slot0.scaleHandler_)
	ScreenRotateUtil.ChangeScreenOrientation(slot0.screenOrientation_)
	ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

	Screen.autorotateToPortrait = false
	Screen.autorotateToPortraitUpsideDown = false
	Screen.autorotateToLandscapeLeft = true
	Screen.autorotateToLandscapeRight = true

	setScreenOrientation(true)

	slot2, slot3 = SettingTools.GetSettingScreenSize(tonumber(SettingData:GetSettingData().pic.resolution))

	UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(false)
	U3DHud.mInstance:SetWidthAndHeight(1920, 1080)
	FrameTimer.New(function ()
		Screen.SetResolution(uv0, uv1, true)
		manager.notify:Invoke(HERO_DISPLAY_EXIT)
	end, 2, 1):Start()
	slot0.touchView_:OnExit()
	slot0.expressionView_:OnExit()
	slot0.heroPoseView_:OnExit()
	slot0.shareView_:OnExit()
	slot0:UnloadModel()

	if slot0.hideTimer_ then
		slot0.hideTimer_:Stop()

		slot0.hideTimer_ = nil
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonBack_, nil, function ()
		uv0.expressionView_:TryExitSaveData()
	end)
	slot0:AddBtnListener(slot0.buttonHide_, nil, function ()
		SetActive(uv0.goUIPanel_, false)
		uv0:HidePosePanel()

		if uv0.isFirstShowTips_ then
			SetActive(uv0.goClickTips_, true)

			uv0.hideTimer_ = Timer.New(function ()
				uv0.hideTimer_ = nil

				SetActive(uv0.goClickTips_, false)
			end, 2, 1)

			uv0.hideTimer_:Start()

			uv0.isFirstShowTips_ = false
		end

		uv0.touchView_:HideUI()
	end)
	slot0:AddBtnListener(slot0.buttonWeapon_, nil, function ()
		if HeroDisplayData:GetHeroPoseList(uv0.heroID_)[uv0.poseIndex_].hasWeapon == false then
			ShowTips("CANNOT_SWITCH_WEAPON_STATE")

			return
		end

		uv0.showWeapon_ = not uv0.showWeapon_

		if uv0.showWeapon_ then
			uv0.weaponController_:SetSelectedState("1")
		else
			uv0.weaponController_:SetSelectedState("0")
		end

		HeroTools.SetHeroModelWeaponActivity(uv0.uiTpose_, uv0.showWeapon_)
	end)
	slot0:AddBtnListener(slot0.buttonPose_, nil, function ()
		uv0.isShowPosePanel_ = not uv0.isShowPosePanel_

		uv0.heroPoseView_:Show(uv0.isShowPosePanel_)
		SetActive(uv0.goSelect_, uv0.isShowPosePanel_)

		if uv0.isShowPosePanel_ then
			uv0.touchView_:HideUI()
		end

		uv0:HideScalePanel()
	end)
	slot0:AddBtnListener(slot0.buttonSnap_, nil, function ()
		if uv0.isShowPosePanel_ then
			uv0:HidePosePanel()
		end

		slot0 = uv0

		slot0:HideScalePanel()
		SetActive(uv0.goUIPanel_, false)

		slot0 = uv0.snapView_

		slot0:Snap(function ()
			SetActive(uv0.goUIPanel_, true)
			uv0.shareView_:SetData(uv0.heroID_, uv0.showWeapon_, uv0.poseIndex_)
			uv0.shareView_:OnSnape()

			slot0 = HeroDisplayData:GetHeroPoseList(uv0.heroID_)[uv0.poseIndex_]
			slot1 = 0

			if uv0.showWeapon_ and slot0.hasWeapon then
				slot1 = 1
			end

			SDKTools.SendMessageToSDK("screenshot", {
				screenshot_oper = 1,
				share_channel = 0,
				hero_id = uv0.heroID_,
				weapon_on = slot1,
				posture_id = uv0.poseIndex_,
				logo_location = HeroDisplayData.settingProfile_.logoPos == 0 and 2 or HeroDisplayData.settingProfile_.logoPos,
				card_show = HeroDisplayData.settingProfile_.cardShow and 1 or 0,
				card_location = HeroDisplayData.settingProfile_.cardPos == 0 and 1 or HeroDisplayData.settingProfile_.cardPos,
				lv_show = HeroDisplayData.settingProfile_.cardShowLv and 1 or 0,
				uid_show = HeroDisplayData.settingProfile_.cardShowUID and 1 or 0
			})
		end)
	end)
	slot0:AddBtnListener(slot0.buttonExpression_, nil, function ()
		uv0.expressionView_:OnShow(uv0.uiTpose_)
	end)
	slot0:AddBtnListener(slot0.buttonSetting_, nil, function ()
		SetActive(uv0.goSettingPanel_, true)
		uv0.settingView_:OnEnter()
		uv0:HideScalePanel()
	end)
	slot0:AddBtnListener(slot0.buttonScale_, nil, function ()
		slot0 = uv0.touchView_

		slot0:HideUI()

		slot0 = uv0

		slot0:HidePosePanel()

		slot0 = uv0.scaleController_

		slot0:SetSelectedState("true")

		uv0.scaleIndex_ = (uv0.scaleIndex_ + 1) % #uv0.scaleTable_
		uv0.scaleText_.text = uv0.scaleTable_[uv0.scaleIndex_ + 1][1]
		slot2 = LeanTween.value(uv0.camera_.fieldOfView, uv0.scaleTable_[uv0.scaleIndex_ + 1][2], 0.35)

		slot2:setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.camera_.fieldOfView = slot0
		end))
		slot2:setOnComplete(System.Action(function ()
			uv0:setOnUpdate(nil):setOnComplete(nil)
		end))
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.heroPoseSelectHandler_ = nil
	slot0.clickHandler_ = nil

	slot0.touchView_:Dispose()

	slot0.touchView_ = nil

	slot0.settingView_:Dispose()

	slot0.settingView_ = nil

	slot0.snapView_:Dispose()

	slot0.snapView_ = nil

	slot0.shareView_:Dispose()

	slot0.shareView_ = nil

	slot0.expressionView_:Dispose()

	slot0.expressionView_ = nil

	slot0.heroPoseView_:Dispose()

	slot0.heroPoseView_ = nil
	slot0.rotateHandler_ = nil
	slot0.upDownHandler_ = nil
	slot0.scaleHandler_ = nil
end

function slot0.LoadModel(slot0)
	slot2 = HeroTools.HeroUsingSkinInfo(slot0.heroID_).id

	if slot0.heroModel_ then
		slot0:DestroyCurrentModel()

		slot0.heroModel_ = nil
	end

	slot0.modelPath_ = "Char/" .. slot1.display_model_id
	slot0.heroModel_ = Asset.Instantiate(slot0.modelPath_)
	slot3 = HeroCfg[slot0.heroID_]
	slot4 = HeroDisplayCfg[slot3.id].position
	slot5 = HeroDisplayCfg[slot3.id].rotation
	slot6 = HeroDisplayCfg[slot3.id].scale
	slot7 = slot0.heroModel_.transform
	slot0.heroTransform_ = slot0:FindTrs(string.format("%sui", slot2), slot7)
	slot7.localPosition = Vector3.New(slot4[1], slot4[2], slot4[3])
	slot7.localEulerAngles = Vector3.New(slot5[1], slot5[2], slot5[3])
	slot7.localScale = Vector3.New(slot6[1], slot6[2], slot6[3])

	if slot0:FindTrs(slot2 .. "ui", slot7) then
		slot8.localEulerAngles = Vector3.zero
	end

	slot0.uiTpose_ = slot0:FindTrs(string.format("%dui/%dui_tpose", slot2, slot2), slot7)

	if slot0.uiTpose_ then
		slot0.animator_ = slot0:FindCom(typeof(Animator), "", slot0.uiTpose_)
	end

	slot0:InitHeroExpressionParams()
end

function slot0.DestroyCurrentModel(slot0)
	if slot0.heroModel_ and slot0.modelPath_ then
		Object.DestroyImmediate(slot0.heroModel_)
		Asset.Unload(slot0.modelPath_)
		manager.gc:Collect()
		Resources.UnloadUnusedAssets()

		slot0.heroModel_ = nil
		slot0.modelPath_ = nil
	end
end

function slot0.UnloadModel(slot0)
	if slot0.heroModel_ then
		slot0:DestroyCurrentModel()

		slot0.posterGirlId_ = nil
		slot0.heroTransform_ = nil
	end
end

function slot0.ResetHeroExpressionParams(slot0)
	for slot6, slot7 in ipairs(HeroDisplayData:GetHeroExpressionParams(slot0.heroID_)[1].values) do
		slot0.skinnedMeshRenderer_:SetBlendShapeWeight(slot6 - 1, slot7 / 100)
	end
end

function slot0.InitHeroExpressionParams(slot0)
	slot2 = slot0:FindCom(typeof(UnityEngine.SkinnedMeshRenderer), "face", slot0.uiTpose_.transform)

	if HeroDisplayData:GetHeroExpressionParams(slot0.heroID_) == nil then
		slot3 = {}

		for slot7, slot8 in ipairs(HeroDisplayCfg[slot1].skinMeshIDList) do
			table.insert(slot3, slot2:GetBlendShapeWeight(slot7 - 1) * 100)
		end

		HeroDisplayAction.SetDefaultHeroExpression(slot1, slot3)
	end

	HeroDisplayData:InitCacheExpressionParams(slot1)
	HeroDisplayData:InitHeroPose(slot1)

	slot0.skinnedMeshRenderer_ = slot2
end

function slot0.RotateModel(slot0, slot1)
	if slot0.heroTransform_ == nil then
		return
	end

	slot0.heroTransform_:Rotate(0, slot1, 0, Space.World)
end

function slot0.UpDownModel(slot0, slot1)
	slot3 = GameSetting.camera_y_range.value[2]

	if GameSetting.camera_y_range.value[1] > manager.ui.mainCamera.transform.position.y + slot1 then
		slot5 = slot2 - slot4.position.y
	elseif slot3 < slot6 then
		slot5 = slot3 - slot4.position.y
	end

	slot4:Translate(0, slot5, 0)
end

function slot0.ScaleModel(slot0, slot1)
	slot3 = GameSetting.camera_field_range.value[2]

	if GameSetting.camera_field_range.value[1] > manager.ui.mainCameraCom_.fieldOfView + slot1 then
		manager.ui.mainCameraCom_.fieldOfView = slot2
	elseif slot3 < slot4 then
		manager.ui.mainCameraCom_.fieldOfView = slot3
	else
		manager.ui.mainCameraCom_.fieldOfView = slot4
	end
end

function slot0.HeroPoseSelect(slot0, slot1)
	if HeroDisplayData:GetHeroPoseList(slot0.heroID_) == nil then
		return
	end

	if slot0.heroModel_ == nil then
		return
	end

	slot2 = HeroDisplayData:GetHeroPoseList(slot0.heroID_)[slot1]

	if slot0.uiTpose_ then
		manager.resourcePool:ResetBlendShapes(slot0.heroModel_)
		slot0.animator_:Play(HeroDisplayPoseCfg[slot2.id].poseName)
	end

	slot0.heroPoseView_:SetData(slot1)

	slot0.poseIndex_ = slot1
	slot0.showWeapon_ = slot2.hasWeapon

	HeroTools.SetHeroModelWeaponActivity(slot0.uiTpose_, slot0.showWeapon_)
	slot0:RefreshWeaponBtn()
end

function slot0.ClickTrigger(slot0)
	SetActive(slot0.goUIPanel_, true)

	if slot0.hideTimer_ then
		slot0.hideTimer_:Stop()

		slot0.hideTimer_ = nil
	end

	SetActive(slot0.goClickTips_, false)
	slot0:HidePosePanel()
	slot0:HideScalePanel()
end

function slot0.HidePosePanel(slot0)
	slot0.isShowPosePanel_ = false

	slot0.heroPoseView_:Show(false)
	SetActive(slot0.goSelect_, false)
end

function slot0.HideScalePanel(slot0)
	slot0.scaleController_:SetSelectedState("false")
end

function slot0.RefreshWeaponBtn(slot0)
	slot1 = HeroDisplayData:GetHeroPoseList(slot0.heroID_)[slot0.poseIndex_]

	if slot0.showWeapon_ and slot1.hasWeapon then
		slot0.weaponController_:SetSelectedState("1")
	else
		slot0.weaponController_:SetSelectedState("0")
	end
end

function slot0.ScreenAdapt(slot0)
	if slot0.ADAPT_RAITO < _G.SCREEN_WIDTH / _G.SCREEN_HEIGHT then
		slot0.goUIPanel_.transform.offsetMax = Vector2(0, -1 * slot0.VIEW_ADAPT_DISTANCE)
	end
end

return slot0
