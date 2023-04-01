slot1 = false
slot2 = manager.net

slot2:Bind(59001, function (slot0)
	uv0 = true

	ActivityNewbieData:InitData(slot0)
	uv1.PlayerUpgradeRedPoint()
	ActivityNewbieTools.RefreshFirstRechargeRedPoint()
	ActivityNewbieTools.RefreshMonthlyCardRedPoint()
	ActivityNewbieTools.RefreshBpRedPoint()
end)

slot2 = manager.net

slot2:Bind(59009, function (slot0)
	if uv0 == true then
		ActivityNewbieData:UpdateRecharge(slot0.newbie_recharge_reward)
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
		slot1 = ActivityNewbieData:GetUpgradeFinishList()

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
	NewbieSignIn = function (slot0)
		slot1 = manager.net

		slot1:SendWithLoadingNew(59002, {}, 59003, function (slot0)
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
	end
}
