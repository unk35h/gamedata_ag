return {
	GetMainUIName = function (slot0)
		if ActivityConst.SUMMER_LIMITED_CALCULATION == slot0 then
			return "UI/SummerUI/SummerArtifactUI"
		elseif ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION == slot0 then
			return "UI/VersionUI/DarkFlameUI/DFArtifactUI/DFArtifactMainUI"
		else
			return "UI/SummerUI/SummerArtifactUI"
		end
	end,
	GetGameHelpKey = function (slot0)
		if ActivityConst.SUMMER_LIMITED_CALCULATION == slot0 then
			return "ACTIVITY_SUMMER_LIMITED_CALCULATION_DESCRIPE"
		elseif ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION == slot0 then
			return "ACTIVITY_1_7_LIMITED_CALCULATION_DESCRIPE"
		else
			return ""
		end
	end,
	GetRankUIName = function (slot0)
		if ActivityConst.SUMMER_LIMITED_CALCULATION == slot0 then
			return "UI/SummerUI/SummerArtifactRankUI"
		elseif ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION == slot0 then
			return "UI/VersionUI/DarkFlameUI/DFArtifactUI/DFArtifactRankUI"
		else
			return "UI/SummerUI/SummerArtifactRankUI"
		end
	end,
	GetBuffList = function (slot0)
		slot1 = nil
		slot2 = {}

		for slot7, slot8 in ipairs(LimitedCalculationData:GetDifficultyList(slot0)) do
			if ActivityLimitCalculationCfg[slot8].player_level ~= 0 then
				table.insert(slot2, slot8)
			end
		end

		return slot2
	end,
	GetDebuffList = function (slot0)
		slot1 = nil
		slot2 = {}

		for slot7, slot8 in ipairs(LimitedCalculationData:GetDifficultyList(slot0)) do
			if ActivityLimitCalculationCfg[slot8].enemy_level ~= 0 then
				table.insert(slot2, slot8)
			end
		end

		return slot2
	end
}
