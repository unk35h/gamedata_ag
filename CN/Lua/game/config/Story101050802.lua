return {
	Play105082001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play105082002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")
			end

			slot4 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			if uv0.bgs_.B14 == nil then
				slot6 = Object.Instantiate(uv0.paintGo_)
				slot6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot5)
				slot6.name = slot5
				slot6.transform.parent = uv0.stage_.transform
				slot6.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot5] = slot6
			end

			slot6 = uv0.bgs_.B14

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				if slot6.GetComponent(slot6, "SpriteRenderer") then
					uv0.var_.alphaOldValueB14 = slot8.material:GetColor("_Color").a
					uv0.var_.alphaMatValueB14 = slot8.material
				end

				uv0.var_.alphaOldValueB14 = 0
			end

			slot8 = 1.5

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot10 = Mathf.Lerp(uv0.var_.alphaOldValueB14, 1, (uv0.time_ - slot7) / slot8)

				if uv0.var_.alphaMatValueB14 then
					slot11 = uv0.var_.alphaMatValueB14
					slot12 = slot11:GetColor("_Color")
					slot12.a = slot10

					slot11:SetColor("_Color", slot12)
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.alphaMatValueB14 then
				slot9 = uv0.var_.alphaMatValueB14
				slot10 = slot9:GetColor("_Color")
				slot10.a = 1

				slot9:SetColor("_Color", slot10)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				slot10 = manager.ui.mainCamera.transform.localPosition
				slot12 = uv0.bgs_.B14
				slot12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot10.x, slot10.y, 0)
				slot12.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot12:GetComponent("SpriteRenderer") and slot13.sprite then
					slot16 = manager.ui.mainCameraCom_
					slot17 = 2 * (slot12.transform.localPosition - slot10).z * Mathf.Tan(slot16.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot23 = slot17 * slot16.aspect / slot13.sprite.bounds.size.x > slot17 / slot13.sprite.bounds.size.y and slot21 or slot22
					slot12.transform.localScale = Vector3.New(slot23, slot23, 0)
				end

				for slot17, slot18 in pairs(uv0.bgs_) do
					if slot17 ~= "B14" then
						slot18.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot10 + 2 and uv0.time_ < slot10 + slot11 + slot0 then
				uv0.allBtn_.enabled = true
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot13 = 0.25

			if 2 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.dialog_:SetActive(true)

				uv0.dialog_.transform.localScale = Vector3(0.8, 0.95, 1)

				LeanTween.scale(uv0.dialog_, Vector3.one, 0.2)

				slot14 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot14:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot14:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082001].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = slot12 + 0.3
			slot15 = uv0:FormatText(StoryWordCfg[105082001].content)
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
	Play105082002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.4

		if ({
			ja = 3.233,
			zh = 5.4
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
				uv0:Play105082003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1035ui_story"] == nil then
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

			slot2 = uv0.actors_["1035ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos1035ui_story = slot2.localPosition
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1035ui_story, Vector3.New(0, -1.1, -5), (uv0.time_ - slot3) / slot4)
				slot8 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot8.x, slot8.y, slot8.z)
				slot9 = slot2.localEulerAngles
				slot9.z = 0
				slot9.x = 0
				slot2.localEulerAngles = slot9
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(0, -1.1, -5)
				slot7 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot2.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot2.localEulerAngles = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/1035/1035action/1035action6_1")
			end

			slot6 = uv0.actors_["1035ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect1035ui_story == nil then
				uv0.var_.characterEffect1035ui_story = slot6.GetComponentInChildren(slot6, typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot9 = (uv0.time_ - slot7) / slot8

				if uv0.var_.characterEffect1035ui_story then
					uv0.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect1035ui_story then
				uv0.var_.characterEffect1035ui_story.fillFlat = false
			end

			slot10 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082002].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082002", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082002", "story_v_out_105082.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("105082002", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_105082", "105082002", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082002", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[105082002].content)
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
	Play105082003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.633

		if ({
			ja = 6.633,
			zh = 6
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
				uv0:Play105082004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["3008ui_story"] == nil then
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

			slot2 = uv0.actors_["3008ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect3008ui_story == nil then
				uv0.var_.characterEffect3008ui_story = slot2.GetComponentInChildren(slot2, typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect3008ui_story then
					uv0.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect3008ui_story then
				uv0.var_.characterEffect3008ui_story.fillFlat = false
			end

			slot5 = uv0.actors_["3008ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos3008ui_story = slot5.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3008ui_story, Vector3.New(0, -1.56, -3.7), (uv0.time_ - slot6) / slot7)
				slot11 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot5.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot5.localEulerAngles = slot12
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(0, -1.56, -3.7)
				slot10 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot5.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot5.localEulerAngles = slot11
			end

			slot8 = uv0.actors_["1035ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos1035ui_story = slot8.localPosition
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(0, 100, 0)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/3008/3008action/3008action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			slot14 = 0.75

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082003].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082003", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082003", "story_v_out_105082.awb") / 1000 > 0 and slot14 < slot18 and uv0.duration_ < slot18 + slot13 then
						slot14 = slot18
						uv0.duration_ = slot18 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						uv0:RecordAudio("105082003", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_105082", "105082003", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082003", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = uv0:FormatText(StoryWordCfg[105082003].content)
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
	Play105082004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.566

		if ({
			ja = 2.566,
			zh = 2.233
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
				uv0:Play105082005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["4010ui_story"] == nil then
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

			slot2 = uv0.actors_["4010ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = slot2.GetComponentInChildren(slot2, typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = false
			end

			slot5 = uv0.actors_["3008ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect3008ui_story == nil then
				uv0.var_.characterEffect3008ui_story = slot5.GetComponentInChildren(slot5, typeof(CharacterEffect))
			end

			slot7 = 0.1

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.characterEffect3008ui_story then
					uv0.var_.characterEffect3008ui_story.fillFlat = true
					uv0.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot8)
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect3008ui_story then
				uv0.var_.characterEffect3008ui_story.fillFlat = true
				uv0.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			slot8 = uv0.actors_["3008ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos3008ui_story = slot8.localPosition
			end

			slot10 = 0.5

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3008ui_story, Vector3.New(1.1, -1.56, -3.7), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(1.1, -1.56, -3.7)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			slot11 = uv0.actors_["4010ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.var_.moveOldPos4010ui_story = slot11.localPosition
			end

			slot13 = 0.001

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4010ui_story, Vector3.New(-1.1, -1.64, -4.6), (uv0.time_ - slot12) / slot13)
				slot17 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot11.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot11.localEulerAngles = slot18
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot11.localPosition = Vector3.New(-1.1, -1.64, -4.6)
				slot16 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot11.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot11.localEulerAngles = slot17
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			slot17 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082004].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082004", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082004", "story_v_out_105082.awb") / 1000 > 0 and slot17 < slot21 and uv0.duration_ < slot21 + slot16 then
						slot17 = slot21
						uv0.duration_ = slot21 + slot16
					end

					if slot19.prefab_name ~= "" and uv0.actors_[slot19.prefab_name] ~= nil then
						uv0:RecordAudio("105082004", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot19.prefab_name].transform, "story_v_out_105082", "105082004", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082004", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot19 = uv0:FormatText(StoryWordCfg[105082004].content)
			slot21 = string.split(slot19, ".")

			if #string.split(slot19, "\n") >= 4 or #slot21 >= 4 then
				slot17 = slot17 * 3
			end

			if slot16 <= uv0.time_ and uv0.time_ < slot16 + slot17 then
				uv0.typewritter.percent = (uv0.time_ - slot16) / slot17

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot16 + slot17 and uv0.time_ < slot16 + slot17 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play105082005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.566

		if ({
			ja = 7.566,
			zh = 4.333
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
				uv0:Play105082006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["3009ui_story"] == nil then
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

			slot2 = uv0.actors_["3009ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect3009ui_story == nil then
				uv0.var_.characterEffect3009ui_story = slot2.GetComponentInChildren(slot2, typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect3009ui_story then
					uv0.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect3009ui_story then
				uv0.var_.characterEffect3009ui_story.fillFlat = false
			end

			slot5 = uv0.actors_["4010ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = slot5.GetComponentInChildren(slot5, typeof(CharacterEffect))
			end

			slot7 = 0.1

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = true
					uv0.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot8)
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = true
				uv0.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			slot8 = uv0.actors_["3008ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos3008ui_story = slot8.localPosition
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(0, 100, 0)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			slot11 = uv0.actors_["3009ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.var_.moveOldPos3009ui_story = slot11.localPosition
			end

			slot13 = 0.001

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3009ui_story, Vector3.New(1.1, -1.8, -4.2), (uv0.time_ - slot12) / slot13)
				slot17 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot11.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot11.localEulerAngles = slot18
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot11.localPosition = Vector3.New(1.1, -1.8, -4.2)
				slot16 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot11.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot11.localEulerAngles = slot17
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/3009action/3009action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot17 = 0.65

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082005].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082005", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082005", "story_v_out_105082.awb") / 1000 > 0 and slot17 < slot21 and uv0.duration_ < slot21 + slot16 then
						slot17 = slot21
						uv0.duration_ = slot21 + slot16
					end

					if slot19.prefab_name ~= "" and uv0.actors_[slot19.prefab_name] ~= nil then
						uv0:RecordAudio("105082005", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot19.prefab_name].transform, "story_v_out_105082", "105082005", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082005", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot19 = uv0:FormatText(StoryWordCfg[105082005].content)
			slot21 = string.split(slot19, ".")

			if #string.split(slot19, "\n") >= 4 or #slot21 >= 4 then
				slot17 = slot17 * 3
			end

			if slot16 <= uv0.time_ and uv0.time_ < slot16 + slot17 then
				uv0.typewritter.percent = (uv0.time_ - slot16) / slot17

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot16 + slot17 and uv0.time_ < slot16 + slot17 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play105082006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.133

		if ({
			ja = 1.999999999999,
			zh = 2.133
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
				uv0:Play105082007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["4010ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = false
			end

			slot4 = uv0.actors_["3009ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect3009ui_story == nil then
				uv0.var_.characterEffect3009ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect3009ui_story then
					uv0.var_.characterEffect3009ui_story.fillFlat = true
					uv0.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot7)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect3009ui_story then
				uv0.var_.characterEffect3009ui_story.fillFlat = true
				uv0.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			slot9 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082006].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082006", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082006", "story_v_out_105082.awb") / 1000 > 0 and slot9 < slot13 and uv0.duration_ < slot13 + slot8 then
						slot9 = slot13
						uv0.duration_ = slot13 + slot8
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						uv0:RecordAudio("105082006", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_105082", "105082006", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082006", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot11 = uv0:FormatText(StoryWordCfg[105082006].content)
			slot13 = string.split(slot11, ".")

			if #string.split(slot11, "\n") >= 4 or #slot13 >= 4 then
				slot9 = slot9 * 3
			end

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				uv0.typewritter.percent = (uv0.time_ - slot8) / slot9

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play105082007 = function (slot0, slot1)
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
				uv0:Play105082008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["4010ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = true
					uv0.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = true
				uv0.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			slot4 = uv0.actors_["3009ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos3009ui_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3009ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot5) / slot6)
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

			slot7 = uv0.actors_["4010ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos4010ui_story = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, 100, 0)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			slot11 = 1.3

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082007].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[105082007].content)
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
	Play105082008 = function (slot0, slot1)
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
				uv0:Play105082009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_5", "se_story_5_signal", "")
			end

			slot4 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082008].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot6 = uv0:FormatText(StoryWordCfg[105082008].content)
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
	Play105082009 = function (slot0, slot1)
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
				uv0:Play105082010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.725

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082009].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[105082009].content)
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
	Play105082010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 9.866

		if ({
			ja = 9.8,
			zh = 9.866
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
				uv0:Play105082011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["4010ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			slot5 = uv0.actors_["4010ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos4010ui_story = slot5.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4010ui_story, Vector3.New(0, -1.64, -4.6), (uv0.time_ - slot6) / slot7)
				slot11 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot5.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot5.localEulerAngles = slot12
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(0, -1.64, -4.6)
				slot10 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot5.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot5.localEulerAngles = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			slot10 = 1.2

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082010].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082010", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082010", "story_v_out_105082.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("105082010", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_105082", "105082010", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082010", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[105082010].content)
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
	Play105082011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.4

		if ({
			ja = 4.4,
			zh = 1.999999999999
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
				uv0:Play105082012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["2020_tpose"] == nil then
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

			slot2 = uv0.actors_["2020_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect2020_tpose == nil then
				uv0.var_.characterEffect2020_tpose = slot2.GetComponentInChildren(slot2, typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect2020_tpose then
					uv0.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect2020_tpose then
				uv0.var_.characterEffect2020_tpose.fillFlat = false
			end

			slot5 = uv0.actors_["4010ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = slot5.GetComponentInChildren(slot5, typeof(CharacterEffect))
			end

			slot7 = 0.1

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = true
					uv0.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot8)
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = true
				uv0.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			slot8 = uv0.actors_["4010ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos4010ui_story = slot8.localPosition
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(0, 100, 0)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			slot11 = uv0.actors_["2020_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.var_.moveOldPos2020_tpose = slot11.localPosition
			end

			slot13 = 0.001

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2020_tpose, Vector3.New(-1.1, -1.25, -3.5), (uv0.time_ - slot12) / slot13)
				slot17 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot11.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot11.localEulerAngles = slot18
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot11.localPosition = Vector3.New(-1.1, -1.25, -3.5)
				slot16 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot11.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot11.localEulerAngles = slot17
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			slot16 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[34].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082011].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082011", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082011", "story_v_out_105082.awb") / 1000 > 0 and slot16 < slot20 and uv0.duration_ < slot20 + slot15 then
						slot16 = slot20
						uv0.duration_ = slot20 + slot15
					end

					if slot18.prefab_name ~= "" and uv0.actors_[slot18.prefab_name] ~= nil then
						uv0:RecordAudio("105082011", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot18.prefab_name].transform, "story_v_out_105082", "105082011", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082011", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot18 = uv0:FormatText(StoryWordCfg[105082011].content)
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
	Play105082012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.8

		if ({
			ja = 4.8,
			zh = 3.033
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
				uv0:Play105082013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_5", "se_story_5_cheer", "")
			end

			if uv0.actors_["2030_tpose"] == nil then
				slot4 = Object.Instantiate(Asset.Load("Char/" .. slot3), uv0.stage_.transform)
				slot4.name = slot3
				slot4.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot3] = slot4
				slot4:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot4, typeof(DynamicBoneHelper)) then
					slot6.EnableDynamicBone(slot6, false)
				end

				uv0:ShowWeapon(slot5.transform, false)

				uv0.var_[slot3 .. "Animator"] = slot5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot3 .. "Animator"].applyRootMotion = true
				uv0.var_[slot3 .. "LipSync"] = slot5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			slot4 = uv0.actors_["2030_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect2030_tpose == nil then
				uv0.var_.characterEffect2030_tpose = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect2030_tpose then
					uv0.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect2030_tpose then
				uv0.var_.characterEffect2030_tpose.fillFlat = false
			end

			slot7 = uv0.actors_["2020_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.characterEffect2020_tpose == nil then
				uv0.var_.characterEffect2020_tpose = slot7.GetComponentInChildren(slot7, typeof(CharacterEffect))
			end

			slot9 = 0.1

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.characterEffect2020_tpose then
					uv0.var_.characterEffect2020_tpose.fillFlat = true
					uv0.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, slot10)
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.characterEffect2020_tpose then
				uv0.var_.characterEffect2020_tpose.fillFlat = true
				uv0.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			slot10 = uv0.actors_["2030_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos2030_tpose = slot10.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2030_tpose, Vector3.New(1.1, -1.25, -3.5), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(1.1, -1.25, -3.5)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			slot15 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[34].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082012].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082012", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082012", "story_v_out_105082.awb") / 1000 > 0 and slot15 < slot19 and uv0.duration_ < slot19 + slot14 then
						slot15 = slot19
						uv0.duration_ = slot19 + slot14
					end

					if slot17.prefab_name ~= "" and uv0.actors_[slot17.prefab_name] ~= nil then
						uv0:RecordAudio("105082012", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot17.prefab_name].transform, "story_v_out_105082", "105082012", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082012", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot17 = uv0:FormatText(StoryWordCfg[105082012].content)
			slot19 = string.split(slot17, ".")

			if #string.split(slot17, "\n") >= 4 or #slot19 >= 4 then
				slot15 = slot15 * 3
			end

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				uv0.typewritter.percent = (uv0.time_ - slot14) / slot15

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play105082013 = function (slot0, slot1)
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
				uv0:Play105082014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["2030_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect2030_tpose == nil then
				uv0.var_.characterEffect2030_tpose = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect2030_tpose then
					uv0.var_.characterEffect2030_tpose.fillFlat = true
					uv0.var_.characterEffect2030_tpose.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect2030_tpose then
				uv0.var_.characterEffect2030_tpose.fillFlat = true
				uv0.var_.characterEffect2030_tpose.fillRatio = 0.5
			end

			slot4 = uv0.actors_["2030_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos2030_tpose = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2030_tpose, Vector3.New(0, 100, 0), (uv0.time_ - slot5) / slot6)
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

			slot7 = uv0.actors_["2020_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos2020_tpose = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2020_tpose, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, 100, 0)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			slot11 = 1.175

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082013].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[105082013].content)
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
	Play105082014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 9

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play105082015(uv1)
			end
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

			if 2 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
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

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot6 = 0.175

			if 4 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.dialog_:SetActive(true)

				uv0.dialog_.transform.localScale = Vector3(0.8, 0.95, 1)

				LeanTween.scale(uv0.dialog_, Vector3.one, 0.2)

				slot7 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot7:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot7:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082014].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = slot5 + 0.3
			slot8 = uv0:FormatText(StoryWordCfg[105082014].content)
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
	Play105082015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.999999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play105082016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1059ui_story"] == nil then
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

			slot2 = uv0.actors_["1059ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1059ui_story == nil then
				uv0.var_.characterEffect1059ui_story = slot2.GetComponentInChildren(slot2, typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1059ui_story then
					uv0.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1059ui_story then
				uv0.var_.characterEffect1059ui_story.fillFlat = false
			end

			slot5 = uv0.actors_["1059ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos1059ui_story = slot5.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1059ui_story, Vector3.New(0, -1.1, -5.4), (uv0.time_ - slot6) / slot7)
				slot11 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot5.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot5.localEulerAngles = slot12
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(0, -1.1, -5.4)
				slot10 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot5.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot5.localEulerAngles = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/1059/1059action/1059action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			slot11 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082015].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082015", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082015", "story_v_out_105082.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
						slot11 = slot15
						uv0.duration_ = slot15 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						uv0:RecordAudio("105082015", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_105082", "105082015", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082015", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[105082015].content)
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
	Play105082016 = function (slot0, slot1)
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
				uv0:Play105082017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1059ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1059ui_story == nil then
				uv0.var_.characterEffect1059ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1059ui_story then
					uv0.var_.characterEffect1059ui_story.fillFlat = true
					uv0.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1059ui_story then
				uv0.var_.characterEffect1059ui_story.fillFlat = true
				uv0.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			slot4 = uv0.actors_["1059ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1059ui_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1059ui_story, Vector3.New(20, -1.1, -5.4), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(20, -1.1, -5.4)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 1.25

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082016].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[105082016].content)
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
	Play105082017 = function (slot0, slot1)
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
				uv0:Play105082018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_5", "se_story_5_arrow", "")
			end

			slot4 = 0.9

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082017].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot6 = uv0:FormatText(StoryWordCfg[105082017].content)
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
	Play105082018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.833

		if ({
			ja = 2.833,
			zh = 2.533
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
				uv0:Play105082019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1148ui_story"] == nil then
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

			slot2 = uv0.actors_["1148ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = slot2.GetComponentInChildren(slot2, typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = false
			end

			slot5 = uv0.actors_["1148ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos1148ui_story = slot5.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(-0.83, -0.85, -5.6), (uv0.time_ - slot6) / slot7)
				slot11 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot5.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot5.localEulerAngles = slot12
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(-0.83, -0.85, -5.6)
				slot10 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot5.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot5.localEulerAngles = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148action/1148action3_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			slot11 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082018].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082018", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082018", "story_v_out_105082.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
						slot11 = slot15
						uv0.duration_ = slot15 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						uv0:RecordAudio("105082018", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_105082", "105082018", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082018", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[105082018].content)
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
	Play105082019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.533

		if ({
			ja = 2.533,
			zh = 1.999999999999
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
				uv0:Play105082020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1027ui_story"] == nil then
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

			slot2 = uv0.actors_["1027ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = slot2.GetComponentInChildren(slot2, typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			slot5 = uv0.actors_["1148ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = slot5.GetComponentInChildren(slot5, typeof(CharacterEffect))
			end

			slot7 = 0.1

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = true
					uv0.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot8)
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = true
				uv0.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			slot8 = uv0.actors_["1027ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos1027ui_story = slot8.localPosition
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0.92, -0.922, -5.1), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(0.92, -0.922, -5.1)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			slot14 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082019].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082019", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082019", "story_v_out_105082.awb") / 1000 > 0 and slot14 < slot18 and uv0.duration_ < slot18 + slot13 then
						slot14 = slot18
						uv0.duration_ = slot18 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						uv0:RecordAudio("105082019", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_105082", "105082019", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082019", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = uv0:FormatText(StoryWordCfg[105082019].content)
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
	Play105082020 = function (slot0, slot1)
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
				uv0:Play105082021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1027ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			slot5 = 0.775

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082020].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[105082020].content)
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
	Play105082021 = function (slot0, slot1)
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
				uv0:Play105082022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1027ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1027ui_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(10, -0.922, -5.1)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			slot4 = uv0.actors_["1148ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1148ui_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -0.85, -5.6)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 1.125

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082021].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[105082021].content)
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
	Play105082022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 9.966

		if ({
			ja = 9.966,
			zh = 9.066
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
				uv0:Play105082023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.175

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_mmr")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082022].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082022", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082022", "story_v_out_105082.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("105082022", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105082", "105082022", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082022", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[105082022].content)
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
	Play105082023 = function (slot0, slot1)
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
				uv0:Play105082024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082023].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[105082023].content)
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
	Play105082024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 13

		if ({
			ja = 13,
			zh = 7.566
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
				uv0:Play105082025(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story", "se_story_robot_long", "")
			end

			if uv0.actors_["3005_tpose"] == nil then
				slot4 = Object.Instantiate(Asset.Load("Char/" .. slot3), uv0.stage_.transform)
				slot4.name = slot3
				slot4.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot3] = slot4
				slot4:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot4, typeof(DynamicBoneHelper)) then
					slot6.EnableDynamicBone(slot6, false)
				end

				uv0:ShowWeapon(slot5.transform, false)

				uv0.var_[slot3 .. "Animator"] = slot5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot3 .. "Animator"].applyRootMotion = true
				uv0.var_[slot3 .. "LipSync"] = slot5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			slot4 = uv0.actors_["3005_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect3005_tpose == nil then
				uv0.var_.characterEffect3005_tpose = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect3005_tpose then
					uv0.var_.characterEffect3005_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect3005_tpose then
				uv0.var_.characterEffect3005_tpose.fillFlat = false
			end

			slot7 = uv0.actors_["3005_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos3005_tpose = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3005_tpose, Vector3.New(0, -2, -2.03), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -2, -2.03)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("3005_tpose", "StoryTimeline/CharAction/story3005/story3005action/3005action1_1")
			end

			slot12 = 0.6

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[58].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082024].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082024", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082024", "story_v_out_105082.awb") / 1000 > 0 and slot12 < slot16 and uv0.duration_ < slot16 + slot11 then
						slot12 = slot16
						uv0.duration_ = slot16 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						uv0:RecordAudio("105082024", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_105082", "105082024", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082024", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = uv0:FormatText(StoryWordCfg[105082024].content)
			slot16 = string.split(slot14, ".")

			if #string.split(slot14, "\n") >= 4 or #slot16 >= 4 then
				slot12 = slot12 * 3
			end

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				uv0.typewritter.percent = (uv0.time_ - slot11) / slot12

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play105082025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.6

		if ({
			ja = 2.6,
			zh = 2.366
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
				uv0:Play105082026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1027ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			slot4 = uv0.actors_["3005_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect3005_tpose == nil then
				uv0.var_.characterEffect3005_tpose = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect3005_tpose then
					uv0.var_.characterEffect3005_tpose.fillFlat = true
					uv0.var_.characterEffect3005_tpose.fillRatio = Mathf.Lerp(0, 0.5, slot7)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect3005_tpose then
				uv0.var_.characterEffect3005_tpose.fillFlat = true
				uv0.var_.characterEffect3005_tpose.fillRatio = 0.5
			end

			slot7 = uv0.actors_["3005_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos3005_tpose = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3005_tpose, Vector3.New(10, -2, -2.03), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(10, -2, -2.03)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			slot10 = uv0.actors_["1027ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos1027ui_story = slot10.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, -0.922, -5.1)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			slot16 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082025].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082025", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082025", "story_v_out_105082.awb") / 1000 > 0 and slot16 < slot20 and uv0.duration_ < slot20 + slot15 then
						slot16 = slot20
						uv0.duration_ = slot20 + slot15
					end

					if slot18.prefab_name ~= "" and uv0.actors_[slot18.prefab_name] ~= nil then
						uv0:RecordAudio("105082025", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot18.prefab_name].transform, "story_v_out_105082", "105082025", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082025", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot18 = uv0:FormatText(StoryWordCfg[105082025].content)
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
	Play105082026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.999999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play105082027(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1080ui_story"] == nil then
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

			slot2 = uv0.actors_["1080ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1080ui_story == nil then
				uv0.var_.characterEffect1080ui_story = slot2.GetComponentInChildren(slot2, typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1080ui_story then
					uv0.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1080ui_story then
				uv0.var_.characterEffect1080ui_story.fillFlat = false
			end

			slot5 = uv0.actors_["1027ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = slot5.GetComponentInChildren(slot5, typeof(CharacterEffect))
			end

			slot7 = 0.1

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot8)
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			slot8 = uv0.actors_["1027ui_story"].transform

			if 0.033 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos1027ui_story = slot8.localPosition
			end

			slot10 = 0.5

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0.92, -0.922, -5.1), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(0.92, -0.922, -5.1)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			slot11 = uv0.actors_["1027ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.var_.moveOldPos1027ui_story = slot11.localPosition
			end

			slot13 = 0.001

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (uv0.time_ - slot12) / slot13)
				slot17 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot11.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot11.localEulerAngles = slot18
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot11.localPosition = Vector3.New(0, -0.922, -5.1)
				slot16 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot11.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot11.localEulerAngles = slot17
			end

			slot14 = uv0.actors_["1080ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.var_.moveOldPos1080ui_story = slot14.localPosition
			end

			slot16 = 0.001

			if slot15 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
				slot14.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1080ui_story, Vector3.New(-0.79, -0.97, -5.5), (uv0.time_ - slot15) / slot16)
				slot20 = manager.ui.mainCamera.transform.position - slot14.position
				slot14.forward = Vector3.New(slot20.x, slot20.y, slot20.z)
				slot21 = slot14.localEulerAngles
				slot21.z = 0
				slot21.x = 0
				slot14.localEulerAngles = slot21
			end

			if uv0.time_ >= slot15 + slot16 and uv0.time_ < slot15 + slot16 + slot0 then
				slot14.localPosition = Vector3.New(-0.79, -0.97, -5.5)
				slot19 = manager.ui.mainCamera.transform.position - slot14.position
				slot14.forward = Vector3.New(slot19.x, slot19.y, slot19.z)
				slot20 = slot14.localEulerAngles
				slot20.z = 0
				slot20.x = 0
				slot14.localEulerAngles = slot20
			end

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/1080/1080action/1080action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			slot20 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082026].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082026", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082026", "story_v_out_105082.awb") / 1000 > 0 and slot20 < slot24 and uv0.duration_ < slot24 + slot19 then
						slot20 = slot24
						uv0.duration_ = slot24 + slot19
					end

					if slot22.prefab_name ~= "" and uv0.actors_[slot22.prefab_name] ~= nil then
						uv0:RecordAudio("105082026", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot22.prefab_name].transform, "story_v_out_105082", "105082026", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082026", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot22 = uv0:FormatText(StoryWordCfg[105082026].content)
			slot24 = string.split(slot22, ".")

			if #string.split(slot22, "\n") >= 4 or #slot24 >= 4 then
				slot20 = slot20 * 3
			end

			if slot19 <= uv0.time_ and uv0.time_ < slot19 + slot20 then
				uv0.typewritter.percent = (uv0.time_ - slot19) / slot20

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot19 + slot20 and uv0.time_ < slot19 + slot20 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play105082027 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.466

		if ({
			ja = 3.466,
			zh = 1.8
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
				uv0:Play105082028(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1080ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1080ui_story == nil then
				uv0.var_.characterEffect1080ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1080ui_story then
					uv0.var_.characterEffect1080ui_story.fillFlat = true
					uv0.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1080ui_story then
				uv0.var_.characterEffect1080ui_story.fillFlat = true
				uv0.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			slot4 = uv0.actors_["1027ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1027ui_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -0.922, -5.1)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot7 = uv0.actors_["1080ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1080ui_story = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1080ui_story, Vector3.New(20, -0.97, -5.5), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(20, -0.97, -5.5)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			slot11 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_mmr")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082027].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082027", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082027", "story_v_out_105082.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
						slot11 = slot15
						uv0.duration_ = slot15 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						uv0:RecordAudio("105082027", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_105082", "105082027", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082027", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[105082027].content)
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
	Play105082028 = function (slot0, slot1)
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
				uv0:Play105082029(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082028].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[105082028].content)
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
	Play105082029 = function (slot0, slot1)
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
				uv0:Play105082030(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.6

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082029].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[105082029].content)
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
	Play105082030 = function (slot0, slot1)
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
				uv0:Play105082031(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_5", "se_story_5_robotstop", "")
			end

			slot4 = 1.2

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082030].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot6 = uv0:FormatText(StoryWordCfg[105082030].content)
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
	Play105082031 = function (slot0, slot1)
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
				uv0:Play105082032(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_5", "se_story_5_robotcollapse", "")
			end

			slot4 = 1.4

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082031].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot6 = uv0:FormatText(StoryWordCfg[105082031].content)
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
	Play105082032 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.5

		if ({
			ja = 5.5,
			zh = 4.666
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
				uv0:Play105082033(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.375

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_mmr")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082032].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082032", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082032", "story_v_out_105082.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("105082032", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105082", "105082032", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082032", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[105082032].content)
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
	Play105082033 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.833

		if ({
			ja = 2.833,
			zh = 2.533
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
				uv0:Play105082034(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1027ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			slot4 = uv0.actors_["1027ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1027ui_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(-0.92, -0.922, -5.1), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(-0.92, -0.922, -5.1)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			slot10 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082033].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082033", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082033", "story_v_out_105082.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("105082033", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_105082", "105082033", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082033", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[105082033].content)
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
	Play105082034 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.8

		if ({
			ja = 3.8,
			zh = 2.066
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
				uv0:Play105082035(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1059ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1059ui_story == nil then
				uv0.var_.characterEffect1059ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1059ui_story then
					uv0.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1059ui_story then
				uv0.var_.characterEffect1059ui_story.fillFlat = false
			end

			slot4 = uv0.actors_["1027ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot7)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			slot7 = uv0.actors_["1059ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1059ui_story = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1059ui_story, Vector3.New(1, -1.1, -5.4), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(1, -1.1, -5.4)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/1059/1059action/1059action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			slot13 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082034].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082034", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082034", "story_v_out_105082.awb") / 1000 > 0 and slot13 < slot17 and uv0.duration_ < slot17 + slot12 then
						slot13 = slot17
						uv0.duration_ = slot17 + slot12
					end

					if slot15.prefab_name ~= "" and uv0.actors_[slot15.prefab_name] ~= nil then
						uv0:RecordAudio("105082034", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot15.prefab_name].transform, "story_v_out_105082", "105082034", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082034", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot15 = uv0:FormatText(StoryWordCfg[105082034].content)
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
	Play105082035 = function (slot0, slot1)
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
				uv0:Play105082036(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1059ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1059ui_story == nil then
				uv0.var_.characterEffect1059ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1059ui_story then
					uv0.var_.characterEffect1059ui_story.fillFlat = true
					uv0.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1059ui_story then
				uv0.var_.characterEffect1059ui_story.fillFlat = true
				uv0.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			slot4 = uv0.actors_["1059ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1059ui_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1059ui_story, Vector3.New(20, -1.1, -5.4), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(20, -1.1, -5.4)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot7 = uv0.actors_["1027ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1027ui_story = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(10, -0.922, -5.1)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			slot11 = 0.575

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082035].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[105082035].content)
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
	Play105082036 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 10.433

		if ({
			ja = 10.433,
			zh = 5.666
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
				uv0:Play105082037(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1059ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1059ui_story == nil then
				uv0.var_.characterEffect1059ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1059ui_story then
					uv0.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1059ui_story then
				uv0.var_.characterEffect1059ui_story.fillFlat = false
			end

			slot4 = uv0.actors_["1059ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1059ui_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1059ui_story, Vector3.New(0, -1.1, -5.4), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -1.1, -5.4)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/1059/1059action/1059action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			slot10 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082036].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082036", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082036", "story_v_out_105082.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("105082036", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_105082", "105082036", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082036", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[105082036].content)
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
	Play105082037 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.5

		if ({
			ja = 2.5,
			zh = 2.2
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
				uv0:Play105082038(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1027ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			slot4 = uv0.actors_["1059ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1059ui_story == nil then
				uv0.var_.characterEffect1059ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1059ui_story then
					uv0.var_.characterEffect1059ui_story.fillFlat = true
					uv0.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot7)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1059ui_story then
				uv0.var_.characterEffect1059ui_story.fillFlat = true
				uv0.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			slot7 = uv0.actors_["1059ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1059ui_story = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1059ui_story, Vector3.New(20, -1.1, -5.4), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(20, -1.1, -5.4)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			slot10 = uv0.actors_["1027ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos1027ui_story = slot10.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(-0.92, -0.922, -5.1), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(-0.92, -0.922, -5.1)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			slot16 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082037].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082037", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082037", "story_v_out_105082.awb") / 1000 > 0 and slot16 < slot20 and uv0.duration_ < slot20 + slot15 then
						slot16 = slot20
						uv0.duration_ = slot20 + slot15
					end

					if slot18.prefab_name ~= "" and uv0.actors_[slot18.prefab_name] ~= nil then
						uv0:RecordAudio("105082037", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot18.prefab_name].transform, "story_v_out_105082", "105082037", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082037", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot18 = uv0:FormatText(StoryWordCfg[105082037].content)
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
	Play105082038 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.366

		if ({
			ja = 4.366,
			zh = 4.133
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
				uv0:Play105082039(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1148ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = false
			end

			slot4 = uv0.actors_["1027ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot7)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			slot7 = uv0.actors_["1148ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1148ui_story = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(0.83, -0.85, -5.6), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0.83, -0.85, -5.6)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148action/1148action9_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			slot13 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082038].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082038", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082038", "story_v_out_105082.awb") / 1000 > 0 and slot13 < slot17 and uv0.duration_ < slot17 + slot12 then
						slot13 = slot17
						uv0.duration_ = slot17 + slot12
					end

					if slot15.prefab_name ~= "" and uv0.actors_[slot15.prefab_name] ~= nil then
						uv0:RecordAudio("105082038", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot15.prefab_name].transform, "story_v_out_105082", "105082038", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082038", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot15 = uv0:FormatText(StoryWordCfg[105082038].content)
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
	Play105082039 = function (slot0, slot1)
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
				uv0:Play105082040(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1148ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = true
					uv0.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = true
				uv0.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			slot5 = 0.625

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082039].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[105082039].content)
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
	Play105082040 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.066

		if ({
			ja = 1.999999999999,
			zh = 2.066
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
				uv0:Play105082041(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1080ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1080ui_story == nil then
				uv0.var_.characterEffect1080ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1080ui_story then
					uv0.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1080ui_story then
				uv0.var_.characterEffect1080ui_story.fillFlat = false
			end

			slot4 = uv0.actors_["1148ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1148ui_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -0.85, -5.6)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot7 = uv0.actors_["1027ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1027ui_story = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(10, -0.922, -5.1)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			slot10 = uv0.actors_["1080ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos1080ui_story = slot10.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1080ui_story, Vector3.New(0, -0.97, -5.5), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, -0.97, -5.5)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/1080/1080action/1080action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			slot16 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082040].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082040", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082040", "story_v_out_105082.awb") / 1000 > 0 and slot16 < slot20 and uv0.duration_ < slot20 + slot15 then
						slot16 = slot20
						uv0.duration_ = slot20 + slot15
					end

					if slot18.prefab_name ~= "" and uv0.actors_[slot18.prefab_name] ~= nil then
						uv0:RecordAudio("105082040", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot18.prefab_name].transform, "story_v_out_105082", "105082040", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082040", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot18 = uv0:FormatText(StoryWordCfg[105082040].content)
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
	Play105082041 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play105082042(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office")
			end

			slot3 = uv0.actors_["1080ui_story"]

			if 2 < uv0.time_ and uv0.time_ <= slot4 + slot0 and uv0.var_.characterEffect1080ui_story == nil then
				uv0.var_.characterEffect1080ui_story = slot3.GetComponentInChildren(slot3, typeof(CharacterEffect))
			end

			slot5 = 0.1

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot6 = (uv0.time_ - slot4) / slot5

				if uv0.var_.characterEffect1080ui_story then
					uv0.var_.characterEffect1080ui_story.fillFlat = true
					uv0.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot6)
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.characterEffect1080ui_story then
				uv0.var_.characterEffect1080ui_story.fillFlat = true
				uv0.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			slot6 = uv0.bgs_.B14

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				if slot6.GetComponent(slot6, "SpriteRenderer") then
					uv0.var_.alphaOldValueB14 = slot8.material:GetColor("_Color").a
					uv0.var_.alphaMatValueB14 = slot8.material
				end

				uv0.var_.alphaOldValueB14 = 1
			end

			slot8 = 1.5

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot10 = Mathf.Lerp(uv0.var_.alphaOldValueB14, 0, (uv0.time_ - slot7) / slot8)

				if uv0.var_.alphaMatValueB14 then
					slot11 = uv0.var_.alphaMatValueB14
					slot12 = slot11:GetColor("_Color")
					slot12.a = slot10

					slot11:SetColor("_Color", slot12)
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.alphaMatValueB14 then
				slot9 = uv0.var_.alphaMatValueB14
				slot10 = slot9:GetColor("_Color")
				slot10.a = 0

				slot9:SetColor("_Color", slot10)
			end

			slot9 = uv0.bgs_.B14.transform

			if 1.5 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPosB14 = slot9.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPosB14, Vector3.New(0, -100, 10), (uv0.time_ - slot10) / slot11)
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(0, -100, 10)
			end

			if uv0.bgs_.A00 == nil then
				slot13 = Object.Instantiate(uv0.paintGo_)
				slot13:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot12)
				slot13.name = slot12
				slot13.transform.parent = uv0.stage_.transform
				slot13.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot12] = slot13
			end

			slot13 = uv0.bgs_.A00

			if 1.5 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				if slot13.GetComponent(slot13, "SpriteRenderer") then
					uv0.var_.alphaOldValueA00 = slot15.material:GetColor("_Color").a
					uv0.var_.alphaMatValueA00 = slot15.material
				end

				uv0.var_.alphaOldValueA00 = 0
			end

			slot15 = 1.5

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot17 = Mathf.Lerp(uv0.var_.alphaOldValueA00, 1, (uv0.time_ - slot14) / slot15)

				if uv0.var_.alphaMatValueA00 then
					slot18 = uv0.var_.alphaMatValueA00
					slot19 = slot18:GetColor("_Color")
					slot19.a = slot17

					slot18:SetColor("_Color", slot19)
				end
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 and uv0.var_.alphaMatValueA00 then
				slot16 = uv0.var_.alphaMatValueA00
				slot17 = slot16:GetColor("_Color")
				slot17.a = 1

				slot16:SetColor("_Color", slot17)
			end

			if 1.5 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				slot17 = manager.ui.mainCamera.transform.localPosition
				slot19 = uv0.bgs_.A00
				slot19.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot17.x, slot17.y, 0)
				slot19.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot19:GetComponent("SpriteRenderer") and slot20.sprite then
					slot23 = manager.ui.mainCameraCom_
					slot24 = 2 * (slot19.transform.localPosition - slot17).z * Mathf.Tan(slot23.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot30 = slot24 * slot23.aspect / slot20.sprite.bounds.size.x > slot24 / slot20.sprite.bounds.size.y and slot28 or slot29
					slot19.transform.localScale = Vector3.New(slot30, slot30, 0)
				end

				for slot24, slot25 in pairs(uv0.bgs_) do
					if slot24 ~= "A00" then
						slot25.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot17 = uv0.actors_["1080ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0.var_.moveOldPos1080ui_story = slot17.localPosition
			end

			slot19 = 0.001

			if slot18 <= uv0.time_ and uv0.time_ < slot18 + slot19 then
				slot17.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1080ui_story, Vector3.New(20, -0.97, -5.5), (uv0.time_ - slot18) / slot19)
				slot23 = manager.ui.mainCamera.transform.position - slot17.position
				slot17.forward = Vector3.New(slot23.x, slot23.y, slot23.z)
				slot24 = slot17.localEulerAngles
				slot24.z = 0
				slot24.x = 0
				slot17.localEulerAngles = slot24
			end

			if uv0.time_ >= slot18 + slot19 and uv0.time_ < slot18 + slot19 + slot0 then
				slot17.localPosition = Vector3.New(20, -0.97, -5.5)
				slot22 = manager.ui.mainCamera.transform.position - slot17.position
				slot17.forward = Vector3.New(slot22.x, slot22.y, slot22.z)
				slot23 = slot17.localEulerAngles
				slot23.z = 0
				slot23.x = 0
				slot17.localEulerAngles = slot23
			end

			if 0 < uv0.time_ and uv0.time_ <= slot20 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot20 + 2 and uv0.time_ < slot20 + slot21 + slot0 then
				uv0.allBtn_.enabled = true
			end

			slot23 = 0.225

			if 2 < uv0.time_ and uv0.time_ <= slot22 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082041].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot25 = uv0:FormatText(StoryWordCfg[105082041].content)
			slot27 = string.split(slot25, ".")

			if #string.split(slot25, "\n") >= 4 or #slot27 >= 4 then
				slot23 = slot23 * 3
			end

			if slot22 <= uv0.time_ and uv0.time_ < slot22 + slot23 then
				uv0.typewritter.percent = (uv0.time_ - slot22) / slot23

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot22 + slot23 and uv0.time_ < slot22 + slot23 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play105082042 = function (slot0, slot1)
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
				uv0:Play105082043(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082042].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[105082042].content)
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
	Play105082043 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.166

		if ({
			ja = 3.166,
			zh = 3.1
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
				uv0:Play105082044(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_mmr")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082043].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082043", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082043", "story_v_out_105082.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("105082043", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105082", "105082043", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082043", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[105082043].content)
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
	Play105082044 = function (slot0, slot1)
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
				uv0:Play105082045(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.875

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082044].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[105082044].content)
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
	Play105082045 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.166

		if ({
			ja = 8.166,
			zh = 5.266
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
				uv0:Play105082046(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.65

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_mmr")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082045].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082045", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082045", "story_v_out_105082.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("105082045", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105082", "105082045", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082045", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[105082045].content)
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
	Play105082046 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.4

		if ({
			ja = 2.4,
			zh = 2.1
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
				uv0:Play105082047(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1037ui_story"] == nil then
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

			slot2 = uv0.actors_["1037ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1037ui_story == nil then
				uv0.var_.characterEffect1037ui_story = slot2.GetComponentInChildren(slot2, typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1037ui_story then
					uv0.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1037ui_story then
				uv0.var_.characterEffect1037ui_story.fillFlat = false
			end

			slot5 = uv0.actors_["1037ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos1037ui_story = slot5.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1037ui_story, Vector3.New(0, -1.14, -5.21), (uv0.time_ - slot6) / slot7)
				slot11 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot5.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot5.localEulerAngles = slot12
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(0, -1.14, -5.21)
				slot10 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot5.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot5.localEulerAngles = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/1037/1037action/1037action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			slot11 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082046].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082046", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082046", "story_v_out_105082.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
						slot11 = slot15
						uv0.duration_ = slot15 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						uv0:RecordAudio("105082046", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_105082", "105082046", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082046", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[105082046].content)
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
	Play105082047 = function (slot0, slot1)
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
				uv0:Play105082048(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1037ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1037ui_story == nil then
				uv0.var_.characterEffect1037ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1037ui_story then
					uv0.var_.characterEffect1037ui_story.fillFlat = true
					uv0.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1037ui_story then
				uv0.var_.characterEffect1037ui_story.fillFlat = true
				uv0.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			slot5 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082047].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[105082047].content)
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
	Play105082048 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.6

		if ({
			ja = 5.6,
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
				uv0:Play105082049(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1037ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1037ui_story == nil then
				uv0.var_.characterEffect1037ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1037ui_story then
					uv0.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1037ui_story then
				uv0.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/1037/1037action/1037action2_2")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			slot7 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082048].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082048", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082048", "story_v_out_105082.awb") / 1000 > 0 and slot7 < slot11 and uv0.duration_ < slot11 + slot6 then
						slot7 = slot11
						uv0.duration_ = slot11 + slot6
					end

					if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
						uv0:RecordAudio("105082048", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_out_105082", "105082048", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082048", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot9 = uv0:FormatText(StoryWordCfg[105082048].content)
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
	Play105082049 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.5

		if ({
			ja = 5.5,
			zh = 5
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
			slot1 = uv0.actors_["1037ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1037ui_story == nil then
				uv0.var_.characterEffect1037ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1037ui_story then
					uv0.var_.characterEffect1037ui_story.fillFlat = true
					uv0.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1037ui_story then
				uv0.var_.characterEffect1037ui_story.fillFlat = true
				uv0.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			slot5 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_mmr")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[105082049].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082049", "story_v_out_105082.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_105082", "105082049", "story_v_out_105082.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
						slot5 = slot9
						uv0.duration_ = slot9 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						uv0:RecordAudio("105082049", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_105082", "105082049", "story_v_out_105082.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_105082", "105082049", "story_v_out_105082.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[105082049].content)
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
	end
}
