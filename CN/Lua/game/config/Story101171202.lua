return {
	Play117122001 = function (slot0, slot1)
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
				uv0:Play117122002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.I08a == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.I08a
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "I08a" then
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

			slot5 = manager.ui.mainCamera.transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.shakeOldPos = slot5.localPosition
			end

			slot7 = 2

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot9, slot10 = math.modf((uv0.time_ - slot6) / 0.066)
				slot5.localPosition = Vector3.New(slot10 * 0.13, slot10 * 0.13, slot10 * 0.13) + uv0.var_.shakeOldPos
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = uv0.var_.shakeOldPos
			end

			slot9 = 0.466666666666667

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot11 = 0.55

			if 2 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:AudioAction("play", "music", "bgm_activity_1_7_story_firehouse", "bgm_activity_1_7_story_firehouse", "bgm_activity_1_7_story_firehouse.awb")
			end

			slot13 = 0.55

			if 2 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122001].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot15 = uv0:FormatText(StoryWordCfg[117122001].content)
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
	Play117122002 = function (slot0, slot1)
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
				uv0:Play117122003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_17", "se_story_17_boss_hawk1", "")
			end

			slot4 = 1.575

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122002].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot6 = uv0:FormatText(StoryWordCfg[117122002].content)
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
	Play117122003 = function (slot0, slot1)
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
				uv0:Play117122004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_16", "se_story_16_fall02", "")
			end

			slot4 = 1.175

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122003].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot6 = uv0:FormatText(StoryWordCfg[117122003].content)
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
	Play117122004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.8

		if ({
			ja = 4.066,
			zh = 5.8
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
				uv0:Play117122005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1132_split_6"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["1132_split_6"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos1132_split_6 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1132_split_6", 3)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1132_split_6, Vector3.New(0, -413, -185), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(0, -413, -185)
			end

			slot5 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and slot5.GetComponent(slot5, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot7
			end

			slot7 = 0.2

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.highlightMatValue1132_split_6 then
					slot9 = Mathf.Lerp(0.5, 1, slot8)
					slot10 = uv0.var_.highlightMatValue1132_split_6
					slot11 = slot10.color
					slot11.r = slot9
					slot11.g = slot9
					slot11.b = slot9
					slot10.color = slot11
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot8 = 1

				slot5.transform:SetSiblingIndex(1)

				slot9 = uv0.var_.highlightMatValue1132_split_6
				slot10 = slot9.color
				slot10.r = slot8
				slot10.g = slot8
				slot10.b = slot8
				slot9.color = slot10
			end

			slot8 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				if slot8.GetComponent(slot8, "Image") then
					uv0.var_.alphaMatValue1132_split_6 = slot10
					uv0.var_.alphaOldValue1132_split_6 = slot10.color.a
				end

				uv0.var_.alphaOldValue1132_split_6 = 0
			end

			slot10 = 0.5

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot12 = Mathf.Lerp(uv0.var_.alphaOldValue1132_split_6, 1, (uv0.time_ - slot9) / slot10)

				if uv0.var_.alphaMatValue1132_split_6 then
					slot13 = uv0.var_.alphaMatValue1132_split_6.color
					slot13.a = slot12
					uv0.var_.alphaMatValue1132_split_6.color = slot13
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.alphaMatValue1132_split_6 then
				slot11 = uv0.var_.alphaMatValue1132_split_6
				slot12 = slot11.color
				slot12.a = 1
				slot11.color = slot12
			end

			slot12 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122004].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122004", "story_v_out_117122.awb") / 1000 > 0 and slot12 < slot16 and uv0.duration_ < slot16 + slot11 then
					slot12 = slot16
					uv0.duration_ = slot16 + slot11
				end

				if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
					uv0:RecordAudio("117122004", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_117122", "117122004", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122004", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = uv0:FormatText(StoryWordCfg[117122004].content)
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
	Play117122005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.9

		if ({
			ja = 1.433,
			zh = 1.9
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
				uv0:Play117122006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue1132_split_6 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue1132_split_6
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue1132_split_6
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_10035_split_5")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122005].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122005", "story_v_out_117122.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
					slot5 = slot9
					uv0.duration_ = slot9 + slot4
				end

				if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
					uv0:RecordAudio("117122005", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_117122", "117122005", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122005", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[117122005].content)
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
	Play117122006 = function (slot0, slot1)
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
				uv0:Play117122007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1132_split_5"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["1132_split_5"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos1132_split_5 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1132_split_5", 7)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1132_split_5, Vector3.New(0, -2000, -185), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(0, -2000, -185)
			end

			slot6 = 0.8

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122006].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot8 = uv0:FormatText(StoryWordCfg[117122006].content)
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
	Play117122007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.666

		if ({
			ja = 2.666,
			zh = 1.5
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
				uv0:Play117122008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["10035_split_4"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["10035_split_4"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos10035_split_4 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10035_split_4", 4)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10035_split_4, Vector3.New(390, -410, -235), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(390, -410, -235)
			end

			if uv0.actors_["1033_split_6"] == nil then
				slot6 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot6.transform:SetSiblingIndex(1)

				slot6.name = slot5
				slot7 = slot6:GetComponent(typeof(Image))
				slot7.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot5)

				slot7:SetNativeSize()

				slot6.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot5] = slot6
			end

			slot6 = uv0.actors_["1033_split_6"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.var_.moveOldPos1033_split_6 = slot6.localPosition
				slot6.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1033_split_6", 2)
			end

			slot8 = 0.001

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot6.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033_split_6, Vector3.New(-390, -420, 0), (uv0.time_ - slot7) / slot8)
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot6.localPosition = Vector3.New(-390, -420, 0)
			end

			slot9 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 and slot9.GetComponent(slot9, "Image") then
				uv0.var_.highlightMatValue1033_split_6 = slot11
			end

			slot11 = 0.2

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot12 = (uv0.time_ - slot10) / slot11

				if uv0.var_.highlightMatValue1033_split_6 then
					slot13 = Mathf.Lerp(0.5, 1, slot12)
					slot14 = uv0.var_.highlightMatValue1033_split_6
					slot15 = slot14.color
					slot15.r = slot13
					slot15.g = slot13
					slot15.b = slot13
					slot14.color = slot15
				end
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 and uv0.var_.highlightMatValue1033_split_6 then
				slot12 = 1

				slot9.transform:SetSiblingIndex(1)

				slot13 = uv0.var_.highlightMatValue1033_split_6
				slot14 = slot13.color
				slot14.r = slot12
				slot14.g = slot12
				slot14.b = slot12
				slot13.color = slot14
			end

			slot12 = uv0.actors_["10035_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 and slot12.GetComponent(slot12, "Image") then
				uv0.var_.highlightMatValue10035_split_4 = slot14
			end

			slot14 = 0.2

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				slot15 = (uv0.time_ - slot13) / slot14

				if uv0.var_.highlightMatValue10035_split_4 then
					slot16 = Mathf.Lerp(1, 0.5, slot15)
					slot17 = uv0.var_.highlightMatValue10035_split_4
					slot18 = slot17.color
					slot18.r = slot16
					slot18.g = slot16
					slot18.b = slot16
					slot17.color = slot18
				end
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 and uv0.var_.highlightMatValue10035_split_4 then
				slot15 = 0.5
				slot16 = uv0.var_.highlightMatValue10035_split_4
				slot17 = slot16.color
				slot17.r = slot15
				slot17.g = slot15
				slot17.b = slot15
				slot16.color = slot17
			end

			slot15 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				if slot15.GetComponent(slot15, "Image") then
					uv0.var_.alphaMatValue1132_split_6 = slot17
					uv0.var_.alphaOldValue1132_split_6 = slot17.color.a
				end

				uv0.var_.alphaOldValue1132_split_6 = 1
			end

			slot17 = 0.5

			if slot16 <= uv0.time_ and uv0.time_ < slot16 + slot17 then
				slot19 = Mathf.Lerp(uv0.var_.alphaOldValue1132_split_6, 0, (uv0.time_ - slot16) / slot17)

				if uv0.var_.alphaMatValue1132_split_6 then
					slot20 = uv0.var_.alphaMatValue1132_split_6.color
					slot20.a = slot19
					uv0.var_.alphaMatValue1132_split_6.color = slot20
				end
			end

			if uv0.time_ >= slot16 + slot17 and uv0.time_ < slot16 + slot17 + slot0 and uv0.var_.alphaMatValue1132_split_6 then
				slot18 = uv0.var_.alphaMatValue1132_split_6
				slot19 = slot18.color
				slot19.a = 0
				slot18.color = slot19
			end

			slot18 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				if slot18.GetComponent(slot18, "Image") then
					uv0.var_.alphaMatValue1033_split_6 = slot20
					uv0.var_.alphaOldValue1033_split_6 = slot20.color.a
				end

				uv0.var_.alphaOldValue1033_split_6 = 0
			end

			slot20 = 0.5

			if slot19 <= uv0.time_ and uv0.time_ < slot19 + slot20 then
				slot22 = Mathf.Lerp(uv0.var_.alphaOldValue1033_split_6, 1, (uv0.time_ - slot19) / slot20)

				if uv0.var_.alphaMatValue1033_split_6 then
					slot23 = uv0.var_.alphaMatValue1033_split_6.color
					slot23.a = slot22
					uv0.var_.alphaMatValue1033_split_6.color = slot23
				end
			end

			if uv0.time_ >= slot19 + slot20 and uv0.time_ < slot19 + slot20 + slot0 and uv0.var_.alphaMatValue1033_split_6 then
				slot21 = uv0.var_.alphaMatValue1033_split_6
				slot22 = slot21.color
				slot22.a = 1
				slot21.color = slot22
			end

			slot21 = uv0.actors_["10035_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot22 + slot0 then
				if slot21.GetComponent(slot21, "Image") then
					uv0.var_.alphaMatValue10035_split_4 = slot23
					uv0.var_.alphaOldValue10035_split_4 = slot23.color.a
				end

				uv0.var_.alphaOldValue10035_split_4 = 0
			end

			slot23 = 0.5

			if slot22 <= uv0.time_ and uv0.time_ < slot22 + slot23 then
				slot25 = Mathf.Lerp(uv0.var_.alphaOldValue10035_split_4, 1, (uv0.time_ - slot22) / slot23)

				if uv0.var_.alphaMatValue10035_split_4 then
					slot26 = uv0.var_.alphaMatValue10035_split_4.color
					slot26.a = slot25
					uv0.var_.alphaMatValue10035_split_4.color = slot26
				end
			end

			if uv0.time_ >= slot22 + slot23 and uv0.time_ < slot22 + slot23 + slot0 and uv0.var_.alphaMatValue10035_split_4 then
				slot24 = uv0.var_.alphaMatValue10035_split_4
				slot25 = slot24.color
				slot25.a = 1
				slot24.color = slot25
			end

			slot25 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot24 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122007].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122007", "story_v_out_117122.awb") / 1000 > 0 and slot25 < slot29 and uv0.duration_ < slot29 + slot24 then
					slot25 = slot29
					uv0.duration_ = slot29 + slot24
				end

				if slot27.prefab_name ~= "" and uv0.actors_[slot27.prefab_name] ~= nil then
					uv0:RecordAudio("117122007", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot27.prefab_name].transform, "story_v_out_117122", "117122007", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122007", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot27 = uv0:FormatText(StoryWordCfg[117122007].content)
			slot29 = string.split(slot27, ".")

			if #string.split(slot27, "\n") >= 4 or #slot29 >= 4 then
				slot25 = slot25 * 3
			end

			if slot24 <= uv0.time_ and uv0.time_ < slot24 + slot25 then
				uv0.typewritter.percent = (uv0.time_ - slot24) / slot25

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot24 + slot25 and uv0.time_ < slot24 + slot25 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play117122008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.166

		if ({
			ja = 4.2,
			zh = 5.166
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
				uv0:Play117122009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["10035_split_5"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["10035_split_5"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos10035_split_5 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10035_split_5", 4)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10035_split_5, Vector3.New(390, -410, -235), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(390, -410, -235)
			end

			slot5 = uv0.actors_["1033_split_6"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos1033_split_6 = slot5.localPosition
				slot5.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1033_split_6", 2)
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033_split_6, Vector3.New(-390, -420, 0), (uv0.time_ - slot6) / slot7)
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(-390, -420, 0)
			end

			slot8 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 and slot8.GetComponent(slot8, "Image") then
				uv0.var_.highlightMatValue1033_split_6 = slot10
			end

			slot10 = 0.2

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot11 = (uv0.time_ - slot9) / slot10

				if uv0.var_.highlightMatValue1033_split_6 then
					slot12 = Mathf.Lerp(1, 0.5, slot11)
					slot13 = uv0.var_.highlightMatValue1033_split_6
					slot14 = slot13.color
					slot14.r = slot12
					slot14.g = slot12
					slot14.b = slot12
					slot13.color = slot14
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.highlightMatValue1033_split_6 then
				slot11 = 0.5
				slot12 = uv0.var_.highlightMatValue1033_split_6
				slot13 = slot12.color
				slot13.r = slot11
				slot13.g = slot11
				slot13.b = slot11
				slot12.color = slot13
			end

			slot11 = uv0.actors_["10035_split_5"]

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 and slot11.GetComponent(slot11, "Image") then
				uv0.var_.highlightMatValue10035_split_5 = slot13
			end

			slot13 = 0.2

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot14 = (uv0.time_ - slot12) / slot13

				if uv0.var_.highlightMatValue10035_split_5 then
					slot15 = Mathf.Lerp(0.5, 1, slot14)
					slot16 = uv0.var_.highlightMatValue10035_split_5
					slot17 = slot16.color
					slot17.r = slot15
					slot17.g = slot15
					slot17.b = slot15
					slot16.color = slot17
				end
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 and uv0.var_.highlightMatValue10035_split_5 then
				slot14 = 1

				slot11.transform:SetSiblingIndex(1)

				slot15 = uv0.var_.highlightMatValue10035_split_5
				slot16 = slot15.color
				slot16.r = slot14
				slot16.g = slot14
				slot16.b = slot14
				slot15.color = slot16
			end

			slot15 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122008].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122008", "story_v_out_117122.awb") / 1000 > 0 and slot15 < slot19 and uv0.duration_ < slot19 + slot14 then
					slot15 = slot19
					uv0.duration_ = slot19 + slot14
				end

				if slot17.prefab_name ~= "" and uv0.actors_[slot17.prefab_name] ~= nil then
					uv0:RecordAudio("117122008", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot17.prefab_name].transform, "story_v_out_117122", "117122008", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122008", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot17 = uv0:FormatText(StoryWordCfg[117122008].content)
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
	Play117122009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.233

		if ({
			ja = 2.266,
			zh = 3.233
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
				uv0:Play117122010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10035_split_5"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10035_split_5 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10035_split_5", 4)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10035_split_5, Vector3.New(390, -410, -235), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -410, -235)
			end

			slot4 = uv0.actors_["10035_split_5"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10035_split_5 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10035_split_5 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue10035_split_5
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10035_split_5 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue10035_split_5
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot7 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and slot7.GetComponent(slot7, "Image") then
				uv0.var_.highlightMatValue1033_split_6 = slot9
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.highlightMatValue1033_split_6 then
					slot11 = Mathf.Lerp(0.5, 1, slot10)
					slot12 = uv0.var_.highlightMatValue1033_split_6
					slot13 = slot12.color
					slot13.r = slot11
					slot13.g = slot11
					slot13.b = slot11
					slot12.color = slot13
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.highlightMatValue1033_split_6 then
				slot10 = 1

				slot7.transform:SetSiblingIndex(1)

				slot11 = uv0.var_.highlightMatValue1033_split_6
				slot12 = slot11.color
				slot12.r = slot10
				slot12.g = slot10
				slot12.b = slot10
				slot11.color = slot12
			end

			slot11 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122009].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122009", "story_v_out_117122.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
					slot11 = slot15
					uv0.duration_ = slot15 + slot10
				end

				if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
					uv0:RecordAudio("117122009", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_117122", "117122009", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122009", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[117122009].content)
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
	Play117122010 = function (slot0, slot1)
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
				uv0:Play117122011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if slot1.GetComponent(slot1, "Image") then
					uv0.var_.alphaMatValue1033_split_6 = slot3
					uv0.var_.alphaOldValue1033_split_6 = slot3.color.a
				end

				uv0.var_.alphaOldValue1033_split_6 = 1
			end

			slot3 = 0.3

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5 = Mathf.Lerp(uv0.var_.alphaOldValue1033_split_6, 0, (uv0.time_ - slot2) / slot3)

				if uv0.var_.alphaMatValue1033_split_6 then
					slot6 = uv0.var_.alphaMatValue1033_split_6.color
					slot6.a = slot5
					uv0.var_.alphaMatValue1033_split_6.color = slot6
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.alphaMatValue1033_split_6 then
				slot4 = uv0.var_.alphaMatValue1033_split_6
				slot5 = slot4.color
				slot5.a = 0
				slot4.color = slot5
			end

			slot4 = uv0.actors_["10035_split_5"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				if slot4.GetComponent(slot4, "Image") then
					uv0.var_.alphaMatValue10035_split_5 = slot6
					uv0.var_.alphaOldValue10035_split_5 = slot6.color.a
				end

				uv0.var_.alphaOldValue10035_split_5 = 1
			end

			slot6 = 0.3

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot8 = Mathf.Lerp(uv0.var_.alphaOldValue10035_split_5, 0, (uv0.time_ - slot5) / slot6)

				if uv0.var_.alphaMatValue10035_split_5 then
					slot9 = uv0.var_.alphaMatValue10035_split_5.color
					slot9.a = slot8
					uv0.var_.alphaMatValue10035_split_5.color = slot9
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.alphaMatValue10035_split_5 then
				slot7 = uv0.var_.alphaMatValue10035_split_5
				slot8 = slot7.color
				slot8.a = 0
				slot7.color = slot8
			end

			slot8 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122010].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117122010].content)
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
	Play117122011 = function (slot0, slot1)
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
				uv0:Play117122012(uv1)
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

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122011].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122011].content)
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
	Play117122012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.766

		if ({
			ja = 3.366,
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
				uv0:Play117122013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033_split_6"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1033_split_6 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1033_split_6", 3)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033_split_6, Vector3.New(0, -420, 0), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -420, 0)
			end

			slot4 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1033_split_6 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1033_split_6 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue1033_split_6
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1033_split_6 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue1033_split_6
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot7 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				if slot7.GetComponent(slot7, "Image") then
					uv0.var_.alphaMatValue1033_split_6 = slot9
					uv0.var_.alphaOldValue1033_split_6 = slot9.color.a
				end

				uv0.var_.alphaOldValue1033_split_6 = 0
			end

			slot9 = 0.5

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot11 = Mathf.Lerp(uv0.var_.alphaOldValue1033_split_6, 1, (uv0.time_ - slot8) / slot9)

				if uv0.var_.alphaMatValue1033_split_6 then
					slot12 = uv0.var_.alphaMatValue1033_split_6.color
					slot12.a = slot11
					uv0.var_.alphaMatValue1033_split_6.color = slot12
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.alphaMatValue1033_split_6 then
				slot10 = uv0.var_.alphaMatValue1033_split_6
				slot11 = slot10.color
				slot11.a = 1
				slot10.color = slot11
			end

			slot11 = 0.75

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122012].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122012", "story_v_out_117122.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
					slot11 = slot15
					uv0.duration_ = slot15 + slot10
				end

				if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
					uv0:RecordAudio("117122012", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_117122", "117122012", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122012", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[117122012].content)
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
	Play117122013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 14.666

		if ({
			ja = 14.666,
			zh = 10.7
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
				uv0:Play117122014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.25

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122013].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122013", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122013", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122013", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122013", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122013].content)
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
	Play117122014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 14.6

		if ({
			ja = 14.6,
			zh = 13.333
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
				uv0:Play117122015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.675

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122014].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122014", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122014", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122014", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122014", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122014].content)
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
	Play117122015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 11.666

		if ({
			ja = 11.666,
			zh = 9.766
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
				uv0:Play117122016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033_split_6"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1033_split_6 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1033_split_6", 3)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033_split_6, Vector3.New(0, -420, 0), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -420, 0)
			end

			slot5 = 1.275

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122015].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122015", "story_v_out_117122.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
					slot5 = slot9
					uv0.duration_ = slot9 + slot4
				end

				if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
					uv0:RecordAudio("117122015", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_117122", "117122015", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122015", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[117122015].content)
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
	Play117122016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.666

		if ({
			ja = 6.666,
			zh = 6.1
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
				uv0:Play117122017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.75

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122016].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122016", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122016", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122016", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122016", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122016].content)
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
	Play117122017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.133

		if ({
			ja = 3.133,
			zh = 3.066
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
				uv0:Play117122018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033_split_6"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1033_split_6 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1033_split_6", 4)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033_split_6, Vector3.New(390, -420, 0), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -420, 0)
			end

			slot4 = uv0.actors_["1132_split_6"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1132_split_6 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1132_split_6", 2)
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1132_split_6, Vector3.New(-390, -413, -185), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(-390, -413, -185)
			end

			slot7 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and slot7.GetComponent(slot7, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot9
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.highlightMatValue1132_split_6 then
					slot11 = Mathf.Lerp(0.5, 1, slot10)
					slot12 = uv0.var_.highlightMatValue1132_split_6
					slot13 = slot12.color
					slot13.r = slot11
					slot13.g = slot11
					slot13.b = slot11
					slot12.color = slot13
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot10 = 1

				slot7.transform:SetSiblingIndex(1)

				slot11 = uv0.var_.highlightMatValue1132_split_6
				slot12 = slot11.color
				slot12.r = slot10
				slot12.g = slot10
				slot12.b = slot10
				slot11.color = slot12
			end

			slot10 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and slot10.GetComponent(slot10, "Image") then
				uv0.var_.highlightMatValue1033_split_6 = slot12
			end

			slot12 = 0.2

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.highlightMatValue1033_split_6 then
					slot14 = Mathf.Lerp(1, 0.5, slot13)
					slot15 = uv0.var_.highlightMatValue1033_split_6
					slot16 = slot15.color
					slot16.r = slot14
					slot16.g = slot14
					slot16.b = slot14
					slot15.color = slot16
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.highlightMatValue1033_split_6 then
				slot13 = 0.5
				slot14 = uv0.var_.highlightMatValue1033_split_6
				slot15 = slot14.color
				slot15.r = slot13
				slot15.g = slot13
				slot15.b = slot13
				slot14.color = slot15
			end

			slot13 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				if slot13.GetComponent(slot13, "Image") then
					uv0.var_.alphaMatValue1132_split_6 = slot15
					uv0.var_.alphaOldValue1132_split_6 = slot15.color.a
				end

				uv0.var_.alphaOldValue1132_split_6 = 0
			end

			slot15 = 0.5

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot17 = Mathf.Lerp(uv0.var_.alphaOldValue1132_split_6, 1, (uv0.time_ - slot14) / slot15)

				if uv0.var_.alphaMatValue1132_split_6 then
					slot18 = uv0.var_.alphaMatValue1132_split_6.color
					slot18.a = slot17
					uv0.var_.alphaMatValue1132_split_6.color = slot18
				end
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 and uv0.var_.alphaMatValue1132_split_6 then
				slot16 = uv0.var_.alphaMatValue1132_split_6
				slot17 = slot16.color
				slot17.a = 1
				slot16.color = slot17
			end

			slot16 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				if slot16.GetComponent(slot16, "Image") then
					uv0.var_.alphaMatValue1033_split_6 = slot18
					uv0.var_.alphaOldValue1033_split_6 = slot18.color.a
				end

				uv0.var_.alphaOldValue1033_split_6 = 0
			end

			slot18 = 0.5

			if slot17 <= uv0.time_ and uv0.time_ < slot17 + slot18 then
				slot20 = Mathf.Lerp(uv0.var_.alphaOldValue1033_split_6, 1, (uv0.time_ - slot17) / slot18)

				if uv0.var_.alphaMatValue1033_split_6 then
					slot21 = uv0.var_.alphaMatValue1033_split_6.color
					slot21.a = slot20
					uv0.var_.alphaMatValue1033_split_6.color = slot21
				end
			end

			if uv0.time_ >= slot17 + slot18 and uv0.time_ < slot17 + slot18 + slot0 and uv0.var_.alphaMatValue1033_split_6 then
				slot19 = uv0.var_.alphaMatValue1033_split_6
				slot20 = slot19.color
				slot20.a = 1
				slot19.color = slot20
			end

			slot20 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122017].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122017", "story_v_out_117122.awb") / 1000 > 0 and slot20 < slot24 and uv0.duration_ < slot24 + slot19 then
					slot20 = slot24
					uv0.duration_ = slot24 + slot19
				end

				if slot22.prefab_name ~= "" and uv0.actors_[slot22.prefab_name] ~= nil then
					uv0:RecordAudio("117122017", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot22.prefab_name].transform, "story_v_out_117122", "117122017", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122017", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot22 = uv0:FormatText(StoryWordCfg[117122017].content)
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
	Play117122018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 10.2

		if ({
			ja = 10.2,
			zh = 5.633
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
				uv0:Play117122019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033_split_6"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1033_split_6 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1033_split_6", 4)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033_split_6, Vector3.New(390, -420, 0), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -420, 0)
			end

			slot4 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1132_split_6 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue1132_split_6
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue1132_split_6
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot7 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and slot7.GetComponent(slot7, "Image") then
				uv0.var_.highlightMatValue1033_split_6 = slot9
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.highlightMatValue1033_split_6 then
					slot11 = Mathf.Lerp(0.5, 1, slot10)
					slot12 = uv0.var_.highlightMatValue1033_split_6
					slot13 = slot12.color
					slot13.r = slot11
					slot13.g = slot11
					slot13.b = slot11
					slot12.color = slot13
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.highlightMatValue1033_split_6 then
				slot10 = 1

				slot7.transform:SetSiblingIndex(1)

				slot11 = uv0.var_.highlightMatValue1033_split_6
				slot12 = slot11.color
				slot12.r = slot10
				slot12.g = slot10
				slot12.b = slot10
				slot11.color = slot12
			end

			slot11 = 0.75

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122018].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122018", "story_v_out_117122.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
					slot11 = slot15
					uv0.duration_ = slot15 + slot10
				end

				if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
					uv0:RecordAudio("117122018", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_117122", "117122018", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122018", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[117122018].content)
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
	Play117122019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.833

		if ({
			ja = 2.833,
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
				uv0:Play117122020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue1132_split_6 then
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue1132_split_6
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1132_split_6
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot4 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1033_split_6 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1033_split_6 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue1033_split_6
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1033_split_6 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue1033_split_6
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122019].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122019", "story_v_out_117122.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
					slot8 = slot12
					uv0.duration_ = slot12 + slot7
				end

				if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
					uv0:RecordAudio("117122019", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117122", "117122019", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122019", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117122019].content)
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
	Play117122020 = function (slot0, slot1)
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
				uv0:Play117122021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue1132_split_6 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue1132_split_6
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue1132_split_6
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			if uv0.actors_["1033_split_5"] == nil then
				slot5 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot5.transform:SetSiblingIndex(1)

				slot5.name = slot4
				slot6 = slot5:GetComponent(typeof(Image))
				slot6.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot4)

				slot6:SetNativeSize()

				slot5.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot4] = slot5
			end

			slot5 = uv0.actors_["1033_split_5"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and slot5.GetComponent(slot5, "Image") then
				uv0.var_.highlightMatValue1033_split_5 = slot7
			end

			slot7 = 0.034

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.highlightMatValue1033_split_5 then
					slot9 = Mathf.Lerp(1, 0.5, slot8)
					slot10 = uv0.var_.highlightMatValue1033_split_5
					slot11 = slot10.color
					slot11.r = slot9
					slot11.g = slot9
					slot11.b = slot9
					slot10.color = slot11
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.highlightMatValue1033_split_5 then
				slot8 = 0.5
				slot9 = uv0.var_.highlightMatValue1033_split_5
				slot10 = slot9.color
				slot10.r = slot8
				slot10.g = slot8
				slot10.b = slot8
				slot9.color = slot10
			end

			slot9 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122020].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot11 = uv0:FormatText(StoryWordCfg[117122020].content)
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
	Play117122021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 11.233

		if ({
			ja = 6.266,
			zh = 11.233
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
				uv0:Play117122022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue1132_split_6 then
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue1132_split_6
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1132_split_6
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122021].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122021", "story_v_out_117122.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
					slot5 = slot9
					uv0.duration_ = slot9 + slot4
				end

				if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
					uv0:RecordAudio("117122021", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_117122", "117122021", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122021", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[117122021].content)
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
	Play117122022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 10.8

		if ({
			ja = 7.5,
			zh = 10.8
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
				uv0:Play117122023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.925

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122022].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122022", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122022", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122022", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122022", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122022].content)
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
	Play117122023 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 11.166

		if ({
			ja = 6.2,
			zh = 11.166
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
				uv0:Play117122024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.175

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122023].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122023", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122023", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122023", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122023", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122023].content)
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
	Play117122024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.4

		if ({
			ja = 5.4,
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
				uv0:Play117122025(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033_split_6"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1033_split_6 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1033_split_6", 4)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033_split_6, Vector3.New(390, -420, 0), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -420, 0)
			end

			slot4 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1132_split_6 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue1132_split_6
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue1132_split_6
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot7 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and slot7.GetComponent(slot7, "Image") then
				uv0.var_.highlightMatValue1033_split_6 = slot9
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.highlightMatValue1033_split_6 then
					slot11 = Mathf.Lerp(0.5, 1, slot10)
					slot12 = uv0.var_.highlightMatValue1033_split_6
					slot13 = slot12.color
					slot13.r = slot11
					slot13.g = slot11
					slot13.b = slot11
					slot12.color = slot13
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.highlightMatValue1033_split_6 then
				slot10 = 1

				slot7.transform:SetSiblingIndex(1)

				slot11 = uv0.var_.highlightMatValue1033_split_6
				slot12 = slot11.color
				slot12.r = slot10
				slot12.g = slot10
				slot12.b = slot10
				slot11.color = slot12
			end

			slot11 = 1.05

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122024].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122024", "story_v_out_117122.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
					slot11 = slot15
					uv0.duration_ = slot15 + slot10
				end

				if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
					uv0:RecordAudio("117122024", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_117122", "117122024", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122024", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[117122024].content)
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
	Play117122025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.6

		if ({
			ja = 4.433,
			zh = 5.6
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
				uv0:Play117122026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122025].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122025", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122025", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122025", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122025", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122025].content)
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
	Play117122026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.4

		if ({
			ja = 4.1,
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
				uv0:Play117122027(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue1132_split_6 then
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue1132_split_6
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1132_split_6
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot4 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1033_split_6 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1033_split_6 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue1033_split_6
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1033_split_6 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue1033_split_6
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.6

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122026].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122026", "story_v_out_117122.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
					slot8 = slot12
					uv0.duration_ = slot12 + slot7
				end

				if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
					uv0:RecordAudio("117122026", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117122", "117122026", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122026", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117122026].content)
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
	Play117122027 = function (slot0, slot1)
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
				uv0:Play117122028(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue1132_split_6 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue1132_split_6
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue1132_split_6
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122027].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[117122027].content)
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
	Play117122028 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.833

		if ({
			ja = 3.566,
			zh = 4.833
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
				uv0:Play117122029(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue1132_split_6 then
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue1132_split_6
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1132_split_6
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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122028].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122028", "story_v_out_117122.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
					slot5 = slot9
					uv0.duration_ = slot9 + slot4
				end

				if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
					uv0:RecordAudio("117122028", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_117122", "117122028", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122028", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[117122028].content)
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
	Play117122029 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.3

		if ({
			ja = 8.3,
			zh = 6.2
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
				uv0:Play117122030(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue1132_split_6 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue1132_split_6
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue1132_split_6
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot4 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1033_split_6 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1033_split_6 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue1033_split_6
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1033_split_6 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue1033_split_6
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.575

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122029].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122029", "story_v_out_117122.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
					slot8 = slot12
					uv0.duration_ = slot12 + slot7
				end

				if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
					uv0:RecordAudio("117122029", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117122", "117122029", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122029", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117122029].content)
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
	Play117122030 = function (slot0, slot1)
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
				uv0:Play117122031(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue1033_split_6 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue1033_split_6 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue1033_split_6
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1033_split_6 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue1033_split_6
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 1.025

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122030].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[117122030].content)
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
	Play117122031 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.466

		if ({
			ja = 2.1,
			zh = 2.466
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
				uv0:Play117122032(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1033_split_4"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["1033_split_4"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos1033_split_4 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1033_split_4", 7)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033_split_4, Vector3.New(0, -2000, 0), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(0, -2000, 0)
			end

			slot5 = uv0.actors_["10035_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and slot5.GetComponent(slot5, "Image") then
				uv0.var_.highlightMatValue10035_split_4 = slot7
			end

			slot7 = 0.2

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.highlightMatValue10035_split_4 then
					slot9 = Mathf.Lerp(0.5, 1, slot8)
					slot10 = uv0.var_.highlightMatValue10035_split_4
					slot11 = slot10.color
					slot11.r = slot9
					slot11.g = slot9
					slot11.b = slot9
					slot10.color = slot11
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.highlightMatValue10035_split_4 then
				slot8 = 1

				slot5.transform:SetSiblingIndex(1)

				slot9 = uv0.var_.highlightMatValue10035_split_4
				slot10 = slot9.color
				slot10.r = slot8
				slot10.g = slot8
				slot10.b = slot8
				slot9.color = slot10
			end

			slot8 = uv0.actors_["10035_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				if slot8.GetComponent(slot8, "Image") then
					uv0.var_.alphaMatValue10035_split_4 = slot10
					uv0.var_.alphaOldValue10035_split_4 = slot10.color.a
				end

				uv0.var_.alphaOldValue10035_split_4 = 0
			end

			slot10 = 0.333333333333333

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot12 = Mathf.Lerp(uv0.var_.alphaOldValue10035_split_4, 1, (uv0.time_ - slot9) / slot10)

				if uv0.var_.alphaMatValue10035_split_4 then
					slot13 = uv0.var_.alphaMatValue10035_split_4.color
					slot13.a = slot12
					uv0.var_.alphaMatValue10035_split_4.color = slot13
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.alphaMatValue10035_split_4 then
				slot11 = uv0.var_.alphaMatValue10035_split_4
				slot12 = slot11.color
				slot12.a = 1
				slot11.color = slot12
			end

			slot12 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_10035_split_4")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122031].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122031", "story_v_out_117122.awb") / 1000 > 0 and slot12 < slot16 and uv0.duration_ < slot16 + slot11 then
					slot12 = slot16
					uv0.duration_ = slot16 + slot11
				end

				if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
					uv0:RecordAudio("117122031", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_117122", "117122031", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122031", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = uv0:FormatText(StoryWordCfg[117122031].content)
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
	Play117122032 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.8

		if ({
			ja = 1.433,
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
				uv0:Play117122033(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue1132_split_6 then
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue1132_split_6
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1132_split_6
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot4 = uv0.actors_["10035_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10035_split_4 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10035_split_4 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue10035_split_4
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10035_split_4 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue10035_split_4
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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122032].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122032", "story_v_out_117122.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
					slot8 = slot12
					uv0.duration_ = slot12 + slot7
				end

				if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
					uv0:RecordAudio("117122032", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117122", "117122032", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122032", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117122032].content)
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
	Play117122033 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.533

		if ({
			ja = 2.666,
			zh = 3.533
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
				uv0:Play117122034(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122033].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122033", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122033", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122033", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122033", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122033].content)
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
	Play117122034 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 9.433

		if ({
			ja = 9.433,
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
				uv0:Play117122035(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10035_split_5"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10035_split_5 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10035_split_5", 4)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10035_split_5, Vector3.New(390, -410, -235), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -410, -235)
			end

			slot4 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1132_split_6 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue1132_split_6
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue1132_split_6
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot7 = uv0.actors_["10035_split_5"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and slot7.GetComponent(slot7, "Image") then
				uv0.var_.highlightMatValue10035_split_5 = slot9
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.highlightMatValue10035_split_5 then
					slot11 = Mathf.Lerp(0.5, 1, slot10)
					slot12 = uv0.var_.highlightMatValue10035_split_5
					slot13 = slot12.color
					slot13.r = slot11
					slot13.g = slot11
					slot13.b = slot11
					slot12.color = slot13
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.highlightMatValue10035_split_5 then
				slot10 = 1

				slot7.transform:SetSiblingIndex(1)

				slot11 = uv0.var_.highlightMatValue10035_split_5
				slot12 = slot11.color
				slot12.r = slot10
				slot12.g = slot10
				slot12.b = slot10
				slot11.color = slot12
			end

			slot10 = uv0.actors_["10035_split_5"]

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				if slot10.GetComponent(slot10, "Image") then
					uv0.var_.alphaMatValue10035_split_5 = slot12
					uv0.var_.alphaOldValue10035_split_5 = slot12.color.a
				end

				uv0.var_.alphaOldValue10035_split_5 = 0
			end

			slot12 = 0.0166666666666667

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot14 = Mathf.Lerp(uv0.var_.alphaOldValue10035_split_5, 1, (uv0.time_ - slot11) / slot12)

				if uv0.var_.alphaMatValue10035_split_5 then
					slot15 = uv0.var_.alphaMatValue10035_split_5.color
					slot15.a = slot14
					uv0.var_.alphaMatValue10035_split_5.color = slot15
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.alphaMatValue10035_split_5 then
				slot13 = uv0.var_.alphaMatValue10035_split_5
				slot14 = slot13.color
				slot14.a = 1
				slot13.color = slot14
			end

			slot14 = 0.775

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122034].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122034", "story_v_out_117122.awb") / 1000 > 0 and slot14 < slot18 and uv0.duration_ < slot18 + slot13 then
					slot14 = slot18
					uv0.duration_ = slot18 + slot13
				end

				if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
					uv0:RecordAudio("117122034", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_117122", "117122034", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122034", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = uv0:FormatText(StoryWordCfg[117122034].content)
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
	Play117122035 = function (slot0, slot1)
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
				uv0:Play117122036(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if slot1.GetComponent(slot1, "Image") then
					uv0.var_.alphaMatValue1132_split_6 = slot3
					uv0.var_.alphaOldValue1132_split_6 = slot3.color.a
				end

				uv0.var_.alphaOldValue1132_split_6 = 1
			end

			slot3 = 0.5

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5 = Mathf.Lerp(uv0.var_.alphaOldValue1132_split_6, 0, (uv0.time_ - slot2) / slot3)

				if uv0.var_.alphaMatValue1132_split_6 then
					slot6 = uv0.var_.alphaMatValue1132_split_6.color
					slot6.a = slot5
					uv0.var_.alphaMatValue1132_split_6.color = slot6
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.alphaMatValue1132_split_6 then
				slot4 = uv0.var_.alphaMatValue1132_split_6
				slot5 = slot4.color
				slot5.a = 0
				slot4.color = slot5
			end

			slot4 = uv0.actors_["10035_split_5"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				if slot4.GetComponent(slot4, "Image") then
					uv0.var_.alphaMatValue10035_split_5 = slot6
					uv0.var_.alphaOldValue10035_split_5 = slot6.color.a
				end

				uv0.var_.alphaOldValue10035_split_5 = 1
			end

			slot6 = 0.5

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot8 = Mathf.Lerp(uv0.var_.alphaOldValue10035_split_5, 0, (uv0.time_ - slot5) / slot6)

				if uv0.var_.alphaMatValue10035_split_5 then
					slot9 = uv0.var_.alphaMatValue10035_split_5.color
					slot9.a = slot8
					uv0.var_.alphaMatValue10035_split_5.color = slot9
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.alphaMatValue10035_split_5 then
				slot7 = uv0.var_.alphaMatValue10035_split_5
				slot8 = slot7.color
				slot8.a = 0
				slot7.color = slot8
			end

			slot8 = 1.375

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122035].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117122035].content)
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
	Play117122036 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 11.733

		if ({
			ja = 11.733,
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
				uv0:Play117122037(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10035_split_4"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10035_split_4 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10035_split_4", 4)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10035_split_4, Vector3.New(390, -410, -235), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -410, -235)
			end

			slot4 = uv0.actors_["1132_split_6"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1132_split_6 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1132_split_6", 2)
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1132_split_6, Vector3.New(-390, -413, -185), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(-390, -413, -185)
			end

			slot7 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and slot7.GetComponent(slot7, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot9
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.highlightMatValue1132_split_6 then
					slot11 = Mathf.Lerp(1, 0.5, slot10)
					slot12 = uv0.var_.highlightMatValue1132_split_6
					slot13 = slot12.color
					slot13.r = slot11
					slot13.g = slot11
					slot13.b = slot11
					slot12.color = slot13
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot10 = 0.5
				slot11 = uv0.var_.highlightMatValue1132_split_6
				slot12 = slot11.color
				slot12.r = slot10
				slot12.g = slot10
				slot12.b = slot10
				slot11.color = slot12
			end

			slot10 = uv0.actors_["10035_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and slot10.GetComponent(slot10, "Image") then
				uv0.var_.highlightMatValue10035_split_4 = slot12
			end

			slot12 = 0.2

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.highlightMatValue10035_split_4 then
					slot14 = Mathf.Lerp(0.5, 1, slot13)
					slot15 = uv0.var_.highlightMatValue10035_split_4
					slot16 = slot15.color
					slot16.r = slot14
					slot16.g = slot14
					slot16.b = slot14
					slot15.color = slot16
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.highlightMatValue10035_split_4 then
				slot13 = 1

				slot10.transform:SetSiblingIndex(1)

				slot14 = uv0.var_.highlightMatValue10035_split_4
				slot15 = slot14.color
				slot15.r = slot13
				slot15.g = slot13
				slot15.b = slot13
				slot14.color = slot15
			end

			slot13 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				if slot13.GetComponent(slot13, "Image") then
					uv0.var_.alphaMatValue1132_split_6 = slot15
					uv0.var_.alphaOldValue1132_split_6 = slot15.color.a
				end

				uv0.var_.alphaOldValue1132_split_6 = 0
			end

			slot15 = 0.5

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot17 = Mathf.Lerp(uv0.var_.alphaOldValue1132_split_6, 1, (uv0.time_ - slot14) / slot15)

				if uv0.var_.alphaMatValue1132_split_6 then
					slot18 = uv0.var_.alphaMatValue1132_split_6.color
					slot18.a = slot17
					uv0.var_.alphaMatValue1132_split_6.color = slot18
				end
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 and uv0.var_.alphaMatValue1132_split_6 then
				slot16 = uv0.var_.alphaMatValue1132_split_6
				slot17 = slot16.color
				slot17.a = 1
				slot16.color = slot17
			end

			slot16 = uv0.actors_["10035_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				if slot16.GetComponent(slot16, "Image") then
					uv0.var_.alphaMatValue10035_split_4 = slot18
					uv0.var_.alphaOldValue10035_split_4 = slot18.color.a
				end

				uv0.var_.alphaOldValue10035_split_4 = 0
			end

			slot18 = 0.5

			if slot17 <= uv0.time_ and uv0.time_ < slot17 + slot18 then
				slot20 = Mathf.Lerp(uv0.var_.alphaOldValue10035_split_4, 1, (uv0.time_ - slot17) / slot18)

				if uv0.var_.alphaMatValue10035_split_4 then
					slot21 = uv0.var_.alphaMatValue10035_split_4.color
					slot21.a = slot20
					uv0.var_.alphaMatValue10035_split_4.color = slot21
				end
			end

			if uv0.time_ >= slot17 + slot18 and uv0.time_ < slot17 + slot18 + slot0 and uv0.var_.alphaMatValue10035_split_4 then
				slot19 = uv0.var_.alphaMatValue10035_split_4
				slot20 = slot19.color
				slot20.a = 1
				slot19.color = slot20
			end

			slot20 = 1.15

			if 0 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122036].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122036", "story_v_out_117122.awb") / 1000 > 0 and slot20 < slot24 and uv0.duration_ < slot24 + slot19 then
					slot20 = slot24
					uv0.duration_ = slot24 + slot19
				end

				if slot22.prefab_name ~= "" and uv0.actors_[slot22.prefab_name] ~= nil then
					uv0:RecordAudio("117122036", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot22.prefab_name].transform, "story_v_out_117122", "117122036", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122036", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot22 = uv0:FormatText(StoryWordCfg[117122036].content)
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
	Play117122037 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.4

		if ({
			ja = 8.4,
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
				uv0:Play117122038(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122037].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122037", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122037", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122037", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122037", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122037].content)
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
	Play117122038 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 13.433

		if ({
			ja = 13.433,
			zh = 6.866
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
				uv0:Play117122039(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.8

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122038].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122038", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122038", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122038", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122038", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122038].content)
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
	Play117122039 = function (slot0, slot1)
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
				uv0:Play117122040(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10035_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10035_split_4 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10035_split_4 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue10035_split_4
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10035_split_4 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue10035_split_4
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 1.15

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122039].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[117122039].content)
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
	Play117122040 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.333

		if ({
			ja = 3.3,
			zh = 5.333
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
				uv0:Play117122041(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10035_split_4"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10035_split_4 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10035_split_4", 4)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10035_split_4, Vector3.New(390, -410, -235), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -410, -235)
			end

			if uv0.actors_["1132_split_1"] == nil then
				slot5 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot5.transform:SetSiblingIndex(1)

				slot5.name = slot4
				slot6 = slot5:GetComponent(typeof(Image))
				slot6.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot4)

				slot6:SetNativeSize()

				slot5.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot4] = slot5
			end

			slot5 = uv0.actors_["1132_split_1"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos1132_split_1 = slot5.localPosition
				slot5.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1132_split_1", 2)
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1132_split_1, Vector3.New(-390, -413, -185), (uv0.time_ - slot6) / slot7)
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(-390, -413, -185)
			end

			slot8 = uv0.actors_["1132_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 and slot8.GetComponent(slot8, "Image") then
				uv0.var_.highlightMatValue1132_split_1 = slot10
			end

			slot10 = 0.2

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot11 = (uv0.time_ - slot9) / slot10

				if uv0.var_.highlightMatValue1132_split_1 then
					slot12 = Mathf.Lerp(0.5, 1, slot11)
					slot13 = uv0.var_.highlightMatValue1132_split_1
					slot14 = slot13.color
					slot14.r = slot12
					slot14.g = slot12
					slot14.b = slot12
					slot13.color = slot14
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.highlightMatValue1132_split_1 then
				slot11 = 1

				slot8.transform:SetSiblingIndex(1)

				slot12 = uv0.var_.highlightMatValue1132_split_1
				slot13 = slot12.color
				slot13.r = slot11
				slot13.g = slot11
				slot13.b = slot11
				slot12.color = slot13
			end

			slot12 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122040].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122040", "story_v_out_117122.awb") / 1000 > 0 and slot12 < slot16 and uv0.duration_ < slot16 + slot11 then
					slot12 = slot16
					uv0.duration_ = slot16 + slot11
				end

				if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
					uv0:RecordAudio("117122040", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_117122", "117122040", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122040", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = uv0:FormatText(StoryWordCfg[117122040].content)
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
	Play117122041 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.1

		if ({
			ja = 5.1,
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
				uv0:Play117122042(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122041].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122041", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122041", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122041", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122041", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122041].content)
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
	Play117122042 = function (slot0, slot1)
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
				uv0:Play117122043(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1132_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if slot1.GetComponent(slot1, "Image") then
					uv0.var_.alphaMatValue1132_split_1 = slot3
					uv0.var_.alphaOldValue1132_split_1 = slot3.color.a
				end

				uv0.var_.alphaOldValue1132_split_1 = 1
			end

			slot3 = 0.5

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5 = Mathf.Lerp(uv0.var_.alphaOldValue1132_split_1, 0, (uv0.time_ - slot2) / slot3)

				if uv0.var_.alphaMatValue1132_split_1 then
					slot6 = uv0.var_.alphaMatValue1132_split_1.color
					slot6.a = slot5
					uv0.var_.alphaMatValue1132_split_1.color = slot6
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.alphaMatValue1132_split_1 then
				slot4 = uv0.var_.alphaMatValue1132_split_1
				slot5 = slot4.color
				slot5.a = 0
				slot4.color = slot5
			end

			slot4 = uv0.actors_["10035_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				if slot4.GetComponent(slot4, "Image") then
					uv0.var_.alphaMatValue10035_split_4 = slot6
					uv0.var_.alphaOldValue10035_split_4 = slot6.color.a
				end

				uv0.var_.alphaOldValue10035_split_4 = 1
			end

			slot6 = 0.5

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot8 = Mathf.Lerp(uv0.var_.alphaOldValue10035_split_4, 0, (uv0.time_ - slot5) / slot6)

				if uv0.var_.alphaMatValue10035_split_4 then
					slot9 = uv0.var_.alphaMatValue10035_split_4.color
					slot9.a = slot8
					uv0.var_.alphaMatValue10035_split_4.color = slot9
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.alphaMatValue10035_split_4 then
				slot7 = uv0.var_.alphaMatValue10035_split_4
				slot8 = slot7.color
				slot8.a = 0
				slot7.color = slot8
			end

			slot8 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122042].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117122042].content)
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
	Play117122043 = function (slot0, slot1)
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
				uv0:Play117122044(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.TI0106 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.TI0106
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "TI0106" then
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
				slot6 = Color.New(1, 1, 1)
				slot6.a = Mathf.Lerp(1, 0, (uv0.time_ - slot3) / slot4)
				uv0.mask_.color = slot6
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot5 = Color.New(1, 1, 1)
				uv0.mask_.enabled = false
				slot5.a = 0
				uv0.mask_.color = slot5
			end

			slot5 = uv0.bgs_.TI0106.transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPosTI0106 = slot5.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPosTI0106, Vector3.New(0, 2.5, 1), (uv0.time_ - slot6) / slot7)
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(0, 2.5, 1)
			end

			slot8 = uv0.bgs_.TI0106.transform

			if 0.0333333333333332 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPosTI0106 = slot8.localPosition
			end

			slot10 = 3.33333333333333

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPosTI0106, Vector3.New(0, 2.5, 2), (uv0.time_ - slot9) / slot10)
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(0, 2.5, 2)
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot12 = 1.35

			if 2 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.dialog_:SetActive(true)

				uv0.dialog_.transform.localScale = Vector3(0.8, 0.95, 1)

				LeanTween.scale(uv0.dialog_, Vector3.one, 0.2)

				slot13 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot13:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot13:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122043].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot11 = slot11 + 0.3
			slot14 = uv0:FormatText(StoryWordCfg[117122043].content)
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
	Play117122044 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.466

		if ({
			ja = 0.999999999999,
			zh = 1.466
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
				uv0:Play117122045(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122044].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122044", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122044", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122044", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122044", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122044].content)
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
	Play117122045 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.033

		if ({
			ja = 3.433,
			zh = 5.033
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
				uv0:Play117122046(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[372].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122045].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122045", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122045", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122045", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122045", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122045].content)
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
	Play117122046 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.4

		if ({
			ja = 1.4,
			zh = 1.1
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
				uv0:Play117122047(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122046].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122046", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122046", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122046", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122046", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122046].content)
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
	Play117122047 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.8

		if ({
			ja = 4.8,
			zh = 4.166
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
				uv0:Play117122048(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.375

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[372].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122047].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122047", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122047", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122047", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122047", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122047].content)
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
	Play117122048 = function (slot0, slot1)
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
				uv0:Play117122049(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122048].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122048].content)
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
	Play117122049 = function (slot0, slot1)
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
				uv0:Play117122050(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.2

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122049].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122049].content)
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
	Play117122050 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.5

		if ({
			ja = 8.5,
			zh = 2.566
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
				uv0:Play117122051(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122050].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122050", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122050", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122050", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122050", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122050].content)
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
	Play117122051 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.9

		if ({
			ja = 2.9,
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
				uv0:Play117122052(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122051].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122051", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122051", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122051", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122051", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122051].content)
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
	Play117122052 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.6

		if ({
			ja = 4.366,
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
				uv0:Play117122053(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122052].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122052", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122052", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122052", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122052", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122052].content)
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
	Play117122053 = function (slot0, slot1)
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
				uv0:Play117122054(uv1)
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

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122053].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122053].content)
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
	Play117122054 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 9.2

		if ({
			ja = 7.6,
			zh = 9.2
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
				uv0:Play117122055(uv1)
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

			slot5 = uv0.bgs_.TI0106.transform

			if 2 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPosTI0106 = slot5.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPosTI0106, Vector3.New(0, 1, 9), (uv0.time_ - slot6) / slot7)
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(0, 1, 9)
			end

			slot8 = uv0.bgs_.TI0106.transform

			if 2.01666666666667 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPosTI0106 = slot8.localPosition
			end

			slot10 = 3

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPosTI0106, Vector3.New(0, 1, 9.5), (uv0.time_ - slot9) / slot10)
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(0, 1, 9.5)
			end

			if 4 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot11 + 1.01666666666667 and uv0.time_ < slot11 + slot12 + slot0 then
				uv0.allBtn_.enabled = true
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot14 = 0.425

			if 4 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[372].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122054].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122054", "story_v_out_117122.awb") / 1000 > 0 and slot14 < slot19 and uv0.duration_ < slot19 + slot13 then
					slot14 = slot19
					uv0.duration_ = slot19 + slot13
				end

				if slot17.prefab_name ~= "" and uv0.actors_[slot17.prefab_name] ~= nil then
					uv0:RecordAudio("117122054", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot17.prefab_name].transform, "story_v_out_117122", "117122054", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122054", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = slot13 + 0.3
			slot16 = uv0:FormatText(StoryWordCfg[117122054].content)
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
	Play117122055 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 17.933

		if ({
			ja = 17.933,
			zh = 6.1
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
				uv0:Play117122056(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[372].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122055].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122055", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122055", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122055", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122055", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122055].content)
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
	Play117122056 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.6

		if ({
			ja = 5.6,
			zh = 2.966
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
				uv0:Play117122057(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.15

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122056].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122056", "story_v_out_117122.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117122056", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117122", "117122056", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122056", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122056].content)
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
	Play117122057 = function (slot0, slot1)
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
				uv0:Play117122058(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.875

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122057].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122057].content)
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
	Play117122058 = function (slot0, slot1)
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
				uv0:Play117122059(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 2 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				slot2 = manager.ui.mainCamera.transform.localPosition
				slot4 = uv0.bgs_.I08a
				slot4.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot2.x, slot2.y, 0)
				slot4.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot4:GetComponent("SpriteRenderer") and slot5.sprite then
					slot8 = manager.ui.mainCameraCom_
					slot9 = 2 * (slot4.transform.localPosition - slot2).z * Mathf.Tan(slot8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot15 = slot9 * slot8.aspect / slot5.sprite.bounds.size.x > slot9 / slot5.sprite.bounds.size.y and slot13 or slot14
					slot4.transform.localScale = Vector3.New(slot15, slot15, 0)
				end

				for slot9, slot10 in pairs(uv0.bgs_) do
					if slot9 ~= "I08a" then
						slot10.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot3 = 2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5 = Color.New(0, 0, 0)
				slot5.a = Mathf.Lerp(0, 1, (uv0.time_ - slot2) / slot3)
				uv0.mask_.color = slot5
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot4 = Color.New(0, 0, 0)
				slot4.a = 1
				uv0.mask_.color = slot4
			end

			if 2 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot5 = 2

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot7 = Color.New(0, 0, 0)
				slot7.a = Mathf.Lerp(1, 0, (uv0.time_ - slot4) / slot5)
				uv0.mask_.color = slot7
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				slot6 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot6.a = 0
				uv0.mask_.color = slot6
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot7 = 0.8

			if 4 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.dialog_:SetActive(true)

				uv0.dialog_.transform.localScale = Vector3(0.8, 0.95, 1)

				LeanTween.scale(uv0.dialog_, Vector3.one, 0.2)

				slot8 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot8:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot8:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122058].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot6 = slot6 + 0.3
			slot9 = uv0:FormatText(StoryWordCfg[117122058].content)
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
	Play117122059 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.833

		if ({
			ja = 5.833,
			zh = 4.866
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
				uv0:Play117122060(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033_split_6"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1033_split_6 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1033_split_6", 3)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033_split_6, Vector3.New(0, -420, 0), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -420, 0)
			end

			slot4 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1033_split_6 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1033_split_6 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue1033_split_6
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1033_split_6 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue1033_split_6
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot7 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				if slot7.GetComponent(slot7, "Image") then
					uv0.var_.alphaMatValue1033_split_6 = slot9
					uv0.var_.alphaOldValue1033_split_6 = slot9.color.a
				end

				uv0.var_.alphaOldValue1033_split_6 = 0
			end

			slot9 = 0.333333333333333

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot11 = Mathf.Lerp(uv0.var_.alphaOldValue1033_split_6, 1, (uv0.time_ - slot8) / slot9)

				if uv0.var_.alphaMatValue1033_split_6 then
					slot12 = uv0.var_.alphaMatValue1033_split_6.color
					slot12.a = slot11
					uv0.var_.alphaMatValue1033_split_6.color = slot12
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.alphaMatValue1033_split_6 then
				slot10 = uv0.var_.alphaMatValue1033_split_6
				slot11 = slot10.color
				slot11.a = 1
				slot10.color = slot11
			end

			slot11 = 0.375

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122059].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122059", "story_v_out_117122.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
					slot11 = slot15
					uv0.duration_ = slot15 + slot10
				end

				if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
					uv0:RecordAudio("117122059", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_117122", "117122059", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122059", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[117122059].content)
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
	Play117122060 = function (slot0, slot1)
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
				uv0:Play117122061(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if slot1.GetComponent(slot1, "Image") then
					uv0.var_.alphaMatValue1033_split_6 = slot3
					uv0.var_.alphaOldValue1033_split_6 = slot3.color.a
				end

				uv0.var_.alphaOldValue1033_split_6 = 1
			end

			slot3 = 0.5

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5 = Mathf.Lerp(uv0.var_.alphaOldValue1033_split_6, 0, (uv0.time_ - slot2) / slot3)

				if uv0.var_.alphaMatValue1033_split_6 then
					slot6 = uv0.var_.alphaMatValue1033_split_6.color
					slot6.a = slot5
					uv0.var_.alphaMatValue1033_split_6.color = slot6
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.alphaMatValue1033_split_6 then
				slot4 = uv0.var_.alphaMatValue1033_split_6
				slot5 = slot4.color
				slot5.a = 0
				slot4.color = slot5
			end

			slot5 = 0.925

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122060].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[117122060].content)
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
	Play117122061 = function (slot0, slot1)
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
				uv0:Play117122062(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.025

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122061].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117122061].content)
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
	Play117122062 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.1

		if ({
			ja = 2.433,
			zh = 6.1
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
				uv0:Play117122063(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1132_split_6"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1132_split_6 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1132_split_6", 2)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1132_split_6, Vector3.New(-390, -413, -185), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -413, -185)
			end

			slot4 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1132_split_6 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue1132_split_6
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue1132_split_6
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot7 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				if slot7.GetComponent(slot7, "Image") then
					uv0.var_.alphaMatValue1132_split_6 = slot9
					uv0.var_.alphaOldValue1132_split_6 = slot9.color.a
				end

				uv0.var_.alphaOldValue1132_split_6 = 0
			end

			slot9 = 0.5

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot11 = Mathf.Lerp(uv0.var_.alphaOldValue1132_split_6, 1, (uv0.time_ - slot8) / slot9)

				if uv0.var_.alphaMatValue1132_split_6 then
					slot12 = uv0.var_.alphaMatValue1132_split_6.color
					slot12.a = slot11
					uv0.var_.alphaMatValue1132_split_6.color = slot12
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.alphaMatValue1132_split_6 then
				slot10 = uv0.var_.alphaMatValue1132_split_6
				slot11 = slot10.color
				slot11.a = 1
				slot10.color = slot11
			end

			slot11 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122062].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122062", "story_v_out_117122.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
					slot11 = slot15
					uv0.duration_ = slot15 + slot10
				end

				if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
					uv0:RecordAudio("117122062", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_117122", "117122062", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122062", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[117122062].content)
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
	Play117122063 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.133

		if ({
			ja = 1.366,
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
				uv0:Play117122064(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10035_split_4"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10035_split_4 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10035_split_4", 4)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10035_split_4, Vector3.New(390, -410, -235), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -410, -235)
			end

			slot4 = uv0.actors_["1132_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1132_split_6 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1132_split_6 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue1132_split_6
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1132_split_6 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue1132_split_6
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot7 = uv0.actors_["10035_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and slot7.GetComponent(slot7, "Image") then
				uv0.var_.highlightMatValue10035_split_4 = slot9
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.highlightMatValue10035_split_4 then
					slot11 = Mathf.Lerp(0.5, 1, slot10)
					slot12 = uv0.var_.highlightMatValue10035_split_4
					slot13 = slot12.color
					slot13.r = slot11
					slot13.g = slot11
					slot13.b = slot11
					slot12.color = slot13
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.highlightMatValue10035_split_4 then
				slot10 = 1

				slot7.transform:SetSiblingIndex(1)

				slot11 = uv0.var_.highlightMatValue10035_split_4
				slot12 = slot11.color
				slot12.r = slot10
				slot12.g = slot10
				slot12.b = slot10
				slot11.color = slot12
			end

			slot10 = uv0.actors_["10035_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				if slot10.GetComponent(slot10, "Image") then
					uv0.var_.alphaMatValue10035_split_4 = slot12
					uv0.var_.alphaOldValue10035_split_4 = slot12.color.a
				end

				uv0.var_.alphaOldValue10035_split_4 = 0
			end

			slot12 = 0.5

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot14 = Mathf.Lerp(uv0.var_.alphaOldValue10035_split_4, 1, (uv0.time_ - slot11) / slot12)

				if uv0.var_.alphaMatValue10035_split_4 then
					slot15 = uv0.var_.alphaMatValue10035_split_4.color
					slot15.a = slot14
					uv0.var_.alphaMatValue10035_split_4.color = slot15
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.alphaMatValue10035_split_4 then
				slot13 = uv0.var_.alphaMatValue10035_split_4
				slot14 = slot13.color
				slot14.a = 1
				slot13.color = slot14
			end

			slot14 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122063].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122063", "story_v_out_117122.awb") / 1000 > 0 and slot14 < slot18 and uv0.duration_ < slot18 + slot13 then
					slot14 = slot18
					uv0.duration_ = slot18 + slot13
				end

				if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
					uv0:RecordAudio("117122063", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_117122", "117122063", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122063", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = uv0:FormatText(StoryWordCfg[117122063].content)
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
	Play117122064 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5

		if ({
			ja = 5,
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
				uv0:Play117122065(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10035_split_4"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10035_split_4 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10035_split_4", 4)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10035_split_4, Vector3.New(390, -410, -235), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -410, -235)
			end

			slot4 = uv0.actors_["1132_split_1"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1132_split_1 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1132_split_1", 2)
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1132_split_1, Vector3.New(-390, -413, -185), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(-390, -413, -185)
			end

			slot7 = uv0.actors_["1132_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and slot7.GetComponent(slot7, "Image") then
				uv0.var_.highlightMatValue1132_split_1 = slot9
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.highlightMatValue1132_split_1 then
					slot11 = Mathf.Lerp(0.5, 1, slot10)
					slot12 = uv0.var_.highlightMatValue1132_split_1
					slot13 = slot12.color
					slot13.r = slot11
					slot13.g = slot11
					slot13.b = slot11
					slot12.color = slot13
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.highlightMatValue1132_split_1 then
				slot10 = 1

				slot7.transform:SetSiblingIndex(1)

				slot11 = uv0.var_.highlightMatValue1132_split_1
				slot12 = slot11.color
				slot12.r = slot10
				slot12.g = slot10
				slot12.b = slot10
				slot11.color = slot12
			end

			slot10 = uv0.actors_["10035_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and slot10.GetComponent(slot10, "Image") then
				uv0.var_.highlightMatValue10035_split_4 = slot12
			end

			slot12 = 0.2

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.highlightMatValue10035_split_4 then
					slot14 = Mathf.Lerp(1, 0.5, slot13)
					slot15 = uv0.var_.highlightMatValue10035_split_4
					slot16 = slot15.color
					slot16.r = slot14
					slot16.g = slot14
					slot16.b = slot14
					slot15.color = slot16
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.highlightMatValue10035_split_4 then
				slot13 = 0.5
				slot14 = uv0.var_.highlightMatValue10035_split_4
				slot15 = slot14.color
				slot15.r = slot13
				slot15.g = slot13
				slot15.b = slot13
				slot14.color = slot15
			end

			slot13 = uv0.actors_["1132_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				if slot13.GetComponent(slot13, "Image") then
					uv0.var_.alphaMatValue1132_split_1 = slot15
					uv0.var_.alphaOldValue1132_split_1 = slot15.color.a
				end

				uv0.var_.alphaOldValue1132_split_1 = 0
			end

			slot15 = 0.0166666666666667

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot17 = Mathf.Lerp(uv0.var_.alphaOldValue1132_split_1, 1, (uv0.time_ - slot14) / slot15)

				if uv0.var_.alphaMatValue1132_split_1 then
					slot18 = uv0.var_.alphaMatValue1132_split_1.color
					slot18.a = slot17
					uv0.var_.alphaMatValue1132_split_1.color = slot18
				end
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 and uv0.var_.alphaMatValue1132_split_1 then
				slot16 = uv0.var_.alphaMatValue1132_split_1
				slot17 = slot16.color
				slot17.a = 1
				slot16.color = slot17
			end

			slot17 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122064].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122064", "story_v_out_117122.awb") / 1000 > 0 and slot17 < slot21 and uv0.duration_ < slot21 + slot16 then
					slot17 = slot21
					uv0.duration_ = slot21 + slot16
				end

				if slot19.prefab_name ~= "" and uv0.actors_[slot19.prefab_name] ~= nil then
					uv0:RecordAudio("117122064", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot19.prefab_name].transform, "story_v_out_117122", "117122064", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122064", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot19 = uv0:FormatText(StoryWordCfg[117122064].content)
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
	Play117122065 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.7

		if ({
			ja = 2.7,
			zh = 0.999999999999
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
			if uv0.actors_["10035_split_2"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["10035_split_2"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos10035_split_2 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10035_split_2", 4)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10035_split_2, Vector3.New(390, -410, -235), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(390, -410, -235)
			end

			slot5 = uv0.actors_["1132_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and slot5.GetComponent(slot5, "Image") then
				uv0.var_.highlightMatValue1132_split_1 = slot7
			end

			slot7 = 0.2

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.highlightMatValue1132_split_1 then
					slot9 = Mathf.Lerp(1, 0.5, slot8)
					slot10 = uv0.var_.highlightMatValue1132_split_1
					slot11 = slot10.color
					slot11.r = slot9
					slot11.g = slot9
					slot11.b = slot9
					slot10.color = slot11
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.highlightMatValue1132_split_1 then
				slot8 = 0.5
				slot9 = uv0.var_.highlightMatValue1132_split_1
				slot10 = slot9.color
				slot10.r = slot8
				slot10.g = slot8
				slot10.b = slot8
				slot9.color = slot10
			end

			slot9 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117122065].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122065", "story_v_out_117122.awb") / 1000 > 0 and slot9 < slot13 and uv0.duration_ < slot13 + slot8 then
					slot9 = slot13
					uv0.duration_ = slot13 + slot8
				end

				if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
					uv0:RecordAudio("117122065", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_117122", "117122065", "story_v_out_117122.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117122", "117122065", "story_v_out_117122.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot11 = uv0:FormatText(StoryWordCfg[117122065].content)
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
	end
}
