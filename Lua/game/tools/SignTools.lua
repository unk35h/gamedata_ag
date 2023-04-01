return {
	IsCanSign = function ()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SIGN) then
			return false
		end

		if uv0.GetDailySignIndex() ~= 0 then
			return true
		end

		slot0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_SIGN] or {}

		for slot4, slot5 in ipairs(slot0) do
			if uv0.GetSevenDaySignIndex(slot5) ~= 0 then
				return true
			end
		end

		return false
	end,
	GetDailySignIndex = function ()
		slot0 = manager.time:GetDeltaToday()

		if not SignData:GetDailySignInfo() then
			return 0
		end

		if not table.keyof(slot1.days, slot0) then
			return table.nums(slot1.days) + 1
		end

		return 0
	end,
	GetSevenDaySignIndex = function (slot0)
		slot1 = manager.time:GetTodayFreshTime()

		if not ActivityData:GetActivityIsOpen(slot0) then
			return 0
		end

		slot4 = ActivityData:GetActivityData(slot0)

		if not SignData:GetSevenDaySignInfo(slot0) or not slot4 then
			return 0
		end

		if ActivityCumulativeSignCfg[slot0] == nil then
			return 0
		end

		if PlayerData:GetPlayerInfo().userLevel < slot5.limit_level then
			return 0
		end

		if slot3.signCount >= #slot5.config_list then
			return 0
		end

		if slot3.lastSignTime < slot1 then
			return slot3.signCount + 1
		end

		return 0
	end,
	GetDailySignState = function (slot0)
		slot1 = manager.time:GetDeltaToday()
		slot2 = SignData:GetDailySignInfo().days
		slot3 = #slot2
		slot4 = 0

		for slot8, slot9 in ipairs(slot2) do
			if slot4 < slot9 then
				slot4 = slot9
			end
		end

		if slot0 <= slot3 then
			return ActivityConst.SIGN_STATE.GETTED
		end

		if slot4 < slot1 and slot3 + 1 == slot0 then
			return ActivityConst.SIGN_STATE.CAN_GET
		end

		if slot4 < slot1 and slot3 + 2 == slot0 or slot4 == slot1 and slot3 + 1 == slot0 then
			return ActivityConst.SIGN_STATE.TOMORROW_GET
		end

		return ActivityConst.SIGN_STATE.NONE
	end,
	GetSevenDaySignState = function (slot0, slot1)
		if not SignData:GetSevenDaySignInfo(slot0) then
			return ActivityConst.SIGN_STATE.NONE
		end

		slot3 = manager.time:GetDeltaToday()

		if slot1 <= slot2.signCount then
			return ActivityConst.SIGN_STATE.GETTED
		end

		if slot2.lastSignTime < slot3 and slot2.signCount + 1 == slot1 then
			return ActivityConst.SIGN_STATE.CAN_GET
		end

		if slot2.lastSignTime < slot3 and slot2.signCount + 2 == slot1 or slot2.lastSignTime == slot3 and slot2.signCount + 1 == slot1 then
			return ActivityConst.SIGN_STATE.TOMORROW_GET
		end

		return ActivityConst.SIGN_STATE.NONE
	end
}
