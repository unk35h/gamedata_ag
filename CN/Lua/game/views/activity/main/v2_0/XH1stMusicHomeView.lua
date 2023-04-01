ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("XH1stMusicHomeView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return "UI/VersionUI/XuHeng1stUI/Music/XH1stMusicHomeUI"
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.m_enterBtn, nil, function ()
		JumpTools.OpenPageByJump("/enternalMusicMain", {
			activity_id = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		JumpTools.OpenPageByJump("enternalMusicReward", {
			activity_id = uv0.activityID_
		})
	end)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, slot0.activityID_))
	manager.redPoint:bindUIandKey(slot0.m_enterBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_OPEN, slot0.activityID_))
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, slot0.activityID_))
	manager.redPoint:unbindUIandKey(slot0.m_enterBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_OPEN, slot0.activityID_))
end

return slot0
