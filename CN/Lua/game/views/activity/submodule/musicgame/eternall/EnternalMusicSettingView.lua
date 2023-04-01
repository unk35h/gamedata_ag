slot0 = class("EnternalMusicSettingView", ReduxView)
slot1 = 5
slot2 = 1
slot3 = 50
slot4 = -50
slot5 = 50
slot6 = -50
slot7 = 100
slot8 = 0

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng1stUI/Music/XH1stMusicSetUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.musicSetGo = Object.Instantiate(Asset.Load("Music/MusicSet"))
	slot0.musicSetController = slot0.musicSetGo:GetComponent("MusicSetController")

	manager.ui:SetMainCamera("musicSet")

	slot0.speedNum = 0
	slot0.judgeNum = 0
	slot0.screanNum = 0
	slot0.showMovie = true
	slot0.test = true
	slot0.ratingController = ControllerUtil.GetController(slot0.transform_, "rating")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.m_speedSlider.minValue = uv0
	slot0.m_speedSlider.maxValue = uv1
	slot0.m_judgeSlider.minValue = uv2
	slot0.m_judgeSlider.maxValue = uv3
	slot0.m_screanSlider.minValue = uv4
	slot0.m_screanSlider.maxValue = uv5
	slot0.m_volumeSlider.minValue = uv6
	slot0.m_volumeSlider.maxValue = uv7
	slot0.testController = ControllerUtil.GetController(slot0.transform_, "test")
	slot0.vedioController = ControllerUtil.GetController(slot0.transform_, "vedio")
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.m_speedSlider.onValueChanged

	slot1:AddListener(function ()
		uv0.speedNum = tonumber(string.format("%.1f", uv0.m_speedSlider.value))
		uv0.m_speedLab.text = uv0.speedNum

		uv0:ChangeSpeed()
	end)
	slot0:AddPressingByTimeListener(slot0.m_speedAddBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv0.speedNum < uv1 then
			uv0.speedNum = uv0.speedNum + 0.1
			uv0.speedNum = math.min(uv0.speedNum, uv1)
			uv0.m_speedSlider.value = uv0.speedNum
			uv0.m_speedLab.text = uv0.speedNum

			uv0:ChangeSpeed()

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

			uv0:ChangeSpeed()

			return true
		end

		return false
	end)

	slot1 = slot0.m_judgeSlider.onValueChanged

	slot1:AddListener(function ()
		uv0.judgeNum = tonumber(string.format("%.0f", uv0.m_judgeSlider.value))
		uv0.m_judgeLab.text = uv0.judgeNum

		uv0:ChangeJudge()
	end)
	slot0:AddPressingByTimeListener(slot0.m_judgeAddBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv0.judgeNum < uv1 then
			uv0.judgeNum = uv0.judgeNum + 1
			uv0.judgeNum = math.min(uv0.judgeNum, uv1)
			uv0.m_judgeSlider.value = uv0.judgeNum
			uv0.m_judgeLab.text = uv0.judgeNum

			uv0:ChangeJudge()

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

			uv0:ChangeJudge()

			return true
		end

		return false
	end)

	slot1 = slot0.m_screanSlider.onValueChanged

	slot1:AddListener(function ()
		uv0.screanNum = tonumber(string.format("%.0f", uv0.m_screanSlider.value))
		uv0.m_screanLab.text = uv0.screanNum

		uv0:ChangeScreen()
	end)
	slot0:AddPressingByTimeListener(slot0.m_screanAddBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv0.screanNum < uv1 then
			uv0.screanNum = uv0.screanNum + 1
			uv0.screanNum = math.min(uv0.screanNum, uv1)
			uv0.m_screanSlider.value = uv0.screanNum
			uv0.m_screanLab.text = uv0.screanNum

			uv0:ChangeScreen()

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.m_screanDelBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv1 < uv0.screanNum then
			uv0.screanNum = uv0.screanNum - 1
			uv0.screanNum = math.max(uv0.screanNum, uv1)
			uv0.m_screanSlider.value = uv0.screanNum
			uv0.m_screanLab.text = uv0.screanNum

			uv0:ChangeScreen()

			return true
		end

		return false
	end)

	slot1 = slot0.m_volumeSlider.onValueChanged

	slot1:AddListener(function ()
		uv0.volumeNum = tonumber(string.format("%.0f", uv0.m_volumeSlider.value))
		uv0.m_volumeLab.text = uv0.volumeNum

		uv0:ChangeVolume()
	end)
	slot0:AddPressingByTimeListener(slot0.m_volumeAddBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv0.volumeNum < uv1 then
			uv0.volumeNum = uv0.volumeNum + 1
			uv0.volumeNum = math.min(uv0.volumeNum, uv1)
			uv0.m_volumeSlider.value = uv0.volumeNum
			uv0.m_volumeLab.text = uv0.volumeNum

			uv0:ChangeVolume()

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.m_volumeDelBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv1 < uv0.volumeNum then
			uv0.volumeNum = uv0.volumeNum - 1
			uv0.volumeNum = math.max(uv0.volumeNum, uv1)
			uv0.m_volumeSlider.value = uv0.volumeNum
			uv0.m_volumeLab.text = uv0.volumeNum

			uv0:ChangeVolume()

			return true
		end

		return false
	end)
	slot0:AddBtnListener(slot0.m_testOn, nil, function ()
		uv0:ChangeTestBool(true)
	end)
	slot0:AddBtnListener(slot0.m_testOff, nil, function ()
		uv0:ChangeTestBool(false)
	end)
	slot0:AddBtnListener(slot0.m_vedioOn, nil, function ()
		uv0:ChangeVedioBool(true)
	end)
	slot0:AddBtnListener(slot0.m_vedioOff, nil, function ()
		uv0:ChangeVedioBool(false)
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera("musicSet")
	slot0.ratingController:SetSelectedIndex(0)
	slot0:InitBackScene()

	slot0.speedNum = MusicData:GetSpeedValue()
	slot0.m_speedSlider.value = slot0.speedNum
	slot0.m_speedLab.text = slot0.speedNum

	slot0:ChangeSpeed()

	slot0.judgeNum = MusicData:GetJudgeValue()
	slot0.m_judgeSlider.value = slot0.judgeNum
	slot0.m_judgeLab.text = slot0.judgeNum

	slot0:ChangeJudge()

	slot0.screanNum = MusicData:GetScreanValue()
	slot0.m_screanSlider.value = slot0.screanNum
	slot0.m_screanLab.text = slot0.screanNum

	slot0:ChangeScreen()

	slot0.volumeNum = MusicData:GetVolumeValue()
	slot0.m_volumeSlider.value = slot0.volumeNum
	slot0.m_volumeLab.text = slot0.volumeNum

	slot0:ChangeVolume()

	slot0.showMovie = MusicData:GetShowMovie()

	slot0.vedioController:SetSelectedIndex(slot0.showMovie and 1 or 0)

	slot0.test = slot0.musicSetController.autoClick

	slot0.testController:SetSelectedIndex(slot0.test and 1 or 0)
	SetActive(slot0.musicSetGo, true)

	slot0.raycaster = manager.ui.mainCamera:AddComponent(typeof(PhysicsRaycaster))

	slot0.musicSetController:Begain()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.raycaster then
		Object.Destroy(slot0.raycaster_)
	end

	slot0.musicSetController:End()
	SetActive(slot0.musicSetGo, false)
	MusicData:SetSpeedValue(slot0.speedNum)
	MusicData:SetJudgeValue(slot0.judgeNum)
	MusicData:SetScreanValue(slot0.screanNum)
	MusicData:SetVolumeValue(slot0.volumeNum)
	MusicData:SetShoMovie(slot0.showMovie)
	SDKTools.SendMessageToSDK("activity_music_setting", {
		activity_id = ActivityConst.VOLUME_MUSIC,
		speed = tostring(slot0.speedNum),
		time = tostring(slot0.judgeNum)
	})

	if slot0.backGround_ then
		manager.resourcePool:DestroyOrReturn(slot0.backGround_, ASSET_TYPE.SCENE)
	end
end

function slot0.ChangeSpeed(slot0)
	slot4 = 350
	slot0.musicSetController.stayTime = slot4 + (5 - slot0.speedNum) * (1500 - slot4) / 4
end

function slot0.ChangeJudge(slot0)
	slot1 = slot0.judgeNum
	slot2 = math.abs(slot1) / 50 * 300

	if slot1 < 0 then
		slot2 = -1 * slot2
	end

	MusicGame.MusicSetController.latency = slot2
end

function slot0.ChangeScreen(slot0)
	slot1 = slot0.screanNum
	slot2 = math.abs(slot1) / 50 * 300

	if slot1 < 0 then
		slot2 = -1 * slot2
	end

	MusicGame.MusicSetController.judgeLatency = slot2
end

function slot0.ChangeVolume(slot0)
	manager.audio:SetEffectAisacControl("musicgame_hitsound_volume", math.abs(slot0.volumeNum) / 100)
end

function slot0.ChangeTestBool(slot0, slot1)
	if slot0.test == slot1 then
		return
	end

	slot0.test = slot1

	slot0.testController:SetSelectedIndex(slot0.test and 1 or 0)

	slot0.musicSetController.autoClick = slot1
end

function slot0.ChangeVedioBool(slot0, slot1)
	if slot1 == slot0.showMovie then
		return
	end

	slot0.showMovie = slot1

	slot0.vedioController:SetSelectedIndex(slot0.showMovie and 1 or 0)
end

function slot0.InitBackScene(slot0)
	slot0.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	slot0.backGroundTrs_ = slot0.backGround_.transform

	slot0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	slot0.backGroundTrs_.localPosition = Vector3(0, 0, 100)
	slot0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	slot0.backGroundTrs_.localScale = Vector3(11, 11, 1)
	slot0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/VersionUI/XuHeng1stUI/XuHeng1st_bg_00122")
end

function slot0.OnMusicSetNodeHit(slot0, slot1, slot2)
	SetActive(slot0.m_effect, false)
	SetActive(slot0.m_effect, true)

	if slot1 ~= MusicConst.MusicNodeHitRating.Miss and (MusicConst.MusicNodeHitType.Short == slot2 or MusicConst.MusicNodeHitType.Long == slot2) then
		manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_musicgame_hitsound", "")
	end

	if MusicConst.MusicNodeHitRating.PerfectPlus == slot1 then
		slot0.ratingController:SetSelectedIndex(4)
	elseif MusicConst.MusicNodeHitRating.Perfect == slot1 then
		slot0.ratingController:SetSelectedIndex(3)
	elseif MusicConst.MusicNodeHitRating.Good == slot1 then
		slot0.ratingController:SetSelectedIndex(2)
	else
		slot0.ratingController:SetSelectedIndex(1)
	end
end

return slot0
