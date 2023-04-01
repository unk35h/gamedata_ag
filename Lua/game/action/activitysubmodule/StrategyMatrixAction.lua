slot1 = manager.net

slot1:Bind(29001, function (slot0)
	StrategyMatrixData:InitMatrixUser(slot0.activity)
	StrategyMatrixAction.CheckRedPoint(slot0.activity.activity_id)
end)

slot1 = manager.net

slot1:Bind(29005, function (slot0)
	StrategyMatrixData:InitMatrixOver(slot0.end_info)
end)

slot1 = manager.notify

slot1:RegistListener(ACTIVITY_UPDATE, function (slot0)
	if ActivityTools.GetActivityType(slot0) == ActivityTemplateConst.STRATEGY_MATRIX then
		StrategyMatrixAction.CheckRedPoint(slot0)
	end
end)

return {
	QueryStartMatrix = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(29012, {
			hero_id_list = slot0,
			activity_id = slot1,
			custom_affix_id_list = slot2
		}, 29013, uv0.StartMatrixCallBack)
	end,
	StartMatrixCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			StrategyMatrixData:UpdateMatrixProcess(slot1.activity_id, MatrixConst.STATE_TYPE.STARTED, slot0.progress)
			StrategyMatrixAction.JumpToStrategyMatrix(slot1.activity_id)
			StrategyMatrixData:SetMatrixBattleHeroTeam(slot1.activity_id, nil)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryNextProgress = function (slot0, slot1)
		manager.net:SendWithLoadingNew(29010, {
			activity_id = slot0,
			params = slot1 or {
				0
			}
		}, 29011, uv0.NextProgressCallBack)
	end,
	NextProgressCallBack = function (slot0, slot1)
		slot2 = slot1.activity_id

		if isSuccess(slot0.result) then
			StrategyMatrixData:UpdateMatrixProcess(slot1.activity_id, MatrixConst.STATE_TYPE.STARTED, slot0.progress)

			if StrategyMatrixData:GetGameState(slot2) == MatrixConst.STATE_TYPE.STARTED then
				if StrategyMatrixData:GetMatrixPhaseData(slot2):GetPhase() == 2 then
					uv0.DoEvent(slot2)
				elseif slot5 == 1 then
					StrategyMatrixAction.JumpToStrategyMatrix(slot2)
				else
					JumpTools.GoToSystem("/matrixBlank/strategyMatrixProcess", {
						matrix_activity_id = slot2
					})
				end
			elseif slot3 == MatrixConst.STATE_TYPE.SUCCESS or slot3 == MatrixConst.STATE_TYPE.FAIL then
				OpenPageUntilLoaded("/matrixBlank/strategyMatrixOver", {
					matrix_activity_id = slot2
				})
			else
				StrategyMatrixAction.GotoStrategyMatrixPrepare(slot2)
			end

			manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end,
	DoEvent = function (slot0)
		if not (StrategyMatrixData:GetMatrixPhaseData(slot0):GetParams()[1] and StrategyMatrixEventTemplateCfg[slot2]) then
			error("StrategyMatrixEventTemplateCfg cant find event by id :" .. slot2)

			return
		end

		if MatrixConst.EVENT_TYPE.SHOP == slot3.event_type then
			JumpTools.GoToSystem("/matrixBlank/strategyMatrixProcessShop", {
				matrix_activity_id = slot0,
				shops = slot1:GetShops()
			})
		elseif MatrixConst.EVENT_TYPE.INCIDENT == slot3.event_type then
			JumpTools.GoToSystem("/strategyMatrixIncident", {
				matrix_activity_id = slot0
			})
		else
			BattleController.GetInstance():LaunchBattle(BattleStrategyMatrixTemplate.New(slot1:GetData(), slot0, StrategyMatrixData:GetTierID(slot0)))
		end
	end,
	QueryMatrixOver = function (slot0)
		manager.net:SendWithLoadingNew(29020, {
			activity_id = slot0
		}, 29021, uv0.MatrixOverCallBack)
	end,
	MatrixOverCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			StrategyMatrixData:UpdateMatrixProcess(slot1.activity_id, MatrixConst.STATE_TYPE.NOTSTARTED, slot0.progress)

			slot2 = slot1.activity_id

			StrategyMatrixAction.QueryStartMatrix(StrategyMatrixCfg[slot2].hero_standard_system_id_list, slot2, {})
			manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryMatrixGiveUp = function (slot0)
		manager.net:SendWithLoadingNew(29024, {
			activity_id = slot0
		}, 29025, uv0.MatrixGiveUpCallBack)
	end,
	MatrixGiveUpCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			StrategyMatrixData:UpdateMatrixProcess(slot1.activity_id, MatrixConst.STATE_TYPE.FAIL, slot0.progress)
			JumpTools.GoToSystem("/matrixBlank/strategyMatrixOver", {
				matrix_activity_id = slot1.activity_id
			})
			manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end,
	BuyShopItem = function (slot0, slot1, slot2, slot3)
		slot5, slot6 = StrategyMatrixData:GetMatrixPhaseData(slot0):GetData()

		for slot10, slot11 in ipairs(slot6) do
			if slot11.index == slot1 then
				manager.net:SendWithLoadingNew(29010, {
					activity_id = slot0,
					params = {
						2,
						slot1,
						slot2,
						slot3 or 0
					}
				}, 29011, uv0.OnBuyShopItem)

				return
			end
		end
	end,
	OnBuyShopItem = function (slot0, slot1)
		if isSuccess(slot0.result) then
			StrategyMatrixData:UpdateMatrixProcess(slot1.activity_id, MatrixConst.STATE_TYPE.STARTED, slot0.progress)
			ShowTips("TRANSACTION_SUCCESS")
			manager.notify:CallUpdateFunc(MATRIX_SHOP_BUY_SUCCESS)
			manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryRefreshShopItem = function (slot0)
		slot4 = StrategyMatrixData:GetShopFressRefreshTimes(slot0)

		if StrategyMatrixData:GetMatrixPhaseData(slot0):GetData() < StrategyMatrixData:GetShoRefreshTimes(slot0) then
			slot5 = GameSetting.matrix_shop_refresh_cost_item_list.value

			if slot4 <= slot2 then
				if StrategyMatrixData:GetMatrixCoint(slot0) < slot5[math.min(slot2 - slot4 + 1, #slot5)][2] then
					ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

					return
				end

				manager.net:SendWithLoadingNew(29010, {
					activity_id = slot0,
					params = {
						1
					}
				}, 29011, uv0.OnRefrshShopItem)
			else
				manager.net:SendWithLoadingNew(29010, {
					activity_id = slot0,
					params = {
						1
					}
				}, 29011, uv0.OnRefrshShopItem)
			end
		end
	end,
	OnRefrshShopItem = function (slot0, slot1)
		if isSuccess(slot0.result) then
			StrategyMatrixData:UpdateMatrixProcess(slot1.activity_id, MatrixConst.STATE_TYPE.STARTED, slot0.progress)
			ShowTips("ASTROLABE_RESET")
			manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end,
	GotoStrategyMatrix = function (slot0, slot1)
		if not ActivityTools.GetActivityIsOpenWithTip(slot0) then
			return
		end

		if StrategyMatrixData:GetGameState(slot0) == MatrixConst.STATE_TYPE.SUCCESS or slot2 == MatrixConst.STATE_TYPE.FAIL then
			OpenPageUntilLoaded("/matrixBlank/strategyMatrixOver", {
				matrix_activity_id = slot0
			})
		elseif slot2 == MatrixConst.STATE_TYPE.NOTSTARTED then
			StrategyMatrixAction.QueryStartMatrix(StrategyMatrixCfg[slot0].hero_standard_system_id_list, slot0, {})
		elseif slot2 == MatrixConst.STATE_TYPE.STARTED then
			if StrategyMatrixData:GetMatrixPhaseData(slot0):GetPhase() == 3 then
				JumpTools.GoToSystem("/matrixBlank/strategyMatrixProcess", {
					matrix_activity_id = slot0
				})
			else
				StrategyMatrixAction.JumpToStrategyMatrix(slot0, slot1)
			end
		end
	end,
	GotoAfterBattleMatirx = function (slot0)
		if not ActivityTools.GetActivityIsOpenWithTip(slot0) then
			OpenPageUntilLoaded("/home", {})

			return
		end

		if StrategyMatrixData:GetGameState(slot0) == MatrixConst.STATE_TYPE.SUCCESS or slot1 == MatrixConst.STATE_TYPE.FAIL then
			OpenPageUntilLoaded("/matrixBlank/strategyMatrixOver", {
				matrix_activity_id = slot0
			})
		elseif slot1 == MatrixConst.STATE_TYPE.STARTED then
			if StrategyMatrixData:GetMatrixPhaseData(slot0):GetPhase() == 3 then
				OpenPageUntilLoaded("/matrixBlank/strategyMatrixProcess", {
					matrix_activity_id = slot0
				})
			else
				StrategyMatrixAction.JumpToStrategyMatrix(slot0)
			end
		end
	end,
	GotoStrategyMatrixPrepare = function (slot0)
		OpenPageUntilLoaded("/thirdVolumePart2Main", {})
	end,
	CheckAllRedPoint = function ()
		slot0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRATEGY_MATRIX] or {}

		for slot4, slot5 in ipairs(slot0) do
			StrategyMatrixAction.CheckRedPoint(slot5)
		end
	end,
	CheckRedPoint = function (slot0)
		if not ActivityData:GetActivityIsOpen(slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, slot0), 0)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, slot0), 0)

			return
		end

		if slot0 == ActivityConst.OSHINAS_MATRIX then
			StrategyMatrixAction.UpdateTaskRedTip(TaskConst.TASK_TYPE.STRATEGY_MATRIX, slot0)
			StrategyMatrixAction.UpdateOpenRedPoint(TaskConst.TASK_TYPE.STRATEGY_MATRIX, slot0)
		elseif slot0 == ActivityConst.STRATEGY_MATRIX_THOR then
			StrategyMatrixAction.UpdateTaskRedTip(TaskConst.TASK_TYPE.STRATEGY_MATRIX, slot0)
			StrategyMatrixAction.UpdateOpenRedPoint(TaskConst.TASK_TYPE.STRATEGY_MATRIX, slot0)
		elseif slot0 == ActivityConst.STRATEGY_MATRIX_THOR_HARD then
			StrategyMatrixAction.UpdateTaskRedTip(TaskConst.TASK_TYPE.STRATEGY_MATRIX, slot0)

			if StrategyMatrixData:GetIsClearance(ActivityConst.STRATEGY_MATRIX_THOR) then
				StrategyMatrixAction.UpdateOpenRedPoint(TaskConst.TASK_TYPE.STRATEGY_MATRIX, slot0)
			else
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, slot0), 0)
			end
		end
	end,
	UpdateTaskRedTip = function (slot0, slot1)
		for slot6, slot7 in pairs(TaskData:GetTaskIDList(slot0)) do
			slot8 = TaskData:GetTask(slot7)

			if AssignmentCfg[slot8.id].need <= slot8.progress and slot8.complete_flag < 1 then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, slot1), 1)

				return true
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, slot1), 0)
	end,
	UpdateOpenRedPoint = function (slot0, slot1)
		if not StrategyMatrixData:GetRead(slot1) then
			for slot6, slot7 in pairs(TaskData:GetTaskIDList(slot0)) do
				if not TaskData:GetTaskComplete(slot7) then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, slot1), 1)

					return
				end
			end

			return
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, slot1), 0)
	end,
	SetStrategyRead = function (slot0)
		StrategyMatrixData:SetRead(slot0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, slot0), 0)
	end,
	JumpToStrategyMatrix = function (slot0, slot1)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.VOLUME_DOWN then
			OpenPageUntilLoaded("/matrixBlank/strategyMatrix", {
				matrix_activity_id = slot0,
				playerAnim = slot1
			})
		elseif slot2 == 12 then
			OpenPageUntilLoaded("/matrixBlank/strategyMatrixThor", {
				matrix_activity_id = slot0,
				playerAnim = slot1
			})
		end
	end
}
