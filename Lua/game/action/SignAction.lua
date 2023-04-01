slot1 = manager.net

slot1:Bind(11013, function (slot0)
	SignData:InitDailySignData(slot0)
	ActivityRedPoint.UpdateDailySignRedPoint()
end)

slot1 = manager.net

slot1:Bind(11015, function (slot0)
	SignData:InitSevenDaySignData(slot0)
	ActivityRedPoint.UpdateSevenDaySignRedPoint()
end)

return {
	QueryDailySign = function ()
		manager.net:SendWithLoadingNew(11010, {
			activity_id = ActivityConst.SIGN
		}, 11011, uv0.OnDailySignCallBack)
	end,
	OnDailySignCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			SignData:UpdateDailySign(manager.time:GetDeltaToday())
			ActivityRedPoint.UpdateDailySignRedPoint()
		end

		manager.notify:CallUpdateFunc(SIGN, slot0, slot1)
	end,
	QuerySevenDaySign = function (slot0)
		manager.net:SendWithLoadingNew(11010, {
			activity_id = slot0
		}, 11011, uv0.OnSevenDaySignCallBack)
	end,
	OnSevenDaySignCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			SignData:UpdateSevenDaySign(slot1.activity_id, manager.time:GetTodayFreshTime())
			ActivityRedPoint.UpdateSevenDaySignRedPoint()
		end

		manager.notify:CallUpdateFunc(SIGN, slot0, slot1)
	end
}
