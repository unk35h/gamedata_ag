slot0 = class("VolumeDemonChallengeMainView", DemonChallengeMainView)

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityId_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("demonChallengeAward", {
			selectId = uv0.curSelectId_
		})
	end)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityId_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("volumeDemonChallengeDifficultySelect", {
			selectId = uv0.curSelectId_
		})
	end)
end

function slot0.LevelRenderer(slot0, slot1, slot2)
	if slot0.levelControllerS_[slot1] == nil then
		slot0.levelControllerS_[slot1] = ControllerUtil.GetController(slot2.transform, "lock")
	end

	slot0.levelControllerS_[slot1]:SetSelectedState("false")

	slot0.lockTextS_[slot1] = slot0:FindCom(typeof(Text), "title/lock/text", slot2.transform)
end

return slot0
