slot1 = false
slot2 = nil

return {
	Init = function ()
		NewDemonChallengeData:InitData()

		if uv0 then
			return
		end

		slot0 = manager.net

		slot0:Bind(64069, function (slot0)
			NewDemonChallengeData:SetMainActivityData(slot0)
			uv0.UpdateRewardRedPoint(slot0.activity_id)
		end)

		slot0 = manager.net

		slot0:Bind(64065, function (slot0)
			NewDemonChallengeData:SetSubActivityData(slot0.activity_info)
			uv0.UpdateSelectRedPoint(slot0.activity_info.activity_id)
			uv0.UpdateRewardRedPoint(ActivityTools.GetMainActivityId(slot0.activity_info.activity_id))
		end)

		uv0 = true
	end,
	GetChallengeReward = function (slot0, slot1)
		uv0 = slot1

		manager.net:SendWithLoadingNew(64066, {
			id = slot0
		}, 64067, uv1.OnGetChallengeReward)
	end,
	OnGetChallengeReward = function (slot0, slot1)
		if isSuccess(slot0.result) then
			NewDemonChallengeData:SetRewardState(uv0, slot1.id, ActivityConst.DEMON_CHALLENGE_REWARD_STATE.RECEIVED)

			if NewDemonChallengeRewardCfg[slot1.id] ~= nil then
				getReward(slot2.item_list)
				uv1.UpdateRewardRedPoint(slot2.activity_id)
			end
		else
			ShowTips(slot0.result)
		end

		manager.notify:CallUpdateFunc(DEMON_CHALLENGE_RECEIVE_REWARD, slot0, slot1)
	end,
	SetSelectedActivityId = function (slot0)
		NewDemonChallengeData:AddSelectedActivityId(slot0)
		uv0.UpdateSelectRedPoint(slot0)
	end,
	InitRedPointKey = function (slot0)
		if #ActivityData:GetActivityData(slot0).subActivityIdList > 0 then
			slot2 = {}

			for slot6 = 1, #slot1 do
				table.insert(slot2, RedPointConst.NEW_DEMON_CHALLENGE_UNFINISH .. slot1[slot6])
			end

			manager.redPoint:addGroup(RedPointConst.NEW_DEMON_CHALLENGE_UNFINISH .. slot0, slot2)
			manager.redPoint:addGroup(RedPointConst.NEW_DEMON_CHALLENGE .. slot0, {
				RedPointConst.NEW_DEMON_CHALLENGE_UNFINISH .. slot0,
				RedPointConst.NEW_DEMON_CHALLENGE_REWARD .. slot0
			})
		end
	end,
	UpdateRewardRedPoint = function (slot0)
		if NewDemonChallengeData:GetRewardStateList(slot0) ~= nil then
			slot2 = NewDemonChallengeData:GetCompletedDifficultyCountList(slot0)
			slot4 = false

			for slot8, slot9 in ipairs(NewDemonChallengeRewardCfg.get_id_list_by_activity_id[slot0]) do
				if NewDemonChallengeRewardCfg[slot9] ~= nil then
					slot12 = slot2[slot10.difficulty_id] or 0

					if slot1[slot9] == ActivityConst.DEMON_CHALLENGE_REWARD_STATE.UNRECEIVE and slot10.complete_num <= slot12 then
						slot4 = true

						break
					end
				end
			end

			manager.redPoint:setTip(RedPointConst.NEW_DEMON_CHALLENGE_REWARD .. slot0, slot4 and 1 or 0)
		end
	end,
	UpdateSelectRedPoint = function (slot0)
		if not ActivityData:GetActivityIsOpen(slot0) then
			return
		end

		slot3 = false

		if NewDemonChallengeData:GetChallengeInfo(slot1) then
			for slot7, slot8 in pairs(slot2.challengeInfo) do
				if ActivityConst.DEMON_CHALLENGE_STATE.UNFINISHED < slot8.challenge_state then
					slot3 = true

					break
				end
			end

			if slot3 == false and not NewDemonChallengeData:GetIsSelected(slot1) then
				manager.redPoint:setTip(RedPointConst.NEW_DEMON_CHALLENGE_UNFINISH .. slot1, 1)
			else
				manager.redPoint:setTip(RedPointConst.NEW_DEMON_CHALLENGE_UNFINISH .. slot1, 0)
			end
		end
	end,
	RefreshRedPoint = function (slot0)
		if ActivityData:GetActivityData(slot0).stopTime <= manager.time:GetServerTime() then
			for slot5, slot6 in ipairs(ActivityData:GetActivityData(slot0).subActivityIdList) do
				manager.redPoint:setTip(RedPointConst.NEW_DEMON_CHALLENGE_UNFINISH .. slot6, 0)
			end

			manager.redPoint:setTip(RedPointConst.NEW_DEMON_CHALLENGE_REWARD .. slot0, 0)
		end
	end
}
