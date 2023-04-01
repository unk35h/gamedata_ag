slot1 = false

return {
	Init = function ()
		if uv0 then
			return
		end

		slot0 = BattleFirstPassData

		slot0:Init()

		slot0 = manager.net

		slot0:Bind(11057, function (slot0)
			BattleFirstPassData:SetData(slot0.shot)
			BattleFirstPassAction:RefreshRedPoint(slot0.shot.activity_id)
		end)

		uv0 = true
	end,
	ReceiveReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(11058, {
			activity_id = slot1,
			first_clear_activity_id = slot2
		}, 11059, handler(slot0, slot0.OnReceiveReward))
	end,
	OnReceiveReward = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			BattleFirstPassData:SetBattleState(slot2.activity_id, slot2.first_clear_activity_id)
			getReward(ActivityFirstClearCfg[slot2.first_clear_activity_id].reward_item_list)
			slot0:RefreshRedPoint(slot2.activity_id)
			manager.notify:CallUpdateFunc(FIRST_REWARD)
		else
			ShowTips(slot1.result)
		end
	end,
	InitRedPointKey = function (slot0)
		slot2 = nil
		slot3 = {}

		for slot7 = 1, #ActivityData:GetActivityData(slot0).subActivityIdList do
			slot8 = nil
		end

		for slot7, slot8 in ipairs(slot1) do
			manager.redPoint:addGroup(RedPointConst.BATTLE_FIRST_PASS .. slot0, {
				RedPointConst.BATTLE_FIRST_PASS .. slot8
			})
			manager.redPoint:addGroup(RedPointConst.BATTLE_FIRST_PASS_REWARD .. slot0, {
				RedPointConst.BATTLE_FIRST_PASS_REWARD .. slot8
			})
		end

		manager.redPoint:addGroup(RedPointConst.BATTLE_FIRST_PASS .. slot0, {
			RedPointConst.BATTLE_FIRST_PASS_REWARD .. slot0
		})
	end,
	RefreshRedPoint = function (slot0, slot1)
		if not ActivityData:GetActivityIsOpen(slot1) then
			return
		end

		slot0.RefreshOnceRedPoint(slot0, slot1)
		slot0.RefreshRewardRedPoint(slot0, slot1)
	end,
	RefreshOnceRedPoint = function (slot0, slot1)
		if BattleFirstPassData:GetBattleFirstPassActivityData(slot1).isNeedRedPoint then
			slot3, slot4 = nil
			slot5 = manager.time:GetServerTime()
			slot7 = BattleFirstPassData:GetBattleFirstPassActivityData(slot1)

			for slot11, slot12 in ipairs(BattleFirstPassData:GetBattleList(slot1)) do
				slot3 = slot7.battleInfo[slot12]

				if ActivityData:GetActivityData(slot12).startTime <= slot5 and slot3.battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.UNFINISHED then
					manager.redPoint:setTip(RedPointConst.BATTLE_FIRST_PASS .. slot12, 1)
				end
			end
		end
	end,
	RefreshRewardRedPoint = function (slot0, slot1)
		slot2 = nil
		slot4 = BattleFirstPassData:GetBattleFirstPassActivityData(slot1)

		for slot8, slot9 in ipairs(BattleFirstPassData:GetBattleList(slot1)) do
			if slot4.battleInfo[slot9].battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.SUCCESS then
				manager.redPoint:setTip(RedPointConst.BATTLE_FIRST_PASS_REWARD .. slot9, 1)
			else
				manager.redPoint:setTip(RedPointConst.BATTLE_FIRST_PASS_REWARD .. slot9, 0)
			end
		end
	end,
	SetOnceRedPointOff = function (slot0, slot1, slot2)
		BattleFirstPassData:SetIsNeedRedPoint(slot1, false)
		manager.redPoint:setTip(RedPointConst.BATTLE_FIRST_PASS .. slot2, 0)
	end
}
