return {
	Play117011001 = function (slot0, slot1)
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
				uv0:Play117011002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.I08b == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.I08b
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "I08b" then
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
				uv0:AudioAction("play", "effect", "se_story_17", "se_story_17_fire_loop", "")
			end

			slot8 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot10 = 0.4

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

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011001].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot9 = slot9 + 0.3
			slot12 = uv0:FormatText(StoryWordCfg[117011001].content)
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
	Play117011002 = function (slot0, slot1)
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
				uv0:Play117011003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = manager.ui.mainCamera.transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.shakeOldPos = slot1.localPosition
			end

			slot3 = 2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5, slot6 = math.modf((uv0.time_ - slot2) / 0.066)
				slot1.localPosition = Vector3.New(slot6 * 0.13, slot6 * 0.13, slot6 * 0.13) + uv0.var_.shakeOldPos
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = uv0.var_.shakeOldPos
			end

			slot5 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_17", "se_story_17_boss_hawk1", "")
			end

			slot7 = 1.65

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011002].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot9 = uv0:FormatText(StoryWordCfg[117011002].content)
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
	Play117011003 = function (slot0, slot1)
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
				uv0:Play117011004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.825

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011003].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117011003].content)
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
	Play117011004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.966

		if ({
			ja = 2.966,
			zh = 1.3
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
				uv0:Play117011005(uv1)
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

			slot7 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_10034_split_2")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011004].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011004", "story_v_out_117011.awb") / 1000 > 0 and slot7 < slot11 and uv0.duration_ < slot11 + slot6 then
					slot7 = slot11
					uv0.duration_ = slot11 + slot6
				end

				if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
					uv0:RecordAudio("117011004", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_out_117011", "117011004", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011004", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot9 = uv0:FormatText(StoryWordCfg[117011004].content)
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
	Play117011005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.6

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117011006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = manager.ui.mainCamera.transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.shakeOldPos = slot1.localPosition
			end

			slot3 = 1

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

			if uv0.time_ >= slot4 + 1 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.allBtn_.enabled = true
			end

			slot7 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks04", "")
			end

			slot9 = 1

			if 0.6 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_17", "se_story_17_boss_hawk3", "")
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot11 = 1.075

			if 0.6 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialog_:SetActive(true)

				uv0.dialog_.transform.localScale = Vector3(0.8, 0.95, 1)

				LeanTween.scale(uv0.dialog_, Vector3.one, 0.2)

				slot12 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot12:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot12:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011005].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = slot10 + 0.3
			slot13 = uv0:FormatText(StoryWordCfg[117011005].content)
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
	Play117011006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 11.6

		if ({
			ja = 9.266,
			zh = 11.6
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
				uv0:Play117011007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.TI0101 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.TI0101
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "TI0101" then
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
				slot6.a = Mathf.Lerp(0, 1, (uv0.time_ - slot3) / slot4)
				uv0.mask_.color = slot6
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot5 = Color.New(0, 0, 0)
				slot5.a = 1
				uv0.mask_.color = slot5
			end

			if 2 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
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

			slot7 = uv0.bgs_.TI0101.transform

			if 2 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPosTI0101 = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPosTI0101, Vector3.New(0, 1, 9), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, 1, 9)
			end

			slot10 = uv0.bgs_.TI0101.transform

			if 2.034 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPosTI0101 = slot10.localPosition
			end

			slot12 = 5.5

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPosTI0101, Vector3.New(0, 1, 10), (uv0.time_ - slot11) / slot12)
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, 1, 10)
			end

			if 4 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot13 + 3.534 and uv0.time_ < slot13 + slot14 + slot0 then
				uv0.allBtn_.enabled = true
			end

			slot16 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:AudioAction("stop", "effect", "se_story_17", "se_story_17_fire_loop", "")
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot18 = 0.975

			if 4 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0.dialog_:SetActive(true)

				uv0.dialog_.transform.localScale = Vector3(0.8, 0.95, 1)

				LeanTween.scale(uv0.dialog_, Vector3.one, 0.2)

				slot19 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot19:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot19:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011006].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011006", "story_v_out_117011.awb") / 1000 > 0 and slot18 < slot23 and uv0.duration_ < slot23 + slot17 then
					slot18 = slot23
					uv0.duration_ = slot23 + slot17
				end

				if slot21.prefab_name ~= "" and uv0.actors_[slot21.prefab_name] ~= nil then
					uv0:RecordAudio("117011006", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot21.prefab_name].transform, "story_v_out_117011", "117011006", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011006", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot17 = slot17 + 0.3
			slot20 = uv0:FormatText(StoryWordCfg[117011006].content)
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
	Play117011007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.066

		if ({
			ja = 6.2,
			zh = 8.066
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
				uv0:Play117011008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.025

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011007].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011007", "story_v_out_117011.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117011007", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117011", "117011007", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011007", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117011007].content)
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
	Play117011008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 12.633

		if ({
			ja = 12.633,
			zh = 6.8
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
				uv0:Play117011009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.85

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011008].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011008", "story_v_out_117011.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117011008", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117011", "117011008", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011008", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117011008].content)
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
	Play117011009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.266

		if ({
			ja = 4.366,
			zh = 7.266
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
				uv0:Play117011010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.9

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011009].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011009", "story_v_out_117011.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117011009", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117011", "117011009", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011009", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117011009].content)
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
	Play117011010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 9.933

		if ({
			ja = 6.666,
			zh = 9.933
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
				uv0:Play117011011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.15

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011010].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011010", "story_v_out_117011.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117011010", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117011", "117011010", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011010", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117011010].content)
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
	Play117011011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.533

		if ({
			ja = 6.533,
			zh = 3.8
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
				uv0:Play117011012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011011].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011011", "story_v_out_117011.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117011011", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117011", "117011011", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011011", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117011011].content)
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
	Play117011012 = function (slot0, slot1)
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
				uv0:Play117011013(uv1)
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

			if uv0.bgs_.ST12 == nil then
				slot6 = Object.Instantiate(uv0.paintGo_)
				slot6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot5)
				slot6.name = slot5
				slot6.transform.parent = uv0.stage_.transform
				slot6.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot5] = slot6
			end

			if 2 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				slot7 = manager.ui.mainCamera.transform.localPosition
				slot9 = uv0.bgs_.ST12
				slot9.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot7.x, slot7.y, 0)
				slot9.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot9:GetComponent("SpriteRenderer") and slot10.sprite then
					slot13 = manager.ui.mainCameraCom_
					slot14 = 2 * (slot9.transform.localPosition - slot7).z * Mathf.Tan(slot13.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot20 = slot14 * slot13.aspect / slot10.sprite.bounds.size.x > slot14 / slot10.sprite.bounds.size.y and slot18 or slot19
					slot9.transform.localScale = Vector3.New(slot20, slot20, 0)
				end

				for slot14, slot15 in pairs(uv0.bgs_) do
					if slot14 ~= "ST12" then
						slot15.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot8 = 1.2

			if 4 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
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

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011012].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = slot7 + 0.3
			slot10 = uv0:FormatText(StoryWordCfg[117011012].content)
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
	Play117011013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.1

		if ({
			ja = 5.1,
			zh = 4.466
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
				uv0:Play117011014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1029_split_1"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["1029_split_1"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos1029_split_1 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1029_split_1", 2)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1029_split_1, Vector3.New(-390, -355, -140), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(-390, -355, -140)
			end

			slot5 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				if slot5.GetComponent(slot5, "Image") then
					uv0.var_.alphaMatValue1029_split_1 = slot7
					uv0.var_.alphaOldValue1029_split_1 = slot7.color.a
				end

				uv0.var_.alphaOldValue1029_split_1 = 0
			end

			slot7 = 0.333333333333333

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot9 = Mathf.Lerp(uv0.var_.alphaOldValue1029_split_1, 1, (uv0.time_ - slot6) / slot7)

				if uv0.var_.alphaMatValue1029_split_1 then
					slot10 = uv0.var_.alphaMatValue1029_split_1.color
					slot10.a = slot9
					uv0.var_.alphaMatValue1029_split_1.color = slot10
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.alphaMatValue1029_split_1 then
				slot8 = uv0.var_.alphaMatValue1029_split_1
				slot9 = slot8.color
				slot9.a = 1
				slot8.color = slot9
			end

			slot9 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot11 = 0.733333333333333

			if 0.2 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")
			end

			slot13 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
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

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011013].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011013", "story_v_out_117011.awb") / 1000 > 0 and slot13 < slot18 and uv0.duration_ < slot18 + slot12 then
					slot13 = slot18
					uv0.duration_ = slot18 + slot12
				end

				if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
					uv0:RecordAudio("117011013", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_117011", "117011013", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011013", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = slot12 + 0.3
			slot15 = uv0:FormatText(StoryWordCfg[117011013].content)
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
	Play117011014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.6

		if ({
			ja = 4.833,
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
				uv0:Play117011015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1033_split_6"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["1033_split_6"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos1033_split_6 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1033_split_6", 4)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033_split_6, Vector3.New(390, -420, 0), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(390, -420, 0)
			end

			slot5 = uv0.actors_["1033_split_6"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				if slot5.GetComponent(slot5, "Image") then
					uv0.var_.alphaMatValue1033_split_6 = slot7
					uv0.var_.alphaOldValue1033_split_6 = slot7.color.a
				end

				uv0.var_.alphaOldValue1033_split_6 = 0
			end

			slot7 = 0.333333333333333

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot9 = Mathf.Lerp(uv0.var_.alphaOldValue1033_split_6, 1, (uv0.time_ - slot6) / slot7)

				if uv0.var_.alphaMatValue1033_split_6 then
					slot10 = uv0.var_.alphaMatValue1033_split_6.color
					slot10.a = slot9
					uv0.var_.alphaMatValue1033_split_6.color = slot10
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.alphaMatValue1033_split_6 then
				slot8 = uv0.var_.alphaMatValue1033_split_6
				slot9 = slot8.color
				slot9.a = 1
				slot8.color = slot9
			end

			slot8 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 and slot8.GetComponent(slot8, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot10
			end

			slot10 = 0.2

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot11 = (uv0.time_ - slot9) / slot10

				if uv0.var_.highlightMatValue1029_split_1 then
					slot12 = Mathf.Lerp(1, 0.5, slot11)
					slot13 = uv0.var_.highlightMatValue1029_split_1
					slot14 = slot13.color
					slot14.r = slot12
					slot14.g = slot12
					slot14.b = slot12
					slot13.color = slot14
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot11 = 0.5
				slot12 = uv0.var_.highlightMatValue1029_split_1
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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011014].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011014", "story_v_out_117011.awb") / 1000 > 0 and slot12 < slot16 and uv0.duration_ < slot16 + slot11 then
					slot12 = slot16
					uv0.duration_ = slot16 + slot11
				end

				if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
					uv0:RecordAudio("117011014", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_117011", "117011014", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011014", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = uv0:FormatText(StoryWordCfg[117011014].content)
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
	Play117011015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.633

		if ({
			ja = 5.966,
			zh = 8.633
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
				uv0:Play117011016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.125

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011015].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011015", "story_v_out_117011.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117011015", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117011", "117011015", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011015", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117011015].content)
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
	Play117011016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.533

		if ({
			ja = 4.1,
			zh = 8.533
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
				uv0:Play117011017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.95

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011016].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011016", "story_v_out_117011.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117011016", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117011", "117011016", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011016", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117011016].content)
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
	Play117011017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 12.733

		if ({
			ja = 12.733,
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
				uv0:Play117011018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.35

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011017].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011017", "story_v_out_117011.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117011017", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117011", "117011017", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011017", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117011017].content)
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
	Play117011018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.266

		if ({
			ja = 4.266,
			zh = 3.7
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
				uv0:Play117011019(uv1)
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

			slot4 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1029_split_1 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue1029_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue1029_split_1
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011018].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011018", "story_v_out_117011.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
					slot8 = slot12
					uv0.duration_ = slot12 + slot7
				end

				if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
					uv0:RecordAudio("117011018", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117011", "117011018", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011018", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117011018].content)
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
	Play117011019 = function (slot0, slot1)
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
				uv0:Play117011020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue1029_split_1 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue1029_split_1
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue1029_split_1
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

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011019].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[117011019].content)
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
	Play117011020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.7

		if ({
			ja = 5.7,
			zh = 2.3
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
				uv0:Play117011021(uv1)
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
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue1033_split_6
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1033_split_6 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1033_split_6
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011020].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011020", "story_v_out_117011.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
					slot5 = slot9
					uv0.duration_ = slot9 + slot4
				end

				if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
					uv0:RecordAudio("117011020", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_117011", "117011020", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011020", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[117011020].content)
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
	Play117011021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.133

		if ({
			ja = 4.133,
			zh = 2.5
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
				uv0:Play117011022(uv1)
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

			slot4 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1029_split_1 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue1029_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue1029_split_1
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011021].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011021", "story_v_out_117011.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
					slot8 = slot12
					uv0.duration_ = slot12 + slot7
				end

				if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
					uv0:RecordAudio("117011021", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117011", "117011021", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011021", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117011021].content)
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
	Play117011022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 9.9

		if ({
			ja = 9.9,
			zh = 8.9
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
				uv0:Play117011023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.975

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011022].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011022", "story_v_out_117011.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117011022", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117011", "117011022", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011022", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117011022].content)
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
	Play117011023 = function (slot0, slot1)
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
				uv0:Play117011024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue1029_split_1 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue1029_split_1
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue1029_split_1
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 0.575

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011023].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[117011023].content)
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
	Play117011024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.566

		if ({
			ja = 7.566,
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
				uv0:Play117011025(uv1)
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
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue1033_split_6
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1033_split_6 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1033_split_6
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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011024].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011024", "story_v_out_117011.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
					slot5 = slot9
					uv0.duration_ = slot9 + slot4
				end

				if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
					uv0:RecordAudio("117011024", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_117011", "117011024", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011024", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[117011024].content)
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
	Play117011025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.233

		if ({
			ja = 8.233,
			zh = 6.8
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
				uv0:Play117011026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.9

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011025].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011025", "story_v_out_117011.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117011025", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117011", "117011025", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011025", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117011025].content)
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
	Play117011026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.7

		if ({
			ja = 5.7,
			zh = 3.6
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
				uv0:Play117011027(uv1)
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

			slot4 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1029_split_1 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue1029_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue1029_split_1
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011026].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011026", "story_v_out_117011.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
					slot8 = slot12
					uv0.duration_ = slot12 + slot7
				end

				if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
					uv0:RecordAudio("117011026", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117011", "117011026", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011026", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117011026].content)
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
	Play117011027 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.533

		if ({
			ja = 1,
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
				uv0:Play117011028(uv1)
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
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue1033_split_6
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1033_split_6 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1033_split_6
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot4 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1029_split_1 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue1029_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue1029_split_1
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011027].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011027", "story_v_out_117011.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
					slot8 = slot12
					uv0.duration_ = slot12 + slot7
				end

				if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
					uv0:RecordAudio("117011027", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117011", "117011027", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011027", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117011027].content)
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
	Play117011028 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.6

		if ({
			ja = 4.966,
			zh = 6.6
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
				uv0:Play117011029(uv1)
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

			slot4 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1029_split_1 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue1029_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue1029_split_1
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.825

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011028].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011028", "story_v_out_117011.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
					slot8 = slot12
					uv0.duration_ = slot12 + slot7
				end

				if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
					uv0:RecordAudio("117011028", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117011", "117011028", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011028", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117011028].content)
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
	Play117011029 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.766

		if ({
			ja = 1.766,
			zh = 0.999999999999
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
				uv0:Play117011030(uv1)
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

				uv0:CheckSpriteTmpPos("1033_split_4", 4)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033_split_4, Vector3.New(390, -420, 0), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(390, -420, 0)
			end

			slot5 = uv0.actors_["1033_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and slot5.GetComponent(slot5, "Image") then
				uv0.var_.highlightMatValue1033_split_4 = slot7
			end

			slot7 = 0.2

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.highlightMatValue1033_split_4 then
					slot9 = Mathf.Lerp(0.5, 1, slot8)
					slot10 = uv0.var_.highlightMatValue1033_split_4
					slot11 = slot10.color
					slot11.r = slot9
					slot11.g = slot9
					slot11.b = slot9
					slot10.color = slot11
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.highlightMatValue1033_split_4 then
				slot8 = 1

				slot5.transform:SetSiblingIndex(1)

				slot9 = uv0.var_.highlightMatValue1033_split_4
				slot10 = slot9.color
				slot10.r = slot8
				slot10.g = slot8
				slot10.b = slot8
				slot9.color = slot10
			end

			slot8 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 and slot8.GetComponent(slot8, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot10
			end

			slot10 = 0.2

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot11 = (uv0.time_ - slot9) / slot10

				if uv0.var_.highlightMatValue1029_split_1 then
					slot12 = Mathf.Lerp(1, 0.5, slot11)
					slot13 = uv0.var_.highlightMatValue1029_split_1
					slot14 = slot13.color
					slot14.r = slot12
					slot14.g = slot12
					slot14.b = slot12
					slot13.color = slot14
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot11 = 0.5
				slot12 = uv0.var_.highlightMatValue1029_split_1
				slot13 = slot12.color
				slot13.r = slot11
				slot13.g = slot11
				slot13.b = slot11
				slot12.color = slot13
			end

			slot12 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011029].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011029", "story_v_out_117011.awb") / 1000 > 0 and slot12 < slot16 and uv0.duration_ < slot16 + slot11 then
					slot12 = slot16
					uv0.duration_ = slot16 + slot11
				end

				if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
					uv0:RecordAudio("117011029", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_117011", "117011029", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011029", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = uv0:FormatText(StoryWordCfg[117011029].content)
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
	Play117011030 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.033

		if ({
			ja = 8.033,
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
				uv0:Play117011031(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033_split_4"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue1033_split_4 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue1033_split_4 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue1033_split_4
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1033_split_4 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue1033_split_4
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot4 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1029_split_1 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue1029_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue1029_split_1
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011030].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011030", "story_v_out_117011.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
					slot8 = slot12
					uv0.duration_ = slot12 + slot7
				end

				if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
					uv0:RecordAudio("117011030", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117011", "117011030", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011030", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117011030].content)
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
	Play117011031 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.466

		if ({
			ja = 6.233,
			zh = 7.466
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
				uv0:Play117011032(uv1)
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

			slot7 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and slot7.GetComponent(slot7, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot9
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.highlightMatValue1029_split_1 then
					slot11 = Mathf.Lerp(1, 0.5, slot10)
					slot12 = uv0.var_.highlightMatValue1029_split_1
					slot13 = slot12.color
					slot13.r = slot11
					slot13.g = slot11
					slot13.b = slot11
					slot12.color = slot13
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot10 = 0.5
				slot11 = uv0.var_.highlightMatValue1029_split_1
				slot12 = slot11.color
				slot12.r = slot10
				slot12.g = slot10
				slot12.b = slot10
				slot11.color = slot12
			end

			slot11 = 0.925

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011031].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011031", "story_v_out_117011.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
					slot11 = slot15
					uv0.duration_ = slot15 + slot10
				end

				if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
					uv0:RecordAudio("117011031", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_117011", "117011031", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011031", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[117011031].content)
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
	Play117011032 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 9.9

		if ({
			ja = 7.733,
			zh = 9.9
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
				uv0:Play117011033(uv1)
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

			slot4 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1029_split_1 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue1029_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue1029_split_1
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 1.325

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011032].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011032", "story_v_out_117011.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
					slot8 = slot12
					uv0.duration_ = slot12 + slot7
				end

				if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
					uv0:RecordAudio("117011032", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117011", "117011032", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011032", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117011032].content)
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
	Play117011033 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 12.533

		if ({
			ja = 9.6,
			zh = 12.533
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
				uv0:Play117011034(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.45

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011033].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011033", "story_v_out_117011.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117011033", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117011", "117011033", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011033", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117011033].content)
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
	Play117011034 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.333

		if ({
			ja = 7.333,
			zh = 3.9
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
				uv0:Play117011035(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011034].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011034", "story_v_out_117011.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117011034", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117011", "117011034", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011034", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117011034].content)
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
	Play117011035 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.133

		if ({
			ja = 5.133,
			zh = 2.333
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
				uv0:Play117011036(uv1)
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
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue1033_split_6
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1033_split_6 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1033_split_6
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot4 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1029_split_1 then
					slot8 = Mathf.Lerp(1, 0.5, slot7)
					slot9 = uv0.var_.highlightMatValue1029_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue1029_split_1
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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011035].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011035", "story_v_out_117011.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
					slot8 = slot12
					uv0.duration_ = slot12 + slot7
				end

				if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
					uv0:RecordAudio("117011035", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117011", "117011035", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011035", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117011035].content)
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
	Play117011036 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.933

		if ({
			ja = 3.933,
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
				uv0:Play117011037(uv1)
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

			slot4 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and slot4.GetComponent(slot4, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.highlightMatValue1029_split_1 then
					slot8 = Mathf.Lerp(0.5, 1, slot7)
					slot9 = uv0.var_.highlightMatValue1029_split_1
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue1029_split_1
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011036].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011036", "story_v_out_117011.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
					slot8 = slot12
					uv0.duration_ = slot12 + slot7
				end

				if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
					uv0:RecordAudio("117011036", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117011", "117011036", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011036", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117011036].content)
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
	Play117011037 = function (slot0, slot1)
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
				uv0:Play117011038(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue1029_split_1 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue1029_split_1
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue1029_split_1
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011037].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[117011037].content)
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
	Play117011038 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.966

		if ({
			ja = 2.7,
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
				uv0:Play117011039(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue1029_split_1 then
					slot5 = Mathf.Lerp(0.5, 1, slot4)
					slot6 = uv0.var_.highlightMatValue1029_split_1
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1029_split_1
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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011038].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011038", "story_v_out_117011.awb") / 1000 > 0 and slot5 < slot9 and uv0.duration_ < slot9 + slot4 then
					slot5 = slot9
					uv0.duration_ = slot9 + slot4
				end

				if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
					uv0:RecordAudio("117011038", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_117011", "117011038", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011038", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[117011038].content)
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
	Play117011039 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.5

		if ({
			ja = 3.5,
			zh = 2.4
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
				uv0:Play117011040(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and slot1.GetComponent(slot1, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.highlightMatValue1029_split_1 then
					slot5 = Mathf.Lerp(1, 0.5, slot4)
					slot6 = uv0.var_.highlightMatValue1029_split_1
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue1029_split_1
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

			slot8 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011039].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011039", "story_v_out_117011.awb") / 1000 > 0 and slot8 < slot12 and uv0.duration_ < slot12 + slot7 then
					slot8 = slot12
					uv0.duration_ = slot12 + slot7
				end

				if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
					uv0:RecordAudio("117011039", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117011", "117011039", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011039", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117011039].content)
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
	Play117011040 = function (slot0, slot1)
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
				uv0:Play117011041(uv1)
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

			slot3 = 0.333333333333333

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

			slot4 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				if slot4.GetComponent(slot4, "Image") then
					uv0.var_.alphaMatValue1029_split_1 = slot6
					uv0.var_.alphaOldValue1029_split_1 = slot6.color.a
				end

				uv0.var_.alphaOldValue1029_split_1 = 1
			end

			slot6 = 0.333333333333333

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot8 = Mathf.Lerp(uv0.var_.alphaOldValue1029_split_1, 0, (uv0.time_ - slot5) / slot6)

				if uv0.var_.alphaMatValue1029_split_1 then
					slot9 = uv0.var_.alphaMatValue1029_split_1.color
					slot9.a = slot8
					uv0.var_.alphaMatValue1029_split_1.color = slot9
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.alphaMatValue1029_split_1 then
				slot7 = uv0.var_.alphaMatValue1029_split_1
				slot8 = slot7.color
				slot8.a = 0
				slot7.color = slot8
			end

			slot8 = 0.975

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011040].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = uv0:FormatText(StoryWordCfg[117011040].content)
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
	Play117011041 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.8

		if ({
			ja = 4.8,
			zh = 3.333
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
				uv0:Play117011042(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if slot1.GetComponent(slot1, "Image") then
					uv0.var_.alphaMatValue1029_split_1 = slot3
					uv0.var_.alphaOldValue1029_split_1 = slot3.color.a
				end

				uv0.var_.alphaOldValue1029_split_1 = 0
			end

			slot3 = 0.333333333333333

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5 = Mathf.Lerp(uv0.var_.alphaOldValue1029_split_1, 1, (uv0.time_ - slot2) / slot3)

				if uv0.var_.alphaMatValue1029_split_1 then
					slot6 = uv0.var_.alphaMatValue1029_split_1.color
					slot6.a = slot5
					uv0.var_.alphaMatValue1029_split_1.color = slot6
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.alphaMatValue1029_split_1 then
				slot4 = uv0.var_.alphaMatValue1029_split_1
				slot5 = slot4.color
				slot5.a = 1
				slot4.color = slot5
			end

			slot4 = uv0.actors_["1029_split_1"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1029_split_1 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1029_split_1", 3)
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1029_split_1, Vector3.New(0, -355, -140), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -355, -140)
			end

			slot7 = uv0.actors_["1029_split_1"]

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and slot7.GetComponent(slot7, "Image") then
				uv0.var_.highlightMatValue1029_split_1 = slot9
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.highlightMatValue1029_split_1 then
					slot11 = Mathf.Lerp(0.5, 1, slot10)
					slot12 = uv0.var_.highlightMatValue1029_split_1
					slot13 = slot12.color
					slot13.r = slot11
					slot13.g = slot11
					slot13.b = slot11
					slot12.color = slot13
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.highlightMatValue1029_split_1 then
				slot10 = 1

				slot7.transform:SetSiblingIndex(1)

				slot11 = uv0.var_.highlightMatValue1029_split_1
				slot12 = slot11.color
				slot12.r = slot10
				slot12.g = slot10
				slot12.b = slot10
				slot11.color = slot12
			end

			slot11 = 0.375

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011041].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011041", "story_v_out_117011.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
					slot11 = slot15
					uv0.duration_ = slot15 + slot10
				end

				if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
					uv0:RecordAudio("117011041", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_117011", "117011041", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011041", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[117011041].content)
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
	Play117011042 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 11.333

		if ({
			ja = 11.333,
			zh = 9.633
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
				uv0:Play117011043(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.ST03 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.ST03
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "ST03" then
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
				slot6.a = Mathf.Lerp(0, 1, (uv0.time_ - slot3) / slot4)
				uv0.mask_.color = slot6
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot5 = Color.New(0, 0, 0)
				slot5.a = 1
				uv0.mask_.color = slot5
			end

			if 2 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
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

			slot7 = uv0.actors_["1029_split_1"].transform

			if 1.966 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1029_split_1 = slot7.localPosition
				slot7.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1029_split_1", 7)
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1029_split_1, Vector3.New(0, -2000, -140), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -2000, -140)
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot11 = 0.825

			if 4 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialog_:SetActive(true)

				uv0.dialog_.transform.localScale = Vector3(0.8, 0.95, 1)

				LeanTween.scale(uv0.dialog_, Vector3.one, 0.2)

				slot12 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot12:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot12:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_reporterw")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011042].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011042", "story_v_out_117011.awb") / 1000 > 0 and slot11 < slot16 and uv0.duration_ < slot16 + slot10 then
					slot11 = slot16
					uv0.duration_ = slot16 + slot10
				end

				if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
					uv0:RecordAudio("117011042", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_117011", "117011042", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011042", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = slot10 + 0.3
			slot13 = uv0:FormatText(StoryWordCfg[117011042].content)
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
	Play117011043 = function (slot0, slot1)
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
				uv0:Play117011044(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_v1_environment_crowd", "se_story_v1_environment_crowd", "se_story_v1_environment_crowd.awb")
			end

			slot4 = 1.225

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011043].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot6 = uv0:FormatText(StoryWordCfg[117011043].content)
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
	Play117011044 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.9

		if ({
			ja = 1.266,
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
				uv0:Play117011045(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_reporterw")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011044].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011044", "story_v_out_117011.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117011044", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117011", "117011044", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011044", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117011044].content)
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
	Play117011045 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 10.766

		if ({
			ja = 10.766,
			zh = 5.9
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
				uv0:Play117011046(uv1)
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

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				if slot5.GetComponent(slot5, "Image") then
					uv0.var_.alphaMatValue1132_split_6 = slot7
					uv0.var_.alphaOldValue1132_split_6 = slot7.color.a
				end

				uv0.var_.alphaOldValue1132_split_6 = 0
			end

			slot7 = 0.333333333333333

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot9 = Mathf.Lerp(uv0.var_.alphaOldValue1132_split_6, 1, (uv0.time_ - slot6) / slot7)

				if uv0.var_.alphaMatValue1132_split_6 then
					slot10 = uv0.var_.alphaMatValue1132_split_6.color
					slot10.a = slot9
					uv0.var_.alphaMatValue1132_split_6.color = slot10
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.alphaMatValue1132_split_6 then
				slot8 = uv0.var_.alphaMatValue1132_split_6
				slot9 = slot8.color
				slot9.a = 1
				slot8.color = slot9
			end

			slot9 = 0.875

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011045].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011045", "story_v_out_117011.awb") / 1000 > 0 and slot9 < slot13 and uv0.duration_ < slot13 + slot8 then
					slot9 = slot13
					uv0.duration_ = slot13 + slot8
				end

				if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
					uv0:RecordAudio("117011045", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_117011", "117011045", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011045", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot11 = uv0:FormatText(StoryWordCfg[117011045].content)
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
	Play117011046 = function (slot0, slot1)
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
				uv0:Play117011047(uv1)
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

			slot3 = 0.333333333333333

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

			slot5 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011046].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = uv0:FormatText(StoryWordCfg[117011046].content)
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
	Play117011047 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.8

		if ({
			ja = 7.8,
			zh = 6.9
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
				uv0:Play117011048(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.925

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_reporterw")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011047].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011047", "story_v_out_117011.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
					slot2 = slot6
					uv0.duration_ = slot6 + slot1
				end

				if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
					uv0:RecordAudio("117011047", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117011", "117011047", "story_v_out_117011.awb"))
				else
					uv0:AudioAction("play", "voice", "story_v_out_117011", "117011047", "story_v_out_117011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117011047].content)
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
	Play117011048 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5

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
			slot2 = 0.925

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[117011048].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[117011048].content)
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
