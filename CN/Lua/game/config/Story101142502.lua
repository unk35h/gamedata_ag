return {
	Play114252001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.933

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114252002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.ST25 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.ST25
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "ST25" then
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

			if uv0.actors_["10015_split_1"] == nil then
				slot6 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot6.transform:SetSiblingIndex(1)

				slot6.name = slot5
				slot7 = slot6:GetComponent(typeof(Image))
				slot7.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot5)

				slot7:SetNativeSize()

				slot6.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot5] = slot6
			end

			slot6 = uv0.actors_["10015_split_1"].transform

			if 1.8 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.var_.moveOldPos10015_split_1 = slot6.localPosition
				slot6.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_1", 4)
			end

			slot8 = 0.001

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot6.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_1, Vector3.New(390, -350, -180), (uv0.time_ - slot7) / slot8)
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot6.localPosition = Vector3.New(390, -350, -180)
			end

			slot9 = uv0.actors_["10015_split_1"]

			if 1.8 < uv0.time_ and uv0.time_ <= slot10 + slot0 and slot9.GetComponent(slot9, "Image") then
				uv0.var_.highlightMatValue10015_split_1 = slot11
			end

			slot11 = 0.034

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot12 = (uv0.time_ - slot10) / slot11

				if uv0.var_.highlightMatValue10015_split_1 then
					slot13 = Mathf.Lerp(0.5, 1, slot12)
					slot14 = uv0.var_.highlightMatValue10015_split_1
					slot15 = slot14.color
					slot15.r = slot13
					slot15.g = slot13
					slot15.b = slot13
					slot14.color = slot15
				end
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 and uv0.var_.highlightMatValue10015_split_1 then
				slot12 = 1

				slot9.transform:SetSiblingIndex(1)

				slot13 = uv0.var_.highlightMatValue10015_split_1
				slot14 = slot13.color
				slot14.r = slot12
				slot14.g = slot12
				slot14.b = slot12
				slot13.color = slot14
			end

			slot12 = uv0.actors_["10015_split_1"]

			if 1.8 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				if slot12.GetComponent(slot12, "Image") then
					uv0.var_.alphaMatValue10015_split_1 = slot14
					uv0.var_.alphaOldValue10015_split_1 = slot14.color.a
				end

				uv0.var_.alphaOldValue10015_split_1 = 0
			end

			slot14 = 0.5

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				slot16 = Mathf.Lerp(uv0.var_.alphaOldValue10015_split_1, 1, (uv0.time_ - slot13) / slot14)

				if uv0.var_.alphaMatValue10015_split_1 then
					slot17 = uv0.var_.alphaMatValue10015_split_1.color
					slot17.a = slot16
					uv0.var_.alphaMatValue10015_split_1.color = slot17
				end
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 and uv0.var_.alphaMatValue10015_split_1 then
				slot15 = uv0.var_.alphaMatValue10015_split_1
				slot16 = slot15.color
				slot16.a = 1
				slot15.color = slot16
			end

			slot16 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot18 = 0.7

			if 2 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0:AudioAction("play", "music", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot20 = 0.425

			if 2 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				uv0.dialog_:SetActive(true)

				uv0.dialog_.transform.localScale = Vector3(0.8, 0.95, 1)

				LeanTween.scale(uv0.dialog_, Vector3.one, 0.2)

				slot21 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot21:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot21:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252001].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114252", "114252001", "story_v_out_114252.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114252", "114252001", "story_v_out_114252.awb") / 1000 > 0 and slot20 < slot25 and uv0.duration_ < slot25 + slot19 then
						slot20 = slot25
						uv0.duration_ = slot25 + slot19
					end

					if slot23.prefab_name ~= "" and uv0.actors_[slot23.prefab_name] ~= nil then
						uv0:RecordAudio("114252001", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot23.prefab_name].transform, "story_v_out_114252", "114252001", "story_v_out_114252.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114252", "114252001", "story_v_out_114252.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot19 = slot19 + 0.3
			slot22 = uv0:FormatText(StoryWordCfg[114252001].content)
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
	Play114252002 = function (slot0, slot1)
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
				uv0:Play114252003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10015_split_1 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10015_split_1 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue10015_split_1
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10015_split_1 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue10015_split_1
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 1.275

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252002].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114252002].content)
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
	Play114252003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 11.033

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114252004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["10018_split_1"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["10018_split_1"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos10018_split_1 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018_split_1", 2)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018_split_1, Vector3.New(-390, -350, -180), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(-390, -350, -180)
			end

			slot5 = uv0.actors_["10018_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and slot5.GetComponent(slot5, "Image") then
				uv0.var_.highlightMatValue10018_split_1 = slot7
			end

			slot7 = 0.034

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.highlightMatValue10018_split_1 then
					slot9 = Mathf.Lerp(0.5, 1, slot8)
					slot10 = uv0.var_.highlightMatValue10018_split_1
					slot11 = slot10.color
					slot11.r = slot9
					slot11.g = slot9
					slot11.b = slot9
					slot10.color = slot11
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.highlightMatValue10018_split_1 then
				slot8 = 1

				slot5.transform:SetSiblingIndex(1)

				slot9 = uv0.var_.highlightMatValue10018_split_1
				slot10 = slot9.color
				slot10.r = slot8
				slot10.g = slot8
				slot10.b = slot8
				slot9.color = slot10
			end

			slot8 = uv0.actors_["10018_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				if slot8.GetComponent(slot8, "Image") then
					uv0.var_.alphaMatValue10018_split_1 = slot10
					uv0.var_.alphaOldValue10018_split_1 = slot10.color.a
				end

				uv0.var_.alphaOldValue10018_split_1 = 0
			end

			slot10 = 0.5

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot12 = Mathf.Lerp(uv0.var_.alphaOldValue10018_split_1, 1, (uv0.time_ - slot9) / slot10)

				if uv0.var_.alphaMatValue10018_split_1 then
					slot13 = uv0.var_.alphaMatValue10018_split_1.color
					slot13.a = slot12
					uv0.var_.alphaMatValue10018_split_1.color = slot13
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.alphaMatValue10018_split_1 then
				slot11 = uv0.var_.alphaMatValue10018_split_1
				slot12 = slot11.color
				slot12.a = 1
				slot11.color = slot12
			end

			slot12 = 0.9

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252003].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114252", "114252003", "story_v_out_114252.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114252", "114252003", "story_v_out_114252.awb") / 1000 > 0 and slot12 < slot16 and uv0.duration_ < slot16 + slot11 then
						slot12 = slot16
						uv0.duration_ = slot16 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						uv0:RecordAudio("114252003", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_114252", "114252003", "story_v_out_114252.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114252", "114252003", "story_v_out_114252.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = uv0:FormatText(StoryWordCfg[114252003].content)
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
	Play114252004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.6

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114252005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["10015_split_4"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["10015_split_4"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos10015_split_4 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_4", 4)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_4, Vector3.New(390, -350, -180), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(390, -350, -180)
			end

			slot5 = uv0.actors_["10015_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and slot5.GetComponent(slot5, "Image") then
				uv0.var_.highlightMatValue10015_split_4 = slot7
			end

			slot7 = 0.034

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.highlightMatValue10015_split_4 then
					slot9 = Mathf.Lerp(0.5, 1, slot8)
					slot10 = uv0.var_.highlightMatValue10015_split_4
					slot11 = slot10.color
					slot11.r = slot9
					slot11.g = slot9
					slot11.b = slot9
					slot10.color = slot11
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.highlightMatValue10015_split_4 then
				slot8 = 1

				slot5.transform:SetSiblingIndex(1)

				slot9 = uv0.var_.highlightMatValue10015_split_4
				slot10 = slot9.color
				slot10.r = slot8
				slot10.g = slot8
				slot10.b = slot8
				slot9.color = slot10
			end

			slot8 = uv0.actors_["10018_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 and slot8.GetComponent(slot8, "Image") then
				uv0.var_.highlightMatValue10018_split_1 = slot10
			end

			slot10 = 0.034

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot11 = (uv0.time_ - slot9) / slot10

				if uv0.var_.highlightMatValue10018_split_1 then
					slot12 = Mathf.Lerp(1, 0.5, slot11)
					slot13 = uv0.var_.highlightMatValue10018_split_1
					slot14 = slot13.color
					slot14.r = slot12
					slot14.g = slot12
					slot14.b = slot12
					slot13.color = slot14
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.highlightMatValue10018_split_1 then
				slot11 = 0.5
				slot12 = uv0.var_.highlightMatValue10018_split_1
				slot13 = slot12.color
				slot13.r = slot11
				slot13.g = slot11
				slot13.b = slot11
				slot12.color = slot13
			end

			slot12 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252004].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114252", "114252004", "story_v_out_114252.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114252", "114252004", "story_v_out_114252.awb") / 1000 > 0 and slot12 < slot16 and uv0.duration_ < slot16 + slot11 then
						slot12 = slot16
						uv0.duration_ = slot16 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						uv0:RecordAudio("114252004", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_114252", "114252004", "story_v_out_114252.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114252", "114252004", "story_v_out_114252.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = uv0:FormatText(StoryWordCfg[114252004].content)
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
	Play114252005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 11.033

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114252006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10015_split_4 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10015_split_4 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue10015_split_4
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10015_split_4 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue10015_split_4
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot4 = uv0.actors_["10018_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10018_split_1 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10018_split_1 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue10018_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10018_split_1 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue10018_split_1
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252005].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114252", "114252005", "story_v_out_114252.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114252", "114252005", "story_v_out_114252.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
						slot8 = slot12
						uv0.duration_ = slot12 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						uv0:RecordAudio("114252005", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114252", "114252005", "story_v_out_114252.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114252", "114252005", "story_v_out_114252.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[114252005].content)
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
	Play114252006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.6

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114252007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["10015_split_5"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["10015_split_5"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos10015_split_5 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_5", 4)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_5, Vector3.New(390, -350, -180), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(390, -350, -180)
			end

			slot5 = uv0.actors_["10015_split_5"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and slot5.GetComponent(slot5, "Image") then
				uv0.var_.highlightMatValue10015_split_5 = slot7
			end

			slot7 = 0.034

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.highlightMatValue10015_split_5 then
					slot9 = Mathf.Lerp(0.5, 1, slot8)
					slot10 = uv0.var_.highlightMatValue10015_split_5
					slot11 = slot10.color
					slot11.r = slot9
					slot11.g = slot9
					slot11.b = slot9
					slot10.color = slot11
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.highlightMatValue10015_split_5 then
				slot8 = 1

				slot5.transform:SetSiblingIndex(1)

				slot9 = uv0.var_.highlightMatValue10015_split_5
				slot10 = slot9.color
				slot10.r = slot8
				slot10.g = slot8
				slot10.b = slot8
				slot9.color = slot10
			end

			slot8 = uv0.actors_["10018_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 and slot8.GetComponent(slot8, "Image") then
				uv0.var_.highlightMatValue10018_split_1 = slot10
			end

			slot10 = 0.034

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot11 = (uv0.time_ - slot9) / slot10

				if uv0.var_.highlightMatValue10018_split_1 then
					slot12 = Mathf.Lerp(1, 0.5, slot11)
					slot13 = uv0.var_.highlightMatValue10018_split_1
					slot14 = slot13.color
					slot14.r = slot12
					slot14.g = slot12
					slot14.b = slot12
					slot13.color = slot14
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.highlightMatValue10018_split_1 then
				slot11 = 0.5
				slot12 = uv0.var_.highlightMatValue10018_split_1
				slot13 = slot12.color
				slot13.r = slot11
				slot13.g = slot11
				slot13.b = slot11
				slot12.color = slot13
			end

			slot12 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252006].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114252", "114252006", "story_v_out_114252.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114252", "114252006", "story_v_out_114252.awb") / 1000 > 0 and slot12 < slot16 and uv0.duration_ < slot16 + slot11 then
						slot12 = slot16
						uv0.duration_ = slot16 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						uv0:RecordAudio("114252006", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_114252", "114252006", "story_v_out_114252.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114252", "114252006", "story_v_out_114252.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = uv0:FormatText(StoryWordCfg[114252006].content)
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
	Play114252007 = function (slot0, slot1)
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
				uv0:Play114252008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015_split_5"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10015_split_5 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10015_split_5 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue10015_split_5
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10015_split_5 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue10015_split_5
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 1.3

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252007].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114252007].content)
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
	Play114252008 = function (slot0, slot1)
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
				uv0:Play114252009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10018_split_1 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10018_split_1 then
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue10018_split_1
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10018_split_1 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue10018_split_1
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252008].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114252", "114252008", "story_v_out_114252.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114252", "114252008", "story_v_out_114252.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
						slot5 = slot9
						uv0.duration_ = slot9 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						uv0:RecordAudio("114252008", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_114252", "114252008", "story_v_out_114252.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114252", "114252008", "story_v_out_114252.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114252008].content)
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
	Play114252009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.2

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114252010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015_split_4"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10015_split_4 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_4", 4)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_4, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			slot4 = uv0.actors_["10015_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10015_split_4 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10015_split_4 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue10015_split_4
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10015_split_4 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue10015_split_4
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot7 = uv0.actors_["10018_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and slot7.GetComponent(slot7, "Image") then
				uv0.var_.highlightMatValue10018_split_1 = slot9
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.highlightMatValue10018_split_1 then
					slot11 = Mathf.Lerp(1, 0.5, slot10)
					slot12 = uv0.var_.highlightMatValue10018_split_1
					slot13 = slot12.color
					slot13.r = slot11
					slot13.g = slot11
					slot13.b = slot11
					slot12.color = slot13
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.highlightMatValue10018_split_1 then
				slot10 = 0.5
				slot11 = uv0.var_.highlightMatValue10018_split_1
				slot12 = slot11.color
				slot12.r = slot10
				slot12.g = slot10
				slot12.b = slot10
				slot11.color = slot12
			end

			slot11 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252009].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114252", "114252009", "story_v_out_114252.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114252", "114252009", "story_v_out_114252.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
						slot11 = slot15
						uv0.duration_ = slot15 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						uv0:RecordAudio("114252009", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114252", "114252009", "story_v_out_114252.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114252", "114252009", "story_v_out_114252.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[114252009].content)
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
	Play114252010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.6

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114252011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10015_split_4 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10015_split_4 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue10015_split_4
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10015_split_4 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue10015_split_4
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot4 = uv0.actors_["10018_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10018_split_1 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10018_split_1 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue10018_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10018_split_1 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue10018_split_1
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252010].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114252", "114252010", "story_v_out_114252.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114252", "114252010", "story_v_out_114252.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
						slot8 = slot12
						uv0.duration_ = slot12 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						uv0:RecordAudio("114252010", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114252", "114252010", "story_v_out_114252.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114252", "114252010", "story_v_out_114252.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[114252010].content)
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
	Play114252011 = function (slot0, slot1)
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
				uv0:Play114252012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10018_split_1 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10018_split_1 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue10018_split_1
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10018_split_1 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue10018_split_1
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252011].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114252011].content)
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
	Play114252012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 9.7

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114252013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10018_split_1 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10018_split_1 then
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue10018_split_1
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10018_split_1 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue10018_split_1
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 0.825

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252012].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114252", "114252012", "story_v_out_114252.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114252", "114252012", "story_v_out_114252.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
						slot5 = slot9
						uv0.duration_ = slot9 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						uv0:RecordAudio("114252012", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_114252", "114252012", "story_v_out_114252.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114252", "114252012", "story_v_out_114252.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114252012].content)
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
	Play114252013 = function (slot0, slot1)
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
				uv0:Play114252014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if slot1.GetComponent(slot1, "Image") then
					uv0.var_.alphaMatValue10015_split_4 = slot3
					uv0.var_.alphaOldValue10015_split_4 = slot3.color.a
				end

				uv0.var_.alphaOldValue10015_split_4 = 1
			end

			slot3 = 0.5

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5 = Mathf.Lerp(uv0.var_.alphaOldValue10015_split_4, 0, (uv0.time_ - slot2) / slot3)

				if uv0.var_.alphaMatValue10015_split_4 then
					slot6 = uv0.var_.alphaMatValue10015_split_4.color
					slot6.a = slot5
					uv0.var_.alphaMatValue10015_split_4.color = slot6
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.alphaMatValue10015_split_4 then
				slot4 = uv0.var_.alphaMatValue10015_split_4
				slot5 = slot4.color
				slot5.a = 0
				slot4.color = slot5
			end

			slot4 = uv0.actors_["10018_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				if slot4.GetComponent(slot4, "Image") then
					uv0.var_.alphaMatValue10018_split_1 = slot6
					uv0.var_.alphaOldValue10018_split_1 = slot6.color.a
				end

				uv0.var_.alphaOldValue10018_split_1 = 1
			end

			slot6 = 0.5

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot8 = Mathf.Lerp(uv0.var_.alphaOldValue10018_split_1, 0, (uv0.time_ - slot5) / slot6)

				if uv0.var_.alphaMatValue10018_split_1 then
					slot9 = uv0.var_.alphaMatValue10018_split_1.color
					slot9.a = slot8
					uv0.var_.alphaMatValue10018_split_1.color = slot9
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.alphaMatValue10018_split_1 then
				slot7 = uv0.var_.alphaMatValue10018_split_1
				slot8 = slot7.color
				slot8.a = 0
				slot7.color = slot8
			end

			slot8 = 0.85

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252013].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[114252013].content)
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
	Play114252014 = function (slot0, slot1)
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
				uv0:Play114252015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252014].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114252014].content)
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
	Play114252015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 12.7

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114252016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.175

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_10005")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252015].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114252", "114252015", "story_v_out_114252.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114252", "114252015", "story_v_out_114252.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("114252015", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114252", "114252015", "story_v_out_114252.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114252", "114252015", "story_v_out_114252.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114252015].content)
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
	Play114252016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 0.999999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114252017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["10015_split_3"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["10015_split_3"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos10015_split_3 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_3", 3)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_3, Vector3.New(0, -350, -180), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(0, -350, -180)
			end

			slot5 = uv0.actors_["10015_split_3"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and slot5.GetComponent(slot5, "Image") then
				uv0.var_.highlightMatValue10015_split_3 = slot7
			end

			slot7 = 0.034

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.highlightMatValue10015_split_3 then
					slot9 = Mathf.Lerp(0.5, 1, slot8)
					slot10 = uv0.var_.highlightMatValue10015_split_3
					slot11 = slot10.color
					slot11.r = slot9
					slot11.g = slot9
					slot11.b = slot9
					slot10.color = slot11
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.highlightMatValue10015_split_3 then
				slot8 = 1

				slot5.transform:SetSiblingIndex(1)

				slot9 = uv0.var_.highlightMatValue10015_split_3
				slot10 = slot9.color
				slot10.r = slot8
				slot10.g = slot8
				slot10.b = slot8
				slot9.color = slot10
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

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot11 + 0.6 and uv0.time_ < slot11 + slot12 + slot0 then
				uv0.allBtn_.enabled = true
			end

			slot13 = uv0.actors_["10015_split_3"]

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				if slot13.GetComponent(slot13, "Image") then
					uv0.var_.alphaMatValue10015_split_3 = slot15
					uv0.var_.alphaOldValue10015_split_3 = slot15.color.a
				end

				uv0.var_.alphaOldValue10015_split_3 = 0
			end

			slot15 = 0.5

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot17 = Mathf.Lerp(uv0.var_.alphaOldValue10015_split_3, 1, (uv0.time_ - slot14) / slot15)

				if uv0.var_.alphaMatValue10015_split_3 then
					slot18 = uv0.var_.alphaMatValue10015_split_3.color
					slot18.a = slot17
					uv0.var_.alphaMatValue10015_split_3.color = slot18
				end
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 and uv0.var_.alphaMatValue10015_split_3 then
				slot16 = uv0.var_.alphaMatValue10015_split_3
				slot17 = slot16.color
				slot17.a = 1
				slot16.color = slot17
			end

			slot17 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252016].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114252", "114252016", "story_v_out_114252.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114252", "114252016", "story_v_out_114252.awb") / 1000 > 0 and slot17 < slot21 and uv0.duration_ < slot21 + slot16 then
						slot17 = slot21
						uv0.duration_ = slot21 + slot16
					end

					if slot19.prefab_name ~= "" and uv0.actors_[slot19.prefab_name] ~= nil then
						uv0:RecordAudio("114252016", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot19.prefab_name].transform, "story_v_out_114252", "114252016", "story_v_out_114252.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114252", "114252016", "story_v_out_114252.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot19 = uv0:FormatText(StoryWordCfg[114252016].content)
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
	Play114252017 = function (slot0, slot1)
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
				uv0:Play114252018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015_split_3"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if slot1.GetComponent(slot1, "Image") then
					uv0.var_.alphaMatValue10015_split_3 = slot3
					uv0.var_.alphaOldValue10015_split_3 = slot3.color.a
				end

				uv0.var_.alphaOldValue10015_split_3 = 1
			end

			slot3 = 0.5

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5 = Mathf.Lerp(uv0.var_.alphaOldValue10015_split_3, 0, (uv0.time_ - slot2) / slot3)

				if uv0.var_.alphaMatValue10015_split_3 then
					slot6 = uv0.var_.alphaMatValue10015_split_3.color
					slot6.a = slot5
					uv0.var_.alphaMatValue10015_split_3.color = slot6
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.alphaMatValue10015_split_3 then
				slot4 = uv0.var_.alphaMatValue10015_split_3
				slot5 = slot4.color
				slot5.a = 0
				slot4.color = slot5
			end

			slot5 = 1.3

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252017].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114252017].content)
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
	Play114252018 = function (slot0, slot1)
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
				uv0:Play114252019(uv1)
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

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252018].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114252018].content)
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
	Play114252019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.233

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114252020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.775

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_10005")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252019].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114252", "114252019", "story_v_out_114252.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114252", "114252019", "story_v_out_114252.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("114252019", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114252", "114252019", "story_v_out_114252.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114252", "114252019", "story_v_out_114252.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114252019].content)
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
	Play114252020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 10.266

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114252021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_10005")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252020].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114252", "114252020", "story_v_out_114252.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114252", "114252020", "story_v_out_114252.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("114252020", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114252", "114252020", "story_v_out_114252.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114252", "114252020", "story_v_out_114252.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114252020].content)
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
	Play114252021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.5

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114252022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["10015_split_6"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["10015_split_6"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos10015_split_6 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_6", 3)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_6, Vector3.New(0, -350, -180), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(0, -350, -180)
			end

			slot5 = uv0.actors_["10015_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and slot5.GetComponent(slot5, "Image") then
				uv0.var_.highlightMatValue10015_split_6 = slot7
			end

			slot7 = 0.034

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.highlightMatValue10015_split_6 then
					slot9 = Mathf.Lerp(0.5, 1, slot8)
					slot10 = uv0.var_.highlightMatValue10015_split_6
					slot11 = slot10.color
					slot11.r = slot9
					slot11.g = slot9
					slot11.b = slot9
					slot10.color = slot11
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.highlightMatValue10015_split_6 then
				slot8 = 1

				slot5.transform:SetSiblingIndex(1)

				slot9 = uv0.var_.highlightMatValue10015_split_6
				slot10 = slot9.color
				slot10.r = slot8
				slot10.g = slot8
				slot10.b = slot8
				slot9.color = slot10
			end

			slot8 = uv0.actors_["10015_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				if slot8.GetComponent(slot8, "Image") then
					uv0.var_.alphaMatValue10015_split_6 = slot10
					uv0.var_.alphaOldValue10015_split_6 = slot10.color.a
				end

				uv0.var_.alphaOldValue10015_split_6 = 0
			end

			slot10 = 0.5

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot12 = Mathf.Lerp(uv0.var_.alphaOldValue10015_split_6, 1, (uv0.time_ - slot9) / slot10)

				if uv0.var_.alphaMatValue10015_split_6 then
					slot13 = uv0.var_.alphaMatValue10015_split_6.color
					slot13.a = slot12
					uv0.var_.alphaMatValue10015_split_6.color = slot13
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.alphaMatValue10015_split_6 then
				slot11 = uv0.var_.alphaMatValue10015_split_6
				slot12 = slot11.color
				slot12.a = 1
				slot11.color = slot12
			end

			slot12 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252021].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114252", "114252021", "story_v_out_114252.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114252", "114252021", "story_v_out_114252.awb") / 1000 > 0 and slot12 < slot16 and uv0.duration_ < slot16 + slot11 then
						slot12 = slot16
						uv0.duration_ = slot16 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						uv0:RecordAudio("114252021", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_114252", "114252021", "story_v_out_114252.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114252", "114252021", "story_v_out_114252.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = uv0:FormatText(StoryWordCfg[114252021].content)
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
	Play114252022 = function (slot0, slot1)
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
				uv0:Play114252023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if slot1.GetComponent(slot1, "Image") then
					uv0.var_.alphaMatValue10015_split_6 = slot3
					uv0.var_.alphaOldValue10015_split_6 = slot3.color.a
				end

				uv0.var_.alphaOldValue10015_split_6 = 1
			end

			slot3 = 0.5

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5 = Mathf.Lerp(uv0.var_.alphaOldValue10015_split_6, 0, (uv0.time_ - slot2) / slot3)

				if uv0.var_.alphaMatValue10015_split_6 then
					slot6 = uv0.var_.alphaMatValue10015_split_6.color
					slot6.a = slot5
					uv0.var_.alphaMatValue10015_split_6.color = slot6
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.alphaMatValue10015_split_6 then
				slot4 = uv0.var_.alphaMatValue10015_split_6
				slot5 = slot4.color
				slot5.a = 0
				slot4.color = slot5
			end

			slot5 = 1.25

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252022].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114252022].content)
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
	Play114252023 = function (slot0, slot1)
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
				uv0:Play114252024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015_split_6"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10015_split_6 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_6", 7)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_6, Vector3.New(0, -2000, 450), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -2000, 450)
			end

			slot4 = uv0.actors_["10018_split_1"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos10018_split_1 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018_split_1", 7)
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018_split_1, Vector3.New(0, -2000, -180), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -2000, -180)
			end

			slot8 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252023].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[114252023].content)
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
	Play114252024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 0.999999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114252025(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_10005")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252024].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114252", "114252024", "story_v_out_114252.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114252", "114252024", "story_v_out_114252.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("114252024", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114252", "114252024", "story_v_out_114252.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114252", "114252024", "story_v_out_114252.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114252024].content)
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
	Play114252025 = function (slot0, slot1)
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
				uv0:Play114252026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.775

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252025].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114252025].content)
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
	Play114252026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 9.8

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
			slot2 = 0.8

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_10005")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[114252026].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114252", "114252026", "story_v_out_114252.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114252", "114252026", "story_v_out_114252.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("114252026", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114252", "114252026", "story_v_out_114252.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114252", "114252026", "story_v_out_114252.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114252026].content)
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
	end
}
