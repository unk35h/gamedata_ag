return {
	GetMainUIName = function (slot0)
		if ActivityConst.SUMMER_PT == slot0 then
			return "UI/Activity/Submodule/ActivityPt/ActivityPtUI"
		elseif ActivityConst.VOLUME_III_PT == slot0 then
			return "UI/VolumeIIIUI/VolumePtUI"
		elseif ActivityConst.VOLUME_III_DOWN_PT == slot0 then
			return "UI/VolumeIIIDownUI/pt/VolumeIIIDownPtUI"
		elseif ActivityConst.FACTORY_PT == slot0 then
			return "UI/MardukUI/ptgame/MardukptUI"
		elseif ActivityConst.SPRING_FESTIVAL_PT == slot0 then
			return "UI/EmptyDream/ptgame/EDream_ptgame"
		elseif ActivityConst.TYR_PT == slot0 then
			return "UI/VersionUI/DarkFlameUI/DFPtGameUI/DFTyrPtMainUI"
		else
			return "UI/Activity/Submodule/ActivityPt/ActivityPtUI"
		end
	end,
	GetHelpKey = function (slot0)
		if ActivityConst.SUMMER_PT == slot0 then
			return "ACTIVITY_SUMMER_PT_REPEAT_DESCRIPE"
		elseif ActivityConst.VOLUME_III_PT == slot0 then
			return "ACTIVITY_CHAPTERIII_PT_DESCRIBE"
		elseif ActivityConst.VOLUME_III_DOWN_PT == slot0 then
			return "ACTIVITY_CHAPTERIII_DOWN_PT_DESCRIBE"
		elseif ActivityConst.FACTORY_PT == slot0 then
			return "ACTIVITY_MARDUK_PT_DESC"
		elseif ActivityConst.SPRING_FESTIVAL_PT == slot0 then
			return "ACTIVITY_INTEGRATE_PT_DESC"
		elseif ActivityConst.TYR_PT == slot0 then
			return "ACTIVITY_TYR_PT_DESC"
		else
			return ""
		end
	end,
	GetEnterVoice = function (slot0)
		if ActivityConst.SPRING_FESTIVAL_PT == slot0 then
			return true, "minigame_activity_1_6", "minigame_activity_1_6_uav_loop", ""
		else
			return false
		end
	end
}
