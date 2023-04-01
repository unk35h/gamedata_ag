return {
	Play100 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.999999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
			slot3 = true

			SetActive(uv0.choicesGo_, slot3)

			for slot3, slot4 in ipairs(uv0.choices_) do
				SetActive(slot4.go, slot3 <= 3)
			end

			uv0.choices_[1].txt.text = uv0:FormatText(StoryChoiceCfg[4].name)
			uv0.choices_[2].txt.text = uv0:FormatText(StoryChoiceCfg[5].name)
			uv0.choices_[3].txt.text = uv0:FormatText(StoryChoiceCfg[6].name)
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play101(uv1)
			end

			if slot0 == 2 then
				uv0:Play113(uv1)
			end

			if slot0 == 3 then
				uv0:Play114(uv1)
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

			if uv0.actors_["1084ui_story"] == nil then
				slot6 = Object.Instantiate(Asset.Load("Char/" .. slot5), uv0.stage_.transform)
				slot6.name = slot5
				slot6.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot5] = slot6
				slot6:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot6, typeof(DynamicBoneHelper)) then
					slot8.EnableDynamicBone(slot8, false)
				end

				uv0:ShowWeapon(slot7.transform, false)

				uv0.var_[slot5 .. "Animator"] = slot7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot5 .. "Animator"].applyRootMotion = true
				uv0.var_[slot5 .. "LipSync"] = slot7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			slot6 = uv0.actors_["1084ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = slot6.GetComponentInChildren(slot6, typeof(CharacterEffect))
			end

			slot8 = 0.1

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot9 = (uv0.time_ - slot7) / slot8

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if uv0.bgs_.ST01 == nil then
				slot10 = Object.Instantiate(uv0.paintGo_)
				slot10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot9)
				slot10.name = slot9
				slot10.transform.parent = uv0.stage_.transform
				slot10.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot9] = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				slot11 = manager.ui.mainCamera.transform.localPosition
				slot13 = uv0.bgs_.ST01
				slot13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot11.x, slot11.y, 0)
				slot13.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot13:GetComponent("SpriteRenderer") and slot14.sprite then
					slot17 = manager.ui.mainCameraCom_
					slot18 = 2 * (slot13.transform.localPosition - slot11).z * Mathf.Tan(slot17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot24 = slot18 * slot17.aspect / slot14.sprite.bounds.size.x > slot18 / slot14.sprite.bounds.size.y and slot22 or slot23
					slot13.transform.localScale = Vector3.New(slot24, slot24, 0)
				end

				for slot18, slot19 in pairs(uv0.bgs_) do
					if slot18 ~= "ST01" then
						slot19.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot11 = uv0.actors_["1084ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.var_.moveOldPos1084ui_story = slot11.localPosition
			end

			slot13 = 0.001

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(-0.85, -1.16, -5), (uv0.time_ - slot12) / slot13)
				slot17 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot11.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot11.localEulerAngles = slot18
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot11.localPosition = Vector3.New(-0.85, -1.16, -5)
				slot16 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot11.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot11.localEulerAngles = slot17
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084action/1084action13_1")
			end

			slot15 = uv0.actors_["1148ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0.var_.moveOldPos1148ui_story = slot15.localPosition
			end

			slot17 = 0.001

			if slot16 <= uv0.time_ and uv0.time_ < slot16 + slot17 then
				slot15.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(0.83, -0.85, -5.6), (uv0.time_ - slot16) / slot17)
				slot21 = manager.ui.mainCamera.transform.position - slot15.position
				slot15.forward = Vector3.New(slot21.x, slot21.y, slot21.z)
				slot22 = slot15.localEulerAngles
				slot22.z = 0
				slot22.x = 0
				slot15.localEulerAngles = slot22
			end

			if uv0.time_ >= slot16 + slot17 and uv0.time_ < slot16 + slot17 + slot0 then
				slot15.localPosition = Vector3.New(0.83, -0.85, -5.6)
				slot20 = manager.ui.mainCamera.transform.position - slot15.position
				slot15.forward = Vector3.New(slot20.x, slot20.y, slot20.z)
				slot21 = slot15.localEulerAngles
				slot21.z = 0
				slot21.x = 0
				slot15.localEulerAngles = slot21
			end

			if 0 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148action/1148action9_1")
			end

			slot20 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
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

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[100].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot19 = slot19 + 0.3
			slot22 = uv0:FormatText(StoryWordCfg[100].content)
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
	Play101 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.566666666665

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play102(uv1)
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

			slot4 = uv0.actors_["1084ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if uv0.bgs_.ST02 == nil then
				slot8 = Object.Instantiate(uv0.paintGo_)
				slot8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot7)
				slot8.name = slot7
				slot8.transform.parent = uv0.stage_.transform
				slot8.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot7] = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				slot9 = manager.ui.mainCamera.transform.localPosition
				slot11 = uv0.bgs_.ST02
				slot11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot9.x, slot9.y, 0)
				slot11.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot11:GetComponent("SpriteRenderer") and slot12.sprite then
					slot15 = manager.ui.mainCameraCom_
					slot16 = 2 * (slot11.transform.localPosition - slot9).z * Mathf.Tan(slot15.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot22 = slot16 * slot15.aspect / slot12.sprite.bounds.size.x > slot16 / slot12.sprite.bounds.size.y and slot20 or slot21
					slot11.transform.localScale = Vector3.New(slot22, slot22, 0)
				end

				for slot16, slot17 in pairs(uv0.bgs_) do
					if slot16 ~= "ST02" then
						slot17.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot9 = uv0.bgs_.ST01.transform

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPosST01 = slot9.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPosST01, Vector3.New(0, -100, 10), (uv0.time_ - slot10) / slot11)
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(0, -100, 10)
			end

			slot12 = uv0.bgs_.ST02.transform

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				if not uv0.var_.effectST02脸红 then
					slot14 = Object.Instantiate(Asset.Load("Effect/Hero/1048/fx_1048_ui_001"))
					slot14.name = "脸红"
					uv0.var_.effectST02脸红 = slot14
				end

				if slot12.Find(slot12, "") then
					slot14.transform.parent = slot15
				else
					slot14.transform.parent = slot12
				end

				slot14.transform.localPosition = Vector3.New(0, 0, 0)
				slot14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084actionlink/1084action4139")
			end

			slot15 = manager.ui.mainCamera.transform

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				if not uv0.var_.effectMainCamera1048镜头前特效 then
					slot17 = Object.Instantiate(Asset.Load("Effect/Hero/1048/fx_1048_ui_001"))
					slot17.name = "1048镜头前特效"
					uv0.var_.effectMainCamera1048镜头前特效 = slot17
				end

				if slot15.Find(slot15, "") then
					slot17.transform.parent = slot18
				else
					slot17.transform.parent = slot15
				end

				slot17.transform.localPosition = Vector3.New(0, 0, 0)
				slot17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			slot18 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
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

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[100].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot17 = slot17 + 0.3
			slot20 = uv0:FormatText(StoryWordCfg[100].content)
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
	Play102 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.91976090269

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103(uv1)
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

			slot4 = uv0.actors_["1084ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if uv0.bgs_.ST03 == nil then
				slot8 = Object.Instantiate(uv0.paintGo_)
				slot8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot7)
				slot8.name = slot7
				slot8.transform.parent = uv0.stage_.transform
				slot8.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot7] = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				slot9 = manager.ui.mainCamera.transform.localPosition
				slot11 = uv0.bgs_.ST03
				slot11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot9.x, slot9.y, 0)
				slot11.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot11:GetComponent("SpriteRenderer") and slot12.sprite then
					slot15 = manager.ui.mainCameraCom_
					slot16 = 2 * (slot11.transform.localPosition - slot9).z * Mathf.Tan(slot15.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot22 = slot16 * slot15.aspect / slot12.sprite.bounds.size.x > slot16 / slot12.sprite.bounds.size.y and slot20 or slot21
					slot11.transform.localScale = Vector3.New(slot22, slot22, 0)
				end

				for slot16, slot17 in pairs(uv0.bgs_) do
					if slot16 ~= "ST03" then
						slot17.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot9 = uv0.bgs_.ST02.transform

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPosST02 = slot9.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPosST02, Vector3.New(0, -100, 10), (uv0.time_ - slot10) / slot11)
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = false

				uv0:SetGaussion(false)
			end

			slot13 = 0.5

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot15 = Color.New(1, 1, 1)
				slot15.a = Mathf.Lerp(0, 1, (uv0.time_ - slot12) / slot13)
				uv0.mask_.color = slot15
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot14 = Color.New(1, 1, 1)
				slot14.a = 1
				uv0.mask_.color = slot14
			end

			if 1 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = false

				uv0:SetGaussion(false)
			end

			slot15 = 0.5

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot17 = Color.New(1, 1, 1)
				slot17.a = Mathf.Lerp(1, 0, (uv0.time_ - slot14) / slot15)
				uv0.mask_.color = slot17
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 then
				slot16 = Color.New(1, 1, 1)
				uv0.mask_.enabled = false
				slot16.a = 0
				uv0.mask_.color = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148actionlink/1148action495")
			end

			slot18 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
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

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[100].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot17 = slot17 + 0.3
			slot20 = uv0:FormatText(StoryWordCfg[100].content)
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
	Play103 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.066666666665

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play104(uv1)
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

			slot4 = uv0.actors_["1084ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if uv0.bgs_.ST03a == nil then
				slot8 = Object.Instantiate(uv0.paintGo_)
				slot8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot7)
				slot8.name = slot7
				slot8.transform.parent = uv0.stage_.transform
				slot8.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot7] = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				slot9 = manager.ui.mainCamera.transform.localPosition
				slot11 = uv0.bgs_.ST03a
				slot11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot9.x, slot9.y, 0)
				slot11.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot11:GetComponent("SpriteRenderer") and slot12.sprite then
					slot15 = manager.ui.mainCameraCom_
					slot16 = 2 * (slot11.transform.localPosition - slot9).z * Mathf.Tan(slot15.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot22 = slot16 * slot15.aspect / slot12.sprite.bounds.size.x > slot16 / slot12.sprite.bounds.size.y and slot20 or slot21
					slot11.transform.localScale = Vector3.New(slot22, slot22, 0)
				end

				for slot16, slot17 in pairs(uv0.bgs_) do
					if slot16 ~= "ST03a" then
						slot17.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot9 = uv0.bgs_.ST03.transform

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPosST03 = slot9.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPosST03, Vector3.New(0, -100, 10), (uv0.time_ - slot10) / slot11)
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084actionlink/1084action492")
			end

			slot14 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
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

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[100].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = slot13 + 0.3
			slot16 = uv0:FormatText(StoryWordCfg[100].content)
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
	Play104 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.128894003386

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play105(uv1)
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

			slot4 = uv0.actors_["1084ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if uv0.bgs_.ST05 == nil then
				slot8 = Object.Instantiate(uv0.paintGo_)
				slot8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot7)
				slot8.name = slot7
				slot8.transform.parent = uv0.stage_.transform
				slot8.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot7] = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				slot9 = manager.ui.mainCamera.transform.localPosition
				slot11 = uv0.bgs_.ST05
				slot11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot9.x, slot9.y, 0)
				slot11.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot11:GetComponent("SpriteRenderer") and slot12.sprite then
					slot15 = manager.ui.mainCameraCom_
					slot16 = 2 * (slot11.transform.localPosition - slot9).z * Mathf.Tan(slot15.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot22 = slot16 * slot15.aspect / slot12.sprite.bounds.size.x > slot16 / slot12.sprite.bounds.size.y and slot20 or slot21
					slot11.transform.localScale = Vector3.New(slot22, slot22, 0)
				end

				for slot16, slot17 in pairs(uv0.bgs_) do
					if slot16 ~= "ST05" then
						slot17.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot9 = uv0.bgs_.ST03a.transform

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPosST03a = slot9.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPosST03a, Vector3.New(0, -100, 10), (uv0.time_ - slot10) / slot11)
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148actionlink/1148action452")
			end

			slot14 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
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

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[100].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = slot13 + 0.3
			slot16 = uv0:FormatText(StoryWordCfg[100].content)
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
	Play105 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.366666666665

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play106(uv1)
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

			slot4 = uv0.actors_["1084ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if uv0.bgs_.ST05a == nil then
				slot8 = Object.Instantiate(uv0.paintGo_)
				slot8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot7)
				slot8.name = slot7
				slot8.transform.parent = uv0.stage_.transform
				slot8.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot7] = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				slot9 = manager.ui.mainCamera.transform.localPosition
				slot11 = uv0.bgs_.ST05a
				slot11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot9.x, slot9.y, 0)
				slot11.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot11:GetComponent("SpriteRenderer") and slot12.sprite then
					slot15 = manager.ui.mainCameraCom_
					slot16 = 2 * (slot11.transform.localPosition - slot9).z * Mathf.Tan(slot15.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot22 = slot16 * slot15.aspect / slot12.sprite.bounds.size.x > slot16 / slot12.sprite.bounds.size.y and slot20 or slot21
					slot11.transform.localScale = Vector3.New(slot22, slot22, 0)
				end

				for slot16, slot17 in pairs(uv0.bgs_) do
					if slot16 ~= "ST05a" then
						slot17.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot9 = uv0.bgs_.ST05.transform

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPosST05 = slot9.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPosST05, Vector3.New(0, -100, 10), (uv0.time_ - slot10) / slot11)
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084actionlink/1084action423")
			end

			slot14 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
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

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[100].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = slot13 + 0.3
			slot16 = uv0:FormatText(StoryWordCfg[100].content)
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
	Play106 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.833333333331

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play107(uv1)
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

			slot4 = uv0.actors_["1084ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if uv0.bgs_.ST06 == nil then
				slot8 = Object.Instantiate(uv0.paintGo_)
				slot8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot7)
				slot8.name = slot7
				slot8.transform.parent = uv0.stage_.transform
				slot8.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot7] = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				slot9 = manager.ui.mainCamera.transform.localPosition
				slot11 = uv0.bgs_.ST06
				slot11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot9.x, slot9.y, 0)
				slot11.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot11:GetComponent("SpriteRenderer") and slot12.sprite then
					slot15 = manager.ui.mainCameraCom_
					slot16 = 2 * (slot11.transform.localPosition - slot9).z * Mathf.Tan(slot15.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot22 = slot16 * slot15.aspect / slot12.sprite.bounds.size.x > slot16 / slot12.sprite.bounds.size.y and slot20 or slot21
					slot11.transform.localScale = Vector3.New(slot22, slot22, 0)
				end

				for slot16, slot17 in pairs(uv0.bgs_) do
					if slot16 ~= "ST06" then
						slot17.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot9 = uv0.bgs_.ST05a.transform

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPosST05a = slot9.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPosST05a, Vector3.New(0, -100, 10), (uv0.time_ - slot10) / slot11)
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148actionlink/1148action423")
			end

			slot14 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
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

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[100].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = slot13 + 0.3
			slot16 = uv0:FormatText(StoryWordCfg[100].content)
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
	Play107 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.799999999998

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108(uv1)
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

			slot4 = uv0.actors_["1084ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if uv0.bgs_.ST06a == nil then
				slot8 = Object.Instantiate(uv0.paintGo_)
				slot8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot7)
				slot8.name = slot7
				slot8.transform.parent = uv0.stage_.transform
				slot8.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot7] = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				slot9 = manager.ui.mainCamera.transform.localPosition
				slot11 = uv0.bgs_.ST06a
				slot11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot9.x, slot9.y, 0)
				slot11.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot11:GetComponent("SpriteRenderer") and slot12.sprite then
					slot15 = manager.ui.mainCameraCom_
					slot16 = 2 * (slot11.transform.localPosition - slot9).z * Mathf.Tan(slot15.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot22 = slot16 * slot15.aspect / slot12.sprite.bounds.size.x > slot16 / slot12.sprite.bounds.size.y and slot20 or slot21
					slot11.transform.localScale = Vector3.New(slot22, slot22, 0)
				end

				for slot16, slot17 in pairs(uv0.bgs_) do
					if slot16 ~= "ST06a" then
						slot17.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot9 = uv0.bgs_.ST06.transform

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPosST06 = slot9.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPosST06, Vector3.New(0, -100, 10), (uv0.time_ - slot10) / slot11)
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084actionlink/1084action434")
			end

			slot14 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
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

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[100].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = slot13 + 0.3
			slot16 = uv0:FormatText(StoryWordCfg[100].content)
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
	Play108 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.049999999998

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play109(uv1)
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

			slot4 = uv0.actors_["1084ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if uv0.bgs_.ST06b == nil then
				slot8 = Object.Instantiate(uv0.paintGo_)
				slot8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot7)
				slot8.name = slot7
				slot8.transform.parent = uv0.stage_.transform
				slot8.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot7] = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				slot9 = manager.ui.mainCamera.transform.localPosition
				slot11 = uv0.bgs_.ST06b
				slot11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot9.x, slot9.y, 0)
				slot11.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot11:GetComponent("SpriteRenderer") and slot12.sprite then
					slot15 = manager.ui.mainCameraCom_
					slot16 = 2 * (slot11.transform.localPosition - slot9).z * Mathf.Tan(slot15.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot22 = slot16 * slot15.aspect / slot12.sprite.bounds.size.x > slot16 / slot12.sprite.bounds.size.y and slot20 or slot21
					slot11.transform.localScale = Vector3.New(slot22, slot22, 0)
				end

				for slot16, slot17 in pairs(uv0.bgs_) do
					if slot16 ~= "ST06b" then
						slot17.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot9 = uv0.bgs_.ST06a.transform

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPosST06a = slot9.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPosST06a, Vector3.New(0, -100, 10), (uv0.time_ - slot10) / slot11)
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148actionlink/1148action434")
			end

			slot14 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
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

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[100].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = slot13 + 0.3
			slot16 = uv0:FormatText(StoryWordCfg[100].content)
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
	Play109 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.666666666665

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110(uv1)
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

			slot4 = uv0.actors_["1084ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			slot7 = uv0.bgs_.ST06b.transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPosST06b = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPosST06b, Vector3.New(0, -100, 10), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -100, 10)
			end

			if uv0.bgs_.ST07a == nil then
				slot11 = Object.Instantiate(uv0.paintGo_)
				slot11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot10)
				slot11.name = slot10
				slot11.transform.parent = uv0.stage_.transform
				slot11.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot10] = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				slot12 = manager.ui.mainCamera.transform.localPosition
				slot14 = uv0.bgs_.ST07a
				slot14.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot12.x, slot12.y, 0)
				slot14.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot14:GetComponent("SpriteRenderer") and slot15.sprite then
					slot18 = manager.ui.mainCameraCom_
					slot19 = 2 * (slot14.transform.localPosition - slot12).z * Mathf.Tan(slot18.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot25 = slot19 * slot18.aspect / slot15.sprite.bounds.size.x > slot19 / slot15.sprite.bounds.size.y and slot23 or slot24
					slot14.transform.localScale = Vector3.New(slot25, slot25, 0)
				end

				for slot19, slot20 in pairs(uv0.bgs_) do
					if slot19 ~= "ST07a" then
						slot20.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084actionlink/1084action445")
			end

			slot14 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
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

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[100].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = slot13 + 0.3
			slot16 = uv0:FormatText(StoryWordCfg[100].content)
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
	Play110 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.7650254013

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play111(uv1)
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

			slot4 = uv0.actors_["1084ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			slot7 = uv0.bgs_.ST07a.transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPosST07a = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPosST07a, Vector3.New(0, -100, 10), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -100, 10)
			end

			if uv0.bgs_.ST07b == nil then
				slot11 = Object.Instantiate(uv0.paintGo_)
				slot11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot10)
				slot11.name = slot10
				slot11.transform.parent = uv0.stage_.transform
				slot11.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot10] = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				slot12 = manager.ui.mainCamera.transform.localPosition
				slot14 = uv0.bgs_.ST07b
				slot14.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot12.x, slot12.y, 0)
				slot14.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot14:GetComponent("SpriteRenderer") and slot15.sprite then
					slot18 = manager.ui.mainCameraCom_
					slot19 = 2 * (slot14.transform.localPosition - slot12).z * Mathf.Tan(slot18.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot25 = slot19 * slot18.aspect / slot15.sprite.bounds.size.x > slot19 / slot15.sprite.bounds.size.y and slot23 or slot24
					slot14.transform.localScale = Vector3.New(slot25, slot25, 0)
				end

				for slot19, slot20 in pairs(uv0.bgs_) do
					if slot19 ~= "ST07b" then
						slot20.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148actionlink/1148action445")
			end

			slot14 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
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

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[100].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = slot13 + 0.3
			slot16 = uv0:FormatText(StoryWordCfg[100].content)
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
	Play111 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.333333333331

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play112(uv1)
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

			slot4 = uv0.actors_["1084ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			slot7 = uv0.bgs_.ST07b.transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPosST07b = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPosST07b, Vector3.New(0, -100, 10), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -100, 10)
			end

			if uv0.bgs_.ST08 == nil then
				slot11 = Object.Instantiate(uv0.paintGo_)
				slot11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot10)
				slot11.name = slot10
				slot11.transform.parent = uv0.stage_.transform
				slot11.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot10] = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				slot12 = manager.ui.mainCamera.transform.localPosition
				slot14 = uv0.bgs_.ST08
				slot14.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot12.x, slot12.y, 0)
				slot14.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot14:GetComponent("SpriteRenderer") and slot15.sprite then
					slot18 = manager.ui.mainCameraCom_
					slot19 = 2 * (slot14.transform.localPosition - slot12).z * Mathf.Tan(slot18.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot25 = slot19 * slot18.aspect / slot15.sprite.bounds.size.x > slot19 / slot15.sprite.bounds.size.y and slot23 or slot24
					slot14.transform.localScale = Vector3.New(slot25, slot25, 0)
				end

				for slot19, slot20 in pairs(uv0.bgs_) do
					if slot19 ~= "ST08" then
						slot20.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084actionlink/1084action456")
			end

			slot14 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
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

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[100].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = slot13 + 0.3
			slot16 = uv0:FormatText(StoryWordCfg[100].content)
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
	Play112 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.933333333331

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

			slot4 = uv0.actors_["1084ui_story"]

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = slot4.GetComponentInChildren(slot4, typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			slot7 = uv0.bgs_.ST08.transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPosST08 = slot7.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPosST08, Vector3.New(0, -100, 10), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -100, 10)
			end

			if uv0.bgs_.ST12 == nil then
				slot11 = Object.Instantiate(uv0.paintGo_)
				slot11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot10)
				slot11.name = slot10
				slot11.transform.parent = uv0.stage_.transform
				slot11.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot10] = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				slot12 = manager.ui.mainCamera.transform.localPosition
				slot14 = uv0.bgs_.ST12
				slot14.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot12.x, slot12.y, 0)
				slot14.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot14:GetComponent("SpriteRenderer") and slot15.sprite then
					slot18 = manager.ui.mainCameraCom_
					slot19 = 2 * (slot14.transform.localPosition - slot12).z * Mathf.Tan(slot18.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot25 = slot19 * slot18.aspect / slot15.sprite.bounds.size.x > slot19 / slot15.sprite.bounds.size.y and slot23 or slot24
					slot14.transform.localScale = Vector3.New(slot25, slot25, 0)
				end

				for slot19, slot20 in pairs(uv0.bgs_) do
					if slot19 ~= "ST12" then
						slot20.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148actionlink/1148action456")
			end

			slot14 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
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

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[100].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = slot13 + 0.3
			slot16 = uv0:FormatText(StoryWordCfg[100].content)
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
	Play113 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.999999999999

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
			slot1 = uv0.actors_["1084ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1084ui_story = slot1.localPosition
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
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

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. "A01a")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(StoryWordCfg[100011003].content)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(false)
			end

			if 0.1 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot7 = 4.4

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 1, (uv0.time_ - slot6) / slot7)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				uv0.fswtw_.percent = 1

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				slot9 = uv0.fswbg_.transform:Find("textbox/content")
				slot11 = slot9:GetComponent("RectTransform")
				slot9:GetComponent("Text").alignment = UnityEngine.TextAnchor.UpperLeft
				slot11.offsetMin = Vector2.New(450, -200)
				slot11.offsetMax = Vector2.New(-450, -200)
			end

			slot10 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.dialogCg_.alpha = 1

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("Textures/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)

				uv0.text_.text = uv0:FormatText(StoryWordCfg[100].content)
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = uv0:FormatText(StoryWordCfg[100].content)
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
	Play114 = function (slot0, slot1)
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
				uv0:Play115(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1084ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1084ui_story = slot1.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
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

			slot4 = uv0.actors_["1148ui_story"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1148ui_story = slot4.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot5) / slot6)
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

			if uv0.actors_["2330001"] == nil then
				slot8 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot8.transform:SetSiblingIndex(1)

				slot8.name = slot7
				slot9 = slot8:GetComponent(typeof(Image))
				slot9.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/Portrait/" .. slot7)

				slot9:SetNativeSize()

				slot8.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot7] = slot8
			end

			slot8 = uv0.actors_["2330001"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos2330001 = slot8.localPosition
				slot8.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("2330001", 2)
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2330001, Vector3.New(-350, -100, 0), (uv0.time_ - slot9) / slot10)
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(-350, -100, 0)
			end

			slot11 = uv0.actors_["2330001"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.var_.moveOldPos2330001 = slot11.localPosition
				slot11.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("2330001", 4)
			end

			slot13 = 0.999999999999

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2330001, Vector3.New(350, -350, 0), (uv0.time_ - slot12) / slot13)
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot11.localPosition = Vector3.New(350, -350, 0)
			end
		end
	end,
	Play115 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.633333333332

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
			if uv0.actors_["2330002"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["2330002"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos2330002 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2330002, Vector3.New(-500, 20, 0), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(-500, 20, 0)
			end

			slot5 = uv0.actors_["2330002"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				if slot5.parent.name == "2330002_mask" then
					uv0["2330002_mask"] = slot5.parent.gameObject:GetComponent("RectTransform")
				else
					slot8 = Object.Instantiate(uv0.canvasGo_.transform:Find("sprite_mask").gameObject)
					slot8.name = "2330002_mask"

					slot8.transform:SetParent(uv0.canvasGo_.transform)
					slot8.transform:SetSiblingIndex(1)

					slot8.transform.localPosition = Vector3.New(0, 0, 0)
					slot8.transform.localScale = Vector3.New(1, 1, 1)

					slot8:SetActive(true)
					slot5.transform:SetParent(slot8.transform)

					uv0["2330002_mask"] = slot8:GetComponent("RectTransform")
				end
			end

			slot7 = 2.6

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = uv0["2330002_mask"]
				slot8.localPosition = Vector3.New(-500, 20, 0)
				slot8.sizeDelta = Vector2.New(Mathf.Lerp(0, 200, (uv0.time_ - slot6) / slot7), 1080)
				slot5.transform.localPosition = Vector3.New(0, 0, 0)
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				uv0["2330002_mask"].sizeDelta = Vector2.New(200, 1080)
			end

			slot8 = uv0.actors_["2330002"].transform

			if 3.76666666666667 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				if slot8.parent.name == "2330002_mask" then
					uv0["2330002_mask"] = slot8.parent.gameObject:GetComponent("RectTransform")
				else
					slot11 = Object.Instantiate(uv0.canvasGo_.transform:Find("sprite_mask").gameObject)
					slot11.name = "2330002_mask"

					slot11.transform:SetParent(uv0.canvasGo_.transform)
					slot11.transform:SetSiblingIndex(1)

					slot11.transform.localPosition = Vector3.New(0, 0, 0)
					slot11.transform.localScale = Vector3.New(1, 1, 1)

					slot11:SetActive(true)
					slot8.transform:SetParent(slot11.transform)

					uv0["2330002_mask"] = slot11:GetComponent("RectTransform")
				end
			end

			slot10 = 1.86666666666667

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot11 = uv0["2330002_mask"]
				slot11.localPosition = Vector3.New(-500, 20, 0)
				slot11.sizeDelta = Vector2.New(Mathf.Lerp(200, 0, (uv0.time_ - slot9) / slot10), 1080)
				slot8.transform.localPosition = Vector3.New(0, 0, 0)
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0["2330002_mask"].sizeDelta = Vector2.New(0, 1080)
			end
		end
	end
}
