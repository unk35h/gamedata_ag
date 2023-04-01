slot0 = singletonClass("TimeMgr")
slot0._Timer = nil
slot0._sAnchorTime = 0
slot0._AnchorDelta = 0
slot0._serverUnitydelta = 0
slot1 = 3600
slot2 = 86400
slot3 = 604800
slot4 = 0
slot5 = 345600

function slot0.Ctor(slot0)
	slot0:OnCtor()
end

function slot0.OnCtor(slot0)
	print("initializing time manager...")

	slot0._Timer = TimeUtil.NewUnityTimer()

	slot0:UpdateTimeInfo()
end

function slot0.UpdateTimeInfo(slot0)
	slot0.timeZero_ = slot0:CalcTimeZone()
	slot0.deltaTimeZero_ = slot0.timeZero_ - uv0
end

function slot0.Update(slot0)
	slot0._Timer:Schedule()
end

function slot0.AddTimer(slot0, slot1, slot2, slot3, slot4)
	return slot0._Timer:SetTimer(slot1, slot2 * 1000, slot3 * 1000, slot4)
end

function slot0.RemoveTimer(slot0, slot1)
	if slot1 == nil or slot1 == 0 then
		return
	end

	slot0._Timer:DeleteTimer(slot1)
end

function slot0.GetHour(slot0, slot1)
	return slot1 * 60 * 60 * 1000
end

function slot0.GetHourInType(slot0, slot1, slot2)
	if slot2 == 1 then
		return slot1 * 60
	elseif slot2 == 2 then
		return slot1 * 60 * 60
	elseif slot2 == 3 then
		return slot1 * 60 * 60 * 1000
	end
end

function slot0.RealtimeSinceStartup(slot0)
	return math.ceil(Time.realtimeSinceStartup)
end

function slot0.SetServerTime(slot0, slot1, slot2)
	slot0._serverUnitydelta = slot1 - slot0:RealtimeSinceStartup()
	slot0._sAnchorTime = slot2
	uv0 = uv1 - slot0._sAnchorTime
	slot0._AnchorDelta = -1 * uv0

	slot0:UpdateTimeInfo()
end

function slot0.GetServerTime(slot0)
	return slot0:RealtimeSinceStartup() + slot0._serverUnitydelta
end

function slot0.GetServerWeek(slot0)
	return math.ceil(((slot0:GetServerTime() - slot0._sAnchorTime) % uv0 + 1) / uv1)
end

function slot0.GetServerHour(slot0)
	return math.floor((slot0:GetServerTime() - slot0._sAnchorTime) % uv0 / uv1)
end

function slot0.Table2ServerTime(slot0, slot1)
	slot1.isdst = false

	return slot0:GetServerTime() - (os.time(os.date("!*t", slot0:GetServerTime() - slot0._AnchorDelta)) - os.time(slot1))
end

function slot0.DescCTime(slot0, slot1, slot2)
	return os.date(slot2 or "!%Y%m%d%H%M%S", slot1)
end

function slot0.STimeDescS(slot0, slot1, slot2)
	return os.date(slot2 or "!%Y/%m/%d %H:%M:%S", slot1 - slot0._AnchorDelta)
end

function slot0.ServerTimeDesc(slot0)
	return slot0:DescCTime(slot0:GetServerTime())
end

function slot0.GetZeroTime(slot0)
	return math.ceil((slot0:GetServerTime() + uv0) / uv1) * uv1 - uv0
end

function slot0.GetTimeByHMS(slot0, slot1, slot2, slot3)
	return slot0:ParseTimeEx(os.date("!%Y-%m-%d", slot0:GetServerTime() - slot0._AnchorDelta) .. " " .. slot1 .. ":" .. slot2 .. ":" .. slot3)
end

function slot0.GetLastZeroTime(slot0)
	return math.floor((slot0:GetServerTime() + uv0) / uv1) * uv1 - uv0
end

function slot0.GetNextWeekStartTime(slot0)
	return math.ceil((slot0:GetServerTime() - 4 * uv0 + uv1) / 604800) * 604800 - uv1 + 4 * uv0
end

function slot0.GetWeekendStartTime(slot0)
	return math.ceil((slot0:GetServerTime() - 4 * uv0 + uv1) / 604800) * 604800 - uv1 + 4 * uv0 - 2 * uv0
end

function slot0.GetNextMonthStartTime(slot0)
	slot1 = slot0:GetServerTime()
	slot2 = tonumber(os.date("!%Y", slot1))

	if (tonumber(os.date("!%m", slot1)) + 1) % 12 == 0 then
		slot3 = 12
	end

	if slot3 == 1 then
		slot2 = slot2 + 1
	end

	return os.time({
		hour = 0,
		min = 0,
		sec = 0,
		day = 1,
		year = slot2,
		month = slot3
	})
end

function slot0.GetNextTime(slot0, slot1, slot2, slot3, slot4)
	slot4 = slot4 or uv0
	slot6 = slot1 * uv1 + slot2 * 60 + slot3

	return math.floor((slot0:GetServerTime() - (slot0._sAnchorTime + slot6)) / slot4 + 1) * slot4 + slot0._sAnchorTime + slot6
end

function slot0.GetNextWeekTime(slot0, slot1, slot2, slot3, slot4)
	return slot0:GetNextTime((slot1 - 1) * 24 + slot2, slot3, slot4, uv0)
end

function slot0.ParseTime(slot0, slot1)
	slot2 = tonumber(slot1)
	slot2 = slot2 / 100
	slot2 = slot2 / 100
	slot2 = slot2 / 100
	slot2 = slot2 / 100

	return slot0:Table2ServerTime({
		year = slot2 / 100,
		month = slot2 % 100,
		day = slot2 % 100,
		hour = slot2 % 100,
		min = slot2 % 100,
		sec = slot2 % 100
	})
end

function slot0.ParseTimeEx(slot0, slot1, slot2)
	if slot2 == nil then
		slot2 = "(%d+)%-(%d+)%-(%d+)%s(%d+)%:(%d+)%:(%d+)"
	end

	slot3, slot4, slot5, slot6, slot7, slot8 = slot1:match(slot2)

	return slot0:Table2ServerTime({
		year = slot3,
		month = slot4,
		day = slot5,
		hour = slot6,
		min = slot7,
		sec = slot8
	})
end

function slot0.parseTimeFromConfig(slot0, slot1)
	return slot0:Table2ServerTime({
		year = slot1[1][1],
		month = slot1[1][2],
		day = slot1[1][3],
		hour = slot1[2][1],
		min = slot1[2][2],
		sec = slot1[2][3]
	})
end

function slot0.DescCDTime(slot0, slot1)
	slot2 = math.floor(slot1 / 3600)
	slot1 = slot1 - slot2 * 3600

	return string.format("%02d:%02d:%02d", slot2, math.floor(slot1 / 60), slot1 % 60)
end

function slot0.DescCdTime2(slot0, slot1)
	slot2 = ""
	slot4 = math.fmod(math.floor(slot1 / 3600), 24)
	slot5 = math.fmod(math.floor(slot1 / 60), 60)
	slot6 = math.fmod(slot1, 60)
	slot8 = GetTips("HOUR")
	slot9 = GetTips("TIP_MINUTE")
	slot10 = GetTips("SECOND")

	return (math.floor(slot1 / 86400) <= 0 or SpliceI18NText({
		slot3,
		GetTips("DAY"),
		string.format("%02d", slot4),
		slot8,
		string.format("%02d", slot5),
		slot9
	})) and (slot4 <= 0 or SpliceI18NText({
		string.format("%02d", slot4),
		slot8,
		string.format("%02d", slot5),
		slot9
	})) and (slot5 <= 0 or SpliceI18NText({
		string.format("%02d", slot5),
		slot9,
		string.format("%02d", slot6),
		slot10
	})) and (slot6 <= 0 or SpliceI18NText({
		string.format("%02d", slot6),
		slot10
	})) and "--/--"
end

function slot0.DescCdTime3(slot0, slot1)
	slot2 = ""
	slot4 = math.fmod(math.floor(slot1 / 3600), 24)
	slot5 = math.fmod(math.floor(slot1 / 60), 60)
	slot6 = math.fmod(slot1, 60)
	slot8 = GetTips("HOUR")
	slot9 = GetTips("MINUTE")
	slot10 = GetTips("SECOND")

	return (math.floor(slot1 / 86400) <= 0 or string.format("%s%s%02d:%02d:%02d", slot3, GetTips("DAY"), slot4, slot5, slot6)) and (slot4 <= 0 or string.format("%d:%02d:%02d", slot4, slot5, slot6)) and (slot5 <= 0 or string.format("%d:%02d:%02d", slot4, slot5, slot6)) and (slot6 <= 0 or string.format("%d:%02d:%02d", slot4, slot5, slot6)) and "--/--"
end

function slot0.parseTimeForm(slot0, slot1)
	return math.floor(slot1 / 86400), math.fmod(math.floor(slot1 / 3600), 24), math.fmod(math.floor(slot1 / 60), 60), math.fmod(slot1, 60)
end

function slot0.CalcMonthDays(slot0, slot1, slot2)
	slot3 = 30
	slot4 = {
		1,
		3,
		5,
		7,
		8,
		10,
		12
	}

	if slot2 == 2 then
		if slot1 % 100 == 0 then
			slot3 = slot1 % 400 == 0 and 29 or 28
		else
			slot3 = slot1 % 4 == 0 and 29 or 28
		end
	elseif table.indexof(slot4, slot2) then
		slot3 = 31
	end

	return slot3
end

function slot0.GetLostTimeStr(slot0, slot1, slot2, slot3)
	slot4 = 1

	if slot2 then
		slot4 = 0
	end

	slot5 = slot1 - slot0:GetServerTime()
	slot7 = math.fmod(math.floor(slot5 / 3600), 24)
	slot8 = math.fmod(math.floor(slot5 / 60), 60)
	slot9 = math.fmod(slot5, 60)

	if math.floor(slot5 / 86400) > 0 then
		return slot6 + slot4 .. GetTips("DAY")
	elseif slot7 > 0 then
		return slot7 + slot4 .. GetTips("HOUR")
	elseif slot8 > 0 then
		return slot8 + slot4 .. GetTips("MINUTE")
	elseif slot9 > 0 then
		return slot9 .. GetTips("SECOND")
	elseif slot3 then
		return 1 .. GetTips("SECOND")
	else
		return GetTips("TIME_OUT")
	end
end

function slot0.GetLostTimeStr2(slot0, slot1, slot2, slot3)
	slot4 = 1

	if slot2 then
		slot4 = 0
	end

	slot5 = slot1 - slot0:GetServerTime()
	slot7 = math.fmod(math.floor(slot5 / 3600), 24)
	slot8 = math.fmod(math.floor(slot5 / 60), 60)
	slot9 = math.fmod(slot5, 60)

	if math.floor(slot5 / 86400) > 0 then
		return slot6 + slot4 .. GetTips("DAY")
	elseif slot7 > 0 then
		return slot7 + slot4 .. GetTips("HOUR")
	elseif slot8 > 0 then
		return slot8 + slot4 .. GetTips("MINUTE")
	elseif slot9 > 0 then
		return 1 .. GetTips("MINUTE")
	elseif slot3 then
		return 1 .. GetTips("MINUTE")
	else
		return GetTips("TIME_OUT")
	end
end

function slot0.GetLostTimeLongStr(slot0, slot1)
	slot2 = slot1 - slot0:GetServerTime()
	slot4 = math.fmod(math.floor(slot2 / 3600), 24)
	slot5 = math.fmod(math.floor(slot2 / 60), 60)
	slot7 = ""
	slot9 = GetTips("HOUR")
	slot10 = GetTips("MINUTE")
	slot11 = GetTips("SECOND")

	return (math.floor(slot2 / 86400) <= 0 or SpliceI18NText({
		slot3,
		GetTips("DAY"),
		string.format("%02d", slot4),
		slot9,
		string.format("%02d", slot5),
		slot10
	})) and (slot4 <= 0 or SpliceI18NText({
		string.format("%02d", slot4),
		slot9,
		string.format("%02d", slot5),
		slot10
	})) and (slot5 <= 0 or SpliceI18NText({
		string.format("%02d", slot5),
		slot10
	})) and (math.fmod(slot2, 60) <= 0 or string.format("1%s", slot10)) and GetTips("TIME_OUT")
end

function slot0.GetBeforeTimeStr(slot0, slot1)
	slot2 = slot0:GetServerTime() - slot1
	slot4 = math.fmod(math.floor(slot2 / 3600), 24)
	slot5 = math.fmod(math.floor(slot2 / 60), 60)
	slot6 = math.fmod(slot2, 60)

	if math.floor(slot2 / 86400) > 0 then
		return SpliceI18NText({
			slot3 + 1,
			GetTips("DAY"),
			GetTips("BEFORE")
		})
	elseif slot4 > 0 then
		return SpliceI18NText({
			slot4 + 1,
			GetTips("HOUR"),
			GetTips("BEFORE")
		})
	elseif slot5 > 0 then
		return SpliceI18NText({
			slot5 + 1,
			GetTips("MINUTE"),
			GetTips("BEFORE")
		})
	elseif slot6 > 0 then
		return SpliceI18NText({
			slot6,
			GetTips("SECOND"),
			GetTips("BEFORE")
		})
	else
		return GetTips("BLANK")
	end
end

function slot0.GetDeltaToday(slot0)
	return slot0:GetToday(manager.time:GetServerTime() - GameSetting.refresh_time1.value[1][1] * 3600)
end

function slot0.GetNextFreshTime(slot0)
	return slot0:GetTodayFreshTime() + uv0
end

function slot0.GetTodayFreshTime(slot0)
	if tonumber(slot0:STimeDescS(slot0:GetServerTime(), "!%H")) < GameSetting.refresh_time1.value[1][1] then
		return manager.time:GetTimeByHMS(GameSetting.refresh_time1.value[1][1], 0, 0) - uv0
	else
		return manager.time:GetTimeByHMS(GameSetting.refresh_time1.value[1][1], 0, 0)
	end
end

function slot0.GetToday(slot0, slot1, slot2)
	return tonumber(slot0:STimeDescS(slot1 or slot0:GetServerTime(), slot2 or "!%d"))
end

function slot0.IsToday(slot0, slot1)
	return math.floor((slot1 + uv0) / 86400) == math.floor((slot0:GetServerTime() + uv0) / 86400)
end

function slot0.DiffDay(slot0, slot1, slot2)
	return math.floor((slot2 - slot0._sAnchorTime) / uv0) - math.floor((slot1 - slot0._sAnchorTime) / uv0)
end

function slot0.DiffDay2(slot0, slot1, slot2)
	slot3 = nil
	slot5 = math.fmod(math.floor(slot1 / 3600), 24)
	slot6 = math.fmod(math.floor(slot1 / 60), 60)
	slot7 = math.fmod(slot1, 60)
	slot9 = math.fmod(math.floor(slot2 / 3600), 24)
	slot10 = math.fmod(math.floor(slot2 / 60), 60)
	slot11 = math.fmod(slot2, 60)

	return math.floor(slot2 / 86400) - math.floor(slot1 / 86400)
end

function slot0.IsSameDay(slot0, slot1, slot2)
	return math.floor((slot1 - slot0._sAnchorTime) / uv0) == math.floor((slot2 - slot0._sAnchorTime) / uv0)
end

function slot0.GetMonthEn(slot0, slot1)
	if tonumber(os.date("!%m", slot1)) == 1 then
		return "Jan."
	end

	if slot2 == 2 then
		return "Feb."
	end

	if slot2 == 3 then
		return "Mar."
	end

	if slot2 == 4 then
		return "Apr."
	end

	if slot2 == 5 then
		return "May."
	end

	if slot2 == 6 then
		return "Jun."
	end

	if slot2 == 7 then
		return "Jul."
	end

	if slot2 == 8 then
		return "Aug."
	end

	if slot2 == 9 then
		return "Sep."
	end

	if slot2 == 10 then
		return "Oct."
	end

	if slot2 == 11 then
		return "Nov."
	end

	if slot2 == 12 then
		return "Dec."
	end
end

function slot0.FormatTime(slot0, slot1)
	if tonumber(os.date("!%Y", slot1)) ~= tonumber(os.date("!%Y", slot0:GetServerTime())) then
		return os.date("%Y/%m/%d %H:%M", slot1)
	elseif not slot0:IsSameDay(slot1, slot3) then
		return os.date("%m/%d %H:%M", slot1)
	else
		return os.date("%H:%M", slot1)
	end
end

function slot0.GetOnLineText(slot0, slot1)
	if slot1 == 0 then
		return GetTips("ONLINE")
	end

	if slot0:GetServerTime() - slot1 < 3600 then
		return GetTips("FRIEND_ONLINE_TIME_WITHIN_AN_HOUR")
	elseif slot2 < 86400 then
		return GetTips("FRIEND_ONLINE_TIME_IN_ONE_DAY")
	elseif slot2 < 2592000 then
		return string.format(GetTips("FRIEND_ONLINE_TIME_ONE_DAY_AGO"), math.floor(slot2 / 86400))
	else
		return string.format(GetTips("FRIEND_ONLINE_TIME_ONE_DAY_AGO"), 30)
	end
end

function slot0.CalcTimeZone(slot0)
	slot1 = os.time()

	return os.difftime(slot1, os.time(os.date("!*t", slot1)))
end

function slot0.GetTimeZone(slot0)
	return slot0.timeZero_
end

function slot0.GetDeltaTimeZone(slot0)
	return slot0.deltaTimeZero_
end

return slot0
