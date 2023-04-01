slot1 = false
slot2 = manager.notify

slot2:RegistListener(ACTIVITY_REWARD_GET, function (slot0)
	ActivityAffixSelectData:OnScoreRewardGet(slot0.point_reward_id_list)

	slot1 = ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_1_7_AFFIX_SELECT]

	for slot5, slot6 in ipairs(slot0.point_reward_id_list) do
		if table.indexof(slot1, slot6) then
			uv0.UpdateScoreBonusRedPoint()

			break
		end
	end
end)

slot2 = manager.net

slot2:Bind(11073, function (slot0)
	ActivityAffixSelectData:OnPushMainActivityData(slot0)
end)

slot2 = manager.net

slot2:Bind(11075, function (slot0)
	ActivityAffixSelectData:OnPushSubActivityData(slot0)
	uv0.UpdateFirstBonusRedPoint()
	uv0.UpdateUnPassRedPoint()
	uv0.UpdateScoreBonusRedPoint()
end)

return {
	Init = function ()
		uv0 = false
	end,
	InitRedPointKey = function (slot0)
		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.AFFIX_SELECT, slot0), {
			RedPointConst.AFFIX_SELECT_BONUS_UNPASS,
			RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET,
			RedPointConst.AFFIX_SELECT_SCORE_BONUS_CAN_GET
		})
	end,
	UpdateUnPassRedPoint = function ()
		slot0 = ActivityAffixSelectData:GetOpenedSubActivityDatas()
		slot1 = false

		if not uv0 then
			for slot5, slot6 in pairs(slot0) do
				if ActivityData:GetActivityIsOpen(slot6.activityId) and slot6.clearState == 1 then
					slot1 = true

					break
				end
			end
		end

		manager.redPoint:setTip(RedPointConst.AFFIX_SELECT_BONUS_UNPASS, slot1 and 1 or 0)
	end,
	ReadUnPassRedPoint = function ()
		uv0 = true

		uv1.UpdateUnPassRedPoint()
	end,
	UpdateFirstBonusRedPoint = function ()
		slot1 = false

		for slot5, slot6 in pairs(ActivityAffixSelectData:GetOpenedSubActivityDatas()) do
			if ActivityData:GetActivityIsOpen(slot6.activityId) and slot6.clearState == 2 then
				slot1 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET, slot1 and 1 or 0)
	end,
	UpdateScoreBonusRedPoint = function ()
		slot0 = false

		for slot5, slot6 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_1_7_AFFIX_SELECT]) do
			slot7 = ActivityPointRewardCfg[slot6]
			slot9 = slot7.need <= ActivityAffixSelectData:GetTotalScore()
			slot10 = ActivityAffixSelectData:HaveGotScoreReward(slot6)

			if ActivityData:GetActivityIsOpen(slot7.activity_id) and slot9 and not slot10 then
				slot0 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.AFFIX_SELECT_SCORE_BONUS_CAN_GET, slot0 and 1 or 0)
	end,
	GetFirstPassReward = function (slot0)
		manager.net:SendWithLoadingNew(11076, {
			id = slot0
		}, 11077, uv0.OnGetFirstPassRewardCallback)
	end,
	OnGetFirstPassRewardCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityAffixSelectData:OnGetFirstBonus(slot1.id)
			getReward(ActivityAffixSelectCfg[slot1.id].reward_item_list)
			uv0.UpdateFirstBonusRedPoint()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	SetAffixList = function (slot0, slot1)
		manager.net:SendWithLoadingNew(11078, {
			id = slot0,
			affix_id_list = slot1
		}, 11079, uv0.OnSelectAffixListCallback)
	end,
	OnSelectAffixListCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityAffixSelectData:OnSetAffix(slot1.id, slot1.affix_id_list)
		else
			ShowTips(GetTips(slot0.result))
		end
	end
}
