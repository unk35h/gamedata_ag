return {
	GetMainUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.TYR then
			return "UI/VersionUI/DarkFlameUI/DFCutGrassUI/DFCutGrassMainUI"
		else
			return "UI/VolumeIIIUI/VolumeCutgrassMainUI"
		end
	end,
	GetSelectUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.TYR then
			return "UI/VersionUI/DarkFlameUI/DFCutGrassUI/DFCutGrassStageUI"
		else
			return "UI/VolumeIIIUI/VolumeCutgrassSelectUI"
		end
	end,
	GetRewardUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.TYR then
			return "UI/VersionUI/DarkFlameUI/DFCutGrassUI/DFCutGrassRewardUI"
		else
			return "UI/VersionUI/HellaUI/Slayer/HellaSlayerRewardUI"
		end
	end,
	GetRewardItemClass = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.TYR then
			return SlayerRewardItem_1_7
		else
			return HellaSlayerRewardItem
		end
	end
}
