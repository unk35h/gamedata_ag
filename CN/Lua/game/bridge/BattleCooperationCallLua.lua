return {
	GotoTeam = function (slot0, slot1)
		print("联机服务端战斗数据返回")
		print("联机收到服务器的消息，获取到新的战斗结果(0:战斗进行中,1:胜利,2:失败,3：主动退出):", slot1.result)

		if BattleConst.BATTLE_RESULT.UNFINISHED < slot1.result and slot1.result <= BattleConst.BATTLE_RESULT.QUIT then
			uv0.goToResult(slot1.result - 1, slot1.star_list)
		end
	end,
	goToResult = function (slot0, slot1)
		_G.PrintAllOpen_ = false

		print("关闭心跳包打印，用于监测网络状态")

		slot3 = {}

		if BattleController.GetInstance():GetBattleStageData():GetThreeStar() and type(slot4) == "table" then
			for slot8 = 1, #slot4 do
				slot9 = slot4[slot8]

				if slot1 and slot1[slot8] then
					table.insert(slot3, {
						id = slot9[1],
						total = slot1[slot8].need_progress,
						current = slot1[slot8].now_progress,
						xData = slot9[2],
						yData = slot9[3],
						isComplete = slot1[slot8].is_achieve == 1 and true or false
					})
				end
			end
		end

		SetForceShowQuanquan(false)

		if _G.CannotConnectTimer then
			_G.CannotConnectTimer:Stop()

			_G.CannotConnectTimer = nil
		end

		if isSuccess(slot0) then
			-- Nothing
		end

		slot6 = slot2:GetStageId()

		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot2:GetType() then
			uv0.GotoCooperationResult(slot0, slot2, slot3)
		else
			uv0.GotoCooperationResult(slot0, slot2, slot3)
		end

		if isSuccess(slot0) then
			if not BattleCallLuaCallBackWait and not BattleCallLuaWaitLoading then
				BattleCallLuaCallBack()

				function BattleCallLuaCallBack()
				end
			end
		else
			BattleCallLuaCallBackWait = false

			if not BattleCallLuaWaitLoading then
				BattleCallLuaCallBack()

				BattleCallLuaCallBack = nil
			end
		end
	end,
	GotoCooperationResult = function (slot0, slot1, slot2)
		if isSuccess(slot0) then
			getRewardData(uv0.GetResultReward(), false)

			function BattleCallLuaCallBack()
				JumpTools.OpenPageByJump("/settlement", {
					result = uv0,
					rewardList = uv1,
					stageData = uv2,
					starMissionData = uv3,
					battleResult = {}
				})
				EndBattleLogic(uv0)
			end

			return
		end

		uv0.GotoBattleFaild(slot0, slot1)
	end,
	GotoBattleFaild = function (slot0, slot1)
		function BattleCallLuaCallBack()
			gameContext:Go("/battleCooperationFailed", {
				stageData = uv0
			})
			EndBattleLogic(uv1)
		end
	end,
	GetResultReward = function ()
		slot0 = {}
		slot1 = {}
		slot4 = BattleFieldData
		slot6 = slot4

		for slot5, slot6 in ipairs(slot4.GetBattleResultData(slot6).dropList) do
			slot1[slot6.battleTimes] = {}

			for slot10, slot11 in ipairs(slot6.rewardItems) do
				print(string.format("服务端发下第%s次物品数据id:", slot6.battleTimes), slot11.id, "num:", slot11.num)
				table.insert(slot1[slot6.battleTimes], {
					slot11.id,
					slot11.num
				})
				table.insert(slot0, {
					slot11.id,
					slot11.num
				})
			end
		end

		return slot0, slot1
	end
}
