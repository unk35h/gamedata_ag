slot1 = nil

return {
	SetUpMusic = function ()
		SceneManager.SetActiveScene(SceneManager.GetSceneByName("X106"))
		manager.uiInit()

		if MusicConst.MusicViewType.Enternal == MusicData:GetMusicViewType(ActivityMusicCfg[MusicData:GetGameId()].activity_id) then
			JumpTools.OpenPageByJump("/enternalMusicGame")
		elseif MusicConst.MusicViewType.Volume == slot3 then
			JumpTools.OpenPageByJump("/volumeMusicGame")
		end

		whereami = "battle"

		manager.audio:DestoryCriAtom()
		manager.audio:SetEffectAisacControl("musicgame_hitsound_volume", MusicData:GetVolumeData())
		manager.ui:SetMainCamera("music")

		slot4 = manager.ui.mainCameraCom_
		slot6 = nil
		slot8 = (GameObject.Find("gameRoot/center") and 2 * math.abs(manager.ui.mainCamera.transform:InverseTransformPoint(slot7.transform.position).z) * Mathf.Tan(slot4.fieldOfView * 0.5 * Mathf.Deg2Rad) * slot4.aspect or 40) / 5
		slot9 = slot8 / 2
		slot10 = -22.9
		slot11 = 0
		slot12 = Vector3.New(slot8, 99, 0.2)
		slot13 = Vector3.New(slot8 * 1.3, 99, 0.2)

		if GameObject.Find("Music/gameRoot/Track1") then
			slot14.transform.localPosition = Vector3.New(-slot8 * 1.5, slot10, 0)
			slot15 = slot14:GetComponent("BoxCollider")
			slot15.size = slot13
			slot15.center = Vector3.New(-slot8 * 0.15, 0, 0)

			if slot14.transform:Find("bg/leftLine") then
				slot17.localPosition = Vector3.New(-1 * slot9 + slot11, 0, 0)
			end

			if slot16:Find("bg/line") then
				slot18.localPosition = Vector3.New(slot9 + slot11, 0, 0)
			end

			if slot16:Find("bg/clickEffect/eff_glow/glow") then
				slot19:GetComponent("SpriteRenderer").size = Vector2.New(slot8 + 0.1, 5.12)
			end
		end

		if GameObject.Find("Music/gameRoot/Track2") then
			slot15.transform.localPosition = Vector3.New(-slot8 * 0.5, slot10, 0)
			slot15:GetComponent("BoxCollider").size = slot12

			if slot15.transform:Find("bg/line") then
				slot17.localPosition = Vector3.New(slot9 + slot11, 0, 0)
			end

			if slot16:Find("bg/clickEffect/eff_glow/glow") then
				slot18:GetComponent("SpriteRenderer").size = Vector2.New(slot8 + 0.1, 5.12)
			end
		end

		if GameObject.Find("Music/gameRoot/Track3") then
			slot16.transform.localPosition = Vector3.New(slot8 * 0.5, slot10, 0)
			slot16:GetComponent("BoxCollider").size = slot12

			if slot16.transform:Find("bg/line") then
				slot18.localPosition = Vector3.New(slot9 + slot11, 0, 0)
			end

			if slot17:Find("bg/clickEffect/eff_glow/glow") then
				slot19:GetComponent("SpriteRenderer").size = Vector2.New(slot8 + 0.1, 5.12)
			end
		end

		if GameObject.Find("Music/gameRoot/Track4") then
			slot17.transform.localPosition = Vector3.New(slot8 * 1.5, slot10, 0)
			slot18 = slot17:GetComponent("BoxCollider")
			slot18.size = slot13
			slot18.center = Vector3.New(slot8 * 0.15, 0, 0)

			if slot17.transform:Find("bg/line") then
				slot20.localPosition = Vector3.New(slot9 + slot11, 0, 0)
			end

			if slot19:Find("bg/clickEffect/eff_glow/glow") then
				slot21:GetComponent("SpriteRenderer").size = Vector2.New(slot8 + 0.1, 5.12)
			end
		end

		if GameObject.Find("Music/background/frame") then
			slot18:GetComponent("SpriteRenderer").size = Vector2.New(slot8 * 4, 3.3)
		end

		if GameObject.Find("Music/background/mask") then
			slot19:GetComponent("SpriteRenderer").size = Vector2.New(slot8 * 4 - 0.1, 999)
		end

		slot20 = 400 * Mathf.Tan(slot4.fieldOfView * 0.5 * Mathf.Deg2Rad)
		slot24 = math.max(slot20 * slot4.aspect / 234, slot20 / 108)

		if GameObject.Find("movie") then
			if MusicData:GetShowMovie() then
				SetActive(slot25, true)

				slot26 = slot25.transform

				slot26:SetParent(manager.ui.mainCamera.transform)

				slot26.localPosition = Vector3(0, 0, 200)
				slot26.localEulerAngles = Vector3(0, 0, 0)
				slot26.localScale = Vector3.New(slot24 * 234, slot24 * 108, 1)
			else
				SetActive(slot25, false)
			end
		end

		if GameObject.Find("object/long/bg") then
			slot26.transform.localScale = Vector3.New(slot8 / 3.9, 1, 1)
		end

		if GameObject.Find("object/short") then
			slot27.transform.localScale = Vector3.New(slot8 / 7.5, 1, 1)
		end
	end,
	OnMusicSceneLoaded = function ()
		uv0 = GameLocalData:GetCommonModule("userSetting").frame or PictureQualitySettingCfg[5].frame

		if uv0 == 0 then
			SettingAction.ChangePicSetting("frame", 1)
		end

		MusicLuaBridge.StartMusicGame()
		manager.notify:CallUpdateFunc(MUSIC_SCENE_LOADED)
	end,
	OnMusicSceneExit = function ()
		if uv0 == 0 then
			SettingAction.ChangePicSetting("frame", 0)
		end

		whereami = "home"

		if SettingData:GetSoundSettingData() and slot0.music then
			manager.audio:SetVolume("music", slot0.music / 100)
		end
	end,
	MusicInitPlay = function ()
		MusicData:ResetGameData()
		manager.notify:CallUpdateFunc(MUSIC_INIT_PLAY)

		if SettingData:GetSoundSettingData() and slot0.music then
			manager.audio:SetVolume("music", slot0.music / 100)
		end
	end,
	MusicNodeHit = function (slot0, slot1)
		MusicData:ModifGameData(slot0)
		manager.notify:CallUpdateFunc(MUSIC_NODE_HIT, slot0, slot1)
	end,
	MusicSetNodeHit = function (slot0, slot1)
		MusicData:ModifGameData(slot0)
		manager.notify:CallUpdateFunc(MUSIC_SET_NODE_HIT, slot0, slot1)
	end,
	OnMusicOver = function ()
		slot0 = MusicData:GetGameScore()

		if MusicData:GetGameId() == 0 then
			MusicAction.GoToMusicMain()

			return
		end

		MusicAction.QueryCompelet(slot1, slot0)
	end,
	OnMusicActiveExit = function ()
		MusicAction.GoToMusicMain()
	end,
	OnMusicPause = function ()
		if MusicConst.MusicViewType.Enternal == MusicData:GetMusicViewType(ActivityMusicCfg[MusicData:GetGameId()].activity_id) then
			JumpTools.OpenPageByJump("enternalMusicStop")
		elseif MusicConst.MusicViewType.Volume == slot2 then
			JumpTools.OpenPageByJump("volumeMusicstop")
		end

		if GameObject.Find("movie") then
			slot3:GetComponent("CriManaMovieMaterial"):Pause(true)
		end
	end
}
