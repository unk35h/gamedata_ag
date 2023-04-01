slot0 = class("VolumeMusicSettingView", ReduxView)
slot1 = 5
slot2 = 1
slot3 = 50
slot4 = -50

function slot0.UIName(slot0)
	return "UI/VolumeIIIDownUI/AthenaMusicGame/VolumeIIIDownMusicSettingUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.m_speedSlider.minValue = uv0
	slot0.m_speedSlider.maxValue = uv1
	slot0.m_judgeSlider.minValue = uv2
	slot0.m_judgeSlider.maxValue = uv3
	slot0.movieController = ControllerUtil.GetController(slot0.m_movieBtn.transform, "select")
	slot0.soundController = ControllerUtil.GetController(slot0.m_soundBtn.transform, "select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_cancelBtn, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.m_confirmBtn, nil, function ()
		MusicData:SetSpeedValue(uv0.speedNum)
		MusicData:SetJudgeValue(uv0.judgeNum)
		MusicData:SetShoMovie(uv0.showMovie)
		MusicData:SetPlayKeyEffectSound(uv0.playSound)
		SDKTools.SendMessageToSDK("activity_music_setting", {
			activity_id = ActivityConst.VOLUME_MUSIC,
			speed = tostring(uv0.speedNum),
			time = tostring(uv0.judgeNum)
		})
		uv0:Back()
	end)

	slot1 = slot0.m_speedSlider.onValueChanged

	slot1:AddListener(function ()
		uv0.speedNum = tonumber(string.format("%.1f", uv0.m_speedSlider.value))
		uv0.m_speedLab.text = uv0.speedNum
	end)
	slot0:AddPressingByTimeListener(slot0.m_speedAddBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv0.speedNum < uv1 then
			uv0.speedNum = uv0.speedNum + 0.1
			uv0.speedNum = math.min(uv0.speedNum, uv1)
			uv0.m_speedSlider.value = uv0.speedNum
			uv0.m_speedLab.text = uv0.speedNum

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.m_speedDelBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv1 < uv0.speedNum then
			uv0.speedNum = uv0.speedNum - 0.1
			uv0.speedNum = math.max(uv0.speedNum, uv1)
			uv0.m_speedSlider.value = uv0.speedNum
			uv0.m_speedLab.text = uv0.speedNum

			return true
		end

		return false
	end)

	slot1 = slot0.m_judgeSlider.onValueChanged

	slot1:AddListener(function ()
		uv0.judgeNum = tonumber(string.format("%.0f", uv0.m_judgeSlider.value))
		uv0.m_judgeLab.text = uv0.judgeNum
	end)
	slot0:AddPressingByTimeListener(slot0.m_judgeAddBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv0.judgeNum < uv1 then
			uv0.judgeNum = uv0.judgeNum + 1
			uv0.judgeNum = math.min(uv0.judgeNum, uv1)
			uv0.m_judgeSlider.value = uv0.judgeNum
			uv0.m_judgeLab.text = uv0.judgeNum

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.m_judgeDelBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv1 < uv0.judgeNum then
			uv0.judgeNum = uv0.judgeNum - 1
			uv0.judgeNum = math.max(uv0.judgeNum, uv1)
			uv0.m_judgeSlider.value = uv0.judgeNum
			uv0.m_judgeLab.text = uv0.judgeNum

			return true
		end

		return false
	end)
	slot0:AddBtnListener(slot0.m_movieBtn, nil, function ()
		uv0.showMovie = not uv0.showMovie

		uv0.movieController:SetSelectedIndex(uv0.showMovie and 1 or 0)
	end)
	slot0:AddBtnListener(slot0.m_soundBtn, nil, function ()
		uv0.playSound = not uv0.playSound

		uv0.soundController:SetSelectedIndex(uv0.playSound and 1 or 0)
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0.speedNum = MusicData:GetSpeedValue()
	slot0.m_speedSlider.value = slot0.speedNum
	slot0.m_speedLab.text = slot0.speedNum
	slot0.judgeNum = MusicData:GetJudgeValue()
	slot0.m_judgeSlider.value = slot0.judgeNum
	slot0.m_judgeLab.text = slot0.judgeNum
	slot0.showMovie = MusicData:GetShowMovie()

	slot0.movieController:SetSelectedIndex(slot0.showMovie and 1 or 0)

	slot0.playSound = MusicData:GetPlayKeyEffectSound()

	slot0.soundController:SetSelectedIndex(slot0.playSound and 1 or 0)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
