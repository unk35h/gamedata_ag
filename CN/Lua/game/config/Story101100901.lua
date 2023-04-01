return {
	Play110091001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.366666666666

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(StoryWordCfg[110091001].content)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(false)
			end

			if 1.8 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot3 = 1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.063000001013279, (uv0.time_ - slot2) / slot3)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.fswtw_.percent = 0.063000001013279

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot5 = 0.333333333333333

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot7 = 0.516666666666667

			if 0.5 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0:AudioAction("play", "music", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot9 = 2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot11 = Color.New(0, 0, 0)
				slot11.a = Mathf.Lerp(1, 0, (uv0.time_ - slot8) / slot9)
				uv0.mask_.color = slot11
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot10 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot10.a = 0
				uv0.mask_.color = slot10
			end
		end
	end,
	Play110091002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 9.737999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 2.52

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.347000002861023, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.347000002861023

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 9.738

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091002", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091002", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.783999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.92

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.565999984741211, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.565999984741211

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 6.784

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091003", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091003", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.887999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 0.84

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.663999974727631, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.663999974727631

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 1.888

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091004", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091004", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.167999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.98

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.883000016212463, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.883000016212463

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 6.168

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091005", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091005", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.108999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.02

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
			slot4 = 3.109

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091006", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091006", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.905999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(StoryWordCfg[110091007].content)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(false)
			end

			if 0.0166666666666667 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot3 = 1.26

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.150999993085861, (uv0.time_ - slot2) / slot3)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.fswtw_.percent = 0.150999993085861

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot4 = 0
			slot5 = 4.906

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091007", "story_v_out_110091.awb") / 1000 > 0 and slot5 < slot6 and uv0.duration_ < slot6 + slot4 then
				slot5 = slot6
				uv0.duration_ = slot6 + slot4
			end

			if slot4 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091007", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.892999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 0.6

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.224000006914139, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.224000006914139

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 1.893

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091008", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091008", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 10.287999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 2.7

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.545000016689301, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.545000016689301

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 10.288

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091009", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091009", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.489999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 2.04

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.787000000476837, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.787000000476837

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 7.49

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091010", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091010", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.756999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.08

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.91100001335144, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.91100001335144

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 4.757

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091011", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091011", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.828999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 0.72

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
			slot4 = 1.829

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091012", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091012", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.481999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0.0166666666666667 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 2.28

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.257999986410141, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.257999986410141

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(StoryWordCfg[110091013].content)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(false)
			end

			slot4 = 0
			slot5 = 6.482

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091013", "story_v_out_110091.awb") / 1000 > 0 and slot5 < slot6 and uv0.duration_ < slot6 + slot4 then
				slot5 = slot6
				uv0.duration_ = slot6 + slot4
			end

			if slot4 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091013", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.988999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.5

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.426999986171722, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.426999986171722

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 3.989

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091014", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091014", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.657999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.2

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.564000010490417, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.564000010490417

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 3.658

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091015", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091015", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.343999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 0.6

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.63400000333786, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.63400000333786

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 1.344

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091016", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091016", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.391999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 2.34

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.896000027656555, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.896000027656555

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 7.392

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091017", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091017", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.105999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 0.9

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
			slot4 = 3.106

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091018", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091018", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.145999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(StoryWordCfg[110091019].content)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(false)
			end

			if 0.0166666666666667 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot3 = 0.78

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.130999997258186, (uv0.time_ - slot2) / slot3)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.fswtw_.percent = 0.130999997258186

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot4 = 0
			slot5 = 3.146

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091019", "story_v_out_110091.awb") / 1000 > 0 and slot5 < slot6 and uv0.duration_ < slot6 + slot4 then
				slot5 = slot6
				uv0.duration_ = slot6 + slot4
			end

			if slot4 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091019", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 10.836999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 2.52

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.544000029563904, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.544000029563904

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 10.837

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091020", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091020", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.361999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110091022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 0.78

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.675000011920929, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.675000011920929

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 4.362

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091021", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091021", "story_v_out_110091.awb")
			end
		end
	end,
	Play110091022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.249999999999

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
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 2.04

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
			slot4 = 8.25

			if manager.audio:GetVoiceLength("story_v_out_110091", "110091022", "story_v_out_110091.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110091", "110091022", "story_v_out_110091.awb")
			end
		end
	end
}
