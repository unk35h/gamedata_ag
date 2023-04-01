slot1 = false

return {
	Init = function ()
		if uv0 then
			return
		end

		uv0 = true
		slot0 = LimitedCalculationData

		slot0:Init()

		slot0 = manager.net

		slot0:Bind(60053, function (slot0)
			LimitedCalculationData:SetData(slot0.calculation)
			LimitedCalculationAction:RefreshRedPoint(slot0.calculation.activity_id)
		end)
	end,
	InitRedPointKey = function (slot0)
		manager.redPoint:addGroup(RedPointConst.LIMITED_CALCULATION .. slot0, {
			RedPointConst.LIMITED_CALCULATION_OPEN .. slot0,
			RedPointConst.LIMITED_CALCULATION_REWARD .. slot0
		})
	end,
	OnReceivePointReward = function (slot0, slot1, slot2)
		LimitedCalculationData:SetRewardState(slot1, slot2)
		slot0:RefreshRewardRedPoint(slot1)
	end,
	QueryRankList = function (slot0, slot1)
		manager.net:SendWithLoadingNew(65000, {
			start = 1,
			stop = 100,
			activity_id = LimitedCalculationData:GetRankID(slot1),
			version = LimitedCalculationData:GetRankVersion(slot1)
		}, 65001, function (slot0, slot1)
			if isSuccess(slot0.result) then
				if slot0.version ~= uv0 or uv0 == 0 then
					LimitedCalculationData:SetRankData(uv1, slot0)
				end
			else
				ShowTips(slot0.result)
			end
		end)

		if GuildData:GetGuildInfo().id ~= nil then
			slot6 = manager.net

			slot6:SendWithLoadingNew(33302, {
				activity_id = slot2
			}, 33303, function (slot0, slot1)
				if isSuccess(slot0.result) then
					LimitedCalculationData:SetGuildRankData(uv0, slot0)
				else
					ShowTips(slot0.result)
				end
			end)
		end
	end,
	RefreshRedPoint = function (slot0, slot1)
		if not ActivityData:GetActivityIsOpen(slot1) then
			return
		end

		slot0.RefreshActivityOpenRedPoint(slot0, slot1)
		slot0.RefreshRewardRedPoint(slot0, slot1)
	end,
	RefreshActivityOpenRedPoint = function (slot0, slot1)
		if not LimitedCalculationData:GetIsNeed(slot1) then
			return
		end

		if LimitedCalculationData:GetScore(slot1) and slot3 <= 0 then
			manager.redPoint:setTip(RedPointConst.LIMITED_CALCULATION_OPEN .. slot1, 1)
		end
	end,
	RefreshRewardRedPoint = function (slot0, slot1)
		slot2 = nil
		slot3 = LimitedCalculationData:GetScore(slot1)

		for slot8, slot9 in ipairs(LimitedCalculationData:GetRewardList(slot1)) do
			if ActivityPointRewardCfg[slot9.id].need < slot3 and slot9.complete_flag == ActivityConst.LIMITED_CALCULATION_REWARD_STATE.UNFINISHED then
				manager.redPoint:setTip(RedPointConst.LIMITED_CALCULATION_REWARD .. slot1, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.LIMITED_CALCULATION_REWARD .. slot1, 0)
	end,
	GetAllRewardAction = function (slot0, slot1)
		slot2 = {}
		slot3 = {}
		slot5 = LimitedCalculationData:GetScore(slot1)
		slot6 = nil

		for slot10, slot11 in ipairs(LimitedCalculationData:GetRewardList(slot1)) do
			slot6 = ActivityPointRewardCfg[slot11.id].need

			if slot11.complete_flag <= 0 and slot6 <= slot5 then
				table.insert(slot2, slot11)
				table.insert(slot3, slot11.id)
			end
		end

		slot7 = manager.net

		slot7:SendWithLoadingNew(60054, {
			point_reward_id_list = slot3
		}, 60055, function (slot0, slot1)
			if isSuccess(slot0.result) then
				slot2 = {}

				for slot6, slot7 in pairs(uv0) do
					slot12 = slot7.id

					LimitedCalculationData:SetRewardState(uv1, slot12)

					slot11 = slot7.id

					for slot11, slot12 in pairs(ActivityPointRewardCfg[slot11].reward_item_list) do
						if slot2[slot12[1]] then
							slot2[slot12[1]] = slot2[slot12[1]] + slot12[2]
						else
							slot2[slot12[1]] = slot12[2]
						end
					end
				end

				slot3 = {}

				for slot7, slot8 in pairs(slot2) do
					table.insert(slot3, {
						slot7,
						slot8
					})
				end

				getReward(slot3)
				manager.notify:Invoke(ACTIVITY_REWARD_GET, {
					point_reward_id_list = slot1.point_reward_id_list
				})
				manager.notify:CallUpdateFunc(RECEIVE_POINT_REWARD, slot1.point_reward_id_list)
				uv2:RefreshRewardRedPoint(uv1)
			else
				ShowTips(slot0.result)
			end
		end)
	end
}
