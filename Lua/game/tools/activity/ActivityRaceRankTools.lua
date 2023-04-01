return {
	GetRankUIName = function (slot0)
		if slot0 == ActivityConst.XUHENG_PT2_RANK then
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtRankUI"
		else
			print("未登记活动", slot0)

			return "UI/VolumeIIIDownUI/ActivityRace/VolumeIIIDownActivityRaceRankUI"
		end
	end
}
