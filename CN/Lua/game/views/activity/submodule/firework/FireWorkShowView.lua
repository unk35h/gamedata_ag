slot0 = class("FireWorkShowView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/Firework/FireworkUI"
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

	slot0.criMovie_ = slot0.m_movie:GetComponent("CriManaMovieControllerForUI")
	slot0.criplayer_ = slot0.criMovie_.player
	slot0.criplayer_.statusChangeCallback = nil
end

function slot0.AddUIListener(slot0)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.CirMovieStatusChange(slot0, slot1)
	if tostring(slot1) == "PlayEnd" or slot2 == "Stop" then
		slot0:ShowOver()
	end
end

function slot0.ShowOver(slot0)
	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	slot0.criplayer_.statusChangeCallback = nil
	slot3 = manager.story

	slot3:StartStoryById(ActivityFireWorkCfg[slot0.activity_id].story_id, function (slot0)
		JumpTools.OpenPageByJump("/fireWorkMain", {
			fire_activity_id = uv0.activity_id
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.activity_id = slot0.params_.fire_activity_id
	slot0.timer = Timer.New(function ()
		uv0:ShowOver()
	end, 20, 1)

	slot0.timer:Start()
	slot0.criplayer_:SetVolume(manager.audio:GetMusicVolume())
	slot0.criplayer_:SetFile(nil, ActivityFireWorkCfg[slot0.activity_id].fireworks)
	slot0.criMovie_:Play()

	slot0.criplayer_.statusChangeCallback = handler(slot0, slot0.CirMovieStatusChange)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	slot0.criplayer_.statusChangeCallback = nil
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
