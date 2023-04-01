slot1 = manager.net

slot1:Bind(64051, function (slot0)
	FireWorkData:InitFireData(slot0)
	uv0.CheckRedPoint(slot0.activity_id)
end)

slot1 = manager.notify

slot1:RegistListener(ACTIVITY_UPDATE, function (slot0)
	if ActivityTools.GetActivityType(slot0) == ActivityTemplateConst.FIRE_WORK then
		FireWorkAction.CheckRedPoint(slot0)
	end
end)

return {
	QueryInvite = function (slot0)
		manager.net:SendWithLoadingNew(64052, {
			activity_id = slot0
		}, 64053, uv0.OnInviteCallBack)
	end,
	OnInviteCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			FireWorkData:SetInvited(slot1.activity_id, true)
			uv0.CheckRedPoint(slot1.activity_id)
			manager.notify:CallUpdateFunc(FIRE_WORK_UPDATE)
			JumpTools.OpenPageByJump("fireWorkResult", {
				isWin = true,
				fire_activity_id = slot1.activity_id
			})
		else
			ShowTips(slot0.result)
		end
	end,
	QueryReceiveReward = function (slot0)
		manager.net:SendWithLoadingNew(64054, {
			activity_id = slot0
		}, 64055, uv0.OnReceiveRewardCallBack)
	end,
	OnReceiveRewardCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			getReward(ActivityFireWorkCfg[slot1.activity_id].reward_item_list)
			FireWorkData:SetRewarded(slot1.activity_id, true)
			uv0.CheckRedPoint(slot1.activity_id)
			manager.notify:CallUpdateFunc(FIRE_WORK_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end,
	CheckRedPoint = function (slot0)
		if ActivityData:GetActivityIsOpen(slot0) and FireWorkData:GetFireData(slot0) then
			if slot1.is_invited and not slot1.is_rewarded then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_REWARD, slot0), 1)
			else
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_REWARD, slot0), 0)
			end

			if slot1.is_invited ~= true and not FireWorkData:GetRead(slot0) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_OPEN, slot0), 1)
			else
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_OPEN, slot0), 0)
			end

			return
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_OPEN, slot0), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_REWARD, slot0), 0)
	end,
	SetRead = function (slot0)
		if manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.FIRE_WORK_OPEN, slot0)) == 1 then
			FireWorkData:SetRead(slot0)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_OPEN, slot0), 0)
		end
	end
}
