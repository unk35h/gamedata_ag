return {
	GetOpenActivityID = function ()
		for slot3 = #ActivityAdvertiseCfg.all, 1, -1 do
			if ActivityTools.GetActivityStatus(ActivityAdvertiseCfg.all[slot3]) == 1 then
				return slot4
			end
		end
	end,
	NeedShowAdvertise = function ()
		if uv0.GetOpenActivityID() == nil then
			return false
		end

		slot1 = getData("activityAdvertise", tostring(slot0)) or 0
		slot2 = getData("activityAdvertise", "prompt") or false

		if ActivityAdvertiseData:GetOpenAdvertiseFlag(slot0) or manager.time:IsToday(slot1) and slot2 then
			return false
		end

		return true
	end
}
