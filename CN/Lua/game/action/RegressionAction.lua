slot1 = manager.net

slot1:Bind(62001, function (slot0)
	RegressionData:InitData(slot0)
	uv0.CheckTaskRedPoint()
	uv0.CheckSignRedPoint()
	uv0.ChcekSurveyRedPoint()
	uv0.CheckBPRedPoint()
end)

return {
	QuerySign = function (slot0)
		manager.net:SendWithLoadingNew(62002, {
			index = slot0
		}, 62003, uv0.OnSignBack)
	end,
	OnSignBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = slot1.index

			getReward({
				SignCfg[RegressionCfg[RegressionData:GetRegressionVersion()].sign_reward[slot2]].reward
			})
			RegressionData:UpdateSign(slot2)
			manager.notify:CallUpdateFunc(REGRESSION_SIGN)
			uv0.CheckSignRedPoint()
		else
			ShowTips(slot0.result)
		end
	end,
	QueryRegressionGift = function ()
		manager.net:SendWithLoadingNew(62004, {}, 62005, uv0.OnRegressionGiftBack)
	end,
	OnRegressionGiftBack = function (slot0)
		if isSuccess(slot0.result) then
			RegressionData:UpdateRegressionGift()
			getReward(RegressionCfg[RegressionData:GetRegressionVersion()] and RegressionCfg[slot1].gift or {}, nil, function ()
				gameContext:Back()
				JumpTools.OpenPageByJump("/regressionNew")
			end, true)
			manager.notify:CallUpdateFunc(REGRESSION_GIFT_REWAD)
		else
			ShowTips(slot0.result)
		end
	end,
	SetAccumulateCurrency = function (slot0)
		RegressionData:SetAccumulateCurrency(slot0)
		uv0.CheckBPRedPoint()
	end,
	SetBPTaskIsRecharge = function ()
		RegressionData:SetBPTaskIsRecharge()
		uv0.CheckBPRedPoint()
	end,
	CheckTaskRedPoint = function ()
		if not RegressionData:IsRegressionOpen() then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY), 0)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK), 0)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE), 0)

			return
		end

		uv0.UpdateTaskRedTip(TaskConst.TASK_TYPE.REGRESSION_DAILY, string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY))
		uv0.UpdateTaskRedTip(TaskConst.TASK_TYPE.REGRESSION_WEEK, string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK))
		uv0.UpdateTaskRedTip(TaskConst.TASK_TYPE.REGRESSION_CHALLENGE, string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE))
	end,
	UpdateTaskRedTip = function (slot0, slot1)
		for slot6, slot7 in pairs(TaskData:GetTaskIDList(slot0)) do
			slot8 = TaskData:GetTask(slot7)

			if AssignmentCfg[slot8.id].need <= slot8.progress and slot8.complete_flag < 1 then
				manager.redPoint:setTip(slot1, 1)

				return true
			end
		end

		manager.redPoint:setTip(slot1, 0)
	end,
	CheckSignRedPoint = function ()
		if not RegressionData:IsRegressionOpen() then
			manager.redPoint:setTip(RedPointConst.REGRESSION_SIGN, 0)

			return
		end

		for slot4 = 1, RegressionData:GetSignIndex() do
			if not RegressionData:IsSignReward(slot4) then
				manager.redPoint:setTip(RedPointConst.REGRESSION_SIGN, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.REGRESSION_SIGN, 0)
	end,
	ChcekSurveyRedPoint = function ()
		if not RegressionData:IsRegressionOpen() then
			manager.redPoint:setTip(RedPointConst.REGRESSION_SURVEY, 0)

			return
		end

		for slot4, slot5 in pairs(SurveyData:GetSurveyList()) do
			if slot5.type == 2 and slot5.start_time <= manager.time:GetServerTime() and slot6 <= slot5.stop_time and (slot5.status == 0 or slot5.status == 1) then
				manager.redPoint:setTip(RedPointConst.REGRESSION_SURVEY, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.REGRESSION_SURVEY, 0)
	end,
	CheckBPRedPoint = function ()
		if not RegressionData:IsRegressionOpen() then
			manager.redPoint:setTip(RedPointConst.REGRESSION_BP, 0)

			return
		end

		slot2 = RegressionData:GetBPTaskStatus()
		slot3 = RegressionData:GetBPTaskIsRecharge()
		slot4 = RegressionData:GetAccumulateCurrency()
		slot5 = false

		for slot9, slot10 in ipairs(RegressionCfg[RegressionData:GetRegressionVersion()].regression_bp) do
			if RegressionBPTaskCfg[slot10].need <= slot4 and (slot2[slot10] == nil or slot2[slot10].is_receive_reward < 1 or slot3 >= 1 and slot2[slot10].is_receive_recharge_reward < 1) then
				slot5 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.REGRESSION_BP, slot5 and 1 or 0)
	end,
	ReceiveBPReward = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(62008, {
			bp_submit = slot0
		}, 62009, function (slot0, slot1)
			if isSuccess(slot0.result) then
				slot3 = {}

				for slot7, slot8 in ipairs(slot1.bp_submit) do
					if slot8.receive_type == 1 then
						table.insertto(slot3, RegressionBPTaskCfg[slot8.id].reward)
					else
						table.insertto(slot3, RegressionBPTaskCfg[slot8.id].recharge_reward)
					end
				end

				getReward(mergeReward(slot3))
				RegressionData:SetBPTaskStatus(slot2)
				uv0.CheckBPRedPoint()

				if uv1 then
					uv1()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	RegressionCapsuleToysDraw = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(62006, {
			times = slot0
		}, 62007, function (slot0, slot1)
			if uv0 then
				uv0(slot0, slot1)
			end
		end)
	end
}
