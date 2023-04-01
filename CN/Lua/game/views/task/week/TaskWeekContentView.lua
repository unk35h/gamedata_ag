slot0 = class("TaskWeekContentView", TaskDailyContentView)

function slot0.RefreshTimeText(slot0)
	slot0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), slot0:GetTimeText(TimeMgr.GetInstance():GetNextWeekTime(1, GameSetting.refresh_time1.value[1][1], 0, 0) - TimeMgr.GetInstance():GetServerTime()))

	if slot0.dailyTimer_ then
		slot0.dailyTimer_:Stop()
	end

	slot0.dailyTimer_ = Timer.New(function ()
		uv0 = uv1 - TimeMgr.GetInstance():GetServerTime()

		if uv0 < 0 then
			uv0 = TimeMgr.GetInstance():GetNextWeekTime(1, GameSetting.refresh_time1.value[1][1], 0, 0) - TimeMgr.GetInstance():GetServerTime()
		end

		uv2.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), uv2:GetTimeText(uv0))
	end, 1, -1)

	slot0.dailyTimer_:Start()
end

return slot0
