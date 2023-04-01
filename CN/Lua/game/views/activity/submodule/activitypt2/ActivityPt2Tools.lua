return {
	GetChallengeCurrencyID = function (slot0)
		if slot0 == ActivityConst.XUHENG_PT2 then
			return CurrencyIdMapCfg.CURRENCY_XUHENG_TICKET.item_id
		else
			return CurrencyIdMapCfg.CURRENCY_XUHENG_TICKET.item_id
		end
	end,
	GetHelpKey = function (slot0)
		if slot0 == ActivityConst.XUHENG_PT2 then
			return "ACTIVITY_XUHENG_PT_DESCRIBE"
		else
			return ""
		end
	end,
	GetLockTip = function (slot0)
		if slot0 == ActivityConst.XUHENG_PT2 then
			return "ACTIVITY_XUHENG_PT_DESCRIBE"
		else
			return ""
		end
	end,
	GetEnterUIName = function (slot0)
		if slot0 == ActivityConst.XUHENG_PT2 then
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtHomeUI"
		else
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtHomeUI"
		end
	end,
	GetMainUIName = function (slot0)
		if slot0 == ActivityConst.XUHENG_PT2 then
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtMainUI"
		else
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtMainUI"
		end
	end,
	GetTaskActivityID = function (slot0, slot1)
		if slot1 == ActivityConst.XUHENG_PT2 then
			return ActivityConst.XUHENG_PT2_TASK
		else
			return ActivityConst.XUHENG_PT2_TASK
		end
	end,
	GetMainActivityID = function (slot0, slot1)
		for slot6, slot7 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_PT_2]) do
			if table.indexof(ActivityCfg[slot7].sub_activity_list, slot1) then
				return slot7
			end
		end
	end
}
