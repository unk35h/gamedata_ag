slot0 = class("LoginRender", ReduxView)

function slot0.UIName(slot0)
	return "UI/LoginInterface"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.OnEnter(slot0)
	whereami = "login"
	_G.isLogining = false
	slot0.params_.isAutoLogin = true

	LoadingUIManager.inst:CloseLoadUI()
	Timer.New(function ()
		GameToSDK.SendMessage("{\"messageType\" : \"GetBulletin\"}")
	end, 1, 1):Start()

	if GameToSDK.CURRENT_SERVER == "kr" then
		slot0.logoController:SetSelectedIndex(1)
	end

	slot0:RegistEventListener(AGE_TIP_CALLBACK, function (slot0)
		print("AGE_TIP_CALLBACK")

		uv0.ageLimitGo_.transform:Find("Canvas/panel/descContainer/friendlyDescText"):GetComponent(typeof(Text)).text = slot0
	end)
end

function slot0.OnExit(slot0)
	slot0.selectRegion_.onValueChanged:RemoveAllListeners()
	slot0:RemoveAllEventListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListenerScale(slot0.startupBtn_, nil, "TryToLoginIn")
	slot0:AddBtnListener(slot0.deleteFolderBtn_, nil, function ()
		if _G.isLogining then
			return
		end

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("VERIFY_ASSETS_BEFORE_CONFIRM"),
			OkCallback = function ()
				JumpTools.OpenPageByJump("repairAssetsView")
			end,
			CancelCallback = function ()
			end
		})
	end)

	slot0.logoController = ControllerUtil.GetController(slot0.gameObject_.transform, "logo")
	slot0.isOverSeas_ = GameToSDK.CURRENT_SERVER ~= nil and slot1 ~= "" and slot1 ~= "zh_cn"
	slot0.myID = PlayerPrefs.GetString("AccountID")

	slot0:UpdateAccount(slot0.myID)
	slot0:AddBtnListener(slot0.levelBtn_, nil, function ()
		SetActive(uv0.ageLimitGo_, true)
	end)
	slot0:AddBtnListener("AgeUI/Canvas/panel/upgradecancelled/okBtn", nil, function ()
		SetActive(uv0.ageLimitGo_, false)
	end)
	slot0:AddBtnListener("AgeUI/Canvas/bgmask", nil, function ()
		SetActive(uv0.ageLimitGo_, false)
	end)

	_G.isLogining = false
	slot0.serverList_ = {
		{
			port = 8102,
			text = "本地服",
			host = "127.0.0.1"
		}
	}

	if not SDKTools.IsSDK() then
		slot0.serverList_ = require("lua_exclude/innerLoginList"):GetLoginList()
	end

	for slot5 = 1, #slot0.serverList_ do
		slot0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(slot0.serverList_[slot5].text))
	end

	slot0.dropDown_:RefreshShownValue()

	slot0.currentServerIndex_ = tonumber(PlayerPrefs.GetString("SelectServer")) or 1

	if GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV then
		slot0.dropDown_.value = slot0.currentServerIndex_ - 1
	end

	slot0:RefreshState()

	slot0.versionName_.text = "VersionName: " .. LuaForUtil.GetResourceVersionName()
	slot0.clientVersion_.text = "ClientVersion: " .. LuaForUtil.GetClientVersion()
	slot0.resourceVersion_.text = "ResourceVersion: " .. LuaForUtil.GetResourceVersion()
	slot0.battleVersion_.text = "BattleVersion: " .. LuaForUtil.GetBattleVersion()
	_G.bulletinInfoGetted = false

	GameToSDK.SendMessage("{\"messageType\" : \"GetAgeTip\"}")
	slot0:WaitForBulletin()
	slot0:AddOperationListener()

	slot0.criMovie_ = slot0.movieGo_:GetComponent("CriManaMovieControllerForUI")
	slot0.criplayer_ = slot0.criMovie_.player

	slot0.criplayer_:SetVolume(manager.audio:GetEffectVolume())
	print("server", GameToSDK.CURRENT_SERVER)
	print("serverList", GameToSDK.SERVER_LIST)
	DealAreaDifferenceCfg(GameToSDK.CURRENT_SERVER)
	SetActive(slot0.selectRegion_.gameObject, GameToSDK.SERVER_LIST.Length > 1)

	if slot4 > 1 then
		slot5 = 0

		for slot9 = 0, slot4 - 1 do
			if GameToSDK.CURRENT_SERVER == GameToSDK.SERVER_LIST[slot9] then
				slot5 = slot9
			end

			slot0.selectRegion_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(AreaDifferenceCfg[GameToSDK.SERVER_LIST[slot9]].name))
		end

		slot6 = slot0.selectRegion_

		slot6:RefreshShownValue()

		slot0.selectRegion_.value = slot5
		slot6 = slot0.selectRegion_.onValueChanged

		slot6:AddListener(function (slot0)
			if slot0 ~= uv0 then
				ShowMessageBox({
					content = GetTips("CHANGE_SERVER"),
					OkCallback = function ()
						PlayerPrefs.SetInt("SERVER_DEFAULT_SELECT_INDEX", uv0)
						Quit()
					end,
					CancelCallback = function ()
						uv0.selectRegion_.value = uv1
					end
				})
			end
		end)
	end
end

function slot0.AddOperationListener(slot0)
	slot0:AddBtnListener(slot0.suggestBtn_, nil, function ()
		SendMessageToSDK("{\"messageType\" : \"StartCustomerService\"}")
	end)
	slot0:AddBtnListener(slot0.sdkBtn_, nil, function ()
		NeedGameUserInfo()
		GameToSDK.GoUserCenter()
	end)
	slot0:AddBtnListener(slot0.anncBtn_, nil, function ()
		if _G.bulletinInfoGetted then
			uv0:ShowWebView()
		end
	end)
	slot0:AddBtnListener(slot0.forumBtn_, nil, function ()
		if _G.ChannelLoginInfo and _G.ChannelLoginInfo.channelToken then
			OperationAction.OpenOperationUrl("FORUM_URL", {
				gameAppId = _G.ChannelLoginInfo.channelAppId,
				token = _G.ChannelLoginInfo.channelToken
			})
		else
			OperationAction.OpenOperationUrl("FORUM_URL_HOME")
		end

		SDKTools.SendMessageToSDK("direction", {
			direction_type = 8,
			direction_channel = 1
		})
	end)
	slot0:AddBtnListener(slot0.protocolBtn_, nil, function ()
	end)
end

function slot0.WaitForBulletin(slot0)
	print("WaitForBulletin 开始监听公告信息返回")

	if SDKTools.IsSDK() then
		print("SDK 环境")

		slot1 = 0
		slot2 = nil

		Timer.New(function ()
			uv0 = uv0 + 1

			if _G.bulletinInfoGetted or uv0 > 30 then
				uv1:Stop()
				Timer.New(function ()
					uv0:ShowWebView()
					uv0:SDKLogin()
					uv0:AddUIListener()
				end, 0.6, 1):Start()
			end
		end, 0.1, -1):Start()
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.imageBtn_, nil, function ()
		if not EvokeGateWayLogin() then
			uv0:SDKLogin()
		end
	end)
end

function slot0.SDKLogin(slot0)
	if _G.isLogining or _G.clickCDing_ then
		return
	end

	_G.clickCDing_ = true

	Debug.Log("唤起SDK登录")
	GameToSDK.Login("{}")
	SendMessageManagerToSDK("SDKLogin")
	TimeTools.StartAfterSeconds(5, function ()
		_G.clickCDing_ = false
	end, {})
end

function slot0.ShowWebView(slot0)
end

function slot0.RefreshState(slot0)
	slot1 = GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV

	SetActive(slot0.btn_server_, slot1)
	SetActive(slot0.btn_account_, slot1)
	SetActive(slot0.btn_start_, slot1)

	slot2 = GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV or _G.CHANNEL_MASTER_ID == 1 or _G.CHANNEL_MASTER_ID == 0

	if slot0.isOverSeas_ then
		SetActive(slot0.levelBtn_.gameObject, false)
		SetActive(slot0.forumGo_, true)
	else
		SetActive(slot0.levelBtn_.gameObject, true)
		SetActive(slot0.suggestGo_, slot2)
		SetActive(slot0.sdkGo_, slot2)
		SetActive(slot0.forumGo_, slot2)
		SetActive(slot0.protocolGo_, false)
	end
end

function slot0.TryToLoginIn(slot0)
	if string.len(tostring(slot0:GetAccount())) < 1 then
		ShowTips("IF_ACCOUNT_NIL")

		return
	end

	slot0.currentServerIndex_ = slot0.dropDown_.value + 1
	GATEWAY_ADDR = slot0.serverList_[slot0.currentServerIndex_].host
	GATEWAY_PORT = slot0.serverList_[slot0.currentServerIndex_].port

	PlayerPrefs.SetString("SelectServer", slot0.currentServerIndex_)
	PlayerPrefs.SetString("AccountID", slot0:GetAccount())
	CheckVersion(function ()
		manager.net.gateWayConnection_.netStatus = "none"

		LoginAction.GateWayLogin(uv0:GetAccount(), uv0:GetPassword())
	end)
end

function slot0.PlayOut(slot0)
	manager.audio:StopEffect()
	manager.messageBox:HideAll()
	slot0:CheckDefaultSetting()
end

function slot0.SetSDKId(slot0)
	if slot0.isOverSeas_ and _G.TMP_ACCOUNT_ID then
		slot0.sdkIdText_.text = "SDKID:" .. _G.TMP_ACCOUNT_ID
	end
end

function slot0.CheckDefaultSetting(slot0)
	if SettingData:NewDevice() then
		slot0:Go("/graphicRecommend", {
			callback = handler(slot0, slot0.OnGraphicQualitySelect)
		})
	else
		slot0:AwakeName()
	end
end

function slot0.OnGraphicQualitySelect(slot0, slot1, slot2)
	SettingData:SetQualitied()
	SettingAction.ChangePicSetting("picOptionId", slot2)
	slot0:AwakeName()
end

function slot0.AwakeName(slot0)
	if PlayerData:GetPlayerInfo().is_changed_nick < 1 then
		slot0:Go("/awakeName")
	else
		CheckNewGuide()
	end
end

function slot0.UpdateAccount(slot0, slot1, slot2)
	slot0.txtAccount_.text = slot1
	slot0.pwd_ = slot2
end

function slot0.GetAccount(slot0)
	return slot0.txtAccount_.text
end

function slot0.GetPassword(slot0)
	return slot0.pwd_ or PlayerPrefs.GetString("UserPwd")
end

function slot0.Cacheable(slot0)
	return false
end

function slot0.Dispose(slot0)
	slot0.logoController = nil

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
