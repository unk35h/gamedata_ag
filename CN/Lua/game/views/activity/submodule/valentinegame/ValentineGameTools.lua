return {
	GetMainUIName = function (slot0)
		if ActivityConst.TYR_VALENTINE_GAME == slot0 then
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineMainUI"
		else
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineMainUI"
		end
	end,
	GetRewardUIName = function (slot0)
		if ActivityConst.TYR_VALENTINE_GAME == slot0 then
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineRewardUI"
		else
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineRewardUI"
		end
	end,
	GetTestUIName = function (slot0)
		if ActivityConst.TYR_VALENTINE_GAME == slot0 then
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineStageUI"
		else
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineStageUI"
		end
	end,
	GetGameHelpKey = function (slot0)
		if ActivityConst.TYR_VALENTINE_GAME == slot0 then
			return "ACTIVITY_VALENTINE_DESCRIPE"
		else
			return ""
		end
	end,
	GetPointRule = function (slot0)
		if ActivityConst.TYR_VALENTINE_GAME == slot0 then
			slot1 = GameSetting.activity_valentine_right_num.value

			return slot1[1], slot1[2]
		else
			slot1 = GameSetting.activity_valentine_right_num.value

			return slot1[1], slot1[2]
		end
	end,
	GetLoadingUIName = function (slot0)
		if ActivityConst.TYR_VALENTINE_GAME == slot0 then
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineStarUI"
		else
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineStarUI"
		end
	end,
	GetGameUIName = function (slot0)
		if ActivityConst.TYR_VALENTINE_GAME == slot0 then
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineGameUI"
		else
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineGameUI"
		end
	end,
	GetResultUIName = function (slot0)
		if ActivityConst.TYR_VALENTINE_GAME == slot0 then
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineResultUI"
		else
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineResultUI"
		end
	end
}
