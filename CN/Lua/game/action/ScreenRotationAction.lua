return {
	RotateToPortrait = function (slot0)
		if GameToSDK.PLATFORM_ID == 0 then
			uv0.RotateToPortraitAndroid(slot0)
		else
			uv0.RotateToPortraitIOS(slot0)
		end
	end,
	RotateToPortraitIOS = function (slot0)
		slot2, slot3 = SettingTools.GetSettingScreenSize(tonumber(SettingData:GetSettingData().pic.resolution))

		ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.Portrait)
		UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(true)
		setScreenOrientation(false)
		U3DHud.mInstance:SetWidthAndHeight(1080, 1920)
		SetActive(manager.ui.mainCamera, false)
		Screen.SetResolution(slot3, slot2, true)

		slot4 = nil

		FrameTimer.New(function ()
			if GameToSDK.PLATFORM_ID == 2 or Screen.orientation == UnityEngine.ScreenOrientation.Portrait then
				uv0:Stop()
				SetActive(manager.ui.mainCamera, true)

				if uv1 then
					uv1()
				end
			end
		end, 1, -1):Start()
	end,
	RotateToPortraitAndroid = function (slot0)
		slot2, slot3 = SettingTools.GetSettingScreenSize(tonumber(SettingData:GetSettingData().pic.resolution))

		ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

		Screen.autorotateToPortrait = true
		Screen.autorotateToPortraitUpsideDown = false
		Screen.autorotateToLandscapeLeft = false
		Screen.autorotateToLandscapeRight = false

		UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(true)
		setScreenOrientation(false)
		U3DHud.mInstance:SetWidthAndHeight(1080, 1920)
		SetActive(manager.ui.mainCamera, false)
		FrameTimer.New(function ()
			Screen.SetResolution(uv0, uv1, true)
			uv2.AutoRotation2AutoRotation(function ()
				SetActive(manager.ui.mainCamera, true)
				UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(true)
				U3DHud.mInstance:SetWidthAndHeight(1080, 1920)
				Screen.SetResolution(uv0, uv1, true)

				if uv2 then
					uv2()
				end
			end)
		end, 1, 1):Start()
	end,
	AutoRotation2AutoRotation = function (slot0)
		slot1 = nil

		FrameTimer.New(function ()
			if GameToSDK.PLATFORM_ID == 2 or Screen.orientation == UnityEngine.ScreenOrientation.LandscapeLeft or Screen.orientation == UnityEngine.ScreenOrientation.LandscapeRight then
				uv0:Stop()
				ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

				Screen.autorotateToPortrait = false
				Screen.autorotateToPortraitUpsideDown = false
				Screen.autorotateToLandscapeLeft = true
				Screen.autorotateToLandscapeRight = true

				uv1.AutoRotation2Portrait(uv2)
			end
		end, 1, -1):Start()
	end,
	AutoRotation2Portrait = function (slot0)
		slot1 = nil

		FrameTimer.New(function ()
			if GameToSDK.PLATFORM_ID == 2 or Screen.orientation == UnityEngine.ScreenOrientation.LandscapeLeft or Screen.orientation == UnityEngine.ScreenOrientation.LandscapeRight then
				uv0:Stop()
				ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.Portrait)

				uv0 = FrameTimer.New(function ()
					if GameToSDK.PLATFORM_ID == 2 or Screen.orientation == UnityEngine.ScreenOrientation.Portrait then
						uv0:Stop()

						if uv1 then
							uv1()
						end
					end
				end, 1, -1)

				uv0:Start()
			end
		end, 1, -1):Start()
	end,
	RotateToLandscape = function (slot0)
		if GameToSDK.PLATFORM_ID == 0 then
			uv0.RotateToLandscapeAndroid(slot0)
		else
			uv0.RotateToLandScapeIOS(slot0)
		end
	end,
	RotateToLandScapeIOS = function (slot0)
		ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.LandscapeLeft)
		ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

		Screen.autorotateToPortrait = false
		Screen.autorotateToPortraitUpsideDown = false
		Screen.autorotateToLandscapeLeft = true
		Screen.autorotateToLandscapeRight = true
		slot2, slot3 = SettingTools.GetSettingScreenSize(tonumber(SettingData:GetSettingData().pic.resolution))

		UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(false)
		setScreenOrientation(true)
		U3DHud.mInstance:SetWidthAndHeight(1920, 1080)
		SetActive(manager.ui.mainCamera, false)
		Screen.SetResolution(slot2, slot3, true)

		slot4 = nil

		FrameTimer.New(function ()
			if GameToSDK.PLATFORM_ID == 2 or Screen.orientation ~= UnityEngine.ScreenOrientation.Portrait then
				uv0:Stop()
				SetActive(manager.ui.mainCamera, true)

				if uv1 then
					uv1()
				end

				manager.notify:Invoke(HERO_DISPLAY_EXIT)
			end
		end, 1, -1):Start()
	end,
	RotateToLandscapeAndroid = function (slot0)
		if GameToSDK.PLATFORM_ID ~= 2 then
			Screen.autorotateToPortrait = false
			Screen.autorotateToPortraitUpsideDown = false
			Screen.autorotateToLandscapeLeft = true
			Screen.autorotateToLandscapeRight = true

			ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.Portrait)
		end

		slot2, slot3 = SettingTools.GetSettingScreenSize(tonumber(SettingData:GetSettingData().pic.resolution))

		UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(false)
		U3DHud.mInstance:SetWidthAndHeight(1920, 1080)
		setScreenOrientation(true)
		SetActive(manager.ui.mainCamera, false)
		FrameTimer.New(function ()
			Screen.SetResolution(uv0, uv1, true)
			uv2.Portrait2AutoRotation(function ()
				SetActive(manager.ui.mainCamera, true)
				UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(false)
				U3DHud.mInstance:SetWidthAndHeight(1920, 1080)
				Screen.SetResolution(uv0, uv1, true)

				if uv2 then
					uv2()
				end
			end)
		end, 1, 1):Start()
	end,
	Portrait2AutoRotation = function (slot0)
		slot1 = nil

		FrameTimer.New(function ()
			if GameToSDK.PLATFORM_ID == 2 or Screen.orientation == UnityEngine.ScreenOrientation.Portrait then
				uv0:Stop()
				ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

				Screen.autorotateToPortrait = true
				Screen.autorotateToPortraitUpsideDown = false
				Screen.autorotateToLandscapeLeft = false
				Screen.autorotateToLandscapeRight = false

				uv1.AutoRotation2LandscapeLeft(uv2)
			end
		end, 1, -1):Start()
	end,
	AutoRotation2LandscapeLeft = function (slot0)
		slot1 = nil

		FrameTimer.New(function ()
			if GameToSDK.PLATFORM_ID == 2 or Screen.orientation == UnityEngine.ScreenOrientation.Portrait then
				uv0:Stop()
				ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.LandscapeLeft)

				Screen.autorotateToPortrait = false
				Screen.autorotateToPortraitUpsideDown = false
				Screen.autorotateToLandscapeLeft = true
				Screen.autorotateToLandscapeRight = true
				uv0 = FrameTimer.New(function ()
					if GameToSDK.PLATFORM_ID == 2 or Screen.orientation ~= UnityEngine.ScreenOrientation.Portrait then
						ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)
						uv0:Stop()
						uv1()
					end
				end, 1, -1)

				uv0:Start()
			end
		end, 1, -1):Start()
	end
}
