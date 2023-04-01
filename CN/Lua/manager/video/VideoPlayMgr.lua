slot0 = class("VideoPlayMgr", import("game.extend.BaseView"))

function slot0.Ctor(slot0)
end

function slot0.InitUI(slot0)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Stage/VideoPlayUI"), manager.ui.uiStory.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()

	slot0.criManaMovieController_ = slot0.goMovie_:GetComponent("CriManaMovieControllerForUI")
	slot0.criplayer_ = slot0.criManaMovieController_.player
	slot0.criplayer_.statusChangeCallback = handler(slot0, slot0.StatusChangeCallback)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		SetActive(uv0.goSkip_, true)
		uv0:AddTimer()
	end)
	slot0:AddBtnListener(slot0.buttonSkip_, nil, function ()
		uv0.criManaMovieController_:Pause(true)

		if uv0.onPauseCallback then
			uv0.onPauseCallback(true)
		end

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("TIP_SKIP_PLOT"),
			OkCallback = function ()
				uv0.criManaMovieController_:Pause(false)

				if uv0.onPauseCallback then
					uv0.onPauseCallback(false)
				end

				uv0.criManaMovieController_:Stop()

				if uv0.onFinishCallback_ then
					uv0.onFinishCallback_(StoryOperDefine.PASS)
				end
			end,
			CancelCallback = function ()
				uv0.criManaMovieController_:Pause(false)

				if uv0.onPauseCallback then
					uv0.onPauseCallback(false)
				end
			end,
			MaskCallback = function ()
				uv0.criManaMovieController_:Pause(false)

				if uv0.onPauseCallback then
					uv0.onPauseCallback(false)
				end
			end
		})
	end)
end

function slot0.Play(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0.gameObject_ == nil then
		slot0:InitUI()
		slot0:AddListeners()
	end

	slot0.startStop_ = false

	if slot3 == nil then
		slot0.autoHide_ = true
	else
		slot0.autoHide_ = slot3
	end

	SetActive(slot0.goSkip_, false)
	slot0.criplayer_:SetVolume(manager.audio:GetMusicVolume())

	slot7 = manager.audio:GetLocalizationFlag()
	slot8 = 0
	slot9 = nil
	slot13 = "[^/]+$"

	for slot13 in string.gmatch(slot1, slot13) do
		slot9 = slot13
	end

	if VideoTrackCfg[slot9] and slot10.has_tracks == 1 then
		if slot7 == "zh" then
			slot8 = 0
		elseif slot7 == "ja" then
			slot8 = 1
		elseif slot7 == "en" then
			slot8 = 2
		elseif slot7 == "kr" then
			slot8 = 3
		end
	end

	slot0.criplayer_:SetAudioTrack(slot8)
	slot0.criplayer_:SetSubtitleChannel(slot8)

	if slot4 == nil then
		slot0.criplayer_:Loop(false)
	else
		slot0.criplayer_:Loop(slot4)
	end

	slot0.criplayer_:SetFile(nil, slot1)

	slot0.onFinishCallback_ = slot2
	slot0.onPauseCallback = slot5

	SetActive(slot0.gameObject_, true)
	slot0.criManaMovieController_:Play()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.gameObject_ then
		slot0.criplayer_.statusChangeCallback = nil

		slot0:RemoveTimer()
		Object.Destroy(slot0.gameObject_)

		slot0.gameObject_ = nil
		slot0.transform_ = nil
		slot0.onFinishCallback_ = nil
		slot0.onPauseCallback = nil
	end
end

function slot0.StatusChangeCallback(slot0, slot1)
	if tostring(slot1) == "PlayEnd" then
		slot0.criManaMovieController_:Stop()

		if slot0.onFinishCallback_ then
			slot0.onFinishCallback_(StoryOperDefine.NORMAL)
		end
	elseif slot2 == "StopProcessing" then
		slot0.startStop_ = true

		return
	elseif slot2 == "Stop" and slot0.startStop_ then
		if slot0.autoHide_ then
			SetActive(slot0.gameObject_, false)
		end

		slot0:RemoveTimer()
	end

	slot0.startStop_ = false
end

function slot0.HidePlayer(slot0)
	if slot0.startStop_ then
		slot0.autoHide_ = true

		return
	end

	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, false)
	end

	slot0.autoHide_ = true
end

function slot0.AddTimer(slot0)
	slot0:RemoveTimer()

	slot0.timer_ = Timer.New(function ()
		SetActive(uv0.goSkip_, false)

		uv0.timer_ = nil
	end, 3, 1)

	slot0.timer_:Start()
end

function slot0.RemoveTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
