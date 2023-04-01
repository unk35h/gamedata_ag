RaceTrailMainView = import("game.views.osiris.raceTrail.RaceTrailMainView")
slot0 = class("VolumeRaceTrailMainView", RaceTrailMainView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIDownUI/RaceTrial/VolumeIIIDownRaceTrial"
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.firstRewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("raceTrailFirstReward", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.scoreRewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("volumeRaceTrailScoreRewardPop", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		RaceTrailAction:ReceiveScoreReward(uv0.curLv_)
	end)
	slot0:AddBtnListener(slot0.DivineBtn_, nil, function ()
		JumpTools.OpenPageByJump("volumeHeroRaceTrailDetails")
	end)
end

return slot0
