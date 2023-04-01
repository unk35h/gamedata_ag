slot1 = false
slot2 = nil

return {
	Init = function ()
		SubDemonChallengeData:InitData()

		if uv0 then
			return
		end

		slot0 = manager.net

		slot0:Bind(11031, function (slot0)
			SubDemonChallengeData:SetData(slot0.activity_info)
			uv0.UpdateRedPoint(slot0.activity_info.activity_id)
		end)

		uv0 = true
	end,
	GetChallengeReward = function (slot0, slot1)
		uv0 = slot1

		manager.net:SendWithLoadingNew(11032, {
			id = slot0
		}, 11033, uv1.OnGetChallengeReward)
	end,
	OnGetChallengeReward = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if uv0 then
				SubDemonChallengeData:SetRewardState(uv0, slot1.id, ActivityConst.DEMON_CHALLENGE_REWARD_STATE.RECEIVED)
			end

			rewardCfg = getRewardFromDropCfg(BattleHeartDemonStageCfg[DemonChallengeCfg[slot1.id].stage_id].drop_lib_id, true)

			getReward(rewardCfg)

			if uv0 then
				uv1.UpdateRedPoint(uv0)
			end
		end

		manager.notify:CallUpdateFunc(DEMON_CHALLENGE_RECEIVE_REWARD, slot0, slot1)
	end,
	SetSelectedActivityId = function (slot0)
		SubDemonChallengeData:AddSelectedActivityId(slot0)
		uv0.UpdateRedPoint(slot0)
	end,
	InitRedPointKey = function (slot0)
		slot2 = {}

		for slot6 = 1, #ActivityData:GetActivityData(slot0).subActivityIdList do
			slot7 = RedPointConst.DEMON_CHALLENGE .. slot1[slot6]

			manager.redPoint:addGroup(slot7, {
				RedPointConst.DEMON_CHALLENGE_REWARD .. slot1[slot6],
				RedPointConst.DEMON_CHALLENGE_UNFINISH .. slot1[slot6]
			})
			table.insert(slot2, slot7)
		end

		manager.redPoint:addGroup(RedPointConst.DEMON_CHALLENGE .. slot0, slot2)
	end,
	UpdateRedPoint = function (slot0)
		if not ActivityData:GetActivityIsOpen(slot0) then
			return
		end

		slot2 = false
		slot3 = false

		if SubDemonChallengeData:GetChallengeInfo(slot0) then
			for slot7, slot8 in pairs(slot1.challengeInfo) do
				slot10 = slot8.reward_state

				if ActivityConst.DEMON_CHALLENGE_STATE.UNFINISHED < slot8.challenge_state and slot10 == ActivityConst.DEMON_CHALLENGE_REWARD_STATE.UNRECEIVE then
					slot2 = true
				elseif slot9 == ActivityConst.DEMON_CHALLENGE_STATE.UNFINISHED then
					slot3 = true
				end
			end
		end

		manager.redPoint:setTip(RedPointConst.DEMON_CHALLENGE_REWARD .. slot0, slot2 and 1 or 0)

		if slot3 and not SubDemonChallengeData:GetIsSelected(slot0) then
			manager.redPoint:setTip(RedPointConst.DEMON_CHALLENGE_REWARD .. slot0, 1)
		else
			manager.redPoint:setTip(RedPointConst.DEMON_CHALLENGE_UNFINISH .. slot0, 0)
		end
	end,
	RefreshRedPoint = function (slot0)
		if ActivityData:GetActivityData(slot0).stopTime <= manager.time:GetServerTime() then
			for slot5, slot6 in ipairs(ActivityData:GetActivityData(slot0).subActivityIdList) do
				manager.redPoint:setTip(RedPointConst.DEMON_CHALLENGE_REWARD .. slot6, 0)
				manager.redPoint:setTip(RedPointConst.DEMON_CHALLENGE_UNFINISH .. slot6, 0)
			end
		end
	end
}
