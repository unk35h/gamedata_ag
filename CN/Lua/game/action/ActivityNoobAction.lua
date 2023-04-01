slot1 = false
slot2 = manager.net

slot2:Bind(59011, function (slot0)
	if not uv0 then
		uv1.InitRedPointConst()
	end

	uv0 = true

	ActivityNoobData:InitData(slot0)
	uv1.PlayerUpgradeRedPoint()
	uv1.RefreshAccumulateRedPoint()
	ActivityNewbieTools.RefreshFirstRechargeRedPoint()
	ActivityNewbieTools.RefreshMonthlyCardRedPoint()
	ActivityNewbieTools.RefreshBpRedPoint()

	for slot5, slot6 in ipairs(TaskData:GetNoobPhaseTask()) do
		TaskData:UpdateNoobTaskRedPoint(slot5)
	end
end)

slot2 = manager.net

slot2:Bind(59009, function (slot0)
	if uv0 == true then
		ActivityNoobData:UpdateRecharge(slot0.newbie_recharge_reward)
		manager.notify:Invoke(NEWBIE_RECHARGE_UPDATE)
		ActivityNewbieTools.RefreshFirstRechargeRedPoint()
		ActivityNewbieTools.RefreshMonthlyCardRedPoint()
		ActivityNewbieTools.RefreshBpRedPoint()
	end
end)

slot2 = manager.notify

slot2:RegistListener(PLAYER_LEVEL_UP, function ()
	if uv0 == true then
		uv1.PlayerUpgradeRedPoint()
	end
end)

return {
	PlayerUpgradeRedPoint = function ()
		if not uv0 then
			return
		end

		slot0 = PlayerData:GetPlayerInfo().userLevel
		slot1 = ActivityNoobData:GetUpgradeFinishList()

		for slot5, slot6 in ipairs(GameSetting.levelup_reward.value) do
			if slot0 < slot6[1] then
				manager.redPoint:setTip(RedPointConst.NEWBIE_UPGRADE, 0)

				return
			end

			if not table.keyof(slot1, slot7) then
				manager.redPoint:setTip(RedPointConst.NEWBIE_UPGRADE, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.NEWBIE_UPGRADE, 0)
	end,
	NoobSignIn = function (slot0)
		slot1 = manager.net

		slot1:SendWithLoadingNew(59012, {}, 59013, function (slot0)
			uv0(slot0)
		end)
	end,
	ReceiveUpgradeReward = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(59004, {
			level = slot0
		}, 59005, function (slot0)
			uv0(slot0)
		end)
	end,
	ReceiveRechargeReward = function (slot0, slot1, slot2)
		slot3 = manager.net

		slot3:SendWithLoadingNew(59006, {
			type = slot0,
			reward_type = slot1
		}, 59007, function (slot0)
			if uv0 then
				uv0(slot0)
			end
		end)
	end,
	ReceiveAccumulateReward = function (slot0)
		slot1 = manager.net

		slot1:SendWithLoadingNew(59014, {
			id = slot0
		}, 59015, function (slot0)
			if isSuccess(slot0.result) then
				ActivityNoobData:SetAccumulateReceivedList(uv0)
				uv1.RefreshAccumulateRedPoint()

				slot2 = {
					[#slot2 + 1] = GameSetting.newbie_task.value[uv0][2]
				}

				getReward(slot2)
				manager.notify:Invoke(NOOB_ACCUMULATE_RECEIVE)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	InitRedPointConst = function ()
		slot0 = {}

		for slot4 = 1, 2 do
			slot0[#slot0 + 1] = string.format("%s_%d", RedPointConst.NEWBIE_SIGN, slot4)
		end

		manager.redPoint:addGroup(RedPointConst.NEWBIE_SIGN, slot0)

		slot3 = {}

		for slot7 = 1, #TaskData:GetNoobPhaseTask() do
			slot3[#slot3 + 1] = string.format("%s_%d", RedPointConst.NEWBIE_TASK, slot7)
		end

		slot3[#slot3 + 1] = RedPointConst.NOOB_TASK_ACCUMULATE

		manager.redPoint:addGroup(RedPointConst.NEWBIE_TASK, slot3)
	end,
	RefreshAccumulateRedPoint = function ()
		slot1 = 0

		for slot5, slot6 in pairs(TaskData:GetNoobCompletedList()) do
			slot1 = slot1 + slot6
		end

		slot2 = ActivityNoobData:GetAccumulateReceivedList() or {}

		for slot7, slot8 in ipairs(GameSetting.newbie_task.value) do
			if slot8[1] <= slot1 and not slot2[slot7] then
				manager.redPoint:setTip(RedPointConst.NOOB_TASK_ACCUMULATE, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.NOOB_TASK_ACCUMULATE, 0)
	end
}
