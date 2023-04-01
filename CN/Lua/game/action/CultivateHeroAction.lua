slot1 = false
slot2 = manager.net

slot2:Bind(64077, function (slot0)
	if uv0 == false then
		CultivateHeroData:Init()

		uv0 = true
	end

	CultivateHeroData:SetData(slot0)
end)

slot2 = manager.net

slot2:Bind(64081, function (slot0)
	CultivateHeroData:UpdateHeroTask(slot0)
end)

slot2 = manager.net

slot2:Bind(64083, function (slot0)
	CultivateHeroData:UpdateDailyTask(slot0)
end)

return {
	RequireReceiveAccumulateTask = function (slot0, slot1, slot2)
		slot4 = manager.net

		slot4:SendWithLoadingNew(60054, {
			point_reward_id_list = {
				slot1
			}
		}, 60055, function (slot0)
			if isSuccess(slot0.result) then
				getReward(ActivityPointRewardCfg[uv0].reward_item_list)
				CultivateHeroData:SetReceivedAccumulateTask(uv0, uv1)

				if uv2 then
					uv2()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	RequireReceiveDailyTask = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(64084, {
			activity_id = slot0
		}, 64085, function (slot0)
			if isSuccess(slot0.result) then
				getReward(ActivityCultivateHeroCfg[uv0].daily_reward)
				CultivateHeroData:SetReceivedDailyTask(uv0)

				if uv1 then
					uv1()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	RequireReceiveHeroTaskList = function (slot0, slot1, slot2)
		slot4 = manager.net

		slot4:SendWithLoadingNew(64078, {
			activity_id = slot0,
			task_id_list = slot1
		}, 64079, function (slot0)
			if isSuccess(slot0.result) then
				slot1 = {}

				for slot5, slot6 in ipairs(uv0) do
					table.insertto(slot1, CultivateHeroTaskCfg[slot6].reward)
				end

				getReward(mergeReward(slot1))
				CultivateHeroData:SetReceivedHeroTaskList(uv0, uv1)

				if uv2 then
					uv2()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	InitRedPointKey = function (slot0)
		slot1 = string.format("%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, slot0)
		slot3 = {}
		slot4 = nil

		for slot8, slot9 in ipairs(ActivityCultivateHeroCfg[slot0].group) do
			slot3[#slot3 + 1] = string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, slot0, slot9)
		end

		manager.redPoint:addGroup(slot1, slot3)
		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.CULTIVATE_HERO, slot0), {
			string.format("%s_%s_Select", RedPointConst.CULTIVATE_HERO, slot0),
			slot1,
			string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, slot0),
			string.format("%s_%s_Accumulate_Reward", RedPointConst.CULTIVATE_HERO, slot0)
		})
		manager.notify:RegistListener(ACTIVITY_PT_UPDATE, uv0.OnDailyPtUpdate)
	end,
	OnDailyPtUpdate = function ()
		for slot4, slot5 in ipairs(ActivityCultivateHeroCfg.all) do
			if ActivityData:GetActivityIsOpen(slot5) and uv0 == true then
				CultivateHeroData:RefreshDailyRedPoint(slot5)
			end
		end
	end
}
