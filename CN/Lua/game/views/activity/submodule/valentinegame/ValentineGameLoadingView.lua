slot0 = class("ValentineGameLoadingView", ReduxView)

function slot0.UIName(slot0)
	return ValentineGameTools.GetLoadingUIName(slot0.params_.activityId)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
end

function slot0.OnEnter(slot0)
	slot0:StopTimer()

	slot0.timer_ = TimeTools.StartAfterSeconds(GameDisplayCfg.activity_valentine_wait_time.value[1], function ()
		JumpTools.OpenPageByJump("/valentineGame", {
			mainActivityID = uv0.params_.mainActivityID,
			activityID = uv0.params_.activityID
		})
	end, {})
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()

	slot0.canvasGroup_.alpha = 0
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
