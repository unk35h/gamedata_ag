slot1 = class("DreamDemonChallengeMainView", import("game.views.activity.Submodule.DemonChallenge.Volume.VolumeDemonChallengeMainView"))

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.difficultyControllerList_ = {
		ControllerUtil.GetController(slot0.difficultyContentTrans_, "nor"),
		ControllerUtil.GetController(slot0.difficultyContentTrans_, "diff"),
		ControllerUtil.GetController(slot0.difficultyContentTrans_, "hard")
	}
end

function slot1.OnLevelSelect(slot0, slot1, slot2, slot3, slot4)
	if not ActivityData:GetActivityData(slot2):IsActivitying() then
		if slot0.curLevelIndex_ and slot0.curLevelIndex_ ~= slot1 then
			if slot5.stopTime <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			else
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot5.startTime)))
			end

			slot0.tree_:SelectGroup(slot0.curLevelIndex_)
		else
			slot0.isNeedExit_ = true
		end

		return
	end

	slot0:RefreshRewardRedPoint(slot0.curSelectId_, slot2)

	slot0.curLevelIndex_ = slot1
	slot0.curSelectId_ = slot2

	if getSpriteWithoutAtlas("Textures/" .. DemonChallengeCfg[DemonChallengeTools.GetChildId(slot0.curSelectId_, 1)].icon) then
		slot0.roleImg_.sprite = slot7
	end

	slot0:RefreshDescText()
	SubDemonChallengeAction.SetSelectedActivityId(slot2)
	slot0:RefreshCompleteStatus(slot2)
end

function slot1.RefreshCompleteStatus(slot0, slot1)
	for slot6, slot7 in ipairs(SubDemonChallengeData:GetChallengeInfo(slot1).challengeInfo) do
		if slot7.challenge_state == ActivityConst.DEMON_CHALLENGE_STATE.UNFINISHED then
			slot0.difficultyControllerList_[slot6]:SetSelectedState("off")
		else
			slot0.difficultyControllerList_[slot6]:SetSelectedState("on")
		end
	end
end

return slot1
