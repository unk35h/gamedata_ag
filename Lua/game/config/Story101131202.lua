return {
	Play113122001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7

		if ({
			ja = 7,
			zh = 6.833
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.F02_1 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.F02_1
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "F02_1" then
						slot11.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot4 = 2

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot6 = Color.New(0, 0, 0)
				slot6.a = Mathf.Lerp(1, 0, (uv0.time_ - slot3) / slot4)
				uv0.mask_.color = slot6
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot5 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot5.a = 0
				uv0.mask_.color = slot5
			end

			slot6 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot8 = 0.566666666666667

			if 2 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:AudioAction("play", "music", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot10 = 0.3

			if 2 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialog_:SetActive(true)

				uv0.dialog_.transform.localScale = Vector3(0.8, 0.95, 1)

				LeanTween.scale(uv0.dialog_, Vector3.one, 0.2)

				slot11 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot11:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot11:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_6045")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122001].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122001", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122001", "story_v_out_113122.awb") / 1000 > 0 and slot10 < slot15 and uv0.duration_ < slot15 + slot9 then
						slot10 = slot15
						uv0.duration_ = slot15 + slot9
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						uv0:RecordAudio("113122001", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_113122", "113122001", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122001", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot9 = slot9 + 0.3
			slot12 = uv0:FormatText(StoryWordCfg[113122001].content)
			slot14 = string.split(slot12, ".")

			if #string.split(slot12, "\n") >= 4 or #slot14 >= 4 then
				slot10 = slot10 * 3
			end

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.65

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122002].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[113122002].content)
			slot6 = string.split(slot4, ".")

			if #string.split(slot4, "\n") >= 4 or #slot6 >= 4 then
				slot2 = slot2 * 3
			end

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.766

		if ({
			ja = 3.766,
			zh = 3.3
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["6046_story"] == nil then
				slot2 = Object.Instantiate(Asset.Load("Char/" .. slot1), uv0.stage_.transform)
				slot2.name = slot1
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot1] = slot2
				slot2:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot2, typeof(DynamicBoneHelper)) then
					slot4.EnableDynamicBone(slot4, false)
				end

				uv0:ShowWeapon(slot3.transform, false)

				uv0.var_[slot1 .. "Animator"] = slot3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot1 .. "Animator"].applyRootMotion = true
				uv0.var_[slot1 .. "LipSync"] = slot3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			slot2 = uv0.actors_["6046_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos6046_story = slot2.localPosition
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos6046_story, Vector3.New(-1.1, -0.55, -5.7), (uv0.time_ - slot3) / slot4)
				slot8 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot8.x, slot8.y, slot8.z)
				slot9 = slot2.localEulerAngles
				slot9.z = 0
				slot9.x = 0
				slot2.localEulerAngles = slot9
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(-1.1, -0.55, -5.7)
				slot7 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot2.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot2.localEulerAngles = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/6046/6046action/6046action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot7 = uv0.actors_["6046_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.characterEffect6046_story == nil then
				uv0.var_.characterEffect6046_story = slot7.GetComponentInChildren(slot7, typeof(CharacterEffect))
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.characterEffect6046_story then
					uv0.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.characterEffect6046_story then
				uv0.var_.characterEffect6046_story.fillFlat = false
			end

			slot11 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122003].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122003", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122003", "story_v_out_113122.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
						slot11 = slot15
						uv0.duration_ = slot15 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						uv0:RecordAudio("113122003", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_113122", "113122003", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122003", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[113122003].content)
			slot15 = string.split(slot13, ".")

			if #string.split(slot13, "\n") >= 4 or #slot15 >= 4 then
				slot11 = slot11 * 3
			end

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				uv0.typewritter.percent = (uv0.time_ - slot10) / slot11

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.2

		if ({
			ja = 5.2,
			zh = 3.166
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["6046_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect6046_story == nil then
				uv0.var_.characterEffect6046_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect6046_story then
					uv0.var_.characterEffect6046_story.fillFlat = true
					uv0.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect6046_story then
				uv0.var_.characterEffect6046_story.fillFlat = true
				uv0.var_.characterEffect6046_story.fillRatio = 0.5
			end

			if uv0.actors_["10006ui_story"] == nil then
				slot5 = Object.Instantiate(Asset.Load("Char/" .. slot4), uv0.stage_.transform)
				slot5.name = slot4
				slot5.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot4] = slot5
				slot5:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot5, typeof(DynamicBoneHelper)) then
					slot7.EnableDynamicBone(slot7, false)
				end

				uv0:ShowWeapon(slot6.transform, false)

				uv0.var_[slot4 .. "Animator"] = slot6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot4 .. "Animator"].applyRootMotion = true
				uv0.var_[slot4 .. "LipSync"] = slot6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			slot5 = uv0.actors_["10006ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos10006ui_story = slot5.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10006ui_story, Vector3.New(1.1, -1.03, -5.05), (uv0.time_ - slot6) / slot7)
				slot11 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot5.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot5.localEulerAngles = slot12
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(1.1, -1.03, -5.05)
				slot10 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot5.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot5.localEulerAngles = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action7_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			slot10 = uv0.actors_["10006ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.characterEffect10006ui_story == nil then
				uv0.var_.characterEffect10006ui_story = slot10.GetComponentInChildren(slot10, typeof(CharacterEffect))
			end

			slot12 = 0.2

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.characterEffect10006ui_story then
					uv0.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.characterEffect10006ui_story then
				uv0.var_.characterEffect10006ui_story.fillFlat = false
			end

			slot14 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122004].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122004", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122004", "story_v_out_113122.awb") / 1000 > 0 and slot14 < slot18 and uv0.duration_ < slot18 + slot13 then
						slot14 = slot18
						uv0.duration_ = slot18 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						uv0:RecordAudio("113122004", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_113122", "113122004", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122004", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = uv0:FormatText(StoryWordCfg[113122004].content)
			slot18 = string.split(slot16, ".")

			if #string.split(slot16, "\n") >= 4 or #slot18 >= 4 then
				slot14 = slot14 * 3
			end

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				uv0.typewritter.percent = (uv0.time_ - slot13) / slot14

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["6046_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos6046_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, 100, 0)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			slot4 = uv0.actors_["10006ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos10006ui_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, 100, 0)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 0.775

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122005].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[113122005].content)
			slot12 = string.split(slot10, ".")

			if #string.split(slot10, "\n") >= 4 or #slot12 >= 4 then
				slot8 = slot8 * 3
			end

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				uv0.typewritter.percent = (uv0.time_ - slot7) / slot8

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.466

		if ({
			ja = 7.466,
			zh = 6.4
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["6045_story"] == nil then
				slot2 = Object.Instantiate(Asset.Load("Char/" .. slot1), uv0.stage_.transform)
				slot2.name = slot1
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot1] = slot2
				slot2:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot2, typeof(DynamicBoneHelper)) then
					slot4.EnableDynamicBone(slot4, false)
				end

				uv0:ShowWeapon(slot3.transform, false)

				uv0.var_[slot1 .. "Animator"] = slot3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot1 .. "Animator"].applyRootMotion = true
				uv0.var_[slot1 .. "LipSync"] = slot3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			slot2 = uv0.actors_["6045_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos6045_story = slot2.localPosition
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos6045_story, Vector3.New(-1.1, -0.55, -5.7), (uv0.time_ - slot3) / slot4)
				slot8 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot8.x, slot8.y, slot8.z)
				slot9 = slot2.localEulerAngles
				slot9.z = 0
				slot9.x = 0
				slot2.localEulerAngles = slot9
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(-1.1, -0.55, -5.7)
				slot7 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot2.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot2.localEulerAngles = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("6045_story", "StoryTimeline/CharAction/6045/6045action/6045action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot7 = uv0.actors_["6045_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.characterEffect6045_story == nil then
				uv0.var_.characterEffect6045_story = slot7.GetComponentInChildren(slot7, typeof(CharacterEffect))
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.characterEffect6045_story then
					uv0.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.characterEffect6045_story then
				uv0.var_.characterEffect6045_story.fillFlat = false
			end

			slot11 = 0.35

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122006].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122006", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122006", "story_v_out_113122.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
						slot11 = slot15
						uv0.duration_ = slot15 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						uv0:RecordAudio("113122006", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_113122", "113122006", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122006", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[113122006].content)
			slot15 = string.split(slot13, ".")

			if #string.split(slot13, "\n") >= 4 or #slot15 >= 4 then
				slot11 = slot11 * 3
			end

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				uv0.typewritter.percent = (uv0.time_ - slot10) / slot11

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5

		if ({
			ja = 5,
			zh = 4
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["6046_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos6046_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos6046_story, Vector3.New(1.1, -0.55, -5.7), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(1.1, -0.55, -5.7)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/6046/6046action/6046action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot6 = uv0.actors_["6046_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect6046_story == nil then
				uv0.var_.characterEffect6046_story = slot6.GetComponentInChildren(slot6, typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot9 = (uv0.time_ - slot7) / slot8

				if uv0.var_.characterEffect6046_story then
					uv0.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect6046_story then
				uv0.var_.characterEffect6046_story.fillFlat = false
			end

			slot9 = uv0.actors_["6045_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 and uv0.var_.characterEffect6045_story == nil then
				uv0.var_.characterEffect6045_story = slot9.GetComponentInChildren(slot9, typeof(CharacterEffect))
			end

			slot11 = 0.2

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot12 = (uv0.time_ - slot10) / slot11

				if uv0.var_.characterEffect6045_story then
					uv0.var_.characterEffect6045_story.fillFlat = true
					uv0.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, slot12)
				end
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 and uv0.var_.characterEffect6045_story then
				uv0.var_.characterEffect6045_story.fillFlat = true
				uv0.var_.characterEffect6045_story.fillRatio = 0.5
			end

			slot13 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122007].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122007", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122007", "story_v_out_113122.awb") / 1000 > 0 and slot13 < slot17 and uv0.duration_ < slot17 + slot12 then
						slot13 = slot17
						uv0.duration_ = slot17 + slot12
					end

					if slot15.prefab_name ~= "" and uv0.actors_[slot15.prefab_name] ~= nil then
						uv0:RecordAudio("113122007", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot15.prefab_name].transform, "story_v_out_113122", "113122007", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122007", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot15 = uv0:FormatText(StoryWordCfg[113122007].content)
			slot17 = string.split(slot15, ".")

			if #string.split(slot15, "\n") >= 4 or #slot17 >= 4 then
				slot13 = slot13 * 3
			end

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				uv0.typewritter.percent = (uv0.time_ - slot12) / slot13

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["6046_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos6046_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, 100, 0)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			slot4 = uv0.actors_["6045_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos6045_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, 100, 0)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 0.85

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122008].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[113122008].content)
			slot12 = string.split(slot10, ".")

			if #string.split(slot10, "\n") >= 4 or #slot12 >= 4 then
				slot8 = slot8 * 3
			end

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				uv0.typewritter.percent = (uv0.time_ - slot7) / slot8

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_10", "se_story_10_mouse", "")
			end

			slot4 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[220].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122009].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot6 = uv0:FormatText(StoryWordCfg[113122009].content)
			slot8 = string.split(slot6, ".")

			if #string.split(slot6, "\n") >= 4 or #slot8 >= 4 then
				slot4 = slot4 * 3
			end

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				uv0.typewritter.percent = (uv0.time_ - slot3) / slot4

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.9

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122010].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[113122010].content)
			slot6 = string.split(slot4, ".")

			if #string.split(slot4, "\n") >= 4 or #slot6 >= 4 then
				slot2 = slot2 * 3
			end

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.833

		if ({
			ja = 3.466,
			zh = 3.833
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["6045_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos6045_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos6045_story, Vector3.New(0, -0.55, -5.7), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -0.55, -5.7)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("6045_story", "StoryTimeline/CharAction/6045/6045action/6045action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot6 = uv0.actors_["6045_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect6045_story == nil then
				uv0.var_.characterEffect6045_story = slot6.GetComponentInChildren(slot6, typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot9 = (uv0.time_ - slot7) / slot8

				if uv0.var_.characterEffect6045_story then
					uv0.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect6045_story then
				uv0.var_.characterEffect6045_story.fillFlat = false
			end

			slot10 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122011].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122011", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122011", "story_v_out_113122.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("113122011", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_113122", "113122011", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122011", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[113122011].content)
			slot14 = string.split(slot12, ".")

			if #string.split(slot12, "\n") >= 4 or #slot14 >= 4 then
				slot10 = slot10 * 3
			end

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["6045_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos6045_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, 100, 0)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			slot5 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_10", "se_story_10_wood", "")
			end

			slot7 = 1.025

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122012].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot9 = uv0:FormatText(StoryWordCfg[113122012].content)
			slot11 = string.split(slot9, ".")

			if #string.split(slot9, "\n") >= 4 or #slot11 >= 4 then
				slot7 = slot7 * 3
			end

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				uv0.typewritter.percent = (uv0.time_ - slot6) / slot7

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.933

		if ({
			ja = 5.933,
			zh = 5.366
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = manager.ui.mainCamera.transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.shakeOldPos = slot1.localPosition
			end

			slot3 = 0.6

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5, slot6 = math.modf((uv0.time_ - slot2) / 0.066)
				slot1.localPosition = Vector3.New(slot6 * 0.13, slot6 * 0.13, slot6 * 0.13) + uv0.var_.shakeOldPos
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = uv0.var_.shakeOldPos
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot4 + 0.6 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.allBtn_.enabled = true
			end

			slot7 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_6045")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122013].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122013", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122013", "story_v_out_113122.awb") / 1000 > 0 and slot7 < slot11 and uv0.duration_ < slot11 + slot6 then
						slot7 = slot11
						uv0.duration_ = slot11 + slot6
					end

					if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
						uv0:RecordAudio("113122013", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_out_113122", "113122013", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122013", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot9 = uv0:FormatText(StoryWordCfg[113122013].content)
			slot11 = string.split(slot9, ".")

			if #string.split(slot9, "\n") >= 4 or #slot11 >= 4 then
				slot7 = slot7 * 3
			end

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				uv0.typewritter.percent = (uv0.time_ - slot6) / slot7

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.5

		if ({
			ja = 6.5,
			zh = 5.533
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["6046_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos6046_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos6046_story, Vector3.New(-1.1, -0.55, -5.7), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-1.1, -0.55, -5.7)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/6046/6046action/6046action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot6 = uv0.actors_["6046_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect6046_story == nil then
				uv0.var_.characterEffect6046_story = slot6.GetComponentInChildren(slot6, typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot9 = (uv0.time_ - slot7) / slot8

				if uv0.var_.characterEffect6046_story then
					uv0.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect6046_story then
				uv0.var_.characterEffect6046_story.fillFlat = false
			end

			slot10 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122014].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122014", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122014", "story_v_out_113122.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("113122014", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_113122", "113122014", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122014", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[113122014].content)
			slot14 = string.split(slot12, ".")

			if #string.split(slot12, "\n") >= 4 or #slot14 >= 4 then
				slot10 = slot10 * 3
			end

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.8

		if ({
			ja = 5.8,
			zh = 3.766
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/6046/6046actionlink/6046action442")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot4 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122015].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122015", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122015", "story_v_out_113122.awb") / 1000 > 0 and slot4 < slot8 and uv0.duration_ < slot8 + slot3 then
						slot4 = slot8
						uv0.duration_ = slot8 + slot3
					end

					if slot6.prefab_name ~= "" and uv0.actors_[slot6.prefab_name] ~= nil then
						uv0:RecordAudio("113122015", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot6.prefab_name].transform, "story_v_out_113122", "113122015", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122015", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot6 = uv0:FormatText(StoryWordCfg[113122015].content)
			slot8 = string.split(slot6, ".")

			if #string.split(slot6, "\n") >= 4 or #slot8 >= 4 then
				slot4 = slot4 * 3
			end

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				uv0.typewritter.percent = (uv0.time_ - slot3) / slot4

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.866

		if ({
			ja = 5.866,
			zh = 5.1
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1097ui_story"] == nil then
				slot2 = Object.Instantiate(Asset.Load("Char/" .. slot1), uv0.stage_.transform)
				slot2.name = slot1
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot1] = slot2
				slot2:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot2, typeof(DynamicBoneHelper)) then
					slot4.EnableDynamicBone(slot4, false)
				end

				uv0:ShowWeapon(slot3.transform, false)

				uv0.var_[slot1 .. "Animator"] = slot3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot1 .. "Animator"].applyRootMotion = true
				uv0.var_[slot1 .. "LipSync"] = slot3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			slot2 = uv0.actors_["1097ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos1097ui_story = slot2.localPosition
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1097ui_story, Vector3.New(1.1, -0.59, -5.7), (uv0.time_ - slot3) / slot4)
				slot8 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot8.x, slot8.y, slot8.z)
				slot9 = slot2.localEulerAngles
				slot9.z = 0
				slot9.x = 0
				slot2.localEulerAngles = slot9
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(1.1, -0.59, -5.7)
				slot7 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot2.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot2.localEulerAngles = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/1097/1097action/1097action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			slot7 = uv0.actors_["1097ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.characterEffect1097ui_story == nil then
				uv0.var_.characterEffect1097ui_story = slot7.GetComponentInChildren(slot7, typeof(CharacterEffect))
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.characterEffect1097ui_story then
					uv0.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.characterEffect1097ui_story then
				uv0.var_.characterEffect1097ui_story.fillFlat = false
			end

			slot10 = uv0.actors_["6046_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.characterEffect6046_story == nil then
				uv0.var_.characterEffect6046_story = slot10.GetComponentInChildren(slot10, typeof(CharacterEffect))
			end

			slot12 = 0.2

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.characterEffect6046_story then
					uv0.var_.characterEffect6046_story.fillFlat = true
					uv0.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, slot13)
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.characterEffect6046_story then
				uv0.var_.characterEffect6046_story.fillFlat = true
				uv0.var_.characterEffect6046_story.fillRatio = 0.5
			end

			slot14 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122016].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122016", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122016", "story_v_out_113122.awb") / 1000 > 0 and slot14 < slot18 and uv0.duration_ < slot18 + slot13 then
						slot14 = slot18
						uv0.duration_ = slot18 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						uv0:RecordAudio("113122016", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_113122", "113122016", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122016", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = uv0:FormatText(StoryWordCfg[113122016].content)
			slot18 = string.split(slot16, ".")

			if #string.split(slot16, "\n") >= 4 or #slot18 >= 4 then
				slot14 = slot14 * 3
			end

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				uv0.typewritter.percent = (uv0.time_ - slot13) / slot14

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.733

		if ({
			ja = 6.733,
			zh = 5.833
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1097ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1097ui_story == nil then
				uv0.var_.characterEffect1097ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1097ui_story then
					uv0.var_.characterEffect1097ui_story.fillFlat = true
					uv0.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1097ui_story then
				uv0.var_.characterEffect1097ui_story.fillFlat = true
				uv0.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			slot4 = uv0.actors_["6045_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos6045_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos6045_story, Vector3.New(-1.1, -0.55, -5.7), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(-1.1, -0.55, -5.7)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("6045_story", "StoryTimeline/CharAction/6045/6045action/6045action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot9 = uv0.actors_["6045_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 and uv0.var_.characterEffect6045_story == nil then
				uv0.var_.characterEffect6045_story = slot9.GetComponentInChildren(slot9, typeof(CharacterEffect))
			end

			slot11 = 0.2

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot12 = (uv0.time_ - slot10) / slot11

				if uv0.var_.characterEffect6045_story then
					uv0.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 and uv0.var_.characterEffect6045_story then
				uv0.var_.characterEffect6045_story.fillFlat = false
			end

			slot12 = uv0.actors_["6046_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.var_.moveOldPos6046_story = slot12.localPosition
			end

			slot14 = 0.001

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				slot12.localPosition = Vector3.Lerp(uv0.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (uv0.time_ - slot13) / slot14)
				slot18 = manager.ui.mainCamera.transform.position - slot12.position
				slot12.forward = Vector3.New(slot18.x, slot18.y, slot18.z)
				slot19 = slot12.localEulerAngles
				slot19.z = 0
				slot19.x = 0
				slot12.localEulerAngles = slot19
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 then
				slot12.localPosition = Vector3.New(0, 100, 0)
				slot17 = manager.ui.mainCamera.transform.position - slot12.position
				slot12.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot12.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot12.localEulerAngles = slot18
			end

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/1097/1097action/1097action4_2")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			slot18 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122017].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122017", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122017", "story_v_out_113122.awb") / 1000 > 0 and slot18 < slot22 and uv0.duration_ < slot22 + slot17 then
						slot18 = slot22
						uv0.duration_ = slot22 + slot17
					end

					if slot20.prefab_name ~= "" and uv0.actors_[slot20.prefab_name] ~= nil then
						uv0:RecordAudio("113122017", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot20.prefab_name].transform, "story_v_out_113122", "113122017", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122017", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot20 = uv0:FormatText(StoryWordCfg[113122017].content)
			slot22 = string.split(slot20, ".")

			if #string.split(slot20, "\n") >= 4 or #slot22 >= 4 then
				slot18 = slot18 * 3
			end

			if slot17 <= uv0.time_ and uv0.time_ < slot17 + slot18 then
				uv0.typewritter.percent = (uv0.time_ - slot17) / slot18

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot17 + slot18 and uv0.time_ < slot17 + slot18 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.1

		if ({
			ja = 3.1,
			zh = 2.866
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["6045_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect6045_story == nil then
				uv0.var_.characterEffect6045_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect6045_story then
					uv0.var_.characterEffect6045_story.fillFlat = true
					uv0.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect6045_story then
				uv0.var_.characterEffect6045_story.fillFlat = true
				uv0.var_.characterEffect6045_story.fillRatio = 0.5
			end

			slot5 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_6046")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122018].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122018", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122018", "story_v_out_113122.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
						slot5 = slot9
						uv0.duration_ = slot9 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						uv0:RecordAudio("113122018", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_113122", "113122018", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122018", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[113122018].content)
			slot9 = string.split(slot7, ".")

			if #string.split(slot7, "\n") >= 4 or #slot9 >= 4 then
				slot5 = slot5 * 3
			end

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 14.966

		if ({
			ja = 14.966,
			zh = 11.466
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			slot2 = uv0.actors_["1097ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1097ui_story == nil then
				uv0.var_.characterEffect1097ui_story = slot2.GetComponentInChildren(slot2, typeof(CharacterEffect))
			end

			slot4 = 0.2

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1097ui_story then
					uv0.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1097ui_story then
				uv0.var_.characterEffect1097ui_story.fillFlat = false
			end

			slot6 = 0.95

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122019].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122019", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122019", "story_v_out_113122.awb") / 1000 > 0 and slot6 < slot10 and uv0.duration_ < slot10 + slot5 then
						slot6 = slot10
						uv0.duration_ = slot10 + slot5
					end

					if slot8.prefab_name ~= "" and uv0.actors_[slot8.prefab_name] ~= nil then
						uv0:RecordAudio("113122019", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot8.prefab_name].transform, "story_v_out_113122", "113122019", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122019", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot8 = uv0:FormatText(StoryWordCfg[113122019].content)
			slot10 = string.split(slot8, ".")

			if #string.split(slot8, "\n") >= 4 or #slot10 >= 4 then
				slot6 = slot6 * 3
			end

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				uv0.typewritter.percent = (uv0.time_ - slot5) / slot6

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1097ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1097ui_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, 100, 0)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			slot4 = uv0.actors_["6045_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos6045_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, 100, 0)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122020].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[113122020].content)
			slot12 = string.split(slot10, ".")

			if #string.split(slot10, "\n") >= 4 or #slot12 >= 4 then
				slot8 = slot8 * 3
			end

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				uv0.typewritter.percent = (uv0.time_ - slot7) / slot8

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.9

		if ({
			ja = 8.9,
			zh = 7.333
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1097ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1097ui_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1097ui_story, Vector3.New(-1.1, -0.59, -5.7), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-1.1, -0.59, -5.7)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/1097/1097action/1097action7_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			slot6 = uv0.actors_["1097ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect1097ui_story == nil then
				uv0.var_.characterEffect1097ui_story = slot6.GetComponentInChildren(slot6, typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot9 = (uv0.time_ - slot7) / slot8

				if uv0.var_.characterEffect1097ui_story then
					uv0.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect1097ui_story then
				uv0.var_.characterEffect1097ui_story.fillFlat = false
			end

			slot10 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122021].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122021", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122021", "story_v_out_113122.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("113122021", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_113122", "113122021", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122021", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[113122021].content)
			slot14 = string.split(slot12, ".")

			if #string.split(slot12, "\n") >= 4 or #slot14 >= 4 then
				slot10 = slot10 * 3
			end

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1097ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1097ui_story == nil then
				uv0.var_.characterEffect1097ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1097ui_story then
					uv0.var_.characterEffect1097ui_story.fillFlat = true
					uv0.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1097ui_story then
				uv0.var_.characterEffect1097ui_story.fillFlat = true
				uv0.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			slot5 = 1.05

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122022].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[113122022].content)
			slot9 = string.split(slot7, ".")

			if #string.split(slot7, "\n") >= 4 or #slot9 >= 4 then
				slot5 = slot5 * 3
			end

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122023 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.766

		if ({
			ja = 5.566,
			zh = 5.766
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10006ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10006ui_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10006ui_story, Vector3.New(1.1, -1.03, -5.05), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(1.1, -1.03, -5.05)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			slot6 = uv0.actors_["10006ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect10006ui_story == nil then
				uv0.var_.characterEffect10006ui_story = slot6.GetComponentInChildren(slot6, typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot9 = (uv0.time_ - slot7) / slot8

				if uv0.var_.characterEffect10006ui_story then
					uv0.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect10006ui_story then
				uv0.var_.characterEffect10006ui_story.fillFlat = false
			end

			slot10 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122023].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122023", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122023", "story_v_out_113122.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("113122023", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_113122", "113122023", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122023", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[113122023].content)
			slot14 = string.split(slot12, ".")

			if #string.split(slot12, "\n") >= 4 or #slot14 >= 4 then
				slot10 = slot10 * 3
			end

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 12.6

		if ({
			ja = 12.6,
			zh = 6.766
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122025(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10006ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect10006ui_story == nil then
				uv0.var_.characterEffect10006ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect10006ui_story then
					uv0.var_.characterEffect10006ui_story.fillFlat = true
					uv0.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect10006ui_story then
				uv0.var_.characterEffect10006ui_story.fillFlat = true
				uv0.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/1097/1097action/1097action7_2")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot6 = uv0.actors_["1097ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect1097ui_story == nil then
				uv0.var_.characterEffect1097ui_story = slot6.GetComponentInChildren(slot6, typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot9 = (uv0.time_ - slot7) / slot8

				if uv0.var_.characterEffect1097ui_story then
					uv0.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect1097ui_story then
				uv0.var_.characterEffect1097ui_story.fillFlat = false
			end

			slot10 = 0.75

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122024].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122024", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122024", "story_v_out_113122.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("113122024", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_113122", "113122024", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122024", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[113122024].content)
			slot14 = string.split(slot12, ".")

			if #string.split(slot12, "\n") >= 4 or #slot14 >= 4 then
				slot10 = slot10 * 3
			end

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.866

		if ({
			ja = 5.5,
			zh = 5.866
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["6046_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos6046_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos6046_story, Vector3.New(1.1, -0.55, -5.7), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(1.1, -0.55, -5.7)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/6046/6046action/6046action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot6 = uv0.actors_["6046_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect6046_story == nil then
				uv0.var_.characterEffect6046_story = slot6.GetComponentInChildren(slot6, typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot9 = (uv0.time_ - slot7) / slot8

				if uv0.var_.characterEffect6046_story then
					uv0.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect6046_story then
				uv0.var_.characterEffect6046_story.fillFlat = false
			end

			slot9 = uv0.actors_["10006ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPos10006ui_story = slot9.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot10) / slot11)
				slot15 = manager.ui.mainCamera.transform.position - slot9.position
				slot9.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot9.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot9.localEulerAngles = slot16
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(0, 100, 0)
				slot14 = manager.ui.mainCamera.transform.position - slot9.position
				slot9.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot9.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot9.localEulerAngles = slot15
			end

			slot12 = uv0.actors_["1097ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 and uv0.var_.characterEffect1097ui_story == nil then
				uv0.var_.characterEffect1097ui_story = slot12.GetComponentInChildren(slot12, typeof(CharacterEffect))
			end

			slot14 = 0.2

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				slot15 = (uv0.time_ - slot13) / slot14

				if uv0.var_.characterEffect1097ui_story then
					uv0.var_.characterEffect1097ui_story.fillFlat = true
					uv0.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot15)
				end
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 and uv0.var_.characterEffect1097ui_story then
				uv0.var_.characterEffect1097ui_story.fillFlat = true
				uv0.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			slot16 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122025].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122025", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122025", "story_v_out_113122.awb") / 1000 > 0 and slot16 < slot20 and uv0.duration_ < slot20 + slot15 then
						slot16 = slot20
						uv0.duration_ = slot20 + slot15
					end

					if slot18.prefab_name ~= "" and uv0.actors_[slot18.prefab_name] ~= nil then
						uv0:RecordAudio("113122025", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot18.prefab_name].transform, "story_v_out_113122", "113122025", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122025", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot18 = uv0:FormatText(StoryWordCfg[113122025].content)
			slot20 = string.split(slot18, ".")

			if #string.split(slot18, "\n") >= 4 or #slot20 >= 4 then
				slot16 = slot16 * 3
			end

			if slot15 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
				uv0.typewritter.percent = (uv0.time_ - slot15) / slot16

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot15 + slot16 and uv0.time_ < slot15 + slot16 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122027(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["6046_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos6046_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, 100, 0)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			slot4 = uv0.actors_["1097ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1097ui_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, 100, 0)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 0.6

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122026].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[113122026].content)
			slot12 = string.split(slot10, ".")

			if #string.split(slot10, "\n") >= 4 or #slot12 >= 4 then
				slot8 = slot8 * 3
			end

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				uv0.typewritter.percent = (uv0.time_ - slot7) / slot8

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122027 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.3

		if ({
			ja = 8.3,
			zh = 7.533
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122028(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["6046_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos6046_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos6046_story, Vector3.New(-1.1, -0.55, -5.7), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-1.1, -0.55, -5.7)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/6046/6046action/6046action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot6 = uv0.actors_["6046_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect6046_story == nil then
				uv0.var_.characterEffect6046_story = slot6.GetComponentInChildren(slot6, typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot9 = (uv0.time_ - slot7) / slot8

				if uv0.var_.characterEffect6046_story then
					uv0.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect6046_story then
				uv0.var_.characterEffect6046_story.fillFlat = false
			end

			slot10 = 0.75

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122027].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122027", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122027", "story_v_out_113122.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("113122027", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_113122", "113122027", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122027", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[113122027].content)
			slot14 = string.split(slot12, ".")

			if #string.split(slot12, "\n") >= 4 or #slot14 >= 4 then
				slot10 = slot10 * 3
			end

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122028 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.266

		if ({
			ja = 1.999999999999,
			zh = 2.266
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122029(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10006ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10006ui_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10006ui_story, Vector3.New(1.1, -1.03, -5.05), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(1.1, -1.03, -5.05)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			slot6 = uv0.actors_["10006ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect10006ui_story == nil then
				uv0.var_.characterEffect10006ui_story = slot6.GetComponentInChildren(slot6, typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot9 = (uv0.time_ - slot7) / slot8

				if uv0.var_.characterEffect10006ui_story then
					uv0.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect10006ui_story then
				uv0.var_.characterEffect10006ui_story.fillFlat = false
			end

			slot9 = uv0.actors_["6046_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 and uv0.var_.characterEffect6046_story == nil then
				uv0.var_.characterEffect6046_story = slot9.GetComponentInChildren(slot9, typeof(CharacterEffect))
			end

			slot11 = 0.2

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot12 = (uv0.time_ - slot10) / slot11

				if uv0.var_.characterEffect6046_story then
					uv0.var_.characterEffect6046_story.fillFlat = true
					uv0.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, slot12)
				end
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 and uv0.var_.characterEffect6046_story then
				uv0.var_.characterEffect6046_story.fillFlat = true
				uv0.var_.characterEffect6046_story.fillRatio = 0.5
			end

			slot13 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122028].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122028", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122028", "story_v_out_113122.awb") / 1000 > 0 and slot13 < slot17 and uv0.duration_ < slot17 + slot12 then
						slot13 = slot17
						uv0.duration_ = slot17 + slot12
					end

					if slot15.prefab_name ~= "" and uv0.actors_[slot15.prefab_name] ~= nil then
						uv0:RecordAudio("113122028", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot15.prefab_name].transform, "story_v_out_113122", "113122028", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122028", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot15 = uv0:FormatText(StoryWordCfg[113122028].content)
			slot17 = string.split(slot15, ".")

			if #string.split(slot15, "\n") >= 4 or #slot17 >= 4 then
				slot13 = slot13 * 3
			end

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				uv0.typewritter.percent = (uv0.time_ - slot12) / slot13

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122029 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.833

		if ({
			ja = 2.833,
			zh = 6.833
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122030(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10006ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect10006ui_story == nil then
				uv0.var_.characterEffect10006ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect10006ui_story then
					uv0.var_.characterEffect10006ui_story.fillFlat = true
					uv0.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect10006ui_story then
				uv0.var_.characterEffect10006ui_story.fillFlat = true
				uv0.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			slot5 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122029].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122029", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122029", "story_v_out_113122.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
						slot5 = slot9
						uv0.duration_ = slot9 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						uv0:RecordAudio("113122029", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_113122", "113122029", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122029", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[113122029].content)
			slot9 = string.split(slot7, ".")

			if #string.split(slot7, "\n") >= 4 or #slot9 >= 4 then
				slot5 = slot5 * 3
			end

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122030 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 15.633

		if ({
			ja = 15.633,
			zh = 7.4
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122031(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			slot3 = uv0.actors_["10006ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 and uv0.var_.characterEffect10006ui_story == nil then
				uv0.var_.characterEffect10006ui_story = slot3.GetComponentInChildren(slot3, typeof(CharacterEffect))
			end

			slot5 = 0.2

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot6 = (uv0.time_ - slot4) / slot5

				if uv0.var_.characterEffect10006ui_story then
					uv0.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.characterEffect10006ui_story then
				uv0.var_.characterEffect10006ui_story.fillFlat = false
			end

			slot7 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122030].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122030", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122030", "story_v_out_113122.awb") / 1000 > 0 and slot7 < slot11 and uv0.duration_ < slot11 + slot6 then
						slot7 = slot11
						uv0.duration_ = slot11 + slot6
					end

					if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
						uv0:RecordAudio("113122030", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_out_113122", "113122030", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122030", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot9 = uv0:FormatText(StoryWordCfg[113122030].content)
			slot11 = string.split(slot9, ".")

			if #string.split(slot9, "\n") >= 4 or #slot11 >= 4 then
				slot7 = slot7 * 3
			end

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				uv0.typewritter.percent = (uv0.time_ - slot6) / slot7

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122031 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 10.633

		if ({
			ja = 10.633,
			zh = 4.966
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122032(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			slot3 = 0.65

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122031].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122031", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122031", "story_v_out_113122.awb") / 1000 > 0 and slot3 < slot7 and uv0.duration_ < slot7 + slot2 then
						slot3 = slot7
						uv0.duration_ = slot7 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						uv0:RecordAudio("113122031", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_out_113122", "113122031", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122031", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = uv0:FormatText(StoryWordCfg[113122031].content)
			slot7 = string.split(slot5, ".")

			if #string.split(slot5, "\n") >= 4 or #slot7 >= 4 then
				slot3 = slot3 * 3
			end

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.typewritter.percent = (uv0.time_ - slot2) / slot3

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122032 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.666

		if ({
			ja = 1.666,
			zh = 1.533
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122033(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10006ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect10006ui_story == nil then
				uv0.var_.characterEffect10006ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect10006ui_story then
					uv0.var_.characterEffect10006ui_story.fillFlat = true
					uv0.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect10006ui_story then
				uv0.var_.characterEffect10006ui_story.fillFlat = true
				uv0.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			slot5 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_1097")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122032].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122032", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122032", "story_v_out_113122.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
						slot5 = slot9
						uv0.duration_ = slot9 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						uv0:RecordAudio("113122032", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_113122", "113122032", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122032", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[113122032].content)
			slot9 = string.split(slot7, ".")

			if #string.split(slot7, "\n") >= 4 or #slot9 >= 4 then
				slot5 = slot5 * 3
			end

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122033 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 11.1

		if ({
			ja = 11.1,
			zh = 7.9
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122034(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/6046/6046actionlink/6046action442")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot3 = uv0.actors_["6046_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 and uv0.var_.characterEffect6046_story == nil then
				uv0.var_.characterEffect6046_story = slot3.GetComponentInChildren(slot3, typeof(CharacterEffect))
			end

			slot5 = 0.2

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot6 = (uv0.time_ - slot4) / slot5

				if uv0.var_.characterEffect6046_story then
					uv0.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.characterEffect6046_story then
				uv0.var_.characterEffect6046_story.fillFlat = false
			end

			slot7 = 0.775

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122033].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122033", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122033", "story_v_out_113122.awb") / 1000 > 0 and slot7 < slot11 and uv0.duration_ < slot11 + slot6 then
						slot7 = slot11
						uv0.duration_ = slot11 + slot6
					end

					if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
						uv0:RecordAudio("113122033", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_out_113122", "113122033", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122033", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot9 = uv0:FormatText(StoryWordCfg[113122033].content)
			slot11 = string.split(slot9, ".")

			if #string.split(slot9, "\n") >= 4 or #slot11 >= 4 then
				slot7 = slot7 * 3
			end

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				uv0.typewritter.percent = (uv0.time_ - slot6) / slot7

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122034 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 20.133

		if ({
			ja = 20.133,
			zh = 10.9
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122035(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["6046_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect6046_story == nil then
				uv0.var_.characterEffect6046_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect6046_story then
					uv0.var_.characterEffect6046_story.fillFlat = true
					uv0.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect6046_story then
				uv0.var_.characterEffect6046_story.fillFlat = true
				uv0.var_.characterEffect6046_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006actionlink/10006action464")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			slot6 = uv0.actors_["10006ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect10006ui_story == nil then
				uv0.var_.characterEffect10006ui_story = slot6.GetComponentInChildren(slot6, typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot9 = (uv0.time_ - slot7) / slot8

				if uv0.var_.characterEffect10006ui_story then
					uv0.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect10006ui_story then
				uv0.var_.characterEffect10006ui_story.fillFlat = false
			end

			slot10 = 1.275

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122034].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122034", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122034", "story_v_out_113122.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("113122034", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_113122", "113122034", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122034", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[113122034].content)
			slot14 = string.split(slot12, ".")

			if #string.split(slot12, "\n") >= 4 or #slot14 >= 4 then
				slot10 = slot10 * 3
			end

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122035 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.4

		if ({
			ja = 4.4,
			zh = 3.966
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122036(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10006ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect10006ui_story == nil then
				uv0.var_.characterEffect10006ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect10006ui_story then
					uv0.var_.characterEffect10006ui_story.fillFlat = true
					uv0.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect10006ui_story then
				uv0.var_.characterEffect10006ui_story.fillFlat = true
				uv0.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/6046/6046action/6046action2_2")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot6 = uv0.actors_["6046_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect6046_story == nil then
				uv0.var_.characterEffect6046_story = slot6.GetComponentInChildren(slot6, typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot9 = (uv0.time_ - slot7) / slot8

				if uv0.var_.characterEffect6046_story then
					uv0.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect6046_story then
				uv0.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action4_2")
			end

			slot11 = 0.375

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122035].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122035", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122035", "story_v_out_113122.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
						slot11 = slot15
						uv0.duration_ = slot15 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						uv0:RecordAudio("113122035", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_113122", "113122035", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122035", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[113122035].content)
			slot15 = string.split(slot13, ".")

			if #string.split(slot13, "\n") >= 4 or #slot15 >= 4 then
				slot11 = slot11 * 3
			end

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				uv0.typewritter.percent = (uv0.time_ - slot10) / slot11

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122036 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.333

		if ({
			ja = 5.333,
			zh = 5.133
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122037(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["6046_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect6046_story == nil then
				uv0.var_.characterEffect6046_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect6046_story then
					uv0.var_.characterEffect6046_story.fillFlat = true
					uv0.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect6046_story then
				uv0.var_.characterEffect6046_story.fillFlat = true
				uv0.var_.characterEffect6046_story.fillRatio = 0.5
			end

			slot5 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_6045")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122036].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122036", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122036", "story_v_out_113122.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
						slot5 = slot9
						uv0.duration_ = slot9 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						uv0:RecordAudio("113122036", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_113122", "113122036", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122036", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[113122036].content)
			slot9 = string.split(slot7, ".")

			if #string.split(slot7, "\n") >= 4 or #slot9 >= 4 then
				slot5 = slot5 * 3
			end

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122037 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.733

		if ({
			ja = 3.6,
			zh = 4.733
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122038(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/6046/6046action/6046action5_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot3 = uv0.actors_["6046_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 and uv0.var_.characterEffect6046_story == nil then
				uv0.var_.characterEffect6046_story = slot3.GetComponentInChildren(slot3, typeof(CharacterEffect))
			end

			slot5 = 0.2

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot6 = (uv0.time_ - slot4) / slot5

				if uv0.var_.characterEffect6046_story then
					uv0.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.characterEffect6046_story then
				uv0.var_.characterEffect6046_story.fillFlat = false
			end

			slot7 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122037].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122037", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122037", "story_v_out_113122.awb") / 1000 > 0 and slot7 < slot11 and uv0.duration_ < slot11 + slot6 then
						slot7 = slot11
						uv0.duration_ = slot11 + slot6
					end

					if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
						uv0:RecordAudio("113122037", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_out_113122", "113122037", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122037", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot9 = uv0:FormatText(StoryWordCfg[113122037].content)
			slot11 = string.split(slot9, ".")

			if #string.split(slot9, "\n") >= 4 or #slot11 >= 4 then
				slot7 = slot7 * 3
			end

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				uv0.typewritter.percent = (uv0.time_ - slot6) / slot7

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122038 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.9

		if ({
			ja = 5.9,
			zh = 4.233
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122039(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["6046_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos6046_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, 100, 0)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			slot4 = uv0.actors_["10006ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos10006ui_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, 100, 0)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot7 = uv0.actors_["1097ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1097ui_story = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1097ui_story, Vector3.New(0, -0.59, -5.7), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -0.59, -5.7)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/1097/1097action/1097action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			slot12 = uv0.actors_["1097ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 and uv0.var_.characterEffect1097ui_story == nil then
				uv0.var_.characterEffect1097ui_story = slot12.GetComponentInChildren(slot12, typeof(CharacterEffect))
			end

			slot14 = 0.2

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				slot15 = (uv0.time_ - slot13) / slot14

				if uv0.var_.characterEffect1097ui_story then
					uv0.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 and uv0.var_.characterEffect1097ui_story then
				uv0.var_.characterEffect1097ui_story.fillFlat = false
			end

			slot16 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122038].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122038", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122038", "story_v_out_113122.awb") / 1000 > 0 and slot16 < slot20 and uv0.duration_ < slot20 + slot15 then
						slot16 = slot20
						uv0.duration_ = slot20 + slot15
					end

					if slot18.prefab_name ~= "" and uv0.actors_[slot18.prefab_name] ~= nil then
						uv0:RecordAudio("113122038", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot18.prefab_name].transform, "story_v_out_113122", "113122038", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122038", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot18 = uv0:FormatText(StoryWordCfg[113122038].content)
			slot20 = string.split(slot18, ".")

			if #string.split(slot18, "\n") >= 4 or #slot20 >= 4 then
				slot16 = slot16 * 3
			end

			if slot15 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
				uv0.typewritter.percent = (uv0.time_ - slot15) / slot16

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot15 + slot16 and uv0.time_ < slot15 + slot16 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122039 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122040(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1097ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1097ui_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, 100, 0)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			slot5 = 1.05

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122039].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[113122039].content)
			slot9 = string.split(slot7, ".")

			if #string.split(slot7, "\n") >= 4 or #slot9 >= 4 then
				slot5 = slot5 * 3
			end

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122040 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 14.333

		if ({
			ja = 14.333,
			zh = 12.366
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122041(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 4.5 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			slot2 = uv0.actors_["1097ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1097ui_story == nil then
				uv0.var_.characterEffect1097ui_story = slot2.GetComponentInChildren(slot2, typeof(CharacterEffect))
			end

			slot4 = 0.2

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1097ui_story then
					uv0.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1097ui_story then
				uv0.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot6 = 2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot8 = Color.New(0, 0, 0)
				slot8.a = Mathf.Lerp(0, 1, (uv0.time_ - slot5) / slot6)
				uv0.mask_.color = slot8
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot7 = Color.New(0, 0, 0)
				slot7.a = 1
				uv0.mask_.color = slot7
			end

			if 2.5 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot8 = 2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot10 = Color.New(0, 0, 0)
				slot10.a = Mathf.Lerp(1, 0, (uv0.time_ - slot7) / slot8)
				uv0.mask_.color = slot10
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot9 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot9.a = 0
				uv0.mask_.color = slot9
			end

			if 2 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot9 + 0.5 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.allBtn_.enabled = true
			end

			if 4.5 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot11 + 0.725 and uv0.time_ < slot11 + slot12 + slot0 then
				uv0.allBtn_.enabled = true
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot14 = 0.725

			if 4.5 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.dialog_:SetActive(true)

				uv0.dialog_.transform.localScale = Vector3(0.8, 0.95, 1)

				LeanTween.scale(uv0.dialog_, Vector3.one, 0.2)

				slot15 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot15:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot15:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_1097")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122040].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122040", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122040", "story_v_out_113122.awb") / 1000 > 0 and slot14 < slot19 and uv0.duration_ < slot19 + slot13 then
						slot14 = slot19
						uv0.duration_ = slot19 + slot13
					end

					if slot17.prefab_name ~= "" and uv0.actors_[slot17.prefab_name] ~= nil then
						uv0:RecordAudio("113122040", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot17.prefab_name].transform, "story_v_out_113122", "113122040", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122040", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = slot13 + 0.3
			slot16 = uv0:FormatText(StoryWordCfg[113122040].content)
			slot18 = string.split(slot16, ".")

			if #string.split(slot16, "\n") >= 4 or #slot18 >= 4 then
				slot14 = slot14 * 3
			end

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				uv0.typewritter.percent = (uv0.time_ - slot13) / slot14

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122041 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.766

		if ({
			ja = 4.766,
			zh = 2.933
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122042(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1097ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1097ui_story == nil then
				uv0.var_.characterEffect1097ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1097ui_story then
					uv0.var_.characterEffect1097ui_story.fillFlat = true
					uv0.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1097ui_story then
				uv0.var_.characterEffect1097ui_story.fillFlat = true
				uv0.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			slot5 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_10006")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122041].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122041", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122041", "story_v_out_113122.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
						slot5 = slot9
						uv0.duration_ = slot9 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						uv0:RecordAudio("113122041", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_113122", "113122041", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122041", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[113122041].content)
			slot9 = string.split(slot7, ".")

			if #string.split(slot7, "\n") >= 4 or #slot9 >= 4 then
				slot5 = slot5 * 3
			end

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122042 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 10.666

		if ({
			ja = 10.666,
			zh = 7.666
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122043(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/1097/1097action/1097action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			slot3 = uv0.actors_["1097ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 and uv0.var_.characterEffect1097ui_story == nil then
				uv0.var_.characterEffect1097ui_story = slot3.GetComponentInChildren(slot3, typeof(CharacterEffect))
			end

			slot5 = 0.2

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot6 = (uv0.time_ - slot4) / slot5

				if uv0.var_.characterEffect1097ui_story then
					uv0.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.characterEffect1097ui_story then
				uv0.var_.characterEffect1097ui_story.fillFlat = false
			end

			slot6 = uv0.actors_["1097ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.var_.moveOldPos1097ui_story = slot6.localPosition
			end

			slot8 = 0.001

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot6.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1097ui_story, Vector3.New(0, -0.59, -5.7), (uv0.time_ - slot7) / slot8)
				slot12 = manager.ui.mainCamera.transform.position - slot6.position
				slot6.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot6.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot6.localEulerAngles = slot13
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot6.localPosition = Vector3.New(0, -0.59, -5.7)
				slot11 = manager.ui.mainCamera.transform.position - slot6.position
				slot6.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot6.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot6.localEulerAngles = slot12
			end

			slot10 = 0.85

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122042].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122042", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122042", "story_v_out_113122.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("113122042", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_113122", "113122042", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122042", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[113122042].content)
			slot14 = string.split(slot12, ".")

			if #string.split(slot12, "\n") >= 4 or #slot14 >= 4 then
				slot10 = slot10 * 3
			end

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122043 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.366

		if ({
			ja = 4.366,
			zh = 4.2
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122044(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1097ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1097ui_story == nil then
				uv0.var_.characterEffect1097ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1097ui_story then
					uv0.var_.characterEffect1097ui_story.fillFlat = true
					uv0.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1097ui_story then
				uv0.var_.characterEffect1097ui_story.fillFlat = true
				uv0.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			slot5 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_10006")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122043].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122043", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122043", "story_v_out_113122.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
						slot5 = slot9
						uv0.duration_ = slot9 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						uv0:RecordAudio("113122043", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_113122", "113122043", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122043", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[113122043].content)
			slot9 = string.split(slot7, ".")

			if #string.split(slot7, "\n") >= 4 or #slot9 >= 4 then
				slot5 = slot5 * 3
			end

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122044 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.166

		if ({
			ja = 6.166,
			zh = 3.633
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play113122045(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			slot2 = uv0.actors_["1097ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1097ui_story == nil then
				uv0.var_.characterEffect1097ui_story = slot2.GetComponentInChildren(slot2, typeof(CharacterEffect))
			end

			slot4 = 0.2

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1097ui_story then
					uv0.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1097ui_story then
				uv0.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/1097/1097action/1097action5_1")
			end

			slot6 = uv0.actors_["1097ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.var_.moveOldPos1097ui_story = slot6.localPosition

				uv0:ShowWeapon(uv0.var_["1097ui_story" .. "Animator"].transform, true)
			end

			slot8 = 0.001

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot6.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1097ui_story, Vector3.New(0, -0.59, -5.7), (uv0.time_ - slot7) / slot8)
				slot12 = manager.ui.mainCamera.transform.position - slot6.position
				slot6.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot6.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot6.localEulerAngles = slot13
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot6.localPosition = Vector3.New(0, -0.59, -5.7)
				slot11 = manager.ui.mainCamera.transform.position - slot6.position
				slot6.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot6.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot6.localEulerAngles = slot12
			end

			slot9 = uv0.actors_["1097ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				if not uv0.var_.effect1097ui_storyyanwu2 then
					slot11 = Object.Instantiate(Asset.Load("Effect/Hero/1097/fx_1097_story_smoke"))
					slot11.name = "yanwu2"
					uv0.var_.effect1097ui_storyyanwu2 = slot11
				end

				if slot9.Find(slot9, "") then
					slot11.transform.parent = slot12
				else
					slot11.transform.parent = slot9
				end

				slot11.transform.localPosition = Vector3.New(0, 1.28, 0.3)
				slot11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			slot11 = uv0.actors_["1097ui_story"].transform

			if 2 < uv0.time_ and uv0.time_ <= slot12 + slot0 and uv0.var_.effect1097ui_storyyanwu2 then
				Object.Destroy(slot13)

				uv0.var_.effect1097ui_storyyanwu2 = nil
			end

			slot14 = 0.35

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122044].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122044", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122044", "story_v_out_113122.awb") / 1000 > 0 and slot14 < slot18 and uv0.duration_ < slot18 + slot13 then
						slot14 = slot18
						uv0.duration_ = slot18 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						uv0:RecordAudio("113122044", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_113122", "113122044", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122044", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = uv0:FormatText(StoryWordCfg[113122044].content)
			slot18 = string.split(slot16, ".")

			if #string.split(slot16, "\n") >= 4 or #slot18 >= 4 then
				slot14 = slot14 * 3
			end

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				uv0.typewritter.percent = (uv0.time_ - slot13) / slot14

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play113122045 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 19.8496666666667

		if ({
			ja = 19.8496666666667,
			zh = 18.6166666666667
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
			uv0.auto_ = false
		end

		function slot1.playNext_(slot0)
			uv0.onStoryFinished_()
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot2 = 2

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				slot4 = Color.New(0, 0, 0)
				slot4.a = Mathf.Lerp(0, 1, (uv0.time_ - slot1) / slot2)
				uv0.mask_.color = slot4
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				slot3 = Color.New(0, 0, 0)
				slot3.a = 1
				uv0.mask_.color = slot3
			end

			if 2.5 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot4 = 2

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot6 = Color.New(0, 0, 0)
				slot6.a = Mathf.Lerp(1, 0, (uv0.time_ - slot3) / slot4)
				uv0.mask_.color = slot6
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot5 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot5.a = 0
				uv0.mask_.color = slot5
			end

			if 5 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot6 = 2.5

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot8 = Color.New(0, 0, 0)
				slot8.a = Mathf.Lerp(0, 1, (uv0.time_ - slot5) / slot6)
				uv0.mask_.color = slot8
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot7 = Color.New(0, 0, 0)
				slot7.a = 1
				uv0.mask_.color = slot7
			end

			if 7.5 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot8 = 0.0166666666666667

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot10 = Color.New(0, 0, 0)
				slot10.a = Mathf.Lerp(1, 0, (uv0.time_ - slot7) / slot8)
				uv0.mask_.color = slot10
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot9 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot9.a = 0
				uv0.mask_.color = slot9
			end

			if 2 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot9 + 0.5 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.allBtn_.enabled = true
			end

			if 4.5 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot11 + 0.5 and uv0.time_ < slot11 + slot12 + slot0 then
				uv0.allBtn_.enabled = true
			end

			if uv0.bgs_.STblack == nil then
				slot14 = Object.Instantiate(uv0.paintGo_)
				slot14:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot13)
				slot14.name = slot13
				slot14.transform.parent = uv0.stage_.transform
				slot14.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot13] = slot14
			end

			if 7.5 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				slot15 = manager.ui.mainCamera.transform.localPosition
				slot17 = uv0.bgs_.STblack
				slot17.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot15.x, slot15.y, 0)
				slot17.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot17:GetComponent("SpriteRenderer") and slot18.sprite then
					slot21 = manager.ui.mainCameraCom_
					slot22 = 2 * (slot17.transform.localPosition - slot15).z * Mathf.Tan(slot21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot28 = slot22 * slot21.aspect / slot18.sprite.bounds.size.x > slot22 / slot18.sprite.bounds.size.y and slot26 or slot27
					slot17.transform.localScale = Vector3.New(slot28, slot28, 0)
				end

				for slot22, slot23 in pairs(uv0.bgs_) do
					if slot22 ~= "STblack" then
						slot23.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot15 = uv0.actors_["1097ui_story"].transform

			if 1.966 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0.var_.moveOldPos1097ui_story = slot15.localPosition
			end

			slot17 = 0.001

			if slot16 <= uv0.time_ and uv0.time_ < slot16 + slot17 then
				slot15.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot16) / slot17)
				slot21 = manager.ui.mainCamera.transform.position - slot15.position
				slot15.forward = Vector3.New(slot21.x, slot21.y, slot21.z)
				slot22 = slot15.localEulerAngles
				slot22.z = 0
				slot22.x = 0
				slot15.localEulerAngles = slot22
			end

			if uv0.time_ >= slot16 + slot17 and uv0.time_ < slot16 + slot17 + slot0 then
				slot15.localPosition = Vector3.New(0, 100, 0)
				slot20 = manager.ui.mainCamera.transform.position - slot15.position
				slot15.forward = Vector3.New(slot20.x, slot20.y, slot20.z)
				slot21 = slot15.localEulerAngles
				slot21.z = 0
				slot21.x = 0
				slot15.localEulerAngles = slot21
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot19 = 1

			if 7.51666666666667 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0.dialog_:SetActive(true)

				uv0.dialog_.transform.localScale = Vector3(0.8, 0.95, 1)

				LeanTween.scale(uv0.dialog_, Vector3.one, 0.2)

				slot20 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot20:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot20:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[113122045].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122045", "story_v_out_113122.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_113122", "113122045", "story_v_out_113122.awb") / 1000 > 0 and slot19 < slot24 and uv0.duration_ < slot24 + slot18 then
						slot19 = slot24
						uv0.duration_ = slot24 + slot18
					end

					if slot22.prefab_name ~= "" and uv0.actors_[slot22.prefab_name] ~= nil then
						uv0:RecordAudio("113122045", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot22.prefab_name].transform, "story_v_out_113122", "113122045", "story_v_out_113122.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_113122", "113122045", "story_v_out_113122.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot18 = slot18 + 0.3
			slot21 = uv0:FormatText(StoryWordCfg[113122045].content)
			slot23 = string.split(slot21, ".")

			if #string.split(slot21, "\n") >= 4 or #slot23 >= 4 then
				slot19 = slot19 * 3
			end

			if slot18 <= uv0.time_ and uv0.time_ < slot18 + slot19 then
				uv0.typewritter.percent = (uv0.time_ - slot18) / slot19

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot18 + slot19 and uv0.time_ < slot18 + slot19 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end
}
