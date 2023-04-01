slot1 = manager.net

slot1:Bind(60059, function (slot0)
	SummerLittleGameData:InitLeviathanGameData(slot0)
	uv0.InitLeviathanRedPoint(slot0.activity_id)
end)

slot1 = manager.net

slot1:Bind(60063, function (slot0)
	SummerLittleGameData:InitSkadiGameData(slot0)
	uv0.InitSkadiRedPoint(slot0.activity_id)
end)

return {
	GetLeviathanReward = function (slot0)
		manager.net:SendWithLoadingNew(60060, {
			activity_id = slot0
		}, 60061, uv0.OnGetLeviathanReward)
	end,
	OnGetLeviathanReward = function (slot0, slot1)
		if isSuccess(slot0.result) then
			SummerLittleGameData:SetLeviathanGameReward(slot1.activity_id, ActivityConst.LITTLE_GAME_STATE.REWARDED)
			getReward(ActivityBubblesCfg[slot1.activity_id].reward_item_list)
			uv0.RefreshLeviathanRewardRedPoint()
			manager.notify:CallUpdateFunc(GET_LEVIATHAN_REWARD)
		else
			ShowTips(slot0.result)
		end
	end,
	GetSkadiReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(60064, {
			activity_id = slot0,
			treasure_id = slot1
		}, 60065, uv0.OnGetSkadiReward)
	end,
	OnGetSkadiReward = function (slot0, slot1)
		if isSuccess(slot0.result) then
			SummerLittleGameData:SetSkadiGameReward(slot1.activity_id, slot1.treasure_id)
			getReward(ActivityCrossWaveCfg[slot1.activity_id].reward_item_list[slot1.treasure_id])
			uv0.RefreshSkadiRewardRedPoint()
			manager.notify:CallUpdateFunc(GET_SKADI_REWARD)
		else
			ShowTips(slot0.result)
		end
	end,
	ActivityOpenCheck = function (slot0)
		if manager.time:GetServerTime() < ActivityData:GetActivityData(slot0).startTime then
			return false
		end

		if slot1.stopTime <= manager.time:GetServerTime() then
			return false
		end

		return true
	end,
	InitSkadiRedPoint = function ()
		slot0 = SummerLittleGameData:IsSkadiRewardPointShow() and 1 or 0
		slot1 = SummerLittleGameData:IsSkadiLevelPointShow() and 1 or 0

		if not uv0.ActivityOpenCheck(ActivityConst.SIKADI_GAME) then
			slot1 = 0
			slot0 = 0
		end

		manager.redPoint:addGroup(RedPointConst.SKADI_LITTLE_GAME .. "_" .. ActivityConst.SIKADI_GAME, {
			RedPointConst.SKADI_LITTLE_GAME_REWARD,
			RedPointConst.SKADI_LITTLE_GAME_LEVEL
		})
		manager.redPoint:setTip(RedPointConst.SKADI_LITTLE_GAME_REWARD, slot0)
		manager.redPoint:setTip(RedPointConst.SKADI_LITTLE_GAME_LEVEL, slot1)
	end,
	InitLeviathanRedPoint = function ()
		slot0 = SummerLittleGameData:IsLeviathanRewardPointShow() and 1 or 0
		slot1 = SummerLittleGameData:IsLeviathanLevelPointShow() and 1 or 0

		if not uv0.ActivityOpenCheck(ActivityConst.LEVIATHAN_GAME) then
			slot1 = 0
			slot0 = 0
		end

		manager.redPoint:addGroup(RedPointConst.LEVIATHAN_LITTLE_GAME .. "_" .. ActivityConst.LEVIATHAN_GAME, {
			RedPointConst.LEVIATHAN_LITTLE_GAME_REWARD,
			RedPointConst.LEVIATHAN_LITTLE_GAME_LEVEL
		})
		manager.redPoint:setTip(RedPointConst.LEVIATHAN_LITTLE_GAME_REWARD, slot0)
		manager.redPoint:setTip(RedPointConst.LEVIATHAN_LITTLE_GAME_LEVEL, slot1)
	end,
	RefreshSkadiRewardRedPoint = function ()
		slot0 = nil

		manager.redPoint:setTip(RedPointConst.SKADI_LITTLE_GAME_REWARD, not uv0.ActivityOpenCheck(ActivityConst.SIKADI_GAME) and 0 or SummerLittleGameData:IsSkadiRewardPointShow() and 1 or 0)
	end,
	RefreshLeviathanRewardRedPoint = function ()
		slot0 = nil

		manager.redPoint:setTip(RedPointConst.LEVIATHAN_LITTLE_GAME_REWARD, not uv0.ActivityOpenCheck(ActivityConst.LEVIATHAN_GAME) and 0 or SummerLittleGameData:IsLeviathanRewardPointShow() and 1 or 0)
	end
}
