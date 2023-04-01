slot1 = false

return {
	Init = function ()
		if uv0 then
			return
		end

		uv0 = true
		slot0 = SurviveSoloData

		slot0:Init()

		slot0 = manager.net

		slot0:Bind(61053, function (slot0)
			slot1 = slot0.activity_info

			SurviveSoloData:InitData(slot1)
			SurviveSoloAction:RefreshRedPoint(slot1.activity_id)
		end)
	end,
	InitRedPointKey = function (slot0)
		slot1 = {}
		slot2 = {}

		for slot8, slot9 in ipairs(ActivityData:GetActivityData(slot0).subActivityIdList) do
			table.insert(slot1, RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. slot9)
			table.insert(slot2, RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. slot9)
		end

		manager.redPoint:addGroup(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. slot0, slot1)
		manager.redPoint:addGroup(RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. slot0, slot2)
		manager.redPoint:addGroup(RedPointConst.SOLO_SURVIVE .. "_" .. slot0, {
			RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. slot0,
			RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. slot0
		})
	end,
	GetReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(61054, {
			id = slot1,
			time = slot2
		}, 61055, handler(uv0, uv0.OnGetReward))
	end,
	OnGetReward = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			slot4 = {}

			for slot8, slot9 in ipairs(ActivitySoloSlayerCfg[slot2.id].reward_item_list) do
				if slot9[1] == slot2.time then
					slot4 = slot9[2]

					break
				end
			end

			SurviveSoloData:SetReward(slot2.id, slot2.time)
			getReward(slot4)
			slot0:RefreshRewardRedPoint(slot2.id)
			manager.notify:CallUpdateFunc(SURVIVE_SOLO_REWARD)
		else
			ShowTips(slot1.result)
		end
	end,
	RefreshRedPoint = function (slot0, slot1)
		slot0.RefreshOpenRedPoint(slot0, slot1)
		slot0.RefreshRewardRedPoint(slot0, slot1)
	end,
	RefreshOpenRedPoint = function (slot0, slot1)
		if not SurviveSoloData:GetData(slot1) or slot2.time >= 0 then
			manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. slot1, 0)
		else
			manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. slot1, 1)
		end
	end,
	RefreshRewardRedPoint = function (slot0, slot1)
		slot3 = false

		if SurviveSoloData:GetData(slot1) then
			slot4 = slot2.time
			slot5 = slot2.rewards

			for slot10, slot11 in ipairs(ActivitySoloSlayerCfg[slot1].reward_item_list) do
				if slot11[1] <= slot4 and not table.indexof(slot5, slot11[1]) then
					slot3 = true

					break
				end
			end
		else
			slot3 = false
		end

		manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. slot1, slot3 and 1 or 0)
	end
}
