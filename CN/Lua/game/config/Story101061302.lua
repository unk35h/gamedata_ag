return {
	Play106132001 = function (slot0, slot1)
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
				uv0:Play106132002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.C01b == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.C01b
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "C01b" then
						slot11.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot3 = uv0.bgs_.C01b

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				if slot3.GetComponent(slot3, "SpriteRenderer") then
					uv0.var_.alphaOldValueC01b = slot5.material:GetColor("_Color").a
					uv0.var_.alphaMatValueC01b = slot5.material
				end

				uv0.var_.alphaOldValueC01b = 0
			end

			slot5 = 1.5

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot7 = Mathf.Lerp(uv0.var_.alphaOldValueC01b, 1, (uv0.time_ - slot4) / slot5)

				if uv0.var_.alphaMatValueC01b then
					slot8 = uv0.var_.alphaMatValueC01b
					slot9 = slot8:GetColor("_Color")
					slot9.a = slot7

					slot8:SetColor("_Color", slot9)
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.alphaMatValueC01b then
				slot6 = uv0.var_.alphaMatValueC01b
				slot7 = slot6:GetColor("_Color")
				slot7.a = 1

				slot6:SetColor("_Color", slot7)
			end

			slot6 = manager.ui.mainCamera.transform

			if 1 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.var_.shakeOldPos = slot6.localPosition
			end

			slot8 = 0.6

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot10, slot11 = math.modf((uv0.time_ - slot7) / 0.066)
				slot6.localPosition = Vector3.New(slot11 * 0.13, slot11 * 0.13, slot11 * 0.13) + uv0.var_.shakeOldPos
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot6.localPosition = uv0.var_.shakeOldPos
			end

			slot9 = manager.ui.mainCamera.transform

			if 2 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.shakeOldPos = slot9.localPosition
			end

			slot11 = 0.6

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot13, slot14 = math.modf((uv0.time_ - slot10) / 0.099)
				slot9.localPosition = Vector3.New(slot14 * 0.13, slot14 * 0.13, slot14 * 0.13) + uv0.var_.shakeOldPos
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = uv0.var_.shakeOldPos
			end

			slot13 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot14 + 2 and uv0.time_ < slot14 + slot15 + slot0 then
				uv0.allBtn_.enabled = true
			end

			slot17 = 2.10843759123236

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_6", "se_story_6_giant_sword", "")
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot19 = 0.65

			if 2 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
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

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132001].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot18 = slot18 + 0.3
			slot21 = uv0:FormatText(StoryWordCfg[106132001].content)
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
	end,
	Play106132002 = function (slot0, slot1)
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
				uv0:Play106132003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.275

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132002].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[106132002].content)
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
	Play106132003 = function (slot0, slot1)
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
				uv0:Play106132004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132003].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[106132003].content)
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
	Play106132004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.9

		if ({
			ja = 2.866,
			zh = 2.9
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
				uv0:Play106132005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["3004_tpose"] == nil then
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

			slot2 = uv0.actors_["3004_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect3004_tpose == nil then
				uv0.var_.characterEffect3004_tpose = slot2.GetComponentInChildren(slot2, typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect3004_tpose then
					uv0.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect3004_tpose then
				uv0.var_.characterEffect3004_tpose.fillFlat = false
			end

			slot5 = uv0.actors_["3004_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos3004_tpose = slot5.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3004_tpose, Vector3.New(0, -2.27, -2.5), (uv0.time_ - slot6) / slot7)
				slot11 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot5.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot5.localEulerAngles = slot12
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(0, -2.27, -2.5)
				slot10 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot5.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot5.localEulerAngles = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			slot10 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132004].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132004", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132004", "story_v_out_106132.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("106132004", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_106132", "106132004", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132004", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[106132004].content)
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
	Play106132005 = function (slot0, slot1)
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
				uv0:Play106132006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["3004_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect3004_tpose == nil then
				uv0.var_.characterEffect3004_tpose = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect3004_tpose then
					uv0.var_.characterEffect3004_tpose.fillFlat = true
					uv0.var_.characterEffect3004_tpose.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect3004_tpose then
				uv0.var_.characterEffect3004_tpose.fillFlat = true
				uv0.var_.characterEffect3004_tpose.fillRatio = 0.5
			end

			slot4 = uv0.actors_["3004_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos3004_tpose = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3004_tpose, Vector3.New(10, -2.27, -2.5), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -2.27, -2.5)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 1.025

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132005].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[106132005].content)
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
	Play106132006 = function (slot0, slot1)
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
				uv0:Play106132007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0.4 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_6", "se_story_6_tearing", "")
			end

			slot4 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132006].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot6 = uv0:FormatText(StoryWordCfg[106132006].content)
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
	Play106132007 = function (slot0, slot1)
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
				uv0:Play106132008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot2 = 0.5

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				slot4 = Color.New(1, 1, 1)
				slot4.a = Mathf.Lerp(1, 0, (uv0.time_ - slot1) / slot2)
				uv0.mask_.color = slot4
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				slot3 = Color.New(1, 1, 1)
				uv0.mask_.enabled = false
				slot3.a = 0
				uv0.mask_.color = slot3
			end

			slot4 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_6", "se_story_6_burning", "")
			end

			slot6 = 1.15

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132007].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot8 = uv0:FormatText(StoryWordCfg[106132007].content)
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
	Play106132008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.6

		if ({
			ja = 2.233,
			zh = 4.6
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
				uv0:Play106132009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["3004_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect3004_tpose == nil then
				uv0.var_.characterEffect3004_tpose = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect3004_tpose then
					uv0.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect3004_tpose then
				uv0.var_.characterEffect3004_tpose.fillFlat = false
			end

			slot4 = uv0.actors_["3004_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos3004_tpose = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3004_tpose, Vector3.New(0, -2.27, -2.5), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -2.27, -2.5)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			slot9 = 0.35

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132008].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132008", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132008", "story_v_out_106132.awb") / 1000 > 0 and slot9 < slot13 and uv0.duration_ < slot13 + slot8 then
						slot9 = slot13
						uv0.duration_ = slot13 + slot8
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						uv0:RecordAudio("106132008", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_106132", "106132008", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132008", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot11 = uv0:FormatText(StoryWordCfg[106132008].content)
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
	Play106132009 = function (slot0, slot1)
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
				uv0:Play106132010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["3004_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect3004_tpose == nil then
				uv0.var_.characterEffect3004_tpose = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect3004_tpose then
					uv0.var_.characterEffect3004_tpose.fillFlat = true
					uv0.var_.characterEffect3004_tpose.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect3004_tpose then
				uv0.var_.characterEffect3004_tpose.fillFlat = true
				uv0.var_.characterEffect3004_tpose.fillRatio = 0.5
			end

			slot4 = uv0.actors_["3004_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos3004_tpose = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3004_tpose, Vector3.New(10, -2.27, -2.5), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -2.27, -2.5)
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

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132009].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[106132009].content)
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
	Play106132010 = function (slot0, slot1)
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
				uv0:Play106132011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = manager.ui.mainCamera.transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.shakeOldPos = slot1.localPosition
			end

			slot3 = 0.6

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5, slot6 = math.modf((uv0.time_ - slot2) / 0.099)
				slot1.localPosition = Vector3.New(slot6 * 0.13, slot6 * 0.13, slot6 * 0.13) + uv0.var_.shakeOldPos
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = uv0.var_.shakeOldPos
			end

			slot5 = 1.3

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132010].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[106132010].content)
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
	Play106132011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.066

		if ({
			ja = 3.066,
			zh = 2.033
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
				uv0:Play106132012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["3004_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect3004_tpose == nil then
				uv0.var_.characterEffect3004_tpose = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect3004_tpose then
					uv0.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect3004_tpose then
				uv0.var_.characterEffect3004_tpose.fillFlat = false
			end

			slot4 = uv0.actors_["3004_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos3004_tpose = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3004_tpose, Vector3.New(0, -2.27, -2.5), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -2.27, -2.5)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			slot8 = manager.ui.mainCamera.transform

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.shakeOldPos = slot8.localPosition
			end

			slot10 = 0.6

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot12, slot13 = math.modf((uv0.time_ - slot9) / 0.066)
				slot8.localPosition = Vector3.New(slot13 * 0.13, slot13 * 0.13, slot13 * 0.13) + uv0.var_.shakeOldPos
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = uv0.var_.shakeOldPos
			end

			slot12 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132011].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132011", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132011", "story_v_out_106132.awb") / 1000 > 0 and slot12 < slot16 and uv0.duration_ < slot16 + slot11 then
						slot12 = slot16
						uv0.duration_ = slot16 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						uv0:RecordAudio("106132011", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_106132", "106132011", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132011", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = uv0:FormatText(StoryWordCfg[106132011].content)
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
	Play106132012 = function (slot0, slot1)
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
				uv0:Play106132013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["3004_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect3004_tpose == nil then
				uv0.var_.characterEffect3004_tpose = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect3004_tpose then
					uv0.var_.characterEffect3004_tpose.fillFlat = true
					uv0.var_.characterEffect3004_tpose.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect3004_tpose then
				uv0.var_.characterEffect3004_tpose.fillFlat = true
				uv0.var_.characterEffect3004_tpose.fillRatio = 0.5
			end

			slot4 = uv0.actors_["3004_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos3004_tpose = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3004_tpose, Vector3.New(10, -2.27, -2.5), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -2.27, -2.5)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 0.975

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132012].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[106132012].content)
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
	Play106132013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.866

		if ({
			ja = 2.8,
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
				uv0:Play106132014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["3004_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect3004_tpose == nil then
				uv0.var_.characterEffect3004_tpose = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect3004_tpose then
					uv0.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect3004_tpose then
				uv0.var_.characterEffect3004_tpose.fillFlat = false
			end

			slot4 = uv0.actors_["3004_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos3004_tpose = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3004_tpose, Vector3.New(0, -2.27, -2.5), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -2.27, -2.5)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			slot9 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132013].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132013", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132013", "story_v_out_106132.awb") / 1000 > 0 and slot9 < slot13 and uv0.duration_ < slot13 + slot8 then
						slot9 = slot13
						uv0.duration_ = slot13 + slot8
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						uv0:RecordAudio("106132013", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_106132", "106132013", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132013", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot11 = uv0:FormatText(StoryWordCfg[106132013].content)
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
	Play106132014 = function (slot0, slot1)
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
				uv0:Play106132015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["3004_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect3004_tpose == nil then
				uv0.var_.characterEffect3004_tpose = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect3004_tpose then
					uv0.var_.characterEffect3004_tpose.fillFlat = true
					uv0.var_.characterEffect3004_tpose.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect3004_tpose then
				uv0.var_.characterEffect3004_tpose.fillFlat = true
				uv0.var_.characterEffect3004_tpose.fillRatio = 0.5
			end

			slot4 = uv0.actors_["3004_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos3004_tpose = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3004_tpose, Vector3.New(10, -2.27, -2.5), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -2.27, -2.5)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 0.367

			if 0.366666666666667 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_6", "se_story_6_snake02", "")
			end

			slot10 = 1.025

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132014].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[106132014].content)
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
	Play106132015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 9.566

		if ({
			ja = 3.366,
			zh = 9.566
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
				uv0:Play106132016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialog_:SetActive(true)

				uv0.dialog_.transform.localScale = Vector3(0.8, 0.95, 1)

				LeanTween.scale(uv0.dialog_, Vector3.one, 0.2)

				slot3 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot3:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot3:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_3004")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132015].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132015", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132015", "story_v_out_106132.awb") / 1000 > 0 and slot2 < slot7 and uv0.duration_ < slot7 + slot1 then
						slot2 = slot7
						uv0.duration_ = slot7 + slot1
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						uv0:RecordAudio("106132015", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_out_106132", "106132015", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132015", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot1 = slot1 + 0.3
			slot4 = uv0:FormatText(StoryWordCfg[106132015].content)
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
	Play106132016 = function (slot0, slot1)
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
				uv0:Play106132017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["3004_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect3004_tpose == nil then
				uv0.var_.characterEffect3004_tpose = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect3004_tpose then
					uv0.var_.characterEffect3004_tpose.fillFlat = true
					uv0.var_.characterEffect3004_tpose.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect3004_tpose then
				uv0.var_.characterEffect3004_tpose.fillFlat = true
				uv0.var_.characterEffect3004_tpose.fillRatio = 0.5
			end

			slot4 = uv0.actors_["3004_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos3004_tpose = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3004_tpose, Vector3.New(10, -2.27, -2.5), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -2.27, -2.5)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_6", "se_story_6_black_fog", "")
			end

			slot10 = 1.1

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132016].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[106132016].content)
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
	Play106132017 = function (slot0, slot1)
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
				uv0:Play106132018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1099ui_story"] == nil then
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

			slot2 = uv0.actors_["1099ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1099ui_story == nil then
				uv0.var_.characterEffect1099ui_story = slot2.GetComponentInChildren(slot2, typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1099ui_story then
					uv0.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1099ui_story then
				uv0.var_.characterEffect1099ui_story.fillFlat = false
			end

			slot5 = uv0.actors_["1099ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos1099ui_story = slot5.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1099ui_story, Vector3.New(0, -1.13, -5.3), (uv0.time_ - slot6) / slot7)
				slot11 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot5.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot5.localEulerAngles = slot12
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(0, -1.13, -5.3)
				slot10 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot5.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot5.localEulerAngles = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/1099/1099action/1099action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			slot11 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132017].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132017", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132017", "story_v_out_106132.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
						slot11 = slot15
						uv0.duration_ = slot15 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						uv0:RecordAudio("106132017", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_106132", "106132017", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132017", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[106132017].content)
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
	Play106132018 = function (slot0, slot1)
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
				uv0:Play106132019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1099ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1099ui_story == nil then
				uv0.var_.characterEffect1099ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1099ui_story then
					uv0.var_.characterEffect1099ui_story.fillFlat = true
					uv0.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1099ui_story then
				uv0.var_.characterEffect1099ui_story.fillFlat = true
				uv0.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			slot4 = uv0.actors_["1099ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1099ui_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1099ui_story, Vector3.New(20, -1.13, -5.3), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(20, -1.13, -5.3)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132018].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[106132018].content)
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
	Play106132019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.8

		if ({
			ja = 1.999999999999,
			zh = 2.8
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
				uv0:Play106132020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1099ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1099ui_story == nil then
				uv0.var_.characterEffect1099ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1099ui_story then
					uv0.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1099ui_story then
				uv0.var_.characterEffect1099ui_story.fillFlat = false
			end

			slot4 = uv0.actors_["1099ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1099ui_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1099ui_story, Vector3.New(0, -1.13, -5.3), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -1.13, -5.3)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/1099/1099action/1099action5_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			slot10 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132019].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132019", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132019", "story_v_out_106132.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("106132019", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_106132", "106132019", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132019", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[106132019].content)
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
	Play106132020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.566

		if ({
			ja = 6.633,
			zh = 8.566
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
				uv0:Play106132021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1093ui_story"] == nil then
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

			slot2 = uv0.actors_["1093ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1093ui_story == nil then
				uv0.var_.characterEffect1093ui_story = slot2.GetComponentInChildren(slot2, typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1093ui_story then
					uv0.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1093ui_story then
				uv0.var_.characterEffect1093ui_story.fillFlat = false
			end

			slot5 = uv0.actors_["1099ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect1099ui_story == nil then
				uv0.var_.characterEffect1099ui_story = slot5.GetComponentInChildren(slot5, typeof(CharacterEffect))
			end

			slot7 = 0.1

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.characterEffect1099ui_story then
					uv0.var_.characterEffect1099ui_story.fillFlat = true
					uv0.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot8)
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect1099ui_story then
				uv0.var_.characterEffect1099ui_story.fillFlat = true
				uv0.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			slot8 = uv0.actors_["1099ui_story"].transform

			if 0.033 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos1099ui_story = slot8.localPosition
			end

			slot10 = 0.5

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1099ui_story, Vector3.New(0.84, -1.13, -5.3), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(0.84, -1.13, -5.3)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			slot11 = uv0.actors_["1099ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.var_.moveOldPos1099ui_story = slot11.localPosition
			end

			slot13 = 0.001

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1099ui_story, Vector3.New(0, -1.13, -5.3), (uv0.time_ - slot12) / slot13)
				slot17 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot11.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot11.localEulerAngles = slot18
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot11.localPosition = Vector3.New(0, -1.13, -5.3)
				slot16 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot11.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot11.localEulerAngles = slot17
			end

			slot14 = uv0.actors_["1093ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.var_.moveOldPos1093ui_story = slot14.localPosition

				uv0:ShowWeapon(uv0.var_["1093ui_story" .. "Animator"].transform, true)
			end

			slot16 = 0.001

			if slot15 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
				slot14.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1093ui_story, Vector3.New(-0.85, -1.16, -5.28), (uv0.time_ - slot15) / slot16)
				slot20 = manager.ui.mainCamera.transform.position - slot14.position
				slot14.forward = Vector3.New(slot20.x, slot20.y, slot20.z)
				slot21 = slot14.localEulerAngles
				slot21.z = 0
				slot21.x = 0
				slot14.localEulerAngles = slot21
			end

			if uv0.time_ >= slot15 + slot16 and uv0.time_ < slot15 + slot16 + slot0 then
				slot14.localPosition = Vector3.New(-0.85, -1.16, -5.28)
				slot19 = manager.ui.mainCamera.transform.position - slot14.position
				slot14.forward = Vector3.New(slot19.x, slot19.y, slot19.z)
				slot20 = slot14.localEulerAngles
				slot20.z = 0
				slot20.x = 0
				slot14.localEulerAngles = slot20
			end

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/1093/1093action/1093action10_2")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			slot20 = 0.8

			if 0 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132020].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132020", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132020", "story_v_out_106132.awb") / 1000 > 0 and slot20 < slot24 and uv0.duration_ < slot24 + slot19 then
						slot20 = slot24
						uv0.duration_ = slot24 + slot19
					end

					if slot22.prefab_name ~= "" and uv0.actors_[slot22.prefab_name] ~= nil then
						uv0:RecordAudio("106132020", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot22.prefab_name].transform, "story_v_out_106132", "106132020", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132020", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot22 = uv0:FormatText(StoryWordCfg[106132020].content)
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
	Play106132021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.033

		if ({
			ja = 3.033,
			zh = 3
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
				uv0:Play106132022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1099ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1099ui_story == nil then
				uv0.var_.characterEffect1099ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1099ui_story then
					uv0.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1099ui_story then
				uv0.var_.characterEffect1099ui_story.fillFlat = false
			end

			slot4 = uv0.actors_["1093ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1093ui_story == nil then
				uv0.var_.characterEffect1093ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1093ui_story then
					uv0.var_.characterEffect1093ui_story.fillFlat = true
					uv0.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot7)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1093ui_story then
				uv0.var_.characterEffect1093ui_story.fillFlat = true
				uv0.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/1099/1099actionlink/1099action456")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			slot10 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132021].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132021", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132021", "story_v_out_106132.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("106132021", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_106132", "106132021", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132021", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[106132021].content)
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
	Play106132022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.066

		if ({
			ja = 8.066,
			zh = 7.8
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
				uv0:Play106132023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1093ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1093ui_story == nil then
				uv0.var_.characterEffect1093ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1093ui_story then
					uv0.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1093ui_story then
				uv0.var_.characterEffect1093ui_story.fillFlat = false
			end

			slot4 = uv0.actors_["1099ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1099ui_story == nil then
				uv0.var_.characterEffect1099ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1099ui_story then
					uv0.var_.characterEffect1099ui_story.fillFlat = true
					uv0.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot7)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1099ui_story then
				uv0.var_.characterEffect1099ui_story.fillFlat = true
				uv0.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			slot9 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132022].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132022", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132022", "story_v_out_106132.awb") / 1000 > 0 and slot9 < slot13 and uv0.duration_ < slot13 + slot8 then
						slot9 = slot13
						uv0.duration_ = slot13 + slot8
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						uv0:RecordAudio("106132022", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_106132", "106132022", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132022", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot11 = uv0:FormatText(StoryWordCfg[106132022].content)
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
	Play106132023 = function (slot0, slot1)
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
				uv0:Play106132024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1099ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1099ui_story == nil then
				uv0.var_.characterEffect1099ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1099ui_story then
					uv0.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1099ui_story then
				uv0.var_.characterEffect1099ui_story.fillFlat = false
			end

			slot4 = uv0.actors_["1093ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1093ui_story == nil then
				uv0.var_.characterEffect1093ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1093ui_story then
					uv0.var_.characterEffect1093ui_story.fillFlat = true
					uv0.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot7)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1093ui_story then
				uv0.var_.characterEffect1093ui_story.fillFlat = true
				uv0.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/1099/1099action/1099action3_2")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			slot10 = 0.15

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132023].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132023", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132023", "story_v_out_106132.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("106132023", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_106132", "106132023", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132023", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[106132023].content)
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
	Play106132024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 9.766

		if ({
			ja = 9.766,
			zh = 8.7
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
				uv0:Play106132025(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1093ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1093ui_story == nil then
				uv0.var_.characterEffect1093ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1093ui_story then
					uv0.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1093ui_story then
				uv0.var_.characterEffect1093ui_story.fillFlat = false
			end

			slot4 = uv0.actors_["1099ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1099ui_story == nil then
				uv0.var_.characterEffect1099ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1099ui_story then
					uv0.var_.characterEffect1099ui_story.fillFlat = true
					uv0.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot7)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1099ui_story then
				uv0.var_.characterEffect1099ui_story.fillFlat = true
				uv0.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			slot9 = 0.8

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132024].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132024", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132024", "story_v_out_106132.awb") / 1000 > 0 and slot9 < slot13 and uv0.duration_ < slot13 + slot8 then
						slot9 = slot13
						uv0.duration_ = slot13 + slot8
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						uv0:RecordAudio("106132024", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_106132", "106132024", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132024", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot11 = uv0:FormatText(StoryWordCfg[106132024].content)
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
	Play106132025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 12.133

		if ({
			ja = 12.133,
			zh = 7.066
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
				uv0:Play106132026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			slot3 = 0.725

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132025].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132025", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132025", "story_v_out_106132.awb") / 1000 > 0 and slot3 < slot7 and uv0.duration_ < slot7 + slot2 then
						slot3 = slot7
						uv0.duration_ = slot7 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						uv0:RecordAudio("106132025", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_out_106132", "106132025", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132025", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = uv0:FormatText(StoryWordCfg[106132025].content)
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
	Play106132026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.933

		if ({
			ja = 6.933,
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
				uv0:Play106132027(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1099ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1099ui_story == nil then
				uv0.var_.characterEffect1099ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1099ui_story then
					uv0.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1099ui_story then
				uv0.var_.characterEffect1099ui_story.fillFlat = false
			end

			slot4 = uv0.actors_["1093ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1093ui_story == nil then
				uv0.var_.characterEffect1093ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1093ui_story then
					uv0.var_.characterEffect1093ui_story.fillFlat = true
					uv0.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot7)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1093ui_story then
				uv0.var_.characterEffect1093ui_story.fillFlat = true
				uv0.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/1099/1099actionlink/1099action465")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			slot10 = 0.575

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132026].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132026", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132026", "story_v_out_106132.awb") / 1000 > 0 and slot10 < slot14 and uv0.duration_ < slot14 + slot9 then
						slot10 = slot14
						uv0.duration_ = slot14 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						uv0:RecordAudio("106132026", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_106132", "106132026", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132026", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[106132026].content)
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
	Play106132027 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.733

		if ({
			ja = 7.733,
			zh = 5.7
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
				uv0:Play106132028(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1093ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1093ui_story == nil then
				uv0.var_.characterEffect1093ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1093ui_story then
					uv0.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1093ui_story then
				uv0.var_.characterEffect1093ui_story.fillFlat = false
			end

			slot4 = uv0.actors_["1099ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1099ui_story == nil then
				uv0.var_.characterEffect1099ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1099ui_story then
					uv0.var_.characterEffect1099ui_story.fillFlat = true
					uv0.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot7)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1099ui_story then
				uv0.var_.characterEffect1099ui_story.fillFlat = true
				uv0.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			slot9 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132027].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132027", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132027", "story_v_out_106132.awb") / 1000 > 0 and slot9 < slot13 and uv0.duration_ < slot13 + slot8 then
						slot9 = slot13
						uv0.duration_ = slot13 + slot8
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						uv0:RecordAudio("106132027", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_106132", "106132027", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132027", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot11 = uv0:FormatText(StoryWordCfg[106132027].content)
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
	Play106132028 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play106132029(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1093ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1093ui_story == nil then
				uv0.var_.characterEffect1093ui_story = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1093ui_story then
					uv0.var_.characterEffect1093ui_story.fillFlat = true
					uv0.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1093ui_story then
				uv0.var_.characterEffect1093ui_story.fillFlat = true
				uv0.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			slot4 = uv0.bgs_.C01b.transform

			if 1.5 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPosC01b = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPosC01b, Vector3.New(0, -100, 10), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -100, 10)
			end

			if uv0.bgs_.C07_1 == nil then
				slot8 = Object.Instantiate(uv0.paintGo_)
				slot8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot7)
				slot8.name = slot7
				slot8.transform.parent = uv0.stage_.transform
				slot8.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot7] = slot8
			end

			if 1.5 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				slot9 = manager.ui.mainCamera.transform.localPosition
				slot11 = uv0.bgs_.C07_1
				slot11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot9.x, slot9.y, 0)
				slot11.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot11:GetComponent("SpriteRenderer") and slot12.sprite then
					slot15 = manager.ui.mainCameraCom_
					slot16 = 2 * (slot11.transform.localPosition - slot9).z * Mathf.Tan(slot15.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot22 = slot16 * slot15.aspect / slot12.sprite.bounds.size.x > slot16 / slot12.sprite.bounds.size.y and slot20 or slot21
					slot11.transform.localScale = Vector3.New(slot22, slot22, 0)
				end

				for slot16, slot17 in pairs(uv0.bgs_) do
					if slot16 ~= "C07_1" then
						slot17.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot9 = uv0.actors_["1099ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPos1099ui_story = slot9.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1099ui_story, Vector3.New(20, -1.13, -5.3), (uv0.time_ - slot10) / slot11)
				slot15 = manager.ui.mainCamera.transform.position - slot9.position
				slot9.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot9.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot9.localEulerAngles = slot16
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(20, -1.13, -5.3)
				slot14 = manager.ui.mainCamera.transform.position - slot9.position
				slot9.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot9.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot9.localEulerAngles = slot15
			end

			slot12 = uv0.actors_["1093ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.var_.moveOldPos1093ui_story = slot12.localPosition
			end

			slot14 = 0.001

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				slot12.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1093ui_story, Vector3.New(10, -1.16, -5.28), (uv0.time_ - slot13) / slot14)
				slot18 = manager.ui.mainCamera.transform.position - slot12.position
				slot12.forward = Vector3.New(slot18.x, slot18.y, slot18.z)
				slot19 = slot12.localEulerAngles
				slot19.z = 0
				slot19.x = 0
				slot12.localEulerAngles = slot19
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 then
				slot12.localPosition = Vector3.New(10, -1.16, -5.28)
				slot17 = manager.ui.mainCamera.transform.position - slot12.position
				slot12.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot12.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot12.localEulerAngles = slot18
			end

			slot15 = uv0.bgs_.C07_1

			if 1.5 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				if slot15.GetComponent(slot15, "SpriteRenderer") then
					uv0.var_.alphaOldValueC07_1 = slot17.material:GetColor("_Color").a
					uv0.var_.alphaMatValueC07_1 = slot17.material
				end

				uv0.var_.alphaOldValueC07_1 = 0
			end

			slot17 = 1.5

			if slot16 <= uv0.time_ and uv0.time_ < slot16 + slot17 then
				slot19 = Mathf.Lerp(uv0.var_.alphaOldValueC07_1, 1, (uv0.time_ - slot16) / slot17)

				if uv0.var_.alphaMatValueC07_1 then
					slot20 = uv0.var_.alphaMatValueC07_1
					slot21 = slot20:GetColor("_Color")
					slot21.a = slot19

					slot20:SetColor("_Color", slot21)
				end
			end

			if uv0.time_ >= slot16 + slot17 and uv0.time_ < slot16 + slot17 + slot0 and uv0.var_.alphaMatValueC07_1 then
				slot18 = uv0.var_.alphaMatValueC07_1
				slot19 = slot18:GetColor("_Color")
				slot19.a = 1

				slot18:SetColor("_Color", slot19)
			end

			slot18 = uv0.bgs_.C01b

			if 0 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				if slot18.GetComponent(slot18, "SpriteRenderer") then
					uv0.var_.alphaOldValueC01b = slot20.material:GetColor("_Color").a
					uv0.var_.alphaMatValueC01b = slot20.material
				end

				uv0.var_.alphaOldValueC01b = 1
			end

			slot20 = 1.5

			if slot19 <= uv0.time_ and uv0.time_ < slot19 + slot20 then
				slot22 = Mathf.Lerp(uv0.var_.alphaOldValueC01b, 0, (uv0.time_ - slot19) / slot20)

				if uv0.var_.alphaMatValueC01b then
					slot23 = uv0.var_.alphaMatValueC01b
					slot24 = slot23:GetColor("_Color")
					slot24.a = slot22

					slot23:SetColor("_Color", slot24)
				end
			end

			if uv0.time_ >= slot19 + slot20 and uv0.time_ < slot19 + slot20 + slot0 and uv0.var_.alphaMatValueC01b then
				slot21 = uv0.var_.alphaMatValueC01b
				slot22 = slot21:GetColor("_Color")
				slot22.a = 0

				slot21:SetColor("_Color", slot22)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot21 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot21 + 3 and uv0.time_ < slot21 + slot22 + slot0 then
				uv0.allBtn_.enabled = true
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot24 = 0.125

			if 3 < uv0.time_ and uv0.time_ <= slot23 + slot0 then
				uv0.dialog_:SetActive(true)

				uv0.dialog_.transform.localScale = Vector3(0.8, 0.95, 1)

				LeanTween.scale(uv0.dialog_, Vector3.one, 0.2)

				slot25 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot25:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot25:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132028].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot23 = slot23 + 0.3
			slot26 = uv0:FormatText(StoryWordCfg[106132028].content)
			slot28 = string.split(slot26, ".")

			if #string.split(slot26, "\n") >= 4 or #slot28 >= 4 then
				slot24 = slot24 * 3
			end

			if slot23 <= uv0.time_ and uv0.time_ < slot23 + slot24 then
				uv0.typewritter.percent = (uv0.time_ - slot23) / slot24

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot23 + slot24 and uv0.time_ < slot23 + slot24 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play106132029 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.866

		if ({
			ja = 1.999999999999,
			zh = 3.866
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
				uv0:Play106132030(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["4014_tpose"] == nil then
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

			slot2 = uv0.actors_["4014_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect4014_tpose == nil then
				uv0.var_.characterEffect4014_tpose = slot2.GetComponentInChildren(slot2, typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect4014_tpose then
					uv0.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect4014_tpose then
				uv0.var_.characterEffect4014_tpose.fillFlat = false
			end

			slot5 = uv0.actors_["4014_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos4014_tpose = slot5.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4014_tpose, Vector3.New(0, -2, -3.6), (uv0.time_ - slot6) / slot7)
				slot11 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot5.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot5.localEulerAngles = slot12
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(0, -2, -3.6)
				slot10 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot5.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot5.localEulerAngles = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot10 = 0.5

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot12 = Color.New(1, 1, 1)
				slot12.a = Mathf.Lerp(1, 0, (uv0.time_ - slot9) / slot10)
				uv0.mask_.color = slot12
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot11 = Color.New(1, 1, 1)
				uv0.mask_.enabled = false
				slot11.a = 0
				uv0.mask_.color = slot11
			end

			slot12 = 0.225

			if 0.5 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132029].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132029", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132029", "story_v_out_106132.awb") / 1000 > 0 and slot12 < slot16 and uv0.duration_ < slot16 + slot11 then
						slot12 = slot16
						uv0.duration_ = slot16 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						uv0:RecordAudio("106132029", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_106132", "106132029", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132029", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = uv0:FormatText(StoryWordCfg[106132029].content)
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
	Play106132030 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.533

		if ({
			ja = 1.999999999999,
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
				uv0:Play106132031(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["4014_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4014_tpose == nil then
				uv0.var_.characterEffect4014_tpose = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4014_tpose then
					uv0.var_.characterEffect4014_tpose.fillFlat = true
					uv0.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4014_tpose then
				uv0.var_.characterEffect4014_tpose.fillFlat = true
				uv0.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			if uv0.actors_["10004ui_story"] == nil then
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

			slot5 = uv0.actors_["10004ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect10004ui_story == nil then
				uv0.var_.characterEffect10004ui_story = slot5.GetComponentInChildren(slot5, typeof(CharacterEffect))
			end

			slot7 = 0.1

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.characterEffect10004ui_story then
					uv0.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect10004ui_story then
				uv0.var_.characterEffect10004ui_story.fillFlat = false
			end

			slot8 = uv0.actors_["4014_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos4014_tpose = slot8.localPosition
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (uv0.time_ - slot9) / slot10)
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

			slot11 = uv0.actors_["10004ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.var_.moveOldPos10004ui_story = slot11.localPosition
			end

			slot13 = 0.001

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10004ui_story, Vector3.New(0, -1.15, -5), (uv0.time_ - slot12) / slot13)
				slot17 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot11.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot11.localEulerAngles = slot18
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot11.localPosition = Vector3.New(0, -1.15, -5)
				slot16 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot11.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot11.localEulerAngles = slot17
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot17 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132030].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132030", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132030", "story_v_out_106132.awb") / 1000 > 0 and slot17 < slot21 and uv0.duration_ < slot21 + slot16 then
						slot17 = slot21
						uv0.duration_ = slot21 + slot16
					end

					if slot19.prefab_name ~= "" and uv0.actors_[slot19.prefab_name] ~= nil then
						uv0:RecordAudio("106132030", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot19.prefab_name].transform, "story_v_out_106132", "106132030", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132030", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot19 = uv0:FormatText(StoryWordCfg[106132030].content)
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
	Play106132031 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.5

		if ({
			ja = 3.333,
			zh = 3.5
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
				uv0:Play106132032(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["4014_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4014_tpose == nil then
				uv0.var_.characterEffect4014_tpose = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4014_tpose then
					uv0.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4014_tpose then
				uv0.var_.characterEffect4014_tpose.fillFlat = false
			end

			slot4 = uv0.actors_["10004ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect10004ui_story == nil then
				uv0.var_.characterEffect10004ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect10004ui_story then
					uv0.var_.characterEffect10004ui_story.fillFlat = true
					uv0.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot7)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect10004ui_story then
				uv0.var_.characterEffect10004ui_story.fillFlat = true
				uv0.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			slot7 = uv0.actors_["4014_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos4014_tpose = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4014_tpose, Vector3.New(0, -2, -3.6), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -2, -3.6)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			slot10 = uv0.actors_["10004ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos10004ui_story = slot10.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10004ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, 100, 0)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			slot14 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132031].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132031", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132031", "story_v_out_106132.awb") / 1000 > 0 and slot14 < slot18 and uv0.duration_ < slot18 + slot13 then
						slot14 = slot18
						uv0.duration_ = slot18 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						uv0:RecordAudio("106132031", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_106132", "106132031", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132031", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = uv0:FormatText(StoryWordCfg[106132031].content)
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
	Play106132032 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.466

		if ({
			ja = 3.466,
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
				uv0:Play106132033(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["4014_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4014_tpose == nil then
				uv0.var_.characterEffect4014_tpose = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4014_tpose then
					uv0.var_.characterEffect4014_tpose.fillFlat = true
					uv0.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4014_tpose then
				uv0.var_.characterEffect4014_tpose.fillFlat = true
				uv0.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			slot4 = uv0.actors_["10004ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect10004ui_story == nil then
				uv0.var_.characterEffect10004ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect10004ui_story then
					uv0.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect10004ui_story then
				uv0.var_.characterEffect10004ui_story.fillFlat = false
			end

			slot7 = uv0.actors_["4014_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos4014_tpose = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
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

			slot10 = uv0.actors_["10004ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos10004ui_story = slot10.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10004ui_story, Vector3.New(0, -1.15, -5), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, -1.15, -5)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action3_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot16 = 0.375

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132032].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132032", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132032", "story_v_out_106132.awb") / 1000 > 0 and slot16 < slot20 and uv0.duration_ < slot20 + slot15 then
						slot16 = slot20
						uv0.duration_ = slot20 + slot15
					end

					if slot18.prefab_name ~= "" and uv0.actors_[slot18.prefab_name] ~= nil then
						uv0:RecordAudio("106132032", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot18.prefab_name].transform, "story_v_out_106132", "106132032", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132032", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot18 = uv0:FormatText(StoryWordCfg[106132032].content)
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
	Play106132033 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.466

		if ({
			ja = 5.466,
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
				uv0:Play106132034(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["4014_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4014_tpose == nil then
				uv0.var_.characterEffect4014_tpose = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4014_tpose then
					uv0.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4014_tpose then
				uv0.var_.characterEffect4014_tpose.fillFlat = false
			end

			slot4 = uv0.actors_["10004ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect10004ui_story == nil then
				uv0.var_.characterEffect10004ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect10004ui_story then
					uv0.var_.characterEffect10004ui_story.fillFlat = true
					uv0.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, slot7)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect10004ui_story then
				uv0.var_.characterEffect10004ui_story.fillFlat = true
				uv0.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			slot7 = uv0.actors_["4014_tpose"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos4014_tpose = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4014_tpose, Vector3.New(0, -2, -3.6), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -2, -3.6)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			slot10 = uv0.actors_["10004ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos10004ui_story = slot10.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10004ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, 100, 0)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			slot14 = 0.35

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132033].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132033", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132033", "story_v_out_106132.awb") / 1000 > 0 and slot14 < slot18 and uv0.duration_ < slot18 + slot13 then
						slot14 = slot18
						uv0.duration_ = slot18 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						uv0:RecordAudio("106132033", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_106132", "106132033", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132033", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = uv0:FormatText(StoryWordCfg[106132033].content)
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
	Play106132034 = function (slot0, slot1)
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
				uv0:Play106132035(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["4014_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4014_tpose == nil then
				uv0.var_.characterEffect4014_tpose = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4014_tpose then
					uv0.var_.characterEffect4014_tpose.fillFlat = true
					uv0.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, slot4)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4014_tpose then
				uv0.var_.characterEffect4014_tpose.fillFlat = true
				uv0.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			slot5 = 0.75

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132034].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[106132034].content)
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
	Play106132035 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6

		if ({
			ja = 5.9,
			zh = 6
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
			slot1 = uv0.actors_["4014_tpose"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4014_tpose == nil then
				uv0.var_.characterEffect4014_tpose = slot1.GetComponentInChildren(slot1, typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4014_tpose then
					uv0.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4014_tpose then
				uv0.var_.characterEffect4014_tpose.fillFlat = false
			end

			slot5 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[106132035].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132035", "story_v_out_106132.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_106132", "106132035", "story_v_out_106132.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
						slot5 = slot9
						uv0.duration_ = slot9 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						uv0:RecordAudio("106132035", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_106132", "106132035", "story_v_out_106132.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_106132", "106132035", "story_v_out_106132.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[106132035].content)
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
