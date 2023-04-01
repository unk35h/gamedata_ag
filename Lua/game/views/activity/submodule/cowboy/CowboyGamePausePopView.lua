slot0 = class("CowboyGamePausePopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/VolumeXiugameSelectUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.quitBtn_, nil, function ()
		manager.audio:Pause("music", false)
		manager.audio:StopEffect()
		manager.audio:Pause("effect", false)
		JumpTools.OpenPageByJump("/cowboy", {
			activityId = uv0.mainActivityID_
		})
	end)
	slot0:AddBtnListener(slot0.continueBtn_, nil, function ()
		manager.audio:Pause("music", false)
		manager.audio:Pause("effect", false)
		manager.notify:CallUpdateFunc(COWBOY_CONTINUE)
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.mainActivityID_ = slot0.params_.mainActivityID
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
