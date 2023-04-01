return {
	GetMainUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.HELLA then
			return "UI/VersionUI/HellaUI/HellaTalentUI"
		else
			return "UI/VersionUI/HellaUI/HellaTalentUI"
		end
	end,
	IsCanUp = function (slot0)
		if TalentTreeData:GetTalentLevel(slot0) < TalentTreeCfg[slot0].max_level then
			slot3 = slot1.cost[slot2 + 1]

			return slot3[2] <= CurrencyData:GetCurrencyNum(slot3[1])
		end

		return false
	end,
	GetActivityIdByTheme = function (slot0)
		for slot5, slot6 in pairs(ActivityData:GetAllActivityData()) do
			if slot0 == ActivityTools.GetActivityTheme(slot5) and ActivityTemplateConst.TALENT_TREE == ActivityTools.GetActivityType(slot5) then
				return slot5
			end
		end
	end
}
