slot1 = false

return {
	Init = function ()
		if uv0 then
			return
		end

		uv0 = true
		slot0 = AntitheticalCoupletData

		slot0:Init()

		slot0 = manager.net

		slot0:Bind(61083, function (slot0)
			AntitheticalCoupletData:InitData(slot0)
			AntitheticalCoupletAction:RefreshRedPoint(slot0.activity_id)
		end)
	end,
	InitRedPointKey = function (slot0)
		slot1 = {}

		for slot7, slot8 in ipairs(ActivityData:GetActivityData(slot0).subActivityIdList) do
			table.insert(slot1, RedPointConst.ANTITHETICAL_COUPLET .. "_" .. slot8)
			manager.redPoint:addGroup(RedPointConst.ANTITHETICAL_COUPLET .. "_" .. slot8, {
				RedPointConst.ANTITHETICAL_COUPLET_OPEN .. "_" .. slot8,
				RedPointConst.ANTITHETICAL_COUPLET_REWARD .. "_" .. slot8
			})
		end

		manager.redPoint:addGroup(RedPointConst.ANTITHETICAL_COUPLET .. "_" .. slot0, slot1)
	end,
	GetReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(61080, {
			activity_id = slot1
		}, 61081, handler(uv0, uv0.OnGetReward))
	end,
	OnGetReward = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			AntitheticalCoupletData:SetReward(slot2.activity_id)
			getReward(ActivitySpringFestivalCoupletsCfg[slot2.activity_id].reward_item_list)
			slot0:RefreshRewardRedPoint(slot2.activity_id)
			manager.notify:CallUpdateFunc(ANTITHETICAL_COUPLET_REWARD)
		else
			ShowTips(slot1.result)
		end
	end,
	ChooseStoryID = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(61084, {
			activity_id = slot1,
			select_id = slot2
		}, 61085, handler(uv0, uv0.OnChooseStoryID))
	end,
	OnChooseStoryID = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			AntitheticalCoupletData:SetChooseID(slot2.activity_id, slot2.select_id)
			slot0:RefreshRedPoint(slot2.activity_id)
		else
			ShowTips(slot1.result)
		end
	end,
	RefreshRedPoint = function (slot0, slot1)
		slot0.RefreshOpenRedPoint(slot0, slot1)
		slot0.RefreshRewardRedPoint(slot0, slot1)
	end,
	RefreshOpenRedPoint = function (slot0, slot1)
		if not AntitheticalCoupletData:GetData(slot1) or slot2.isOpen then
			manager.redPoint:setTip(RedPointConst.ANTITHETICAL_COUPLET_OPEN .. "_" .. slot1, 0)
		else
			manager.redPoint:setTip(RedPointConst.ANTITHETICAL_COUPLET_OPEN .. "_" .. slot1, 1)
		end
	end,
	RefreshRewardRedPoint = function (slot0, slot1)
		if AntitheticalCoupletData:GetData(slot1) and slot2.chooseID ~= 0 and not slot2.isReward then
			manager.redPoint:setTip(RedPointConst.ANTITHETICAL_COUPLET_REWARD .. "_" .. slot1, 1)
		else
			manager.redPoint:setTip(RedPointConst.ANTITHETICAL_COUPLET_REWARD .. "_" .. slot1, 0)
		end
	end
}
