slot0 = class("FishingEnterView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Fishing/FishingEnterUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.illustratedBtn_, nil, function ()
		JumpTools.OpenPageByJump("fishingIllustrated", {})
	end)
	slot0:AddBtnListener(slot0.exchangeBtn_, nil, function ()
		if JumpTools.IsSystemOperationStoped(702) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		slot2 = JumpTools.IsSystemLocked(slot0) ~= nil and slot1 ~= false

		if slot0 and slot1 then
			ShowTips(JumpTools.GetSystemLockedTip(slot0, slot1))

			return
		end

		JumpTools.OpenPageByJump("fishingExchange", {})
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("fishingReward", {})
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		print("goBtn")
		JumpTools.OpenPageByJump("/fishingGame", {})
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "fishingNote",
		type = "jump",
		params = {}
	})
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
	manager.redPoint:bindUIandKey(slot0.groupRedPointContainer_, RedPointConst.FISHING_GROUP_REWARD, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(slot0.receiveRedPointContainer_, RedPointConst.FISHING_RECEIVE_REWARD, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(slot0.scoreRedPointContainer_, RedPointConst.FISHING_SCORE_REWARD, {
		x = 0,
		y = 0
	})
	FishingAction.GetReceiveInfo(ActivityConst.SUMMER_FISHING)
	FishingAction.ReadUnFinishRedPoint()

	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
	slot0:UpdateTimer()
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.groupRedPointContainer_, RedPointConst.FISHING_GROUP_REWARD)
	manager.redPoint:unbindUIandKey(slot0.receiveRedPointContainer_, RedPointConst.FISHING_RECEIVE_REWARD)
	manager.redPoint:unbindUIandKey(slot0.scoreRedPointContainer_, RedPointConst.FISHING_SCORE_REWARD)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.UpdateTimer(slot0)
	if ActivityData:GetActivityData(ActivityConst.SUMMER_FISHING).stopTime <= manager.time:GetServerTime() then
		slot0.lastTimeLabel_.text = GetTips("TIME_OVER")

		return
	end

	slot0.lastTimeLabel_.text = manager.time:GetLostTimeStr(slot1.stopTime)
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
