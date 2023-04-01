slot0 = class("OsirisChessView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/OsirisUI/OsirisConnectUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.chessView_ = {}
	slot4 = ActivityConst.OSIRIS_CHESS

	for slot4, slot5 in ipairs(WarchessLevelCfg.get_id_list_by_activity[slot4]) do
		slot0.chessView_[slot5] = OsirisChessBtnView.New(slot0[string.format("goStage%s_", slot4)], slot5)
	end
end

function slot0.OnEnter(slot0)
	slot4 = {
		BACK_BAR,
		slot5
	}
	slot5 = HOME_BAR

	manager.windowBar:SwitchBar(slot4)

	for slot4, slot5 in pairs(slot0.chessView_) do
		slot5:OnEnter()
	end

	slot0.stopTime_ = ActivityData:GetActivityData(ActivityConst.OSIRIS_CHESS).stopTime

	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.chessView_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.chessView_) do
		slot5:Dispose()
	end

	slot0.chessView_ = nil
end

function slot0.AddListeners(slot0)
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	slot0.textTime_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		uv0.textTime_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
