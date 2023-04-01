slot0 = class("SoundSettingView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.hander_ = slot1
	slot0.transform_ = slot2.transform
	slot0.gameObject_ = slot2
	slot0.info_ = slot3

	slot0:Init()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.soundSlider_ = {}
	slot0.soundText_ = {}
	slot0.soundCutBtn_ = {}
	slot0.soundAddBtn_ = {}

	for slot4 = 1, 3 do
		slot0.soundSlider_[slot4] = slot0["slider" .. slot4 .. "Slr_"]
		slot0.soundText_[slot4] = slot0["num" .. slot4 .. "Text_"]
		slot0.soundCutBtn_[slot4] = slot0["cut" .. slot4 .. "Btn_"]
		slot0.soundAddBtn_[slot4] = slot0["add" .. slot4 .. "Btn_"]
	end

	slot0:InitVoiceLanguageOption()
	slot0:InitTextLanguageOption()
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, 3 do
		slot0:AddToggleListener(slot0.soundSlider_[slot4], function ()
			uv0:SetSoundValue(uv1, uv0.soundSlider_[uv1].value)
		end)
		slot0:AddPressingByTimeListener(slot0.soundCutBtn_[slot4].gameObject, 3, 0.5, 0.5, function ()
			if uv0.soundSlider_[uv1].value > 0 then
				uv0:SetSoundValue(uv1, uv0.soundSlider_[uv1].value - 1)

				return true
			end

			return false
		end)
		slot0:AddPressingByTimeListener(slot0.soundAddBtn_[slot4].gameObject, 3, 0.5, 0.5, function ()
			if uv0.soundSlider_[uv1].value < 100 then
				uv0:SetSoundValue(uv1, uv0.soundSlider_[uv1].value + 1)

				return true
			end

			return false
		end)

		slot5 = slot0:GetOrAddComponent(slot0.soundSlider_[slot4].gameObject, typeof(EventTriggerListener))

		slot5:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function ()
			OperationRecorder.Record("setting", "setting_audio_slide")
		end))
		slot0:SetListener(slot5)
	end

	slot0:AddBtnListener(slot0.switchBtn_, nil, function ()
		if uv0.settingData_.sound_open ~= (uv0.settingData_.sound_open == 1 and 0 or 1) then
			SettingAction.ChangeSoundSetting("sound_open", slot0)
		end
	end)
	slot0:AddToggleListener(slot0.languageDropDown_, function (slot0)
		if VoicePackageManager.Instance:IsHavePackage(VoiceLanguageCfg[AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list[slot0 + 1]].affix) then
			SettingAction.ChangeSoundSetting("voice_language", slot1.voice_list[slot0 + 1])
		elseif LuaForUtil.GetFreeDiskSpace() < VoicePackageManager.Instance:GetPackageSize(slot2.affix) + 200 then
			ShowMessageBox({
				content = GetTips("VOICE_STORAGE_FULL"),
				OkCallback = function ()
					uv0:RefreshVoiceLanguage()
					JumpTools.OpenPageByJump("languagePackage")
				end,
				CancelCallback = function ()
					uv0:RefreshVoiceLanguage()
				end,
				MaskCallback = function ()
					uv0:RefreshVoiceLanguage()
				end
			})
		else
			OpenDownLoadPage(nil, slot2.affix)
		end
	end)
	slot0:AddToggleListener(slot0.textLanguageDropdown_, function (slot0)
		SettingAction.ChangeSoundSetting("text_language", AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].language_list[slot0 + 1])
	end)
	slot0:AddBtnListener(slot0.packageBtn_, nil, function ()
		JumpTools.OpenPageByJump("languagePackage")
	end)
	slot0:AddBtnListener(slot0.switchTeammateBtn_, nil, function ()
		if uv0.settingData_.teammate_sound_open ~= (uv0.settingData_.teammate_sound_open == 1 and 0 or 1) then
			SettingAction.ChangeSoundSetting("teammate_sound_open", slot0)
		end
	end)
end

function slot0.OnDownloaded(slot0, slot1)
	for slot7 = 1, #AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list do
		if VoiceLanguageCfg[slot2.voice_list[slot7]].affix == slot1 then
			SettingAction.ChangeSoundSetting("voice_language", slot7)

			slot0.languageDropDown_.options[slot7 - 1].text = slot9.name

			slot0.languageDropDown_:RefreshShownValue()
		end
	end
end

function slot0.OnCancalDownload(slot0)
	slot0:RefreshVoiceLanguage()
end

function slot0.OnLanguagePackageDeleted(slot0, slot1)
	slot0:RefreshVoiceLanguageOption()
end

function slot0.RefreshUI(slot0)
	slot0.soundSlider_[1].value = slot0.settingData_.music
	slot0.soundText_[1].text = slot0.settingData_.music .. "%"
	slot0.soundSlider_[2].value = slot0.settingData_.effect
	slot0.soundText_[2].text = slot0.settingData_.effect .. "%"
	slot0.soundSlider_[3].value = slot0.settingData_.voice
	slot0.soundText_[3].text = slot0.settingData_.voice .. "%"

	slot0:RefreshSoundSwitch()
	slot0:RefreshVoiceLanguage()
	slot0:RefreshVoiceLanguageOption()
	slot0:RefreshTextLanguage()
	slot0:RefreshTeammateSoundSwitch()
end

function slot0.RefreshSoundSwitch(slot0)
	slot1 = slot0.settingData_.sound_open == 1

	SetActive(slot0.switchOnGo_, slot1)
	SetActive(slot0.switchOffGo_, not slot1)
end

function slot0.RefreshTeammateSoundSwitch(slot0)
	slot1 = slot0.settingData_.teammate_sound_open == 1

	SetActive(slot0.onTeammateGo_, slot1)
	SetActive(slot0.offTeammateGo_, not slot1)
end

function slot0.RefreshSoundSwitch(slot0)
	slot1 = slot0.settingData_.sound_open == 1

	SetActive(slot0.switchOnGo_, slot1)
	SetActive(slot0.switchOffGo_, not slot1)
end

function slot0.InitVoiceLanguageOption(slot0)
	slot0.languageDropDown_:ClearOptions()

	for slot5 = 1, #AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list do
		slot6 = VoiceLanguageCfg[slot1.voice_list[slot5]]
		slot7 = GetI18NText(slot6.name)

		if not VoicePackageManager.Instance:IsHavePackage(slot6.affix) then
			slot7 = string.format("%s(%.2fMB)", slot7, VoicePackageManager.Instance:GetPackageSize(slot6.affix))
		end

		slot0.languageDropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(slot7))
	end
end

function slot0.InitTextLanguageOption(slot0)
	slot0.textLanguageDropdown_:ClearOptions()

	for slot5 = 1, #AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].language_in_list do
		slot0.textLanguageDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(slot1.language_in_list[slot5]))
	end
end

function slot0.RefreshTextLanguage(slot0)
	slot0.textLanguageDropdown_.value = table.indexof(AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].language_list, slot0.settingData_.text_language) - 1
end

function slot0.RefreshVoiceLanguageOption(slot0)
	for slot5 = 1, #AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list do
		slot6 = VoiceLanguageCfg[slot1.voice_list[slot5]]
		slot7 = GetI18NText(slot6.name)

		if not VoicePackageManager.Instance:IsHavePackage(slot6.affix) then
			slot7 = string.format("%s(%.2fMB)", slot7, VoicePackageManager.Instance:GetPackageSize(slot6.affix))
		end

		slot0.languageDropDown_.options[slot5 - 1].text = slot7
	end

	slot0.languageDropDown_:RefreshShownValue()
end

function slot0.RefreshVoiceLanguage(slot0)
	slot0.languageDropDown_.value = table.indexof(AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list, slot0.settingData_.voice_language) - 1
end

function slot0.SetSoundValue(slot0, slot1, slot2)
	if slot1 == 1 then
		SettingAction.ChangeSoundSetting("music", slot2)
	elseif slot1 == 2 then
		SettingAction.ChangeSoundSetting("effect", slot2)
	elseif slot1 == 3 then
		SettingAction.ChangeSoundSetting("voice", slot2)
	end
end

function slot0.CheckDataChange(slot0, slot1)
	if slot0.tmpSettingData_ and not table.equal(slot0.tmpSettingData_, slot0.settingData_, "all") then
		return true
	end

	return false
end

function slot0.SaveData(slot0)
	if slot0:CheckDataChange() then
		slot0.json_ = require("cjson")
		slot1 = deepClone(slot0.settingData_)
		slot1.type = 2

		SDKTools.SendMessageToSDK("audio_setting", {
			bg_audio_setting = slot0.settingData_.music,
			effect_setting = slot0.settingData_.effect,
			sound_setting = slot0.settingData_.voice,
			language = slot0.settingData_.voice_language
		})
		manager.net:Push(38006, {
			format_data = slot0.json_.encode(slot1)
		})
	end

	slot0.tmpSettingData_ = deepClone(slot0.settingData_)
end

function slot0.RecoverTmpData(slot0)
	if slot0:CheckDataChange() then
		if not VoicePackageManager.Instance:IsHavePackage(VoiceLanguageCfg[slot0.tmpSettingData_.voice_language].affix) then
			slot0.tmpSettingData_.voice_language = slot0.settingData_.voice_language
		end

		SettingAction.ChangeSoundSetting("allData", slot0.tmpSettingData_)
	end
end

function slot0.OnSoundSettingChange(slot0, slot1, slot2)
	slot0:RefreshUI()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:OnEnter()
end

function slot0.OnEnter(slot0)
	slot0.settingData_ = SettingData:GetSoundSettingData()

	slot0:RefreshUI()

	slot0.tmpSettingData_ = deepClone(slot0.settingData_)
	slot1 = slot0.hander_.params_.setType or SettingConst.SETTING_TYPE.SYSTEM

	SetActive(slot0.languageDropDown_.gameObject, slot1 == SettingConst.SETTING_TYPE.SYSTEM)
	SetActive(slot0.packageBtn_.gameObject, slot1 == SettingConst.SETTING_TYPE.SYSTEM)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.hander_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
