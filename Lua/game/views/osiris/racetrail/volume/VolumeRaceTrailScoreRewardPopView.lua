slot1 = class("VolumeRaceTrailScoreRewardPopView", import("game.views.osiris.raceTrail.RaceTrailScoreRewardPopView"))

function slot1.UIName(slot0)
	return "UI/VolumeIIIDownUI/RaceTrial/VolumeIIIRaceTrialScoreRewardUI"
end

function slot1.GetRewardItemClass(slot0)
	return VolumeRaceTrailScoreRewardItem
end

return slot1
