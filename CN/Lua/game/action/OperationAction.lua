slot1 = manager.net

slot1:Bind(40021, function (slot0)
	OperationData:InitOperationOpenList(slot0)
end)

slot1 = manager.net

slot1:Bind(40031, function (slot0)
	OperationData:SetFunctionStopIdList(slot0.id_list)
end)

slot1 = manager.net

slot1:Bind(40033, function (slot0)
	OperationData:InitFollowOpenList(slot0)
end)

slot1 = nil
slot2 = false

return {
	GetOperationUrl = function (slot0)
		if not GameToSDK.clientInfo.configS then
			print("error GameToSDK.clientInfo empty configS")

			return nil
		end

		if not slot1:ContainsKey(slot0) then
			print("error GameToSDK.clientInfo empty configS by key : " .. slot0)

			return nil
		end

		return slot1:get_Item(slot0)
	end,
	OpenOperationUrl = function (slot0, slot1)
		if not GameToSDK.clientInfo.configS then
			print("error GameToSDK.clientInfo empty configS")

			return
		end

		if not slot2:ContainsKey(slot0) then
			print("error GameToSDK.clientInfo empty configS by key : " .. slot0)

			return
		end

		slot3 = slot2:get_Item(slot0)
		slot4 = ""

		print("url : ", EncodeURL((slot0 ~= "INQUERY_URL" or string.format(slot3, slot1.userId, slot1.signUserId)) and (slot0 ~= "FORUM_URL" and slot0 ~= "OFFICIAL_SUGGEST_URL" or string.format(slot3, slot1.userId, slot1.signUserId, slot1.gameAppId, slot1.token)) and (slot0 ~= "FORUM_URL_HERO" or string.format(slot3, slot1.userId, slot1.signUserId, slot1.gameAppId, slot1.token, slot1.heroName)) and (slot0 ~= "OFFICIAL_DISCUSS_URL" or string.format(slot3, slot1.gameAppId, slot1.token)) and (slot0 ~= "ACTIVITY_URL" or string.format(slot3, slot1.userId, slot1.signUserId)) and (slot0 ~= "GUIDE_URL" or string.format(slot3, slot1.userId, slot1.signUserId)) and slot3))

		if GameToSDK.PLATFORM_ID == 1 and (slot0 == "FORUM_URL" or slot0 == "FORUM_URL_HOME" or slot0 == "FORUM_URL_HERO" or slot0 == "OFFICIAL_SUGGEST_URL") then
			Application.OpenURL(slot4)
		else
			FrameTimer.New(function ()
				LuaForUtil.OpenWebView(uv0, true, function ()
					print("--->> open webView to portrait")
				end, function ()
					print("====>>> close webView recover")
				end)
			end, 6, 1):Start()
		end
	end,
	OnApplicationBack = function ()
		if SurveyData:GetCacheFollowTip() then
			ShowTips(slot0)
		end
	end,
	GetUnreadMsgResult = function ()
		if uv0.GetOperationUrl("BBS_BASE_URL") then
			slot1 = PlayerData
			slot1 = slot1:GetPlayerInfo()

			LuaForUtil.GetUnreadMsg(slot0, slot1.userID .. "_" .. slot1.signUserId, 1, function (slot0)
				if slot0 > 0 then
					manager.redPoint:setTip(RedPointConst.FORUM_UNREAD, 1)
				end
			end)
		end
	end,
	ChangeScreenSettingToPortrait = function ()
		uv0 = Screen.orientation
		slot1, slot2 = SettingTools.GetSettingScreenSize(tonumber(SettingData:GetSettingData().pic.resolution))

		SetActive(manager.ui.mainCamera, false)
		FrameTimer.New(function ()
			if not uv0 then
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
			FrameTimer.New(function ()
				Screen.SetResolution(uv0, uv1, true)

				if not uv2 then
					FrameTimer.New(function ()
						ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

						Screen.autorotateToPortrait = false
						Screen.autorotateToPortraitUpsideDown = false
						Screen.autorotateToLandscapeLeft = true
						Screen.autorotateToLandscapeRight = true

						FrameTimer.New(function ()
							ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.Portrait)
							FrameTimer.New(function ()
								UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(true)
								U3DHud.mInstance:SetWidthAndHeight(1080, 1920)
								Screen.SetResolution(uv0, uv1, true)

								uv2 = true
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
		end, 1, 1):Start()
		FrameTimer.New(function ()
			SetActive(manager.ui.mainCamera, true)
		end, 6, 1):Start()
	end,
	RecoverScreenSetting = function ()
		SetActive(manager.ui.mainCamera, false)
		FrameTimer.New(function ()
			ScreenRotateUtil.ChangeScreenOrientation(uv0)
			ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

			Screen.autorotateToPortrait = false
			Screen.autorotateToPortraitUpsideDown = false
			Screen.autorotateToLandscapeLeft = true
			Screen.autorotateToLandscapeRight = true

			setScreenOrientation(true)

			slot1, slot2 = SettingTools.GetSettingScreenSize(tonumber(SettingData:GetSettingData().pic.resolution))

			UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(false)
			U3DHud.mInstance:SetWidthAndHeight(1920, 1080)
			FrameTimer.New(function ()
				Screen.SetResolution(uv0, uv1, true)
			end, 2, 1):Start()
		end, 1, 1):Start()
		FrameTimer.New(function ()
			SetActive(manager.ui.mainCamera, true)
		end, 4, 1):Start()
	end
}
