return {
	Play114202001 = function (slot0, slot1)
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
				uv0:Play114202002(uv1)
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
				slot4.a = Mathf.Lerp(1, 0, (uv0.time_ - slot1) / slot2)
				uv0.mask_.color = slot4
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				slot3 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot3.a = 0
				uv0.mask_.color = slot3
			end

			if uv0.bgs_.F04 == nil then
				slot4 = Object.Instantiate(uv0.paintGo_)
				slot4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot3)
				slot4.name = slot3
				slot4.transform.parent = uv0.stage_.transform
				slot4.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot3] = slot4
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				slot5 = manager.ui.mainCamera.transform.localPosition
				slot7 = uv0.bgs_.F04
				slot7.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot5.x, slot5.y, 0)
				slot7.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot7:GetComponent("SpriteRenderer") and slot8.sprite then
					slot11 = manager.ui.mainCameraCom_
					slot12 = 2 * (slot7.transform.localPosition - slot5).z * Mathf.Tan(slot11.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot18 = slot12 * slot11.aspect / slot8.sprite.bounds.size.x > slot12 / slot8.sprite.bounds.size.y and slot16 or slot17
					slot7.transform.localScale = Vector3.New(slot18, slot18, 0)
				end

				for slot12, slot13 in pairs(uv0.bgs_) do
					if slot12 ~= "F04" then
						slot13.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot6 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot8 = 0.333333333333333

			if 2 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:AudioAction("play", "music", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot10 = 0.05

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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[234].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202001].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot9 = slot9 + 0.3
			slot12 = uv0:FormatText(StoryWordCfg[114202001].content)
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
	Play114202002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.4

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.15

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[209].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_2050")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202002].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202002", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202002", "story_v_out_114202.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("114202002", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114202", "114202002", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202002", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114202002].content)
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
	Play114202003 = function (slot0, slot1)
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
				uv0:Play114202004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.95

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202003].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114202003].content)
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
	Play114202004 = function (slot0, slot1)
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
				uv0:Play114202005(uv1)
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

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202004].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114202004].content)
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
	Play114202005 = function (slot0, slot1)
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
				uv0:Play114202006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.25

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202005].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114202005].content)
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
	Play114202006 = function (slot0, slot1)
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
				uv0:Play114202007(uv1)
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

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202006].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114202006].content)
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
	Play114202007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.766

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["10017"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["10017"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos10017 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10017", 2)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10017, Vector3.New(-390, -350, -180), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(-390, -350, -180)
			end

			slot5 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and slot5.GetComponent(slot5, "Image") then
				uv0.var_.highlightMatValue10017 = slot7
			end

			slot7 = 0.034

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.highlightMatValue10017 then
					slot9 = Mathf.Lerp(0.5, 1, slot8)
					slot10 = uv0.var_.highlightMatValue10017
					slot11 = slot10.color
					slot11.r = slot9
					slot11.g = slot9
					slot11.b = slot9
					slot10.color = slot11
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.highlightMatValue10017 then
				slot8 = 1

				slot5.transform:SetSiblingIndex(1)

				slot9 = uv0.var_.highlightMatValue10017
				slot10 = slot9.color
				slot10.r = slot8
				slot10.g = slot8
				slot10.b = slot8
				slot9.color = slot10
			end

			slot8 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				if slot8.GetComponent(slot8, "Image") then
					uv0.var_.alphaMatValue10017 = slot10
					uv0.var_.alphaOldValue10017 = slot10.color.a
				end

				uv0.var_.alphaOldValue10017 = 0
			end

			slot10 = 0.5

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot12 = Mathf.Lerp(uv0.var_.alphaOldValue10017, 1, (uv0.time_ - slot9) / slot10)

				if uv0.var_.alphaMatValue10017 then
					slot13 = uv0.var_.alphaMatValue10017.color
					slot13.a = slot12
					uv0.var_.alphaMatValue10017.color = slot13
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.alphaMatValue10017 then
				slot11 = uv0.var_.alphaMatValue10017
				slot12 = slot11.color
				slot12.a = 1
				slot11.color = slot12
			end

			slot12 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202007].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202007", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202007", "story_v_out_114202.awb") / 1000 > 0 and slot12 < slot16 and uv0.duration_ < slot16 + slot11 then
						slot12 = slot16
						uv0.duration_ = slot16 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						uv0:RecordAudio("114202007", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_114202", "114202007", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202007", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = uv0:FormatText(StoryWordCfg[114202007].content)
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
	Play114202008 = function (slot0, slot1)
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
				uv0:Play114202009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10017 = slot3
			end

			slot3 = 0.5

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10017 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue10017
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10017 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue10017
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202008].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114202008].content)
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
	Play114202009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.066

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["10015_split_1"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["10015_split_1"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos10015_split_1 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_1", 4)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_1, Vector3.New(390, -350, -180), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(390, -350, -180)
			end

			slot5 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and slot5.GetComponent(slot5, "Image") then
				uv0.var_.highlightMatValue10015_split_1 = slot7
			end

			slot7 = 0.034

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.highlightMatValue10015_split_1 then
					slot9 = Mathf.Lerp(0.5, 1, slot8)
					slot10 = uv0.var_.highlightMatValue10015_split_1
					slot11 = slot10.color
					slot11.r = slot9
					slot11.g = slot9
					slot11.b = slot9
					slot10.color = slot11
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.highlightMatValue10015_split_1 then
				slot8 = 1

				slot5.transform:SetSiblingIndex(1)

				slot9 = uv0.var_.highlightMatValue10015_split_1
				slot10 = slot9.color
				slot10.r = slot8
				slot10.g = slot8
				slot10.b = slot8
				slot9.color = slot10
			end

			slot8 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				if slot8.GetComponent(slot8, "Image") then
					uv0.var_.alphaMatValue10015_split_1 = slot10
					uv0.var_.alphaOldValue10015_split_1 = slot10.color.a
				end

				uv0.var_.alphaOldValue10015_split_1 = 0
			end

			slot10 = 0.5

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot12 = Mathf.Lerp(uv0.var_.alphaOldValue10015_split_1, 1, (uv0.time_ - slot9) / slot10)

				if uv0.var_.alphaMatValue10015_split_1 then
					slot13 = uv0.var_.alphaMatValue10015_split_1.color
					slot13.a = slot12
					uv0.var_.alphaMatValue10015_split_1.color = slot13
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.alphaMatValue10015_split_1 then
				slot11 = uv0.var_.alphaMatValue10015_split_1
				slot12 = slot11.color
				slot12.a = 1
				slot11.color = slot12
			end

			slot12 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202009].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202009", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202009", "story_v_out_114202.awb") / 1000 > 0 and slot12 < slot16 and uv0.duration_ < slot16 + slot11 then
						slot12 = slot16
						uv0.duration_ = slot16 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						uv0:RecordAudio("114202009", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_114202", "114202009", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202009", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = uv0:FormatText(StoryWordCfg[114202009].content)
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
	Play114202010 = function (slot0, slot1)
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
				uv0:Play114202011(uv1)
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

			slot5 = 0.6

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202010].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114202010].content)
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
	Play114202011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.5

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["10015_split_2"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["10015_split_2"]

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and slot2.GetComponent(slot2, "Image") then
				uv0.var_.highlightMatValue10015_split_2 = slot4
			end

			slot4 = 0.034

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.highlightMatValue10015_split_2 then
					slot6 = Mathf.Lerp(0.5, 1, slot5)
					slot7 = uv0.var_.highlightMatValue10015_split_2
					slot8 = slot7.color
					slot8.r = slot6
					slot8.g = slot6
					slot8.b = slot6
					slot7.color = slot8
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.highlightMatValue10015_split_2 then
				slot5 = 1

				slot2.transform:SetSiblingIndex(1)

				slot6 = uv0.var_.highlightMatValue10015_split_2
				slot7 = slot6.color
				slot7.r = slot5
				slot7.g = slot5
				slot7.b = slot5
				slot6.color = slot7
			end

			slot5 = uv0.actors_["10015_split_2"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos10015_split_2 = slot5.localPosition
				slot5.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_2", 4)
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_2, Vector3.New(390, -350, -180), (uv0.time_ - slot6) / slot7)
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(390, -350, -180)
			end

			slot9 = 0.15

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202011].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202011", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202011", "story_v_out_114202.awb") / 1000 > 0 and slot9 < slot13 and uv0.duration_ < slot13 + slot8 then
						slot9 = slot13
						uv0.duration_ = slot13 + slot8
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						uv0:RecordAudio("114202011", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_114202", "114202011", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202011", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot11 = uv0:FormatText(StoryWordCfg[114202011].content)
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
	Play114202012 = function (slot0, slot1)
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
				uv0:Play114202013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015_split_2"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10015_split_2 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10015_split_2 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue10015_split_2
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10015_split_2 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue10015_split_2
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 0.625

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202012].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114202012].content)
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
	Play114202013 = function (slot0, slot1)
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
				uv0:Play114202014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015_split_2"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10015_split_2 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_2", 7)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_2, Vector3.New(0, -2000, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -2000, -180)
			end

			slot4 = uv0.actors_["10015_split_1"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos10015_split_1 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_1", 3)
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_1, Vector3.New(0, -350, -180), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -350, -180)
			end

			slot7 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and slot7.GetComponent(slot7, "Image") then
				uv0.var_.highlightMatValue10017 = slot9
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.highlightMatValue10017 then
					slot11 = Mathf.Lerp(1, 0.5, slot10)
					slot12 = uv0.var_.highlightMatValue10017
					slot13 = slot12.color
					slot13.r = slot11
					slot13.g = slot11
					slot13.b = slot11
					slot12.color = slot13
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.highlightMatValue10017 then
				slot10 = 0.5
				slot11 = uv0.var_.highlightMatValue10017
				slot12 = slot11.color
				slot12.r = slot10
				slot12.g = slot10
				slot12.b = slot10
				slot11.color = slot12
			end

			slot10 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				if slot10.GetComponent(slot10, "Image") then
					uv0.var_.alphaMatValue10015_split_1 = slot12
					uv0.var_.alphaOldValue10015_split_1 = slot12.color.a
				end

				uv0.var_.alphaOldValue10015_split_1 = 0
			end

			slot12 = 0.5

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot14 = Mathf.Lerp(uv0.var_.alphaOldValue10015_split_1, 1, (uv0.time_ - slot11) / slot12)

				if uv0.var_.alphaMatValue10015_split_1 then
					slot15 = uv0.var_.alphaMatValue10015_split_1.color
					slot15.a = slot14
					uv0.var_.alphaMatValue10015_split_1.color = slot15
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.alphaMatValue10015_split_1 then
				slot13 = uv0.var_.alphaMatValue10015_split_1
				slot14 = slot13.color
				slot14.a = 1
				slot13.color = slot14
			end

			slot13 = uv0.actors_["10017"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.var_.moveOldPos10017 = slot13.localPosition
				slot13.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10017", 7)
			end

			slot15 = 0.001

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot13.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10017, Vector3.New(0, -2000, 300), (uv0.time_ - slot14) / slot15)
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 then
				slot13.localPosition = Vector3.New(0, -2000, 300)
			end

			slot16 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 and slot16.GetComponent(slot16, "Image") then
				uv0.var_.highlightMatValue10015_split_1 = slot18
			end

			slot18 = 0.034

			if slot17 <= uv0.time_ and uv0.time_ < slot17 + slot18 then
				slot19 = (uv0.time_ - slot17) / slot18

				if uv0.var_.highlightMatValue10015_split_1 then
					slot20 = Mathf.Lerp(0.5, 1, slot19)
					slot21 = uv0.var_.highlightMatValue10015_split_1
					slot22 = slot21.color
					slot22.r = slot20
					slot22.g = slot20
					slot22.b = slot20
					slot21.color = slot22
				end
			end

			if uv0.time_ >= slot17 + slot18 and uv0.time_ < slot17 + slot18 + slot0 and uv0.var_.highlightMatValue10015_split_1 then
				slot19 = 1

				slot16.transform:SetSiblingIndex(1)

				slot20 = uv0.var_.highlightMatValue10015_split_1
				slot21 = slot20.color
				slot21.r = slot19
				slot21.g = slot19
				slot21.b = slot19
				slot20.color = slot21
			end

			slot20 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202013].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot22 = uv0:FormatText(StoryWordCfg[114202013].content)
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
	Play114202014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.366

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202015(uv1)
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
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue10015_split_1
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10015_split_1 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue10015_split_1
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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202014].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202014", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202014", "story_v_out_114202.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
						slot5 = slot9
						uv0.duration_ = slot9 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						uv0:RecordAudio("114202014", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_114202", "114202014", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202014", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114202014].content)
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
	Play114202015 = function (slot0, slot1)
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
				uv0:Play114202016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if slot1.GetComponent(slot1, "Image") then
					uv0.var_.alphaMatValue10015_split_1 = slot3
					uv0.var_.alphaOldValue10015_split_1 = slot3.color.a
				end

				uv0.var_.alphaOldValue10015_split_1 = 1
			end

			slot3 = 0.5

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5 = Mathf.Lerp(uv0.var_.alphaOldValue10015_split_1, 0, (uv0.time_ - slot2) / slot3)

				if uv0.var_.alphaMatValue10015_split_1 then
					slot6 = uv0.var_.alphaMatValue10015_split_1.color
					slot6.a = slot5
					uv0.var_.alphaMatValue10015_split_1.color = slot6
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.alphaMatValue10015_split_1 then
				slot4 = uv0.var_.alphaMatValue10015_split_1
				slot5 = slot4.color
				slot5.a = 0
				slot4.color = slot5
			end

			slot5 = 0.8

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202015].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114202015].content)
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
	Play114202016 = function (slot0, slot1)
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
				uv0:Play114202017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.175

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202016].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114202016].content)
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
	Play114202017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.999999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.ST21 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.ST21
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "ST21" then
						slot11.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot4 = 1.999999999999

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot6 = Color.New(0, 0, 0)
				slot6.a = Mathf.Lerp(0, 1, (uv0.time_ - slot3) / slot4)
				uv0.mask_.color = slot6
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot5 = Color.New(0, 0, 0)
				slot5.a = 1
				uv0.mask_.color = slot5
			end

			if 1.999999999999 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot6 = 2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot8 = Color.New(0, 0, 0)
				slot8.a = Mathf.Lerp(1, 0, (uv0.time_ - slot5) / slot6)
				uv0.mask_.color = slot8
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot7 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot7.a = 0
				uv0.mask_.color = slot7
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot8 = 0.175

			if 3.999999999999 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialog_:SetActive(true)

				uv0.dialog_.transform.localScale = Vector3(0.8, 0.95, 1)

				LeanTween.scale(uv0.dialog_, Vector3.one, 0.2)

				slot9 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot9:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot9:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202017].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = slot7 + 0.3
			slot10 = uv0:FormatText(StoryWordCfg[114202017].content)
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
	Play114202018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.866

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10017 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10017", 2)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10017, Vector3.New(-390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -350, -180)
			end

			slot4 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10017 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10017 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue10017
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10017 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue10017
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot7 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				if slot7.GetComponent(slot7, "Image") then
					uv0.var_.alphaMatValue10017 = slot9
					uv0.var_.alphaOldValue10017 = slot9.color.a
				end

				uv0.var_.alphaOldValue10017 = 0
			end

			slot9 = 0.5

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot11 = Mathf.Lerp(uv0.var_.alphaOldValue10017, 1, (uv0.time_ - slot8) / slot9)

				if uv0.var_.alphaMatValue10017 then
					slot12 = uv0.var_.alphaMatValue10017.color
					slot12.a = slot11
					uv0.var_.alphaMatValue10017.color = slot12
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.alphaMatValue10017 then
				slot10 = uv0.var_.alphaMatValue10017
				slot11 = slot10.color
				slot11.a = 1
				slot10.color = slot11
			end

			slot11 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202018].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202018", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202018", "story_v_out_114202.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
						slot11 = slot15
						uv0.duration_ = slot15 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						uv0:RecordAudio("114202018", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114202", "114202018", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202018", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[114202018].content)
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
	Play114202019 = function (slot0, slot1)
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
				uv0:Play114202020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015_split_1"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10015_split_1 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_1", 4)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_1, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			slot4 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10017 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10017 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue10017
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10017 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue10017
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot7 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and slot7.GetComponent(slot7, "Image") then
				uv0.var_.highlightMatValue10015_split_1 = slot9
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.highlightMatValue10015_split_1 then
					slot11 = Mathf.Lerp(0.5, 1, slot10)
					slot12 = uv0.var_.highlightMatValue10015_split_1
					slot13 = slot12.color
					slot13.r = slot11
					slot13.g = slot11
					slot13.b = slot11
					slot12.color = slot13
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.highlightMatValue10015_split_1 then
				slot10 = 1

				slot7.transform:SetSiblingIndex(1)

				slot11 = uv0.var_.highlightMatValue10015_split_1
				slot12 = slot11.color
				slot12.r = slot10
				slot12.g = slot10
				slot12.b = slot10
				slot11.color = slot12
			end

			slot10 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				if slot10.GetComponent(slot10, "Image") then
					uv0.var_.alphaMatValue10015_split_1 = slot12
					uv0.var_.alphaOldValue10015_split_1 = slot12.color.a
				end

				uv0.var_.alphaOldValue10015_split_1 = 0
			end

			slot12 = 0.5

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot14 = Mathf.Lerp(uv0.var_.alphaOldValue10015_split_1, 1, (uv0.time_ - slot11) / slot12)

				if uv0.var_.alphaMatValue10015_split_1 then
					slot15 = uv0.var_.alphaMatValue10015_split_1.color
					slot15.a = slot14
					uv0.var_.alphaMatValue10015_split_1.color = slot15
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.alphaMatValue10015_split_1 then
				slot13 = uv0.var_.alphaMatValue10015_split_1
				slot14 = slot13.color
				slot14.a = 1
				slot13.color = slot14
			end

			slot14 = 0.6

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202019].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202019", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202019", "story_v_out_114202.awb") / 1000 > 0 and slot14 < slot18 and uv0.duration_ < slot18 + slot13 then
						slot14 = slot18
						uv0.duration_ = slot18 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						uv0:RecordAudio("114202019", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_114202", "114202019", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202019", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = uv0:FormatText(StoryWordCfg[114202019].content)
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
	Play114202020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.9

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10017 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10017 then
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue10017
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10017 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue10017
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot4 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10015_split_1 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10015_split_1 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue10015_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10015_split_1 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue10015_split_1
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.35

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202020].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202020", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202020", "story_v_out_114202.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
						slot8 = slot12
						uv0.duration_ = slot12 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						uv0:RecordAudio("114202020", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114202", "114202020", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202020", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[114202020].content)
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
	Play114202021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.566

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10017 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10017 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue10017
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10017 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue10017
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot4 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10015_split_1 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10015_split_1 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue10015_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10015_split_1 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue10015_split_1
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.625

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202021].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202021", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202021", "story_v_out_114202.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
						slot8 = slot12
						uv0.duration_ = slot12 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						uv0:RecordAudio("114202021", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114202", "114202021", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202021", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[114202021].content)
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
	Play114202022 = function (slot0, slot1)
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
				uv0:Play114202023(uv1)
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

			slot5 = 1.35

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202022].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114202022].content)
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
	Play114202023 = function (slot0, slot1)
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
				uv0:Play114202024(uv1)
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

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202023].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114202023].content)
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
	Play114202024 = function (slot0, slot1)
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
				uv0:Play114202025(uv1)
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

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202024].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114202024].content)
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
	Play114202025 = function (slot0, slot1)
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
				uv0:Play114202026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202025].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114202025].content)
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
	Play114202026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.733

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202027(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10017 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10017 then
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue10017
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10017 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue10017
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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202026].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202026", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202026", "story_v_out_114202.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
						slot5 = slot9
						uv0.duration_ = slot9 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						uv0:RecordAudio("114202026", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_114202", "114202026", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202026", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114202026].content)
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
	Play114202027 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.266

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202028(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202027].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202027", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202027", "story_v_out_114202.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("114202027", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114202", "114202027", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202027", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114202027].content)
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
	Play114202028 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.333

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202029(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.85

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202028].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202028", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202028", "story_v_out_114202.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("114202028", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114202", "114202028", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202028", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114202028].content)
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
	Play114202029 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 9.133

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202030(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10017 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10017 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue10017
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10017 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue10017
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot4 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10015_split_1 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10015_split_1 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue10015_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10015_split_1 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue10015_split_1
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 1.025

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202029].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202029", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202029", "story_v_out_114202.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
						slot8 = slot12
						uv0.duration_ = slot12 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						uv0:RecordAudio("114202029", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114202", "114202029", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202029", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[114202029].content)
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
	Play114202030 = function (slot0, slot1)
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
				uv0:Play114202031(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if slot1.GetComponent(slot1, "Image") then
					uv0.var_.alphaMatValue10015_split_1 = slot3
					uv0.var_.alphaOldValue10015_split_1 = slot3.color.a
				end

				uv0.var_.alphaOldValue10015_split_1 = 1
			end

			slot3 = 0.5

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5 = Mathf.Lerp(uv0.var_.alphaOldValue10015_split_1, 0, (uv0.time_ - slot2) / slot3)

				if uv0.var_.alphaMatValue10015_split_1 then
					slot6 = uv0.var_.alphaMatValue10015_split_1.color
					slot6.a = slot5
					uv0.var_.alphaMatValue10015_split_1.color = slot6
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.alphaMatValue10015_split_1 then
				slot4 = uv0.var_.alphaMatValue10015_split_1
				slot5 = slot4.color
				slot5.a = 0
				slot4.color = slot5
			end

			slot4 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				if slot4.GetComponent(slot4, "Image") then
					uv0.var_.alphaMatValue10017 = slot6
					uv0.var_.alphaOldValue10017 = slot6.color.a
				end

				uv0.var_.alphaOldValue10017 = 1
			end

			slot6 = 0.5

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot8 = Mathf.Lerp(uv0.var_.alphaOldValue10017, 0, (uv0.time_ - slot5) / slot6)

				if uv0.var_.alphaMatValue10017 then
					slot9 = uv0.var_.alphaMatValue10017.color
					slot9.a = slot8
					uv0.var_.alphaMatValue10017.color = slot9
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.alphaMatValue10017 then
				slot7 = uv0.var_.alphaMatValue10017
				slot8 = slot7.color
				slot8.a = 0
				slot7.color = slot8
			end

			slot8 = 0.9

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202030].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[114202030].content)
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
	Play114202031 = function (slot0, slot1)
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
				uv0:Play114202032(uv1)
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

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202031].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114202031].content)
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
	Play114202032 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 10.9

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202033(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10017 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10017", 2)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10017, Vector3.New(-390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -350, -180)
			end

			slot4 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10017 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10017 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue10017
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10017 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue10017
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot7 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and slot7.GetComponent(slot7, "Image") then
				uv0.var_.highlightMatValue10017 = slot9
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.highlightMatValue10017 then
					slot11 = Mathf.Lerp(0.5, 1, slot10)
					slot12 = uv0.var_.highlightMatValue10017
					slot13 = slot12.color
					slot13.r = slot11
					slot13.g = slot11
					slot13.b = slot11
					slot12.color = slot13
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.highlightMatValue10017 then
				slot10 = 1

				slot7.transform:SetSiblingIndex(1)

				slot11 = uv0.var_.highlightMatValue10017
				slot12 = slot11.color
				slot12.r = slot10
				slot12.g = slot10
				slot12.b = slot10
				slot11.color = slot12
			end

			slot10 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				if slot10.GetComponent(slot10, "Image") then
					uv0.var_.alphaMatValue10017 = slot12
					uv0.var_.alphaOldValue10017 = slot12.color.a
				end

				uv0.var_.alphaOldValue10017 = 0
			end

			slot12 = 0.5

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot14 = Mathf.Lerp(uv0.var_.alphaOldValue10017, 1, (uv0.time_ - slot11) / slot12)

				if uv0.var_.alphaMatValue10017 then
					slot15 = uv0.var_.alphaMatValue10017.color
					slot15.a = slot14
					uv0.var_.alphaMatValue10017.color = slot15
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.alphaMatValue10017 then
				slot13 = uv0.var_.alphaMatValue10017
				slot14 = slot13.color
				slot14.a = 1
				slot13.color = slot14
			end

			slot14 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202032].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202032", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202032", "story_v_out_114202.awb") / 1000 > 0 and slot14 < slot18 and uv0.duration_ < slot18 + slot13 then
						slot14 = slot18
						uv0.duration_ = slot18 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						uv0:RecordAudio("114202032", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_114202", "114202032", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202032", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = uv0:FormatText(StoryWordCfg[114202032].content)
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
	Play114202033 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.7

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202034(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015_split_1"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10015_split_1 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_1", 4)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_1, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			slot4 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10017 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10017 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue10017
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10017 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue10017
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot7 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and slot7.GetComponent(slot7, "Image") then
				uv0.var_.highlightMatValue10015_split_1 = slot9
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.highlightMatValue10015_split_1 then
					slot11 = Mathf.Lerp(0.5, 1, slot10)
					slot12 = uv0.var_.highlightMatValue10015_split_1
					slot13 = slot12.color
					slot13.r = slot11
					slot13.g = slot11
					slot13.b = slot11
					slot12.color = slot13
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.highlightMatValue10015_split_1 then
				slot10 = 1

				slot7.transform:SetSiblingIndex(1)

				slot11 = uv0.var_.highlightMatValue10015_split_1
				slot12 = slot11.color
				slot12.r = slot10
				slot12.g = slot10
				slot12.b = slot10
				slot11.color = slot12
			end

			slot10 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				if slot10.GetComponent(slot10, "Image") then
					uv0.var_.alphaMatValue10015_split_1 = slot12
					uv0.var_.alphaOldValue10015_split_1 = slot12.color.a
				end

				uv0.var_.alphaOldValue10015_split_1 = 0
			end

			slot12 = 0.5

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot14 = Mathf.Lerp(uv0.var_.alphaOldValue10015_split_1, 1, (uv0.time_ - slot11) / slot12)

				if uv0.var_.alphaMatValue10015_split_1 then
					slot15 = uv0.var_.alphaMatValue10015_split_1.color
					slot15.a = slot14
					uv0.var_.alphaMatValue10015_split_1.color = slot15
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.alphaMatValue10015_split_1 then
				slot13 = uv0.var_.alphaMatValue10015_split_1
				slot14 = slot13.color
				slot14.a = 1
				slot13.color = slot14
			end

			slot14 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202033].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202033", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202033", "story_v_out_114202.awb") / 1000 > 0 and slot14 < slot18 and uv0.duration_ < slot18 + slot13 then
						slot14 = slot18
						uv0.duration_ = slot18 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						uv0:RecordAudio("114202033", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_114202", "114202033", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202033", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = uv0:FormatText(StoryWordCfg[114202033].content)
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
	Play114202034 = function (slot0, slot1)
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
				uv0:Play114202035(uv1)
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

			slot5 = 1.3

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202034].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114202034].content)
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
	Play114202035 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.033

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202036(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10017 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10017 then
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue10017
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10017 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue10017
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot4 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10015_split_1 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10015_split_1 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue10015_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10015_split_1 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue10015_split_1
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202035].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202035", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202035", "story_v_out_114202.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
						slot8 = slot12
						uv0.duration_ = slot12 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						uv0:RecordAudio("114202035", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114202", "114202035", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202035", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[114202035].content)
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
	Play114202036 = function (slot0, slot1)
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
				uv0:Play114202037(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10017 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10017 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue10017
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10017 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue10017
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 1.475

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202036].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114202036].content)
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
	Play114202037 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.9

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202038(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10017 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10017 then
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue10017
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10017 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue10017
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202037].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202037", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202037", "story_v_out_114202.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
						slot5 = slot9
						uv0.duration_ = slot9 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						uv0:RecordAudio("114202037", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_114202", "114202037", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202037", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114202037].content)
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
	Play114202038 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 10.966

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202039(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.325

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202038].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202038", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202038", "story_v_out_114202.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("114202038", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114202", "114202038", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202038", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114202038].content)
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
	Play114202039 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 12.4

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202040(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.225

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202039].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202039", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202039", "story_v_out_114202.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("114202039", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114202", "114202039", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202039", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114202039].content)
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
	Play114202040 = function (slot0, slot1)
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
				uv0:Play114202041(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10017 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10017 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue10017
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10017 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue10017
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot4 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10015_split_1 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10015_split_1 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue10015_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10015_split_1 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue10015_split_1
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202040].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202040", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202040", "story_v_out_114202.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
						slot8 = slot12
						uv0.duration_ = slot12 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						uv0:RecordAudio("114202040", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114202", "114202040", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202040", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[114202040].content)
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
	Play114202041 = function (slot0, slot1)
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
				uv0:Play114202042(uv1)
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

			slot5 = 1.65

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202041].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114202041].content)
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
	Play114202042 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 11.7

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202043(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"].transform

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10017 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10017", 3)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10017, Vector3.New(0, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -350, -180)
			end

			slot4 = uv0.actors_["10017"]

			if 2 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10017 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10017 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue10017
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10017 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue10017
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot8 = 2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot10 = Color.New(1, 1, 1)
				slot10.a = Mathf.Lerp(1, 0, (uv0.time_ - slot7) / slot8)
				uv0.mask_.color = slot10
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot9 = Color.New(1, 1, 1)
				uv0.mask_.enabled = false
				slot9.a = 0
				uv0.mask_.color = slot9
			end

			slot9 = uv0.actors_["10017"]

			if 2 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				if slot9.GetComponent(slot9, "Image") then
					uv0.var_.alphaMatValue10017 = slot11
					uv0.var_.alphaOldValue10017 = slot11.color.a
				end

				uv0.var_.alphaOldValue10017 = 0
			end

			slot11 = 0.5

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot13 = Mathf.Lerp(uv0.var_.alphaOldValue10017, 1, (uv0.time_ - slot10) / slot11)

				if uv0.var_.alphaMatValue10017 then
					slot14 = uv0.var_.alphaMatValue10017.color
					slot14.a = slot13
					uv0.var_.alphaMatValue10017.color = slot14
				end
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 and uv0.var_.alphaMatValue10017 then
				slot12 = uv0.var_.alphaMatValue10017
				slot13 = slot12.color
				slot13.a = 1
				slot12.color = slot13
			end

			slot12 = uv0.actors_["10017"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.var_.moveOldPos10017 = slot12.localPosition
				slot12.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10017", 7)
			end

			slot14 = 0.001

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				slot12.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10017, Vector3.New(0, -2000, 300), (uv0.time_ - slot13) / slot14)
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 then
				slot12.localPosition = Vector3.New(0, -2000, 300)
			end

			slot15 = uv0.actors_["10015_split_1"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0.var_.moveOldPos10015_split_1 = slot15.localPosition
				slot15.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_1", 7)
			end

			slot17 = 0.001

			if slot16 <= uv0.time_ and uv0.time_ < slot16 + slot17 then
				slot15.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_1, Vector3.New(0, -2000, 300), (uv0.time_ - slot16) / slot17)
			end

			if uv0.time_ >= slot16 + slot17 and uv0.time_ < slot16 + slot17 + slot0 then
				slot15.localPosition = Vector3.New(0, -2000, 300)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				slot19 = manager.ui.mainCamera.transform.localPosition
				slot21 = uv0.bgs_.F04
				slot21.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot19.x, slot19.y, 0)
				slot21.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot21:GetComponent("SpriteRenderer") and slot22.sprite then
					slot25 = manager.ui.mainCameraCom_
					slot26 = 2 * (slot21.transform.localPosition - slot19).z * Mathf.Tan(slot25.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot32 = slot26 * slot25.aspect / slot22.sprite.bounds.size.x > slot26 / slot22.sprite.bounds.size.y and slot30 or slot31
					slot21.transform.localScale = Vector3.New(slot32, slot32, 0)
				end

				for slot26, slot27 in pairs(uv0.bgs_) do
					if slot26 ~= "F04" then
						slot27.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot20 = 1.125

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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202042].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202042", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202042", "story_v_out_114202.awb") / 1000 > 0 and slot20 < slot25 and uv0.duration_ < slot25 + slot19 then
						slot20 = slot25
						uv0.duration_ = slot25 + slot19
					end

					if slot23.prefab_name ~= "" and uv0.actors_[slot23.prefab_name] ~= nil then
						uv0:RecordAudio("114202042", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot23.prefab_name].transform, "story_v_out_114202", "114202042", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202042", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot19 = slot19 + 0.3
			slot22 = uv0:FormatText(StoryWordCfg[114202042].content)
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
	Play114202043 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.9

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202044(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10017 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10017 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue10017
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10017 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue10017
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[209].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_2050")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202043].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202043", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202043", "story_v_out_114202.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
						slot5 = slot9
						uv0.duration_ = slot9 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						uv0:RecordAudio("114202043", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_114202", "114202043", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202043", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114202043].content)
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
	Play114202044 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.466

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202045(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10017 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10017 then
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue10017
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10017 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue10017
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202044].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202044", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202044", "story_v_out_114202.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
						slot5 = slot9
						uv0.duration_ = slot9 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						uv0:RecordAudio("114202044", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_114202", "114202044", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202044", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114202044].content)
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
	Play114202045 = function (slot0, slot1)
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
				uv0:Play114202046(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if slot1.GetComponent(slot1, "Image") then
					uv0.var_.alphaMatValue10017 = slot3
					uv0.var_.alphaOldValue10017 = slot3.color.a
				end

				uv0.var_.alphaOldValue10017 = 0
			end

			slot3 = 0.5

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5 = Mathf.Lerp(uv0.var_.alphaOldValue10017, 1, (uv0.time_ - slot2) / slot3)

				if uv0.var_.alphaMatValue10017 then
					slot6 = uv0.var_.alphaMatValue10017.color
					slot6.a = slot5
					uv0.var_.alphaMatValue10017.color = slot6
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.alphaMatValue10017 then
				slot4 = uv0.var_.alphaMatValue10017
				slot5 = slot4.color
				slot5.a = 1
				slot4.color = slot5
			end

			slot5 = 0.725

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202045].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[114202045].content)
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
	Play114202046 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 11.133

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202047(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10017 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10017", 2)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10017, Vector3.New(-390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -350, -180)
			end

			slot4 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10017 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10017 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue10017
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10017 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue10017
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot7 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				if slot7.GetComponent(slot7, "Image") then
					uv0.var_.alphaMatValue10017 = slot9
					uv0.var_.alphaOldValue10017 = slot9.color.a
				end

				uv0.var_.alphaOldValue10017 = 0
			end

			slot9 = 0.5

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot11 = Mathf.Lerp(uv0.var_.alphaOldValue10017, 1, (uv0.time_ - slot8) / slot9)

				if uv0.var_.alphaMatValue10017 then
					slot12 = uv0.var_.alphaMatValue10017.color
					slot12.a = slot11
					uv0.var_.alphaMatValue10017.color = slot12
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.alphaMatValue10017 then
				slot10 = uv0.var_.alphaMatValue10017
				slot11 = slot10.color
				slot11.a = 1
				slot10.color = slot11
			end

			slot11 = 1.1

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202046].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202046", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202046", "story_v_out_114202.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
						slot11 = slot15
						uv0.duration_ = slot15 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						uv0:RecordAudio("114202046", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114202", "114202046", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202046", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[114202046].content)
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
	Play114202047 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.9

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202048(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015_split_1"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10015_split_1 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_1", 4)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_1, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			slot4 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10017 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10017 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue10017
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10017 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue10017
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot7 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and slot7.GetComponent(slot7, "Image") then
				uv0.var_.highlightMatValue10015_split_1 = slot9
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.highlightMatValue10015_split_1 then
					slot11 = Mathf.Lerp(0.5, 1, slot10)
					slot12 = uv0.var_.highlightMatValue10015_split_1
					slot13 = slot12.color
					slot13.r = slot11
					slot13.g = slot11
					slot13.b = slot11
					slot12.color = slot13
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.highlightMatValue10015_split_1 then
				slot10 = 1

				slot7.transform:SetSiblingIndex(1)

				slot11 = uv0.var_.highlightMatValue10015_split_1
				slot12 = slot11.color
				slot12.r = slot10
				slot12.g = slot10
				slot12.b = slot10
				slot11.color = slot12
			end

			slot10 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				if slot10.GetComponent(slot10, "Image") then
					uv0.var_.alphaMatValue10015_split_1 = slot12
					uv0.var_.alphaOldValue10015_split_1 = slot12.color.a
				end

				uv0.var_.alphaOldValue10015_split_1 = 0
			end

			slot12 = 0.5

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot14 = Mathf.Lerp(uv0.var_.alphaOldValue10015_split_1, 1, (uv0.time_ - slot11) / slot12)

				if uv0.var_.alphaMatValue10015_split_1 then
					slot15 = uv0.var_.alphaMatValue10015_split_1.color
					slot15.a = slot14
					uv0.var_.alphaMatValue10015_split_1.color = slot15
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.alphaMatValue10015_split_1 then
				slot13 = uv0.var_.alphaMatValue10015_split_1
				slot14 = slot13.color
				slot14.a = 1
				slot13.color = slot14
			end

			slot14 = 0.375

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202047].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202047", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202047", "story_v_out_114202.awb") / 1000 > 0 and slot14 < slot18 and uv0.duration_ < slot18 + slot13 then
						slot14 = slot18
						uv0.duration_ = slot18 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						uv0:RecordAudio("114202047", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_114202", "114202047", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202047", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = uv0:FormatText(StoryWordCfg[114202047].content)
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
	Play114202048 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.733

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202049(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue10017 = slot3
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue10017 then
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue10017
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue10017 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue10017
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot4 = uv0.actors_["10015_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10015_split_1 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10015_split_1 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue10015_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10015_split_1 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue10015_split_1
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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202048].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202048", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202048", "story_v_out_114202.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
						slot8 = slot12
						uv0.duration_ = slot12 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						uv0:RecordAudio("114202048", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114202", "114202048", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202048", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[114202048].content)
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
	Play114202049 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.866

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114202050(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.95

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202049].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202049", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202049", "story_v_out_114202.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("114202049", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114202", "114202049", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202049", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[114202049].content)
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
	Play114202050 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.4

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
			slot1 = uv0.actors_["10015_split_1"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10015_split_1 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_1", 7)
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_1, Vector3.New(0, -2000, 300), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -2000, 300)
			end

			slot4 = uv0.actors_["10017"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue10017 = slot6
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue10017 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue10017
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue10017 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue10017
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			if uv0.actors_["10015_split_5"] == nil then
				slot8 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot8.transform:SetSiblingIndex(1)

				slot8.name = slot7
				slot9 = slot8:GetComponent(typeof(Image))
				slot9.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot7)

				slot9:SetNativeSize()

				slot8.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot7] = slot8
			end

			slot8 = uv0.actors_["10015_split_5"]

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 and slot8.GetComponent(slot8, "Image") then
				uv0.var_.highlightMatValue10015_split_5 = slot10
			end

			slot10 = 0.034

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot11 = (uv0.time_ - slot9) / slot10

				if uv0.var_.highlightMatValue10015_split_5 then
					slot12 = Mathf.Lerp(0.5, 1, slot11)
					slot13 = uv0.var_.highlightMatValue10015_split_5
					slot14 = slot13.color
					slot14.r = slot12
					slot14.g = slot12
					slot14.b = slot12
					slot13.color = slot14
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.highlightMatValue10015_split_5 then
				slot11 = 1

				slot8.transform:SetSiblingIndex(1)

				slot12 = uv0.var_.highlightMatValue10015_split_5
				slot13 = slot12.color
				slot13.r = slot11
				slot13.g = slot11
				slot13.b = slot11
				slot12.color = slot13
			end

			slot11 = uv0.actors_["10015_split_5"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.var_.moveOldPos10015_split_5 = slot11.localPosition
				slot11.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015_split_5", 4)
			end

			slot13 = 0.001

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015_split_5, Vector3.New(390, -350, -180), (uv0.time_ - slot12) / slot13)
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot11.localPosition = Vector3.New(390, -350, -180)
			end

			slot15 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[114202050].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202050", "story_v_out_114202.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_114202", "114202050", "story_v_out_114202.awb") / 1000 > 0 and slot15 < slot19 and uv0.duration_ < slot19 + slot14 then
						slot15 = slot19
						uv0.duration_ = slot19 + slot14
					end

					if slot17.prefab_name ~= "" and uv0.actors_[slot17.prefab_name] ~= nil then
						uv0:RecordAudio("114202050", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot17.prefab_name].transform, "story_v_out_114202", "114202050", "story_v_out_114202.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_114202", "114202050", "story_v_out_114202.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot17 = uv0:FormatText(StoryWordCfg[114202050].content)
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
	end
}
