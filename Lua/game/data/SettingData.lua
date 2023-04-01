slot0 = singletonClass("SettingData")
slot1 = {}
slot2 = false

function slot0.NewDevice(slot0)
	return uv0
end

function slot0.SetQualitied(slot0)
	uv0 = false
end

function slot0.InitSetting(slot0)
	slot2 = nil
	slot3 = {}

	if GameLocalData:GetCommonModule("userSetting").picOptionId == nil then
		uv0 = true
		slot3 = PictureQualitySettingCfg[5]
	end

	slot5 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]

	if not table.indexof(slot5.language_list, slot1.text_language or slot5.language_list[1]) then
		slot6 = slot5.language_list[1]
	end

	if not table.indexof(slot5.voice_list, slot1.voice_language or slot5.voice_list[1]) then
		slot7 = slot5.voice_list[1]
	end

	uv1 = {
		pic = {
			picOptionId = slot1.picOptionId or slot2,
			resolution = slot1.resolution or slot3.resolution,
			teammate_effect = slot1.teammate_effect or slot3.teammate_effect,
			frame = slot1.frame or slot3.frame,
			hdr = slot1.hdr or slot3.hdr,
			anti_aliasing = slot1.anti_aliasing or slot3.anti_aliasing,
			reflection_effect = slot1.reflection_effect or slot3.reflection_effect
		},
		sound = {
			music = slot1.music or 50,
			effect = slot1.effect or 50,
			voice = slot1.voice or 50,
			sound_open = slot1.sound_open or 1,
			teammate_sound_open = slot1.teammate_sound_open or 1,
			voice_language = slot7,
			text_language = slot6
		},
		push = {
			push_btn = slot1.push_btn or 1,
			expedition_success = slot1.expedition_success or 1,
			fatigue_recovery_full = slot1.fatigue_recovery_full or 1,
			fatigue_receive = slot1.fatigue_receive or 1
		},
		game = {
			battle_hit_num_mine = slot1.battle_hit_num_mine or 1,
			battle_hit_num_teammate = slot1.battle_hit_num_teammate or 1,
			battle_lock_type = slot1.battle_lock_type or 0,
			adapter_value = slot1.adapter_value or 60,
			moveable_stick = slot1.moveable_stick or 1,
			cus_full_play_controlled_type = slot1.cus_full_play_controlled_type or 0
		},
		battleUI = {
			battle_ui_cur_type = slot1.battle_ui_cur_type or "",
			battle_ui_cur_alpha_value = slot1.battle_ui_cur_alpha_value or 1,
			battle_ui_cur_rotate_speed = slot1.battle_ui_cur_rotate_speed or 0.5,
			battle_ui_type_0 = slot1.battle_ui_type_0 or "",
			battle_ui_alpha_0 = slot1.battle_ui_alpha_0 or 1,
			battle_ui_rotate_speed_0 = slot1.battle_ui_rotate_speed_0 or 0.5,
			battle_ui_type_1 = slot1.battle_ui_type_1 or "",
			battle_ui_alpha_1 = slot1.battle_ui_alpha_1 or 1,
			battle_ui_rotate_speed_1 = slot1.battle_ui_rotate_speed_1 or 0.5,
			battle_ui_type_2 = slot1.battle_ui_type_2 or "",
			battle_ui_alpha_2 = slot1.battle_ui_alpha_2 or 1,
			battle_ui_rotate_speed_2 = slot1.battle_ui_rotate_speed_2 or 0.5,
			battle_ui_type_3 = slot1.battle_ui_type_3 or "",
			battle_ui_alpha_3 = slot1.battle_ui_alpha_3 or 1,
			battle_ui_rotate_speed_3 = slot1.battle_ui_rotate_speed_3 or 0.5
		},
		remind = {
			activity_sign_reminder = slot1.activity_sign_reminder or 1,
			month_card_reminder = slot1.month_card_reminder or 1,
			fatigue_full_reminder = slot1.fatigue_full_reminder or 1,
			diamond_buy_item_reminder = slot1.diamond_buy_item_reminder or 1,
			core_equip_buy_item_reminder = slot1.core_equip_buy_item_reminder or 1,
			info_badge_top_buy_item_reminder = slot1.info_badge_top_buy_item_reminder or 1,
			boss_challenge_s_buy_item_reminder = slot1.boss_challenge_s_buy_item_reminder or 1,
			diamond_buy_fatigue_reminder = slot1.diamond_buy_fatigue_reminder or 0,
			diamond_buy_gold_reminder = slot1.diamond_buy_gold_reminder or 0,
			spirit_refine_reminder = slot1.spirit_refine_reminder or 1,
			servant_promote_reminder = slot1.servant_promote_reminder or 1,
			refresh_enchantment_times_reminder = slot1.refresh_enchantment_times_reminder or 1,
			uninstall_equip_reminder = slot1.uninstall_equip_reminder or 1,
			rebuild_hero_equip_reminder = slot1.rebuild_hero_equip_reminder or 1
		}
	}

	if slot4 then
		slot0:SaveData("pic", uv1.pic)
		slot0:SaveData("battle_hit_num_mine", 1)
		slot0:SaveData("battle_hit_num_teammate", 1)
		slot0:SaveData("battle_lock_type", 0)
		slot0:SaveData("moveable_stick", 1)
		slot0:SaveData("cus_full_play_controlled_type", 0)
		slot0:SaveData("battle_ui_cur_type", "")
		slot0:SaveData("battle_ui_type_0", "")
		slot0:SaveData("battle_ui_type_1", "")
		slot0:SaveData("battle_ui_type_2", "")
		slot0:SaveData("battle_ui_type_3", "")
		slot0:SaveData("battle_ui_cur_alpha_value", 1)
		slot0:SaveData("battle_ui_alpha_0", 1)
		slot0:SaveData("battle_ui_alpha_1", 1)
		slot0:SaveData("battle_ui_alpha_2", 1)
		slot0:SaveData("battle_ui_alpha_3", 1)
		slot0:SaveData("battle_ui_cur_rotate_speed", 0.5)
		slot0:SaveData("battle_ui_rotate_speed_0", 0.5)
		slot0:SaveData("battle_ui_rotate_speed_1", 0.5)
		slot0:SaveData("battle_ui_rotate_speed_2", 0.5)
		slot0:SaveData("battle_ui_rotate_speed_3", 0.5)
	end

	if uv1.sound and uv1.sound.voice_language and VoiceLanguageCfg[uv1.sound.voice_language] and not VoicePackageManager.Instance:IsHavePackage(slot8.affix) then
		slot9 = VoicePackageManager.Instance:GetValidPackage()

		for slot14 = 1, #VoiceLanguageCfg.all do
			if VoiceLanguageCfg[slot14].affix == slot9 then
				uv1.sound.voice_language = slot14
			end
		end
	end
end

function slot0.ModifyPicSetting(slot0, slot1, slot2)
	if slot1 == "picOptionId" and slot2 ~= SettingConst.GRAPHIC_CUSTOM_ID or slot1 == "allData" then
		slot3 = slot1 == "picOptionId" and PictureQualitySettingCfg[slot2] or slot2
		uv0.pic.picOptionId = slot3.picOptionId or slot3.id
		uv0.pic.resolution = slot3.resolution
		uv0.pic.frame = slot3.frame
		uv0.pic.hdr = slot3.hdr
		uv0.pic.anti_aliasing = slot3.anti_aliasing
		uv0.pic.reflection_effect = slot3.reflection_effect
		uv0.pic.teammate_effect = slot3.teammate_effect

		slot0:SaveData("pic", uv0.pic)
	else
		uv0.pic[slot1] = slot2
		uv0.pic.picOptionId = SettingConst.GRAPHIC_CUSTOM_ID

		slot0:SaveData(slot1, slot2)
		slot0:SaveData("picOptionId", SettingConst.GRAPHIC_CUSTOM_ID)
	end
end

function slot0.ModifySoundSetting(slot0, slot1, slot2)
	if slot1 == "allData" then
		for slot6, slot7 in pairs(uv0.sound) do
			uv0.sound[slot6] = slot2[slot6]

			slot0:SaveData(slot1, slot2)
		end
	else
		uv0.sound[slot1] = slot2

		slot0:SaveData(slot1, slot2)
	end
end

function slot0.ModifyPushSetting(slot0, slot1, slot2)
	uv0.push[slot1] = slot2

	slot0:SaveData(slot1, slot2)
end

function slot0.ModifyGameSetting(slot0, slot1, slot2)
	if slot1 == "allData" then
		for slot6, slot7 in pairs(uv0.game) do
			uv0.game[slot6] = slot2[slot6]

			slot0:SaveData(slot1, slot2)
		end
	else
		uv0.game[slot1] = slot2

		slot0:SaveData(slot1, slot2)
	end
end

function slot0.ModifyBattleUISetting(slot0, slot1, slot2)
	if slot1 == "allData" then
		for slot6, slot7 in pairs(uv0.battleUI) do
			uv0.battleUI[slot6] = slot2[slot6]

			slot0:SaveData(slot6, slot2[slot6])
		end
	else
		uv0.battleUI[slot1] = slot2

		slot0:SaveData(slot1, slot2)
	end
end

function slot0.ModifyRemindSetting(slot0, slot1, slot2)
	if slot1 == "allData" then
		for slot6, slot7 in pairs(uv0.remind) do
			uv0.remind[slot6] = slot2[slot6]

			slot0:SaveData(slot6, slot2[slot6])
		end
	else
		uv0.remind[slot1] = slot2

		slot0:SaveData(slot1, slot2)
	end
end

function slot0.SaveData(slot0, slot1, slot2)
	if slot1 == "pic" then
		GameLocalData:SaveToCommonModule("userSetting", "picOptionId", slot2.picOptionId)
		GameLocalData:SaveToCommonModule("userSetting", "resolution", slot2.resolution)
		GameLocalData:SaveToCommonModule("userSetting", "frame", slot2.frame)
		GameLocalData:SaveToCommonModule("userSetting", "hdr", slot2.hdr)
		GameLocalData:SaveToCommonModule("userSetting", "anti_aliasing", slot2.anti_aliasing)
		GameLocalData:SaveToCommonModule("userSetting", "reflection_effect", slot2.reflection_effect)
		GameLocalData:SaveToCommonModule("userSetting", "teammate_effect", slot2.teammate_effect)
	else
		GameLocalData:SaveToCommonModule("userSetting", slot1, slot2)
	end

	slot0:ApplyToBattle(slot1, slot2)
end

function slot0.ApplyToBattle(slot0, slot1, slot2)
	if slot1 == "pic" then
		PlayerPrefs.SetInt("allowHDR", slot2.hdr)
		PlayerPrefs.SetInt("frame", slot2.frame)
		PlayerPrefs.SetInt("allowMSAA", slot2.anti_aliasing)
	elseif slot1 == "hdr" then
		PlayerPrefs.SetInt("allowHDR", slot2)
	elseif slot1 == "anti_aliasing" then
		PlayerPrefs.SetInt("allowMSAA", slot2)
	elseif slot1 == "frame" then
		PlayerPrefs.SetInt("frame", slot2)
	elseif slot1 == "battle_hit_num_mine" then
		PlayerPrefs.SetInt("battle_hit_num_mine", slot2)
	elseif slot1 == "battle_hit_num_teammate" then
		PlayerPrefs.SetInt("battle_hit_num_teammate", slot2)
	elseif slot1 == "battle_lock_type" then
		PlayerPrefs.SetInt("battle_lock_type", slot2)
	elseif slot1 == "battle_ui_cur_type" then
		PlayerPrefs.SetString("battle_ui_cur_type", slot2)
	elseif slot1 == "battle_ui_cur_alpha_value" then
		PlayerPrefs.SetFloat("battle_ui_cur_alpha_value", slot2)
	elseif slot1 == "battle_ui_cur_rotate_speed" then
		PlayerPrefs.SetFloat("battle_ui_cur_rotate_speed", slot2)
	elseif slot1 == "moveable_stick" then
		PlayerPrefs.SetInt("moveable_stick", slot2)
	elseif slot1 == "cus_full_play_controlled_type" then
		PlayerPrefs.SetInt("CooperateUniqueSkillFullPlayControlledType", slot2)
	end
end

function slot0.GetSettingData(slot0)
	return uv0
end

function slot0.GetPicSettingData(slot0)
	return uv0.pic
end

function slot0.GetSoundSettingData(slot0)
	return uv0.sound
end

function slot0.GetGameSettingData(slot0)
	return uv0.game
end

function slot0.GetCurrentLanguage(slot0)
	return uv0.sound.text_language
end

function slot0.GetCurrentLanguageKey(slot0)
	return "@" .. uv0.sound.text_language
end

function slot0.GetBattleUISettingData(slot0)
	return uv0.battleUI
end

function slot0.GetRemindSettingData(slot0)
	return uv0.remind
end

function slot0.GetDefaultSetting(slot0)
	if GameToSDK.PLATFORM_ID == 1 then
		if UnityEngine.SystemInfo.systemMemorySize > 2048 then
			return 5
		else
			return 4
		end
	end

	if UnityEngine.SystemInfo.systemMemorySize > 4096 and UnityEngine.SystemInfo.processorCount > 4 and UnityEngine.SystemInfo.processorFrequency > 2000 and UnityEngine.SystemInfo.supports2DArrayTextures and UnityEngine.SystemInfo.supports3DTextures and UnityEngine.SystemInfo.supportsComputeShaders and UnityEngine.SystemInfo.graphicsMemorySize > 1024 then
		return 5
	end

	return 4
end

return slot0
