slot0 = singletonClass("GameTimer")
slot1 = 0
slot2 = 0
slot3 = 0
slot4, slot5, slot6 = nil

function slot0.SetNextDayFreshTime(slot0, slot1)
	if uv0 ~= slot1 then
		uv0 = slot1

		slot0:StartCountNextDay()
	end
end

function slot0.GetNextDayFreshTime(slot0)
	return uv0
end

function slot0.StartCountNextDay(slot0)
	slot0:StopCountNextDay()

	uv0 = Timer.New(function ()
		if uv0 < manager.time:GetServerTime() then
			uv1:StopCountNextDay()
			PlayerAction.RequestNewDayData()
		end
	end, 1, -1)

	uv0:Start()
end

function slot0.StopCountNextDay(slot0)
	if uv0 then
		uv0:Stop()

		uv0 = nil
	end
end

function slot0.SetNextWeekFreshTime(slot0, slot1)
	if uv0 ~= slot1 then
		uv0 = slot1

		slot0:StartCountNextWeek()
	end
end

function slot0.GetNextWeekFreshTime(slot0)
	return uv0
end

function slot0.StartCountNextWeek(slot0)
	slot0:StopCountNextWeek()

	uv0 = Timer.New(function ()
		if uv0 < manager.time:GetServerTime() then
			uv1:StopCountNextDay()
			PlayerAction.RequestNewDayData()
		end
	end, 1, -1)

	uv0:Start()
end

function slot0.StopCountNextWeek(slot0)
	if uv0 then
		uv0:Stop()

		uv0 = nil
	end
end

function slot0.SetNextMonthFreshTime(slot0, slot1)
	print("nextMonthFreshTime_ newTime", uv0, slot1)

	if uv0 ~= slot1 then
		uv0 = slot1

		slot0:StartCountNextMonth()
	end
end

function slot0.GetNextMonthFreshTime(slot0)
	return uv0
end

function slot0.StartCountNextMonth(slot0)
	slot0:StopCountNextMonth()

	uv0 = Timer.New(function ()
		if uv0 < manager.time:GetServerTime() then
			uv1:StopCountNextDay()
			PlayerAction.RequestNewDayData()
		end
	end, 1, -1)

	uv0:Start()
end

function slot0.StopCountNextMonth(slot0)
	if uv0 then
		uv0:Stop()

		uv0 = nil
	end
end

function slot0.Dispose(slot0)
	uv0 = 0

	slot0:StopCountNextDay()
end

return slot0
