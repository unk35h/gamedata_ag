slot1 = class("VolumeRaceTrailScoreRewardItem", import("game.views.osiris.raceTrail.RaceTrailScoreRewardItem"))

function slot1.RefreshTitle(slot0)
	slot0.title_.text = slot0.cfg_.need
end

return slot1
