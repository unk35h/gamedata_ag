return {
	Play110061001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 17.499999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110061002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(StoryWordCfg[110061001].content)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(false)
			end

			if 1.8 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot3 = 3

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.244000002741814, (uv0.time_ - slot2) / slot3)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.fswtw_.percent = 0.244000002741814

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot4 = 1.8
			slot5 = 12.624

			if manager.audio:GetVoiceLength("story_v_out_110061", "110061001", "story_v_out_110061.awb") / 1000 > 0 and slot5 < slot6 and uv0.duration_ < slot6 + slot4 then
				slot5 = slot6
				uv0.duration_ = slot6 + slot4
			end

			if slot4 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110061", "110061001", "story_v_out_110061.awb")
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
	Play110061002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 5.340999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110061003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.62

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.377999991178513, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.377999991178513

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 5.341

			if manager.audio:GetVoiceLength("story_v_out_110061", "110061002", "story_v_out_110061.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110061", "110061002", "story_v_out_110061.awb")
			end
		end
	end,
	Play110061003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.572999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110061004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.26

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.477999985218048, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.477999985218048

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 4.573

			if manager.audio:GetVoiceLength("story_v_out_110061", "110061003", "story_v_out_110061.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110061", "110061003", "story_v_out_110061.awb")
			end
		end
	end,
	Play110061004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 4.692999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110061005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.5

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.600000023841858, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.600000023841858

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 4.693

			if manager.audio:GetVoiceLength("story_v_out_110061", "110061004", "story_v_out_110061.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110061", "110061004", "story_v_out_110061.awb")
			end
		end
	end,
	Play110061005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 10.865999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110061006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 2.88

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.834999978542328, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.834999978542328

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 10.866

			if manager.audio:GetVoiceLength("story_v_out_110061", "110061005", "story_v_out_110061.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110061", "110061005", "story_v_out_110061.awb")
			end
		end
	end,
	Play110061006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.162999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110061007(uv1)
			end
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
			slot4 = 6.163

			if manager.audio:GetVoiceLength("story_v_out_110061", "110061006", "story_v_out_110061.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110061", "110061006", "story_v_out_110061.awb")
			end
		end
	end,
	Play110061007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 7.299999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110061008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(StoryWordCfg[110061007].content)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(false)
			end

			if 1.8 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot3 = 1.32

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.136999994516373, (uv0.time_ - slot2) / slot3)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.fswtw_.percent = 0.136999994516373

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot4 = 1.8
			slot5 = 5.144

			if manager.audio:GetVoiceLength("story_v_out_110061", "110061007", "story_v_out_110061.awb") / 1000 > 0 and slot5 < slot6 and uv0.duration_ < slot6 + slot4 then
				slot5 = slot6
				uv0.duration_ = slot6 + slot4
			end

			if slot4 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110061", "110061007", "story_v_out_110061.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot8 = 2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot10 = Color.New(0, 0, 0)
				slot10.a = Mathf.Lerp(1, 0, (uv0.time_ - slot7) / slot8)
				uv0.mask_.color = slot10
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot9 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot9.a = 0
				uv0.mask_.color = slot9
			end
		end
	end,
	Play110061008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.324999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110061009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.86

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.33500000834465, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.33500000834465

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 8.325

			if manager.audio:GetVoiceLength("story_v_out_110061", "110061008", "story_v_out_110061.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110061", "110061008", "story_v_out_110061.awb")
			end
		end
	end,
	Play110061009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 8.052999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110061010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 2.22

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.568000018596649, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.568000018596649

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 8.053

			if manager.audio:GetVoiceLength("story_v_out_110061", "110061009", "story_v_out_110061.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110061", "110061009", "story_v_out_110061.awb")
			end
		end
	end,
	Play110061010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 6.287999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110061011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.62

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.740000009536743, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.740000009536743

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 6.288

			if manager.audio:GetVoiceLength("story_v_out_110061", "110061010", "story_v_out_110061.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110061", "110061010", "story_v_out_110061.awb")
			end
		end
	end,
	Play110061011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 0.499999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110061012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 0.18

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.762000024318695, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.762000024318695

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play110061012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 2.426999999999

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110061013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 1.02

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, 0.867999970912933, (uv0.time_ - slot1) / slot2)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.fswtw_.percent = 0.867999970912933

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)
			end

			slot3 = 0
			slot4 = 2.427

			if manager.audio:GetVoiceLength("story_v_out_110061", "110061012", "story_v_out_110061.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110061", "110061012", "story_v_out_110061.awb")
			end
		end
	end,
	Play110061013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.state_ = "playing"
		slot1.duration_ = 3.324999999999

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

			slot2 = 1.26

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
			slot4 = 3.325

			if manager.audio:GetVoiceLength("story_v_out_110061", "110061013", "story_v_out_110061.awb") / 1000 > 0 and slot4 < slot5 and uv0.duration_ < slot5 + slot3 then
				slot4 = slot5
				uv0.duration_ = slot5 + slot3
			end

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110061", "110061013", "story_v_out_110061.awb")
			end
		end
	end
}
