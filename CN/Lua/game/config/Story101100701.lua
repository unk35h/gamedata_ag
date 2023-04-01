return {
	Play110071001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.866666666666

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110071002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(StoryWordCfg[110071001].content)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(false)
			end

			if 1.81666666666667 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot3 = 1.98

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.180999994277954, (uv0.time_ - slot2) / slot3)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.fswtw_.percent = 0.180999994277954

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot4 = 1.8
			slot5 = 4.666

			if manager.audio:GetVoiceLength("story_v_out_110071", "110071001", "story_v_out_110071.awb") / 1000 > 0 and slot5 < slot6 and uv0.duration_ < slot6 + slot4 then
				slot5 = slot6
				uv0.duration_ = slot6 + slot4
			end

			if slot4 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110071", "110071001", "story_v_out_110071.awb")
			end

			slot8 = 0.333333333333333

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot10 = 2.45666666666667

			if 0.5 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "music", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot12 = 2

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot14 = Color.New(0, 0, 0)
				slot14.a = Mathf.Lerp(1, 0, (uv0.time_ - slot11) / slot12)
				uv0.mask_.color = slot14
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot13 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot13.a = 0
				uv0.mask_.color = slot13
			end
		end
	end,
	Play110071002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.433999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110071003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.02

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.275000005960464, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.275000005960464

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 2.434

			if manager.audio:GetVoiceLength("story_v_out_110071", "110071002", "story_v_out_110071.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110071", "110071002", "story_v_out_110071.awb")
			end
		end
	end,
	Play110071003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 9.087999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110071004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 2.7

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.521000027656555, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.521000027656555

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 9.088

			if manager.audio:GetVoiceLength("story_v_out_110071", "110071003", "story_v_out_110071.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110071", "110071003", "story_v_out_110071.awb")
			end
		end
	end,
	Play110071004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 9.111999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110071005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 2.58

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.757000029087067, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.757000029087067

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 9.112

			if manager.audio:GetVoiceLength("story_v_out_110071", "110071004", "story_v_out_110071.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110071", "110071004", "story_v_out_110071.awb")
			end
		end
	end,
	Play110071005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.151999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110071006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 2.16

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.952000021934509, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.952000021934509

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 6.152

			if manager.audio:GetVoiceLength("story_v_out_110071", "110071005", "story_v_out_110071.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110071", "110071005", "story_v_out_110071.awb")
			end
		end
	end,
	Play110071006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.057999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110071007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 0.54

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
			slot4 = 2.058

			if manager.audio:GetVoiceLength("story_v_out_110071", "110071006", "story_v_out_110071.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110071", "110071006", "story_v_out_110071.awb")
			end
		end
	end,
	Play110071007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 10.505999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110071008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(StoryWordCfg[110071007].content)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(false)
			end

			if 0.0166666666666667 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot3 = 3

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.328000009059906, (uv0.time_ - slot2) / slot3)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.fswtw_.percent = 0.328000009059906

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot4 = 0
			slot5 = 10.506

			if manager.audio:GetVoiceLength("story_v_out_110071", "110071007", "story_v_out_110071.awb") / 1000 > 0 and slot5 < slot6 and uv0.duration_ < slot6 + slot4 then
				slot5 = slot6
				uv0.duration_ = slot6 + slot4
			end

			if slot4 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110071", "110071007", "story_v_out_110071.awb")
			end
		end
	end,
	Play110071008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.732999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110071009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.08

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.449999988079071, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.449999988079071

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 3.733

			if manager.audio:GetVoiceLength("story_v_out_110071", "110071008", "story_v_out_110071.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110071", "110071008", "story_v_out_110071.awb")
			end
		end
	end,
	Play110071009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.545999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110071010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 2.1

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
			slot4 = 5.546

			if manager.audio:GetVoiceLength("story_v_out_110071", "110071009", "story_v_out_110071.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110071", "110071009", "story_v_out_110071.awb")
			end
		end
	end,
	Play110071010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.335999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110071011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 0.9

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.774999976158142, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.774999976158142

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 2.336

			if manager.audio:GetVoiceLength("story_v_out_110071", "110071010", "story_v_out_110071.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110071", "110071010", "story_v_out_110071.awb")
			end
		end
	end,
	Play110071011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.832999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110071012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.44

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.936999976634979, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.936999976634979

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 4.833

			if manager.audio:GetVoiceLength("story_v_out_110071", "110071011", "story_v_out_110071.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110071", "110071011", "story_v_out_110071.awb")
			end
		end
	end,
	Play110071012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 1.327999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110071013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 0.6

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
			slot4 = 1.328

			if manager.audio:GetVoiceLength("story_v_out_110071", "110071012", "story_v_out_110071.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110071", "110071012", "story_v_out_110071.awb")
			end
		end
	end,
	Play110071013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.093999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110071014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(StoryWordCfg[110071013].content)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(false)
			end

			if 0.0166666666666667 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot3 = 1.08

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.150000005960464, (uv0.time_ - slot2) / slot3)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.fswtw_.percent = 0.150000005960464

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot4 = 0
			slot5 = 2.094

			if manager.audio:GetVoiceLength("story_v_out_110071", "110071013", "story_v_out_110071.awb") / 1000 > 0 and slot5 < slot6 and uv0.duration_ < slot6 + slot4 then
				slot5 = slot6
				uv0.duration_ = slot6 + slot4
			end

			if slot4 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110071", "110071013", "story_v_out_110071.awb")
			end
		end
	end,
	Play110071014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.047999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110071015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.62

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.375, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.375

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 6.048

			if manager.audio:GetVoiceLength("story_v_out_110071", "110071014", "story_v_out_110071.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110071", "110071014", "story_v_out_110071.awb")
			end
		end
	end,
	Play110071015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 13.535999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110071016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 3.18

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.813000023365021, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.813000023365021

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 13.536

			if manager.audio:GetVoiceLength("story_v_out_110071", "110071015", "story_v_out_110071.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110071", "110071015", "story_v_out_110071.awb")
			end
		end
	end,
	Play110071016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.511999999999

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

			slot2 = 1.32

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
			slot4 = 8.512

			if manager.audio:GetVoiceLength("story_v_out_110071", "110071016", "story_v_out_110071.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110071", "110071016", "story_v_out_110071.awb")
			end
		end
	end
}
