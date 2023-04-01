slot1 = false

return {
	Init = function ()
		if uv0 then
			return
		end

		uv0 = true
		slot0 = CowboyData

		slot0:Init()

		slot0 = manager.net

		slot0:Bind(61013, function (slot0)
			CowboyData:InitData(slot0)
			CowboyAction:RefreshRedPoint(slot0.activity_id)
		end)
	end,
	InitRedPointKey = function (slot0)
		slot1 = {}
		slot2 = {}

		for slot8, slot9 in ipairs(ActivityData:GetActivityData(slot0).subActivityIdList) do
			table.insert(slot1, RedPointConst.COWBOY_OPEN .. "_" .. slot9)
			table.insert(slot2, RedPointConst.COWBOY_REWARD .. "_" .. slot9)
		end

		manager.redPoint:addGroup(RedPointConst.COWBOY_OPEN .. "_" .. slot0, slot1)
		manager.redPoint:addGroup(RedPointConst.COWBOY_REWARD .. "_" .. slot0, slot2)
		manager.redPoint:addGroup(RedPointConst.COWBOY .. "_" .. slot0, {
			RedPointConst.COWBOY_OPEN .. "_" .. slot0,
			RedPointConst.COWBOY_REWARD .. "_" .. slot0
		})
	end,
	SendActivityInfo = function (slot0, slot1, slot2, slot3, slot4)
		slot6 = manager.net

		slot6:SendWithLoadingNew(61014, {
			activity_id = slot2,
			activity_point = slot3
		}, 61015, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 then
					uv0()
				end

				uv1:RefreshReward(uv2)
			else
				ShowTips(slot0.result)
				JumpTools.OpenPageByJump("/cowboy", {
					activityId = uv3
				})
			end
		end)
	end,
	GetReward = function (slot0, slot1, slot2)
		slot4 = manager.net

		slot4:SendWithLoadingNew(61010, {
			point_id = slot2
		}, 61011, function (slot0)
			if isSuccess(slot0.result) then
				CowboyData:SetReward(uv0, uv1)
				getReward(ActivityPointRewardCfg[uv1].reward_item_list)
				uv2:RefreshReward(uv0)
				manager.notify:CallUpdateFunc(COWBOY_REWARD)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	RefreshRedPoint = function (slot0, slot1)
		if not ActivityData:GetActivityData(slot1):IsActivitying() then
			manager.redPoint:setTip(RedPointConst.COWBOY_OPEN .. "_" .. slot1, 0)
			manager.redPoint:setTip(RedPointConst.COWBOY_REWARD .. "_" .. slot1, 0)

			return
		end

		slot0.RefreshOpen(slot0, slot1)
		slot0.RefreshReward(slot0, slot1)
	end,
	RefreshOpen = function (slot0, slot1)
		if ActivityCfg[slot1].activity_template == ActivityTemplateConst.COWBOY then
			return
		end

		slot3 = ActivityData:GetActivityData(slot1)

		if not CowboyData:GetOpen(slot1) and slot3.IsActivitying(slot3) then
			manager.redPoint:setTip(RedPointConst.COWBOY_OPEN .. "_" .. slot1, 1)
		else
			manager.redPoint:setTip(RedPointConst.COWBOY_OPEN .. "_" .. slot1, 0)
		end
	end,
	RefreshReward = function (slot0, slot1)
		if not ActivityData:GetActivityData(slot1):IsActivitying() then
			return
		end

		manager.redPoint:setTip(RedPointConst.COWBOY_REWARD .. "_" .. slot1, CowboyData:IsRewardRedPointShow(slot1) and 1 or 0)
	end,
	CloseActivity = function (slot0, slot1)
		if ActivityData:GetActivityData(slot1):IsActivitying() then
			return
		end

		slot2 = ActivityCfg[slot1].sub_activity_list or {}

		for slot6, slot7 in ipairs(slot2) do
			manager.redPoint:setTip(RedPointConst.COWBOY_OPEN .. "_" .. slot7, 0)
			manager.redPoint:setTip(RedPointConst.COWBOY_REWARD .. "_" .. slot7, 0)
		end
	end
}
