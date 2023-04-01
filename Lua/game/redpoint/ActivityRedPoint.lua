slot1 = manager.notify

slot1:RegistListener(BATTLE_STAGE_PLOT_CHANGE, function (slot0)
	uv0.UpdateDailySignRedPoint()
	uv0.UpdateSevenDaySignRedPoint()
end)

return {
	UpdateDailySignRedPoint = function ()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SIGN) then
			return false
		end

		manager.redPoint:setTip(RedPointConst.SIGN_DAILY, SignTools.GetDailySignIndex() ~= 0 and 1 or 0)
	end,
	UpdateSevenDaySignRedPoint = function ()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SIGN) then
			return false
		end

		slot0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_SIGN] or {}

		for slot4, slot5 in ipairs(slot0) do
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SIGN_SEVEN_DAY, slot5), SignTools.GetSevenDaySignIndex(slot5) ~= 0 and 1 or 0)
		end
	end
}
