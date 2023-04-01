function OnExchangeCodeCallBack(slot0, slot1)
	if slot0 then
		print("Lua OnExchangeCodeCallBack Success")
	else
		print("Lua OnExchangeCodeCallBack" .. slot1)
	end

	SetForceShowQuanquan(false)
	manager.notify:CallUpdateFunc(ON_EXCHANGE_CODE, slot0, slot1)
end

GameToSDK.RegisterGiftCodeResultEvent(OnExchangeCodeCallBack)

return {
	ChangePicSetting = function (slot0, slot1)
		SettingData:ModifyPicSetting(slot0, slot1)
		uv0.DeployPicSetting(slot0, slot1)
		manager.notify:CallUpdateFunc(PIC_SETTING_CHANGE, {}, {
			key = slot0,
			data = slot1
		})
	end,
	ChangeSoundSetting = function (slot0, slot1)
		SettingData:ModifySoundSetting(slot0, slot1)
		uv0.DeploySoundSetting(slot0, slot1)
		manager.notify:CallUpdateFunc(SOUND_SETTING_CHANGE, {}, {
			key = slot0,
			data = slot1
		})
	end,
	ChangePushSetting = function (slot0, slot1)
		SettingData:ModifyPushSetting(slot0, slot1)
		manager.notify:CallUpdateFunc(PUSH_SETTING_CHANGE, {}, {
			key = slot0,
			data = slot1
		})
	end,
	ChangeGameSetting = function (slot0, slot1)
		SettingData:ModifyGameSetting(slot0, slot1)
		uv0.DeployGameSetting(slot0, slot1)
		manager.notify:CallUpdateFunc(GAME_SETTING_CHANGE, {}, {
			key = slot0,
			data = slot1
		})
	end,
	ChangeRemindSetting = function (slot0, slot1)
		SettingData:ModifyRemindSetting(slot0, slot1)
		manager.notify:CallUpdateFunc(REMIND_SETTING_CHANGE, {}, {
			key = slot0,
			data = slot1
		})
	end,
	DeployPicSetting = function (slot0, slot1)
		slot2 = {}

		if slot0 == "picOptionId" and slot1 ~= SettingConst.GRAPHIC_CUSTOM_ID then
			slot3 = PictureQualitySettingCfg[slot1]
			slot2.picOptionId = slot3.id
			slot2.resolution = slot3.resolution
			slot2.frame = slot3.frame
			slot2.hdr = slot3.hdr
			slot2.high_quality = slot3.high_quality
			slot2.anti_aliasing = slot3.anti_aliasing
			slot2.distortion_effect = slot3.distortion_effect
			slot2.reflection_effect = slot3.reflection_effect
			slot2.physical_simulation = slot3.physical_simulation
			slot2.teammate_effect = slot3.teammate_effect
		elseif slot0 == "allData" then
			slot2 = slot1
		else
			slot2[slot0] = slot1
		end

		slot3 = manager.ui.cameraExtension

		if slot2.resolution then
			slot5, slot6 = SettingTools.GetSettingScreenSize(tonumber(slot2.resolution))

			Screen.SetResolution(slot5, slot6, true)
		elseif slot2.hdr then
			slot3.hdr = slot2.hdr == 1
		elseif slot2.anti_aliasing then
			if PlayerPrefs.GetInt("allowMSAA") == 0 then
				UnityEngine.Pipelines.SimPipeline.SimPipelineSettings.AliasingEnable = false
			else
				UnityEngine.Pipelines.SimPipeline.SimPipelineSettings.AliasingEnable = true
			end
		elseif slot2.frame then
			Application.targetFrameRate = slot2.frame == 0 and 30 or slot2.frame == 1 and 60 or 120
		end
	end,
	DeploySoundSetting = function (slot0, slot1)
		if slot0 == "allData" then
			for slot5, slot6 in pairs(slot1) do
				uv0.ChangeSingleSoundSetting(slot5, slot6)
			end
		else
			uv0.ChangeSingleSoundSetting(slot0, slot1)
		end
	end,
	ChangeSingleSoundSetting = function (slot0, slot1)
		if slot0 == "music" or slot0 == "effect" or slot0 == "voice" then
			manager.audio:SetVolume(slot0, slot1 / 100)
		elseif slot0 == "sound_open" then
			manager.audio:SetAudioMasterMute(slot1 == 0)
		elseif slot0 == "voice_language" then
			if VoiceLanguageCfg[slot2.voice_list[table.indexof(AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list, slot1) or 1]] then
				manager.audio:SetLocalizationFlag(slot4.affix)
			end
		elseif slot0 == "teammate_sound_open" then
			AudioManager.BattleTeammateVoiceSwitch = slot1 == 1
		elseif slot0 == "text_language" then
			PlayerPrefs.SetString("text_language", slot1)
			ReduxFactory.GetInstance():ClearCacheViews()
			LuaForUtil.RefreshI18NText(manager.ui.uiMain)
		end
	end,
	DeployGameSetting = function (slot0, slot1)
		if slot0 == "allData" then
			for slot5, slot6 in pairs(slot1) do
				uv0.ChangeSingleGameSetting(slot5, slot6)
			end
		else
			uv0.ChangeSingleGameSetting(slot0, slot1)
		end
	end,
	ChangeSingleGameSetting = function (slot0, slot1)
		if slot0 == "adapter_value" then
			ReduxView.VIEW_ADAPT_DISTANCE = slot1

			for slot6, slot7 in pairs(gameContext:GetAllOpenPage()) do
				if slot7.AdaptScreen then
					slot7.AdaptScreen(slot7)
				end
			end

			if manager.managerInit and manager.windowBar:IsInited() then
				manager.windowBar:AdaptScreen()
			end
		end
	end,
	ExchangeCode = function (slot0, slot1)
		slot2 = PlayerData:GetPlayerInfo()
		slot3 = slot2.userID .. "_" .. slot2.signUserId

		GameToSDK.ExChangeGiftCode(slot3, slot0)
		print("ExchangeCode:" .. slot3)
		SetForceShowQuanquan(true)
	end
}
