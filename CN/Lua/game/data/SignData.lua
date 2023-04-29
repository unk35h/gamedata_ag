slot0 = singletonClass("SignData")
slot1 = nil
slot2 = {}

function slot0.Init(slot0)
	uv0 = nil
	uv1 = {}
end

function slot0.InitDailySignData(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.sign_list) do
		table.insert(slot2, slot7)
	end

	uv0 = {
		id = ActivityConst.SIGN,
		year = slot1.year,
		month = slot1.month,
		day = slot1.day,
		days = slot2
	}
end

function slot0.InitSevenDaySignData(slot0, slot1)
	slot2 = slot1.activity_id
	uv0[slot2] = {
		id = slot2,
		signCount = slot1.sign_count,
		lastSignTime = slot1.last_sign_time
	}
end

function slot0.UpdateDailySign(slot0, slot1)
	table.insert(uv0.days, slot1)
end

function slot0.UpdateSevenDaySign(slot0, slot1, slot2)
	if uv0[slot1] then
		uv0[slot1].signCount = uv0[slot1].signCount + 1
		uv0[slot1].lastSignTime = slot2
	end
end

function slot0.GetDailySignInfo(slot0)
	return uv0
end

function slot0.GetSevenDaySignInfo(slot0, slot1)
	return uv0[slot1]
end

slot3 = 1

function slot0.GetHistoryIndex(slot0)
	return uv0
end

function slot0.SetHistoryIndex(slot0, slot1)
	uv0 = slot1
end

return slot0
