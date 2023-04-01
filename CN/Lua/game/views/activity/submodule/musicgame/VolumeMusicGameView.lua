slot0 = class("VolumeMusicGameView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIDownUI/AthenaMusicGame/VolumeIIIDownMusicGameUI"
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

	slot0.ratingController = ControllerUtil.GetController(slot0.transform_, "rating")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_pauseBtn, nil, function ()
		if MusicLuaBridge.GetCurrentState() == "PlayState" or slot0 == "PlayPreparationState" then
			MusicLuaBridge.PauseMusicGame()
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.m_name.text = ActivityMusicCfg[MusicData:GetGameId()].name

	if not MusicData:GetShowMovie() then
		slot0:InitBackScene()
	end

	if slot2.difficult == 2 then
		slot0.m_difficutLab.text = GetTips("ACTIVITY_MUSIC_LEVEL_2")
	elseif slot2.difficult == 9 then
		slot0.m_difficutLab.text = GetTips("ACTIVITY_MUSIC_LEVEL_3")
	else
		slot0.m_difficutLab.text = GetTips("ACTIVITY_MUSIC_LEVEL_1")
	end

	slot0.ratingController:SetSelectedIndex(0)

	slot0.playEffect = MusicData:GetPlayKeyEffectSound()
end

function slot0.OnExit(slot0)
	manager.ui:ResetMainCamera()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.UpdateScore(slot0)
	slot0.m_scoreLab.text = MusicData:GetGameScore()
end

function slot0.OnMusicInitPlay(slot0)
	slot0:UpdateScore()

	slot0.m_comboLab.text = ""

	slot0.ratingController:SetSelectedIndex(0)
end

function slot0.OnMusicNodeHit(slot0, slot1, slot2)
	SetActive(slot0.m_effect, false)
	SetActive(slot0.m_effect, true)
	slot0:UpdateScore()

	if MusicConst.MusicNodeHitRating.PerfectPlus == slot1 then
		slot0.ratingController:SetSelectedIndex(3)
	elseif MusicConst.MusicNodeHitRating.Perfect == slot1 then
		slot0.ratingController:SetSelectedIndex(3)
	elseif MusicConst.MusicNodeHitRating.Good == slot1 then
		slot0.ratingController:SetSelectedIndex(2)
	else
		slot0.ratingController:SetSelectedIndex(1)
	end

	slot0.m_comboLab.text = MusicData:GetComboHit()

	if slot0.playEffect and slot1 ~= MusicConst.MusicNodeHitRating.Miss and (MusicConst.MusicNodeHitType.Short == slot2 or MusicConst.MusicNodeHitType.Long == slot2) then
		manager.audio:PlayEffect("minigame_activity_1_4", "minigame_activity_1_4_tambourine", "")
	end
end

function slot0.InitBackScene(slot0)
	slot0.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	slot0.backGroundTrs_ = slot0.backGround_.transform

	slot0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	slot0.backGroundTrs_.localPosition = Vector3(0, 0, 100)
	slot0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	slot0.backGroundTrs_.localScale = Vector3(11, 11, 1)
	slot0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/VolumeIIIDownUI/VolumeDown_bg_00050")
end

return slot0
