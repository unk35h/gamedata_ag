slot0 = class("ObtainHeroMovieView", ObtainBaseView)

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.showSkipHandler = slot3
	slot0.refreshShareHandler_ = slot4
end

function slot0.Init(slot0)
	slot0:InitUI()
	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.criMovie_ = slot0.movie_:GetComponent("CriManaMovieControllerForUI")
	slot0.criplayer_ = slot0.criMovie_.player
	slot0.cirMovieLoop_ = slot0.movieLoop_:GetComponent("CriManaMovieControllerForUI")
	slot0.criplayerLoop_ = slot0.cirMovieLoop_.player
	slot0.starController_ = ControllerUtil.GetController(slot0.transform_, "star")
	slot0.SimplePlayer_ = slot0:FindCom("VoiceOfObtainHeroSimplePlayer", "CriwareAudio")
	slot0.commonItem_ = CommonItem.New(slot0.itemGo_)
	slot0.startDirectorStopCallBack = handler(slot0, slot0.StartDirectorStopCallBack)
	slot0.playableDirectorStart_.stopped = slot0.playableDirectorStart_.stopped + slot0.startDirectorStopCallBack

	slot0.criplayer_:SetMaxPictureDataSize(300000)

	slot0._timer = FrameTimer.New(handler(slot0, slot0.MovieProcess), 1, -1)
end

function slot0.Show(slot0, slot1)
	slot0.item = slot1

	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, true)
	end

	slot2 = ObtainHeroMovieCfg[slot1.id]
	slot0.start_path = slot2.start_path
	slot0.loop_path = slot2.loop_path
	slot0.start_movie_frames = slot2.start_movie_frames
	slot0.isPlayMovie = false
	slot0.isPlayMovieEnd = false

	slot0.criMovie_:Stop()

	slot0.movieTrs_.localPosition = Vector2(9999, 9999)

	slot0.cirMovieLoop_:Stop()

	slot0.movieLoopTrs_.localPosition = Vector2(9999, 9999)

	slot0.criplayer_:SetFile(nil, slot0.start_path, CriMana.Player.SetMode.New)
	slot0.criplayer_:SetFile(nil, slot0.loop_path, CriMana.Player.SetMode.AppendRepeatedly)
	slot0.criplayerLoop_:SetFile(nil, slot0.loop_path)

	slot3 = manager.audio:GetMusicVolume()

	slot0.criplayer_:SetVolume(slot3)
	slot0.criplayerLoop_:SetVolume(slot3)
	slot0:SetVideoTrack(slot0.criplayer_, slot0.start_path)
	slot0:SetVideoTrack(slot0.criplayerLoop_, slot0.loop_path)
	slot0:SetInfo(slot1)
	slot0.playableDirectorStart_:Evaluate()
	slot0.playableDirectorStart_:Play()
	SetActive(slot0.m_endGo, false)
end

function slot0.SetVideoTrack(slot0, slot1, slot2)
	slot3 = manager.audio:GetLocalizationFlag()
	slot4 = 0
	slot5 = nil
	slot9 = "[^/]+$"

	for slot9 in string.gmatch(slot2, slot9) do
		slot5 = slot9
	end

	if VideoTrackCfg[slot5] and slot6.has_tracks == 1 then
		if slot3 == "zh" then
			slot4 = 0
		elseif slot3 == "ja" then
			slot4 = 1
		elseif slot3 == "en" then
			slot4 = 2
		elseif slot3 == "kr" then
			slot4 = 3
		end
	end

	slot1:SetAudioTrack(slot4)
	slot1:SetSubtitleChannel(slot4)
end

function slot0.Hide(slot0)
	slot0._timer:Stop()
	uv0.super.Hide(slot0)
end

function slot0.PlayMovie(slot0, slot1)
	if slot0.isPlayMovie then
		if slot1 then
			slot0.isPlayMovieEnd = true

			slot0.criMovie_:Stop()

			slot0.movieTrs_.localPosition = Vector2(9999, 9999)

			slot0.cirMovieLoop_:Play()

			slot0.movieLoopTrs_.localPosition = Vector2(0, 0)
		end

		return
	end

	slot0.isPlayMovie = true

	if slot1 then
		slot0.cirMovieLoop_:Play()

		slot0.movieLoopTrs_.localPosition = Vector2(0, 0)
	else
		slot0.criMovie_:Play()

		slot0.movieTrs_.localPosition = Vector2(0, 0)
	end

	slot0._timer:Start()
end

function slot0.MovieProcess(slot0)
	slot2 = slot0.criplayer_:GetDisplayedFrameNo()

	if tostring(slot0.criplayer_.status) == "Playing" and slot0.start_movie_frames < slot2 then
		SetActive(slot0.m_endGo, true)

		if slot0.item.switchHeroReward then
			slot0.playableDirectorEndSplinter_:Evaluate()
			slot0.playableDirectorEndSplinter_:Play()
		else
			slot0.playableDirectorEnd_:Evaluate()
			slot0.playableDirectorEnd_:Play()
		end

		slot0._timer:Stop()

		slot0.isPlayMovieEnd = true

		saveData(DrawConst.WATCH_TAG, tostring(slot0.item.id), true)

		if slot0.showSkipHandler then
			slot0.showSkipHandler()
		end

		if slot0.refreshShareHandler_ then
			slot0.refreshShareHandler_()
		end
	end
end

function slot0.OnClick(slot0)
	slot1 = slot0.item.switchHeroReward and slot0.playableDirectorEndSplinter_ or slot0.playableDirectorEnd_

	if slot0.isPlayMovieEnd and (slot1.time == 0 or slot0:GetTimeLineEndTime() <= slot1.time) then
		return true
	end

	if not (getData(DrawConst.WATCH_TAG, tostring(slot0.item.id)) or false) then
		return false
	end

	if not slot0.isPlayMovieEnd then
		slot0:PlayMovie(true)
	end

	slot0.isPlayMovieEnd = true

	slot0._timer:Stop()
	SetActive(slot0.m_endGo, true)

	slot0.playableDirectorStart_.time = slot0.playableDirectorStart_.duration
	slot1.time = slot0:GetTimeLineEndTime()

	slot1:Play()

	if slot0.showSkipHandler then
		slot0.showSkipHandler()
	end

	return false
end

function slot0.Skip2End(slot0)
	slot1 = slot0.item.switchHeroReward and slot0.playableDirectorEndSplinter_ or slot0.playableDirectorEnd_

	if not slot0.isPlayMovieEnd then
		slot0:PlayMovie(true)
	end

	slot0.isPlayMovieEnd = true

	slot0._timer:Stop()
	SetActive(slot0.m_endGo, true)

	slot0.playableDirectorStart_.time = slot0.playableDirectorStart_.duration
	slot1.time = 1.5

	slot1:Play()

	if slot0.showSkipHandler then
		slot0.showSkipHandler()
	end
end

function slot0.GetTimeLineEndTime(slot0)
	if not slot0.item.switchHeroReward then
		return 1.5
	else
		return 3
	end
end

function slot0.SetInfo(slot0, slot1)
	if slot1.draw_rebate and slot1.draw_rebate ~= 0 then
		SetActive(slot0.rebateGo_, true)

		slot0.rebateLab_.text = "x" .. slot1.draw_rebate
	else
		SetActive(slot0.rebateGo_, false)
	end

	if not HeroCfg[slot1.id] then
		return
	end

	slot0.name_.text = GetI18NText(slot3.name) .. "·" .. GetI18NText(slot3.suffix)
	slot0.camp_.sprite = getSprite("Atlas/CampItem", RaceEffectCfg[slot3.race].icon)
	slot6 = math.min(ItemCfg[slot2].display_rare, 5)

	slot0.starController_:SetSelectedIndex(slot6)

	if slot6 == 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif slot6 == 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end

	slot0.SimplePlayer_:SetVoiceInfo(string.format("vo_sys_%d", slot2), string.format("v_s_%d_%s", slot2, "get"), string.format("vo_sys_%d.awb", slot2))

	if slot1.switchHeroReward then
		slot0.commonItem_:RefreshData({
			id = slot5.fragment,
			number = HeroTools.GetHeroRecoveryNum(slot2)
		})
		SetActive(slot0.itemGo_, true)
	else
		SetActive(slot0.itemGo_, false)
	end
end

function slot0.Dispose(slot0)
	slot0.playableDirectorStart_.stopped = slot0.playableDirectorStart_.stopped - slot0.startDirectorStopCallBack

	uv0.super.Dispose(slot0)
end

function slot0.OnObtainHeroMovieAnimtionEvent(slot0)
	slot0:PlayMovie()
end

function slot0.StartDirectorStopCallBack(slot0)
	slot0:PlayMovie()
end

return slot0
