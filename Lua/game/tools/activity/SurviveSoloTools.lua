return {
	GetMainUIName = function (slot0)
		if ActivityConst.FACTORY_SURVIVE_SOLO == slot0 then
			return "UI/MardukUI/onerolesurvial/MardukOneroleUI"
		elseif ActivityConst.TYR_SURVIVE_SOLO == slot0 then
			return "UI/VersionUI/DarkFlameUI/DFDisorienTationUI/DFDisorienTationUI"
		else
			return "UI/MardukUI/onerolesurvial/MardukOneroleUI"
		end
	end,
	GetGameHelpKey = function (slot0)
		if ActivityConst.FACTORY_SURVIVE_SOLO == slot0 then
			return "ACTIVITY_SOLO_SLAYER_DESC"
		elseif ActivityConst.TYR_SURVIVE_SOLO == slot0 then
			return "ACTIVITY_SOLO_SLAYER_DESC"
		else
			return ""
		end
	end,
	GetRewardPopView = function (slot0)
		if ActivityConst.FACTORY_SURVIVE_SOLO == slot0 then
			return "UI/MardukUI/onerolesurvial/MardukOneroleRewardUI"
		elseif ActivityConst.TYR_SURVIVE_SOLO == slot0 then
			return "UI/VersionUI/DarkFlameUI/DFDisorienTationUI/DFDisorienTationRewardUI"
		else
			return "UI/MardukUI/onerolesurvial/MardukOneroleRewardUI"
		end
	end,
	GetRewardItemSkin = function (slot0)
		if ActivityConst.FACTORY_SURVIVE_SOLO == slot0 then
			return FactorySkinTrialRewardItem
		else
			return RewardItem
		end
	end
}
