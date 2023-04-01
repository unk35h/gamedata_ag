slot1 = false

return {
	Init = function ()
		if uv0 then
			return
		end

		uv0 = true
		slot0 = ValentineGameData

		slot0:Init()

		slot0 = manager.net

		slot0:Bind(64073, function (slot0)
			ValentineGameData:InitData(slot0)
			ValentineGameAction:RefreshRedPoint(slot0.activity_id)
		end)
	end,
	InitRedPointKey = function (slot0)
		slot1 = {}
		slot2 = {}
		slot3 = {}

		for slot9, slot10 in ipairs(ActivityData:GetActivityData(slot0).subActivityIdList) do
			table.insert(slot1, RedPointConst.VALENTINE_GAME .. "_" .. slot10)
			table.insert(slot2, RedPointConst.VALENTINE_GAME_OPEN .. "_" .. slot10)
			table.insert(slot3, RedPointConst.VALENTINE_GAME_REWARD .. "_" .. slot10)
			manager.redPoint:addGroup(RedPointConst.VALENTINE_GAME .. "_" .. slot10, {
				RedPointConst.VALENTINE_GAME_OPEN .. "_" .. slot10,
				RedPointConst.VALENTINE_GAME_REWARD .. "_" .. slot10
			})
		end

		manager.redPoint:addGroup(RedPointConst.VALENTINE_GAME .. "_" .. slot0, slot1)
		manager.redPoint:addGroup(RedPointConst.VALENTINE_GAME_OPEN .. "_" .. slot0, slot2)
		manager.redPoint:addGroup(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. slot0, slot3)
	end,
	GetReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(64070, {
			activity_id = slot1
		}, 64071, handler(uv0, uv0.OnGetReward))
	end,
	OnGetReward = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			getReward(ActivityValentineCfg[slot2.activity_id].reward_item_list)
			ValentineGameData:SetReward(slot2.activity_id)
			slot0:RefreshRewardRedPoint(slot2.activity_id)
			manager.notify:CallUpdateFunc(VALENTINE_GAME_REWARD)
		else
			ShowTips(slot1.result)
		end
	end,
	SetPoint = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(64074, {
			activity_id = slot1,
			point = slot2
		}, 64075, handler(uv0, uv0.OnSetPoint))
	end,
	OnSetPoint = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			ValentineGameData:SetPoint(slot2.activity_id, slot2.point)
			manager.notify:CallUpdateFunc(VALENTINE_RESULT)
		else
			JumpTools.OpenPageByJump("/valentineGameTest", {
				activityId = slot2.activity_id
			})
			ShowTips(slot1.result)
		end
	end,
	RefreshRedPoint = function (slot0, slot1)
		slot0.RefreshOpenRedPoint(slot0, slot1)
		slot0.RefreshRewardRedPoint(slot0, slot1)
	end,
	RefreshOpenRedPoint = function (slot0, slot1)
		if not ValentineGameData:GetData(slot1) or slot2.isOpen then
			manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_OPEN .. "_" .. slot1, 0)
		else
			manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_OPEN .. "_" .. slot1, 1)
		end
	end,
	RefreshRewardRedPoint = function (slot0, slot1)
		if ValentineGameData:GetData(slot1) and slot2.isClear and not slot2.isReward then
			manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. slot1, 1)
		else
			manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. slot1, 0)
		end
	end
}
