return {
	Play108072001 = function (slot0, slot1)
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
				uv0:Play108072002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.S0804 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.S0804
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "S0804" then
						slot11.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot3 = uv0.bgs_.S0804

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				if slot3.GetComponent(slot3, "SpriteRenderer") then
					uv0.var_.alphaOldValueS0804 = slot5.material:GetColor("_Color").a
					uv0.var_.alphaMatValueS0804 = slot5.material
				end

				uv0.var_.alphaOldValueS0804 = 0
			end

			slot5 = 1.5

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot7 = Mathf.Lerp(uv0.var_.alphaOldValueS0804, 1, (uv0.time_ - slot4) / slot5)

				if uv0.var_.alphaMatValueS0804 then
					slot8 = uv0.var_.alphaMatValueS0804
					slot9 = slot8:GetColor("_Color")
					slot9.a = slot7

					slot8:SetColor("_Color", slot9)
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.alphaMatValueS0804 then
				slot6 = uv0.var_.alphaMatValueS0804
				slot7 = slot6:GetColor("_Color")
				slot7.a = 1

				slot6:SetColor("_Color", slot7)
			end

			slot7 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot8 + 2 and uv0.time_ < slot8 + slot9 + slot0 then
				uv0.allBtn_.enabled = true
			end

			if uv0.time_ <= 0.033 then
				uv0.dialog_:SetActive(false)
			end

			slot11 = 0.55

			if 2 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
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

				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072001].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = slot10 + 0.3
			slot13 = uv0:FormatText(StoryWordCfg[108072001].content)
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
	Play108072002 = function (slot0, slot1)
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
				uv0:Play108072003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.85

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072002].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[108072002].content)
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
	Play108072003 = function (slot0, slot1)
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
				uv0:Play108072004(uv1)
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

				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072003].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[108072003].content)
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
	Play108072004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.200999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(StoryWordCfg[108072004].content)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(false)
			end

			if 0.0166666666666667 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot3 = 0.96

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.115000002086163, (uv0.time_ - slot2) / slot3)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.fswtw_.percent = 0.115000002086163

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			if uv0.bgs_.STblack == nil then
				slot5 = Object.Instantiate(uv0.paintGo_)
				slot5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot4)
				slot5.name = slot4
				slot5.transform.parent = uv0.stage_.transform
				slot5.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot4] = slot5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				slot6 = manager.ui.mainCamera.transform.localPosition
				slot8 = uv0.bgs_.STblack
				slot8.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot6.x, slot6.y, 0)
				slot8.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot8:GetComponent("SpriteRenderer") and slot9.sprite then
					slot12 = manager.ui.mainCameraCom_
					slot13 = 2 * (slot8.transform.localPosition - slot6).z * Mathf.Tan(slot12.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot19 = slot13 * slot12.aspect / slot9.sprite.bounds.size.x > slot13 / slot9.sprite.bounds.size.y and slot17 or slot18
					slot8.transform.localScale = Vector3.New(slot19, slot19, 0)
				end

				for slot13, slot14 in pairs(uv0.bgs_) do
					if slot13 ~= "STblack" then
						slot14.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot6 = 0
			slot7 = 4.201

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072004", "story_v_out_108072.awb") / 1000 > 0 and slot7 < slot8 and uv0.duration_ < slot8 + slot6 then
				slot7 = slot8
				uv0.duration_ = slot8 + slot6
			end

			if slot6 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072004", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.052999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 0.66

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.195999994874001, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.195999994874001

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 3.053

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072006", "story_v_out_108072.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072006", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.395999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 2.28

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.439000010490417, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.439000010490417

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 8.396

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072007", "story_v_out_108072.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072007", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.865999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.5

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.597000002861023, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.597000002861023

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 5.866

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072008", "story_v_out_108072.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072008", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.597999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 0.72

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.690999984741211, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.690999984741211

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 2.598

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072009", "story_v_out_108072.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072009", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 13.990999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 2.28

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 1, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 1

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 13.991

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072010", "story_v_out_108072.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072010", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.976999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(StoryWordCfg[108072011].content)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(false)
			end

			if 0.0166666666666667 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot3 = 1.5

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.24099999666214, (uv0.time_ - slot2) / slot3)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.fswtw_.percent = 0.24099999666214

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot4 = 0
			slot5 = 7.977

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072011", "story_v_out_108072.awb") / 1000 > 0 and slot5 < slot6 and uv0.duration_ < slot6 + slot4 then
				slot5 = slot6
				uv0.duration_ = slot6 + slot4
			end

			if slot4 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072011", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 14.424999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 2.22

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.579999983310699, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.579999983310699

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 14.425

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072013", "story_v_out_108072.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072013", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.559999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.08

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.742999970912933, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.742999970912933

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 5.56

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072014", "story_v_out_108072.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072014", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 10.189999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.68

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 1, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 1

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 10.19

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072015", "story_v_out_108072.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072015", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.2

		if ({
			ja = 7.2,
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
				uv0:Play108072018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				slot2 = manager.ui.mainCamera.transform.localPosition
				slot4 = uv0.bgs_.S0804
				slot4.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot2.x, slot2.y, 0)
				slot4.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot4:GetComponent("SpriteRenderer") and slot5.sprite then
					slot8 = manager.ui.mainCameraCom_
					slot9 = 2 * (slot4.transform.localPosition - slot2).z * Mathf.Tan(slot8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot15 = slot9 * slot8.aspect / slot5.sprite.bounds.size.x > slot9 / slot5.sprite.bounds.size.y and slot13 or slot14
					slot4.transform.localScale = Vector3.New(slot15, slot15, 0)
				end

				for slot9, slot10 in pairs(uv0.bgs_) do
					if slot9 ~= "S0804" then
						slot10.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.fswbg_:SetActive(false)
				uv0.dialog_:SetActive(true)
				uv0:ShowNextGo(false)
			end

			slot4 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.dialog_:SetActive(true)

				uv0.dialog_.transform.localScale = Vector3(0.8, 0.95, 1)

				LeanTween.scale(uv0.dialog_, Vector3.one, 0.2)

				slot5 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot5:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot5:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072017].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072017", "story_v_out_108072.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_108072", "108072017", "story_v_out_108072.awb") / 1000 > 0 and slot4 < slot9 and uv0.duration_ < slot9 + slot3 then
						slot4 = slot9
						uv0.duration_ = slot9 + slot3
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						uv0:RecordAudio("108072017", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_108072", "108072017", "story_v_out_108072.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072017", "story_v_out_108072.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot3 = slot3 + 0.3
			slot6 = uv0:FormatText(StoryWordCfg[108072017].content)
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
	Play108072018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 10

		if ({
			ja = 10,
			zh = 5.933
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
				uv0:Play108072019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.65

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072018].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072018", "story_v_out_108072.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_108072", "108072018", "story_v_out_108072.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("108072018", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_108072", "108072018", "story_v_out_108072.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072018", "story_v_out_108072.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[108072018].content)
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
	Play108072019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.266

		if ({
			ja = 5,
			zh = 6.266
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
				uv0:Play108072020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_1050")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072019].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072019", "story_v_out_108072.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_108072", "108072019", "story_v_out_108072.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("108072019", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_108072", "108072019", "story_v_out_108072.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072019", "story_v_out_108072.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[108072019].content)
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
	Play108072020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.166

		if ({
			ja = 2.9,
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
				uv0:Play108072021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. "story_1099")
				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072020].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072020", "story_v_out_108072.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_108072", "108072020", "story_v_out_108072.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("108072020", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_108072", "108072020", "story_v_out_108072.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072020", "story_v_out_108072.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[108072020].content)
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
	Play108072021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.9

		if ({
			ja = 8.666,
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
				uv0:Play108072022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072021].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072021", "story_v_out_108072.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_108072", "108072021", "story_v_out_108072.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("108072021", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_108072", "108072021", "story_v_out_108072.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072021", "story_v_out_108072.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[108072021].content)
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
	Play108072022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 19.133

		if ({
			ja = 19.133,
			zh = 15.166
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
				uv0:Play108072023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.075

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072022].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072022", "story_v_out_108072.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_108072", "108072022", "story_v_out_108072.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("108072022", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_108072", "108072022", "story_v_out_108072.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072022", "story_v_out_108072.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[108072022].content)
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
	Play108072023 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.066

		if ({
			ja = 8.066,
			zh = 6.966
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
				uv0:Play108072024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072023].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072023", "story_v_out_108072.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_108072", "108072023", "story_v_out_108072.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("108072023", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_108072", "108072023", "story_v_out_108072.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072023", "story_v_out_108072.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[108072023].content)
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
	Play108072024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 13.266

		if ({
			ja = 13.266,
			zh = 10.333
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
				uv0:Play108072025(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072024].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072024", "story_v_out_108072.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_108072", "108072024", "story_v_out_108072.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("108072024", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_108072", "108072024", "story_v_out_108072.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072024", "story_v_out_108072.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[108072024].content)
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
	Play108072025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.8

		if ({
			ja = 1.166,
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
				uv0:Play108072026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072025].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072025", "story_v_out_108072.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_108072", "108072025", "story_v_out_108072.awb") / 1000 > 0 and slot2 < slot6 and uv0.duration_ < slot6 + slot1 then
						slot2 = slot6
						uv0.duration_ = slot6 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						uv0:RecordAudio("108072025", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_108072", "108072025", "story_v_out_108072.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072025", "story_v_out_108072.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[108072025].content)
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
	Play108072026 = function (slot0, slot1)
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
				uv0:Play108072027(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072026].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[108072026].content)
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
	Play108072027 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.5

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072028(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.C04 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 1.5 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.C04
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "C04" then
						slot11.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot3 = uv0.bgs_.S0804

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				if slot3.GetComponent(slot3, "SpriteRenderer") then
					uv0.var_.alphaOldValueS0804 = slot5.material:GetColor("_Color").a
					uv0.var_.alphaMatValueS0804 = slot5.material
				end

				uv0.var_.alphaOldValueS0804 = 1
			end

			slot5 = 1.5

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot7 = Mathf.Lerp(uv0.var_.alphaOldValueS0804, 0, (uv0.time_ - slot4) / slot5)

				if uv0.var_.alphaMatValueS0804 then
					slot8 = uv0.var_.alphaMatValueS0804
					slot9 = slot8:GetColor("_Color")
					slot9.a = slot7

					slot8:SetColor("_Color", slot9)
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.alphaMatValueS0804 then
				slot6 = uv0.var_.alphaMatValueS0804
				slot7 = slot6:GetColor("_Color")
				slot7.a = 0

				slot6:SetColor("_Color", slot7)
			end

			slot6 = uv0.bgs_.C04

			if 1.5 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				if slot6.GetComponent(slot6, "SpriteRenderer") then
					uv0.var_.alphaOldValueC04 = slot8.material:GetColor("_Color").a
					uv0.var_.alphaMatValueC04 = slot8.material
				end

				uv0.var_.alphaOldValueC04 = 0
			end

			slot8 = 1.5

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot10 = Mathf.Lerp(uv0.var_.alphaOldValueC04, 1, (uv0.time_ - slot7) / slot8)

				if uv0.var_.alphaMatValueC04 then
					slot11 = uv0.var_.alphaMatValueC04
					slot12 = slot11:GetColor("_Color")
					slot12.a = slot10

					slot11:SetColor("_Color", slot12)
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.alphaMatValueC04 then
				slot9 = uv0.var_.alphaMatValueC04
				slot10 = slot9:GetColor("_Color")
				slot10.a = 1

				slot9:SetColor("_Color", slot10)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot9 + 1.5 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.allBtn_.enabled = true
			end

			slot12 = 0.65

			if 1.5 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072027].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = uv0:FormatText(StoryWordCfg[108072027].content)
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
	Play108072028 = function (slot0, slot1)
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
				uv0:Play108072029(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072028].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = uv0:FormatText(StoryWordCfg[108072028].content)
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
	Play108072029 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.866

		if ({
			ja = 3.3,
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
				uv0:Play108072030(uv1)
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

			slot2 = uv0.actors_["1099ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos1099ui_story = slot2.localPosition
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1099ui_story, Vector3.New(0, -1.13, -5.3), (uv0.time_ - slot3) / slot4)
				slot8 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot8.x, slot8.y, slot8.z)
				slot9 = slot2.localEulerAngles
				slot9.z = 0
				slot9.x = 0
				slot2.localEulerAngles = slot9
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(0, -1.13, -5.3)
				slot7 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot2.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot2.localEulerAngles = slot8
			end

			slot5 = uv0.actors_["1099ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect1099ui_story == nil then
				uv0.var_.characterEffect1099ui_story = slot5.GetComponentInChildren(slot5, typeof(CharacterEffect))
			end

			slot7 = 0.2

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.characterEffect1099ui_story then
					uv0.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect1099ui_story then
				uv0.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/1099/1099action/1099action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			slot11 = 0.725

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072029].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072029", "story_v_out_108072.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_108072", "108072029", "story_v_out_108072.awb") / 1000 > 0 and slot11 < slot15 and uv0.duration_ < slot15 + slot10 then
						slot11 = slot15
						uv0.duration_ = slot15 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						uv0:RecordAudio("108072029", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_108072", "108072029", "story_v_out_108072.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072029", "story_v_out_108072.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = uv0:FormatText(StoryWordCfg[108072029].content)
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
	Play108072030 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 11.9

		if ({
			ja = 11.9,
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
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			slot3 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_black")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[108072030].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072030", "story_v_out_108072.awb") ~= 0 then
					if manager.audio:GetVoiceLength("story_v_out_108072", "108072030", "story_v_out_108072.awb") / 1000 > 0 and slot3 < slot7 and uv0.duration_ < slot7 + slot2 then
						slot3 = slot7
						uv0.duration_ = slot7 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						uv0:RecordAudio("108072030", LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_out_108072", "108072030", "story_v_out_108072.awb"))
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072030", "story_v_out_108072.awb")
					end
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = uv0:FormatText(StoryWordCfg[108072030].content)
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
	end
}
