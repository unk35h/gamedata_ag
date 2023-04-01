slot1 = manager.net

slot1:Bind(11043, function (slot0)
	SlayerData:InitSlayerData(slot0)
	SlayerAction.UpdateRedPoint(slot0.slayer.activity_id)
end)

slot1 = manager.notify

slot1:RegistListener(ACTIVITY_UPDATE, function (slot0)
	if ActivityTools.GetActivityType(slot0) == ActivityTemplateConst.SLAYER then
		SlayerAction.UpdateRedPoint(slot0)
	elseif slot1 == ActivityTemplateConst.SLAYER_REGION and ActivityTools.GetMainActivityId(slot0) ~= nil then
		SlayerAction.UpdateRedPoint(slot2)
	end
end)

return {
	QueryPointReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(11044, {
			activity_id = slot0,
			point_reward_id = slot1
		}, 11045, uv0.PointRewardCallBack)
	end,
	PointRewardCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			SlayerData:SetReceivedReward(slot1.activity_id, slot1.point_reward_id)
			getReward(ActivitySlayerPointRewardCfg[slot1.point_reward_id].reward_item_list)
			manager.notify:CallUpdateFunc(SLAYER_REWARD)
			SlayerAction.CheckSlayerRewardRedPoint(slot1.activity_id)
		else
			ShowTips(slot0.result)
		end
	end,
	UpdateRedPoint = function (slot0)
		if not ActivityData:GetActivityIsOpen(slot0) then
			if #ActivityCfg[slot0].sub_activity_list > 0 then
				for slot5, slot6 in ipairs(slot1) do
					manager.redPoint:setTip(string.format("%s_%s_select", RedPointConst.SLYAER_REGIONS, slot6), 0)
					manager.redPoint:setTip(string.format("%s_%s_reward", RedPointConst.SLYAER_REGIONS, slot6), 0)
				end
			end

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SLYAER_REWARD, slot0), 0)

			return
		end

		SlayerAction.CheckSlayerRewardRedPoint(slot0)
		SlayerAction.CheckSlayerRegionRedPoint(slot0)
	end,
	CheckSlayerRegionRedPoint = function (slot0)
		for slot5, slot6 in pairs(ActivityCfg[slot0].sub_activity_list) do
			if not SlayerData:GetRead(slot6) then
				if ActivityData:GetActivityIsOpen(slot6) and SlayerData:GetPoint(slot0, slot6) == 0 then
					manager.redPoint:setTip(string.format("%s_%s_select", RedPointConst.SLYAER_REGIONS, slot6), 1)
				else
					manager.redPoint:setTip(string.format("%s_%s_select", RedPointConst.SLYAER_REGIONS, slot6), 0)
				end
			end
		end
	end,
	CheckSlayerRewardRedPoint = function (slot0)
		slot2 = 0

		for slot6, slot7 in pairs(ActivityCfg[slot0].sub_activity_list) do
			if SlayerData:GetPoint(slot0, slot7) > 0 then
				slot10 = 0

				for slot14, slot15 in ipairs(ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[slot7]) do
					if not SlayerData:GetReceivedReward(slot0, slot15) and ActivitySlayerPointRewardCfg[slot15].need <= slot8 then
						slot2 = 1
						slot10 = 1

						break
					end
				end

				manager.redPoint:setTip(string.format("%s_%s_reward", RedPointConst.SLYAER_REGIONS, slot7), slot10)
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SLYAER_REWARD, slot0), slot2)
	end,
	SetSlayerRead = function (slot0)
		if manager.redPoint:getTipValue(string.format("%s_%s_select", RedPointConst.SLYAER_REGIONS, slot0)) == 1 then
			SlayerData:SetRead(slot0)
			manager.redPoint:setTip(string.format("%s_%s_select", RedPointConst.SLYAER_REGIONS, slot0), 0)
		end
	end,
	GetSlayerRewardState = function (slot0, slot1)
		if SlayerData:GetPoint(slot0, slot1) > 0 then
			for slot7, slot8 in ipairs(ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[slot1]) do
				if not SlayerData:GetReceivedReward(slot0, slot8) and ActivitySlayerPointRewardCfg[slot8].need <= slot2 then
					return true
				end
			end

			return false
		end

		return false
	end
}
