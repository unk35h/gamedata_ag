return {
	GetMainViewUIName = function (slot0)
		return "UI/VersionUI/XuHeng1stUI/XH1stSkinTrialUI/XH1stSkinTrialMainUI"
	end,
	GetSelectViewUIName = function (slot0)
		return "UI/VersionUI/XuHeng1stUI/XH1stSkinTrialUI/XH1stSkinTrialUI"
	end,
	GetSkinContentViewUIName = function (slot0, slot1)
	end,
	GetSkinContentViewClass = function (slot0)
	end,
	GoToSelectView = function (slot0, slot1)
		JumpTools.OpenPageByJump("/skinTrialSelectView_2_0", {
			activityID = slot0,
			skinTrialID = slot1
		})
	end
}
