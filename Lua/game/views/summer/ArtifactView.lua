slot0 = class("ArtifactView", ReduxView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummeDivinepersonalityUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if ActivityData:GetActivityIsOpen(ActivityConst.SUMMER_ARTIFACT) then
			uv0:Go("/artifactLevel")
		elseif manager.time:GetServerTime() < ActivityData:GetActivityData(ActivityConst.SUMMER_ARTIFACT).stopTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ActivityConst.SUMMER_ARTIFACT).startTime)))
		else
			ShowTips(GetTips("TIME_OVER"))
		end
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	slot0.stopTime_ = ActivityData:GetActivityData(ActivityConst.SUMMER_ARTIFACT).stopTime
	slot0.timer_ = Timer.New(function ()
		if manager.time:GetServerTime() < uv0.stopTime_ then
			uv0.timeText_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
		else
			uv0:StopTimer()

			uv0.timeText_.text = GetTips("TIME_OVER")

			return
		end
	end, -1, 1)

	slot0.timer_:Start()
	manager.redPoint:bindUIandKey(slot0.startTrs_, string.format("%s_%s", RedPointConst.ARTIFACT, ActivityConst.SUMMER_ARTIFACT))
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SUMMER_ARTIFACT_DESCRIPE")
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopTimer()
	manager.redPoint:unbindUIandKey(slot0.startTrs_, string.format("%s_%s", RedPointConst.ARTIFACT, ActivityConst.SUMMER_ARTIFACT))
end

function slot0.Dispose(slot0)
	slot0.super.Dispose(slot0)
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
