slot0 = import("game.const.SettingConst")

return function (slot0, slot1)
	if slot0 == nil then
		slot0 = {
			pic = {
				picOptionId = GameLocalData:GetCommonModule("userSetting").picOptionId or 4,
				resolution = slot2.resolution or 2,
				aiEffectQuality = slot2.aiEffectQuality or 1,
				frame = slot2.frame or 0,
				hdr = slot2.hdr or 1,
				high_quality = slot2.high_quality or 1,
				anti_aliasing = slot2.anti_aliasing or 1,
				distortion_effect = slot2.distortion_effect or 1,
				reflection_effect = slot2.reflection_effect or 1,
				physical_simulation = slot2.physical_simulation or 1,
				contrast = slot2.contrast or 0
			},
			sound = {
				music = slot2.sound_music or 50,
				effect = slot2.sound_effect or 50,
				voice = slot2.sound_voice or 50
			},
			push = {
				push_btn = slot2.push_btn or 1,
				expedition_success = slot2.expedition_success or 1,
				fatigue_recovery_full = slot2.fatigue_recovery_full or 1,
				fatigue_receive = slot2.fatigue_receive or 1
			},
			game = {
				battle_hit_num_mine = slot2.battle_hit_num_mine or 1,
				battle_hit_num_teammate = slot2.battle_hit_num_teammate or 1,
				battle_effect_teammate = slot2.battle_effect_teammate or 1,
				battle_skill_feature = slot2.battle_skill_feature or 1
			}
		}
	end

	if ({
		[ACTIONS.SETTING_PIC_MODIFY] = function (slot0)
			if uv0.data.settingType == uv1.SETTING_PIC_RESOLUTION then
				slot0.pic.resolution = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "resolution", uv0.data.val)
			elseif uv0.data.settingType == uv1.SETTING_PIC_FRAME then
				slot0.pic.frame = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "frame", uv0.data.val)

				Application.targetFrameRate = tostring(uv0.data.val) == "0" and 30 or tostring(uv0.data.val) == "1" and 60 or 120
			elseif uv0.data.settingType == uv1.SETTING_PIC_HDR then
				slot0.pic.hdr = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "hdr", uv0.data.val)
			elseif uv0.data.settingType == uv1.SETTING_PIC_HIGH_QUALITY then
				slot0.pic.high_quality = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "high_quality", uv0.data.val)
			elseif uv0.data.settingType == uv1.SETTING_PIC_ANTI_ALIASING then
				slot0.pic.anti_aliasing = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "anti_aliasing", uv0.data.val)
			elseif uv0.data.settingType == uv1.SETTING_PIC_DISTORTION_EFFECT then
				slot0.pic.distortion_effect = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "distortion_effect", uv0.data.val)
			elseif uv0.data.settingType == uv1.SETTING_PIC_REFLECTION_EFFECT then
				slot0.pic.reflection_effect = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "reflection_effect", uv0.data.val)
			elseif uv0.data.settingType == uv1.SETTING_PIC_PHYSICAL_SIMULATION then
				slot0.pic.physical_simulation = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "physical_simulation", uv0.data.val)
			elseif uv0.data.settingType == uv1.SETTING_PIC_AI_EFFECT_QUALITY then
				slot0.pic.aiEffectQuality = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "aiEffectQuality", uv0.data.val)
			end
		end,
		[ACTIONS.SETTING_CONTRAST_MODIFY] = function (slot0)
			if uv0.data.settingType == uv1.SETTING_PIC_CONTRAST then
				slot0.pic.contrast = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "contrast", uv0.data.val)
			end
		end,
		[ACTIONS.SETTING_SOUND_MODIFY] = function (slot0)
			if uv0.data.settingType == uv1.SETTING_SOUND_MUSIC then
				slot0.sound.music = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "sound_music", uv0.data.val)
			elseif uv0.data.settingType == uv1.SETTING_SOUND_EFFECT then
				slot0.sound.effect = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "sound_effect", uv0.data.val)
			elseif uv0.data.settingType == uv1.SETTING_SOUND_VOICE then
				slot0.sound.voice = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "sound_voice", uv0.data.val)
			end
		end,
		[ACTIONS.SETTING_PUSH_MODIFY] = function (slot0)
			if uv0.data.settingType == uv1.SETTING_PUSH_BTN then
				slot0.push.push_btn = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "push_btn", uv0.data.val)
			elseif uv0.data.settingType == uv1.SETTING_PUSH_EXPEDITION_SUCCESS then
				slot0.push.expedition_success = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "expedition_success", uv0.data.val)
			elseif uv0.data.settingType == uv1.SETTING_PUSH_FATIGUE_RECOVERY_FULL then
				slot0.push.fatigue_recovery_full = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "fatigue_recovery_full", uv0.data.val)
			elseif uv0.data.settingType == uv1.SETTING_PUSH_FATIGUE_RECEIVE then
				slot0.push.fatigue_receive = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "fatigue_receive", uv0.data.val)
			end
		end,
		[ACTIONS.SETTING_GAME_MODIFY] = function (slot0)
			if uv0.data.settingType == uv1.SETTING_GAME_BATTLE_HIT_NUM_MINE then
				slot0.game.battle_hit_num_mine = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "battle_hit_num_mine", uv0.data.val)
			elseif uv0.data.settingType == uv1.SETTING_GAME_BATTLE_HIT_NUM_TEAMMATE then
				slot0.game.battle_hit_num_teammate = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "battle_hit_num_teammate", uv0.data.val)
			elseif uv0.data.settingType == uv1.SETTING_GAME_BATTLE_EFFECT_TEAMMATE then
				slot0.game.battle_effect_teammate = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "battle_effect_teammate", uv0.data.val)
			elseif uv0.data.settingType == uv1.SETTING_GAME_BATTLE_SKILL_FEATURE then
				slot0.game.battle_skill_feature = uv0.data.val

				GameLocalData:SaveToCommonModule("userSetting", "battle_skill_feature", uv0.data.val)
			end
		end,
		[ACTIONS.SETTING_PIC_DEFAULT] = function (slot0)
			slot0.pic.picOptionId = uv0.data

			GameLocalData:SaveToCommonModule("userSetting", "picOptionId", uv0.data)

			if PictureQualitySettingCfg[uv0.data] then
				slot0.pic.resolution = slot1.resolution

				GameLocalData:SaveToCommonModule("userSetting", "resolution", slot1.resolution)

				slot0.pic.frame = slot1.frame

				GameLocalData:SaveToCommonModule("userSetting", "frame", slot1.frame)

				slot0.pic.hdr = slot1.hdr

				GameLocalData:SaveToCommonModule("userSetting", "hdr", slot1.hdr)

				slot0.pic.high_quality = slot1.high_quality

				GameLocalData:SaveToCommonModule("userSetting", "high_quality", slot1.high_quality)

				slot0.pic.anti_aliasing = slot1.anti_aliasing

				GameLocalData:SaveToCommonModule("userSetting", "anti_aliasing", slot1.anti_aliasing)

				slot0.pic.distortion_effect = slot1.distortion_effect

				GameLocalData:SaveToCommonModule("userSetting", "distortion_effect", slot1.distortion_effect)

				slot0.pic.reflection_effect = slot1.reflection_effect

				GameLocalData:SaveToCommonModule("userSetting", "reflection_effect", slot1.reflection_effect)

				slot0.pic.physical_simulation = slot1.physical_simulation

				GameLocalData:SaveToCommonModule("userSetting", "physical_simulation", slot1.physical_simulation)

				slot0.pic.aiEffectQuality = slot1.teammate_effect

				GameLocalData:SaveToCommonModule("userSetting", "aiEffectQuality", slot1.teammate_effect)
				GameLocalData:SaveToCommonModule("userSetting", "nowChosen", uv0.data)
			end
		end
	})[slot1.type] then
		return immer.produce(slot0, function (slot0)
			uv0[uv1.type](slot0)
		end)
	else
		return slot0
	end
end
