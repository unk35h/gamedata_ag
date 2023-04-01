BattleCooperationCallLua = require("game/bridge/BattleCooperationCallLua")
slot0 = false

function ShowBattlePausePage(slot0, slot1)
	slot2 = BattleController.GetInstance():GetBattleStageData()

	if not BattleFieldData:IsInBattle() and BattleConst.STAGE_TYPE_NEW.POLYHEDRON ~= slot2.GetType(slot2) then
		return
	end

	CheckManagers()

	if BattleConst.STAGE_TYPE_NEW.POLYHEDRON ~= slot2.GetType(slot2) then
		gameContext.oldRoutes_ = {}
	end

	slot3 = BattleInstance.CaculateStarMission(slot2, slot0)
	slot4 = slot2.GetStageId(slot2)
	slot6 = SettingConst.SETTING_TYPE.BATTLE_OTHER

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot2.GetType(slot2) then
		slot6 = SettingConst.SETTING_TYPE.BATTLE_MAIN
	end

	gameContext:Go("/setting", {
		setType = slot6,
		section = slot4,
		result = slot0,
		starMissionData = slot3,
		newbie = slot1,
		stageData = slot2
	})
	OperationRecorder.Record("BattleCallLua", "combat_pause")
end

slot1 = 202005
slot2 = 200005
_G.BATTLE_SERVER_ERROR_TIME = 0

function BattleServerConnectError(slot0)
	if slot0 == uv0 then
		LuaExchangeHelper.EndWaitReadyAck()
		CheckManagers()
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("COOPERATION_NOT_JOIN_AFTER_OTHERS_READY"),
			OkCallback = function ()
				slot0 = gameContext

				slot0:DestroyCurRoutes()
				CooperationAction.LeaveCooperationBattle(function (slot0)
					BattleInstance.QuitBattle(BattleController.GetInstance():GetBattleStageData(), true)
				end)
			end
		})

		return
	end

	if slot0 ~= uv1 then
		CheckManagers()

		function BattleCallLuaCallBack()
			print("与战斗服连接出现错误，玩家白打，返回登录界面")
		end
	end

	_G.BATTLE_SERVER_ERROR_TIME = _G.BATTLE_SERVER_ERROR_TIME + 1

	ConnectionHelper.OnBattleServerConnectError(slot0, _G.BATTLE_SERVER_ERROR_TIME)
end

function ShowStory(slot0, slot1, slot2)
	CheckManagers()

	gameContext.oldRoutes_ = {}
	slot3 = manager.story

	slot3:StartBattleStory(slot0, function ()
		gameContext:DestroyCurRoutes()
		LuaExchangeHelper.ActionInvoke(uv0)
	end, slot1)
end

function GetMardukePlane()
	return TowerGameData:GetCanUsePlane()
end

function SendQuitBattle(slot0, slot1)
	uv0 = slot1

	manager.uiInit()

	gameContext.oldRoutes_ = {}

	print("客户端战斗结束，准备向服务端请求战斗结果")

	if BattleConst.STAGE_TYPE_NEW.POLYHEDRON ~= BattleController.GetInstance():GetBattleStageData():GetType() then
		BattleInstance.hideBattlePanel()
	end

	whereami = "battleResult"
	_G.PrintAllOpen_ = true

	print("开启心跳包打印，用于监测网络状态")
	print("网络连接状态是否可用：", Application.internetReachability ~= UnityEngine.NetworkReachability.NotReachable)
	print("网络连接状态是否为局域网：", Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork)
	SDKTools.SendMessageToSDK("load_time_before_battle", {
		combat_id = slot2:GetStageId(),
		battle_id = BattleFieldData:GetServerBattleID(),
		use_milliseconds = slot0.loadMilliseconds,
		battle_version = LuaForUtil.GetBattleVersion()
	})
	manager.achievementTips:FliteAchievementType({
		AchievementConst.AchievementType.MISSION,
		AchievementConst.AchievementType.BATTLE
	})

	if slot2:GetIsCooperation() then
		slot6 = manager.net

		slot6:SendWithLoadingNew(54110, {
			battle_id = slot3
		}, 54111, function (slot0, slot1)
			BattleFieldData:FishCooperationBattle(slot0)
			gameContext:DestroyCurRoutes()
			BattleCooperationCallLua.GotoTeam(uv0, slot0.battle_result)
		end)
	else
		slot6 = manager.net

		slot6:SendWithLoadingNew(54032, {
			battle_id = slot3
		}, 54033, function (slot0, slot1)
			BattleFieldData:FinishBattle(slot0)
			gameContext:DestroyCurRoutes()
			GotoTeam(uv0, slot0.battle_result, slot0.result)
		end)
	end

	BattleCallLuaWaitLoading = true

	PreLoadAsset({
		["Atlas/BattleSettlement"] = 20,
		["Atlas/NewBattleSettlement"] = 20
	}, 0, function ()
		for slot3, slot4 in pairs(uv0) do
			LuaForUtil.PreLoadAtlas(slot3)
		end

		BattleCallLuaWaitLoading = false

		if BattleCallLuaCallBack and not BattleCallLuaCallBackWait then
			BattleCallLuaCallBack()

			BattleCallLuaCallBack = nil
		end
	end, true)
end

function GotoTeam(slot0, slot1, slot2)
	print("服务端战斗数据返回")
	print("收到服务器的消息，获取到新的战斗结果(0:战斗进行中,1:胜利,2:失败,3：主动退出):", slot1.result)

	if BattleConst.BATTLE_RESULT.UNFINISHED < slot1.result and slot1.result <= BattleConst.BATTLE_RESULT.QUIT then
		goToResult(slot1.result - 1, slot1.star_list, {
			challengedNumber = slot1.clear_times,
			clear_times = slot1.clear_times,
			errorCode = slot2
		})
	end
end

function goToResult(slot0, slot1, slot2)
	_G.PrintAllOpen_ = false

	print("关闭心跳包打印，用于监测网络状态")

	slot4 = {}

	if BattleController.GetInstance():GetBattleStageData():GetThreeStar() and type(slot5) == "table" then
		for slot9 = 1, #slot5 do
			slot11 = slot5[slot9]

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == slot3.GetType(slot3) then
				if slot1 and slot1[slot9] then
					table.insert(slot4, {
						id = slot11[1],
						total = slot1[slot9].need_progress,
						current = slot1[slot9].now_progress,
						xData = slot11[2],
						yData = slot11[3],
						isComplete = slot1[slot9].is_achieve == 1 and true or false
					})

					if slot1[slot9].is_achieve == 1 and (isSuccess(slot0) or slot11[1] == 15 or slot11[1] == 16) then
						MythicData:UpdateStarIndex(slot9)
					end
				end
			elseif slot1 and slot1[slot9] then
				table.insert(slot4, {
					id = slot11[1],
					total = slot1[slot9].need_progress,
					current = slot1[slot9].now_progress,
					xData = slot11[2],
					yData = slot11[3],
					isComplete = slot1[slot9].is_achieve == 1 and true or false
				})
			end
		end
	end

	SetForceShowQuanquan(false)

	if _G.CannotConnectTimer then
		_G.CannotConnectTimer:Stop()

		_G.CannotConnectTimer = nil
	end

	ViewAnimationManager.isReturnFromBattle = true

	if isSuccess(slot0) and isSuccess(slot2.errorCode) then
		slot6, slot7 = slot3:GetHeroTeam()
		slot8 = slot3:GetSystemHeroTeam()
		slot9 = slot3:GetMultiple()
		slot10 = slot2.clear_times * GameSetting.mastery_gain.value[1]

		for slot14 = 1, #slot6 do
			if slot8[slot14] == nil and slot6[slot14] ~= 0 and (slot7[slot14] == nil or slot7[slot14] == 0) then
				HeroData:HeroClearTimesModify(slot6[slot14], slot10)
				ArchiveData:AddExp(HeroTools.GetHeroOntologyID(slot6[slot14]), GameSetting.hero_love_exp_gain.value[1] * slot9)
			end
		end

		HeroAction.UpdateHeartRedPoint()
		HeroAction.UpdateStoryRedPoint()

		slot11, slot12, slot13, slot14 = slot3:GetRevive()

		if slot11 and slot12 ~= 0 then
			CurrencyAction.CurrencyModify(slot12, -1 * LuaExchangeHelper.GetBattleStatisticsData().dataForLua.resurrectTimes * slot14)
		end
	end

	slot7 = slot3:GetStageId()

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot3:GetType() or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT == slot6 then
		GotoChapterStage(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY == slot6 or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == slot6 or BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_GAME == slot6 or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT == slot6 then
		GotoMultipleResult(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == slot6 then
		if isSuccess(slot0) then
			TowerData:UpdateOverTower(getChapterIDByStageID(slot7), slot7)
		end

		GotoStage(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == slot6 then
		GotoBossNormalChallenge(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE == slot6 then
		GotoBossAdvanceChallenge(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == slot6 then
		if isSuccess(slot0) and not MythicData:GetIsNew() then
			MythicData:UpdatePartitionState(slot3:GetDest())
		end

		MythicAction:UpdateMythicRedTip()
		GotoStage(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == slot6 then
		if isSuccess(slot0) then
			MatrixAction.DoAfterEvnet(MatrixData:GetBattleTier())
		end

		GotoMatrix(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS == slot6 then
		if isSuccess(slot0) then
			manager.ChessManager:BattleSuccess()
		end

		manager.ChessManager.forceBattle:BattleResult(isSuccess(slot0))
		GotoStage(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON == slot6 then
		GotoStage(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.NEW_DEMON == slot6 then
		GotoStage(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.RACE_TRAIL == slot6 then
		GotoRaceTrail(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.SLAYER == slot6 then
		GotoSlayerResult(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.TOWER_DEFENCE == slot6 then
		GotoStage(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE == slot6 then
		GotoSoloChallenge(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION == slot6 then
		GotoScoreStage(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.SKADI_GAME == slot6 then
		GotoSkadiResult(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == slot6 then
		GotoActivityMatrixResult(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE == slot6 then
		GotoGuildBoss(1, slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE == slot6 then
		GotoGuildBoss(2, slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE == slot6 then
		GoToActivityRaceResult(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX == slot6 then
		GotoActivityMatrixResult(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL == slot6 then
		GotoEquipBreakThrough(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == slot6 then
		GotoMythicFinalStage(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY == slot6 then
		GotoGuildActivity(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE == slot6 then
		GotoSequentialBattleResult(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO == slot6 then
		GotoSoloSurvive(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL == slot6 then
		GotoMardukSpecial(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS == slot6 then
		GotoActivityWorldBoss(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT == slot6 then
		GotoScoreResult(ActivityAffixSelectData:GetLevelScore(slot3:GetActivityID()), slot0, slot3, slot4, slot2, true)
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL == slot6 then
		GotoMultipleResult(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE == slot6 then
		GotoActivityPt2ChallengeStage(slot0, slot3, slot4, slot2)
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD == slot6 then
		GotoScoreResult(ActivityPt2Data:GetHardScore(), slot0, slot3, slot4, slot2, true)
	elseif BattleConst.STAGE_TYPE_NEW.ABYSS == slot6 then
		slot8 = 1

		if isSuccess(slot0) then
			GotoAbyssSuccess(AbyssData:GetStageScore(slot3:GetLayerId(), slot3:GetStageIndex()), slot0, slot3, slot4, slot2)
		elseif slot3:IsBoss() then
			slot11 = 0
			slot12 = AbyssData:GetCurrentBossPhase()

			if LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas:TryGetValue(37, nil) then
				slot11 = slot9[37] or 0
			end

			if slot9:TryGetValue(36, slot10) then
				slot12 = slot9[36] or 0
			end

			slot13 = AbyssData:GetBossTotalHp(slot3:GetStageId())

			if slot2.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
				GotoAbyssBossFailed(slot13, slot13, slot0, slot3, slot2)
			else
				slot17 = slot11 / (AbyssData:GetPhaseBossHp(slot3:GetStageId(), slot12) * AbyssData:GetStageData(slot3:GetLayerId(), slot3:GetStageIndex()).boss_hp_rate / 1000)

				if not slot9:TryGetValue(37, slot10) then
					slot17 = 1
				end

				GotoAbyssBossFailed(AbyssData:ConvertPhaseBossHpToTotal(slot3:GetStageId(), slot12, slot15.boss_hp_rate * slot17), slot13, slot0, slot3, slot2)
			end
		else
			function BattleCallLuaCallBack()
				slot0 = uv0
				slot1 = manager.story

				slot1:CheckBattleStory(slot0:GetStageId(), manager.story.LOSE, function ()
					gameContext:Go("/battlefailedWithButton", {
						stageData = uv0,
						battleResult = uv1
					})
					manager.story:RemovePlayer()
					EndBattleLogic(uv2)
				end)
			end
		end
	elseif BattleConst.STAGE_TYPE_NEW.POLYHEDRON == slot6 then
		GotoPolyhedron(slot0, slot3, slot4, slot2)
	else
		GotoStage(slot0, slot3, slot4, slot2)
	end

	if not BattleCallLuaCallBackWait and not BattleCallLuaWaitLoading then
		BattleCallLuaCallBack()

		BattleCallLuaCallBack = nil
	end
end

function ShowSettlement()
	print("收到允许弹出结算界面通知（因为可能在播放胜利动作中）")

	if _G.CannotConnectTimer then
		_G.CannotConnectTimer:Stop()

		_G.CannotConnectTimer = nil
	end

	BattleCallLuaCallBackWait = false

	if BattleCallLuaCallBack and not BattleCallLuaWaitLoading then
		BattleCallLuaCallBack()

		BattleCallLuaCallBack = nil
	else
		CheckManagers()

		if not ConnectionHelper.GetIsDealWithError() then
			SetForceShowQuanquan(true)
		end

		_G.CannotConnectTimer = Timer.New(function ()
			ConnectionHelper.ShowReturnToLoginTip()
		end, 600, 1)

		_G.CannotConnectTimer:Start()
	end
end

function slot3()
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

function GotoStage(slot0, slot1, slot2, slot3)
	slot4, slot5 = uv0()

	getRewardData(slot4, false)

	function slot6()
		slot0 = {}

		for slot4, slot5 in pairs(uv0) do
			if ItemCfg[slot5[1]] then
				if ItemConst.ITEM_TYPE.HERO == slot6.type then
					table.insert(slot0, {
						id = slot5[1]
					})
				elseif ItemConst.ITEM_TYPE.WEAPON_SERVANT == slot6.type and (not IllustratedData:GetExistServant(slot5[1]) or slot6.display_rare > 3) then
					table.insert(slot0, {
						id = slot5[1]
					})
				end
			end
		end

		slot1 = manager.story

		slot1:RemovePlayer()

		function slot1()
			JumpTools.OpenPageByJump("/settlement", {
				result = uv0,
				rewardList = uv1,
				stageData = uv2,
				starMissionData = uv3,
				battleResult = uv4
			})
			EndBattleLogic(uv0)
		end

		if #slot0 > 0 then
			gameContext:Go("obtainView", {
				doNextHandler = slot1,
				itemList = slot0
			})
		else
			slot1()
		end
	end

	if isSuccess(slot0) then
		function BattleCallLuaCallBack()
			if uv0:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
				manager.story:CheckChessBattleStory(manager.story.WIN, uv1)
			else
				manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.WIN, uv1)
			end
		end
	else
		GotoBattleFaild(slot0, slot1, slot2, slot3)
	end
end

function GotoChapterStage(slot0, slot1, slot2, slot3)
	slot4, slot5 = uv0()

	getRewardData(slot4, false)

	function slot6()
		slot0 = {}

		for slot4, slot5 in pairs(uv0) do
			if ItemCfg[slot5[1]] then
				if ItemConst.ITEM_TYPE.HERO == slot6.type then
					table.insert(slot0, {
						id = slot5[1]
					})
				elseif ItemConst.ITEM_TYPE.WEAPON_SERVANT == slot6.type and (not IllustratedData:GetExistServant(slot5[1]) or slot6.display_rare > 3) then
					table.insert(slot0, {
						id = slot5[1]
					})
				end
			end
		end

		slot1 = manager.story

		slot1:RemovePlayer()

		function slot1()
			JumpTools.OpenPageByJump("/battleChapterResult", {
				result = uv0,
				rewardList = uv1,
				stageData = uv2,
				starMissionData = uv3,
				battleResult = uv4
			})
			EndBattleLogic(uv0)
		end

		if #slot0 > 0 then
			gameContext:Go("obtainView", {
				doNextHandler = slot1,
				itemList = slot0
			})
		else
			slot1()
		end
	end

	if isSuccess(slot0) then
		function BattleCallLuaCallBack()
			if uv0:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
				manager.story:CheckChessBattleStory(manager.story.WIN, uv1)
			else
				manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.WIN, uv1)
			end
		end
	else
		GotoBattleFaild(slot0, slot1, slot2, slot3)
	end
end

function GotoMultipleResult(slot0, slot1, slot2, slot3)
	if uv0 == true then
		slot0 = 3
	end

	slot4, slot5 = uv1()

	getRewardData(slot4)

	if isSuccess(slot0) or not uv0 and slot3.challengedNumber >= 1 then
		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == slot1.GetType(slot1) then
			BattleEquipAction.CaculateGuaranteeNum(slot1.GetStageId(slot1), slot5)
		end

		function BattleCallLuaCallBack()
			gameContext:Go("/battleMultipleResult", {
				stageData = uv0,
				rewardList = uv1,
				multiple = uv2.challengedNumber,
				battleResult = uv2
			})
			EndBattleLogic(uv3)
		end
	else
		GotoBattleFaild(slot0, slot1, slot2, slot3)
	end
end

function GotoMatrix(slot0, slot1, slot2, slot3)
	slot4, slot5 = uv0()

	getRewardData(slot4)

	if isSuccess(slot0) then
		function BattleCallLuaCallBack()
			gameContext:Go("/battleMatrixResult", {
				multiple = 1,
				stageData = uv0,
				rewardList = uv1,
				battleResult = uv2
			})
			EndBattleLogic(uv3)
		end
	else
		function BattleCallLuaCallBack()
			gameContext:Go("/battleMatrixFailed", {
				stageData = uv0,
				starMissionData = uv1,
				battleResult = uv2
			})
			manager.story:RemovePlayer()
			EndBattleLogic(uv3)
		end
	end
end

function GotoGuildBoss(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = uv0()

	getRewardData(slot5)

	if slot1 + 1 ~= BattleConst.BATTLE_RESULT.QUIT then
		function BattleCallLuaCallBack()
			slot0 = 0

			if not GuildData:GetBossData().initedFromServer then
				gameContext:Go("/battleScorResult", {
					stageData = uv0,
					rewardList = uv1,
					score = 0,
					battleResult = uv2
				})
				EndBattleLogic(uv3)
				ShowTips("CLUB_KICK")

				return
			end

			slot2 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
			slot3, slot4, slot5 = BattleTools.GetBattleStatisticsData()
			slot6 = slot4.damage
			slot7 = ClubBossIdCfg[GuildData:GetBossData().challengeInfo.boss_id].boss_hp[GuildData:GetBossDifficulty()]

			if uv4 == 1 then
				slot8 = GameSetting.club_boss_point_cal_pre_stage.value
				slot0 = math.floor(slot8[1] + (1 - slot2 / slot8[2]) * slot8[3])

				if isSuccess(uv3) then
					gameContext:Go("/battleScorResult", {
						stageData = uv0,
						rewardList = uv1,
						score = slot0,
						battleResult = uv2
					})
					EndBattleLogic(uv3)
				else
					slot9 = uv0
					slot10 = manager.story

					slot10:CheckBattleStory(slot9:GetStageId(), manager.story.LOSE, function ()
						gameContext:Go("/battlefailed", {
							stageData = uv0,
							starMissionData = uv1,
							battleResult = uv2
						})
						manager.story:RemovePlayer()
						EndBattleLogic(uv3)
					end)
				end
			else
				CustomLog.Log(debug.traceback(string.format("公会BOSS总伤害：%s", tostring(slot6))))

				slot8 = GameSetting.club_boss_point_cal.value
				slot9 = 0

				if isSuccess(uv3) then
					slot9 = (1 - slot2 / slot8[2]) * slot8[3]
				end

				slot0 = math.floor(math.min(tonumber(tostring(slot6)) / slot7, 1) * slot8[1] + slot9)

				GuildData:ResetBossPersonalScore(slot0)
				gameContext:Go("/battleScorResult", {
					stageData = uv0,
					rewardList = uv1,
					score = slot0,
					battleResult = uv2
				})
				EndBattleLogic(uv3)
			end
		end
	else
		GotoBattleFaild(slot1, slot2, slot3, slot4)
	end
end

function GotoBattleFaild(slot0, slot1, slot2, slot3)
	function BattleCallLuaCallBack()
		slot0 = uv0
		slot1 = manager.story

		slot1:CheckBattleStory(slot0:GetStageId(), manager.story.LOSE, function ()
			if uv0 and uv0:GetType() == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON then
				gameContext:Go("/battleheartfailed", {
					stageData = uv0,
					starMissionData = uv1,
					battleResult = uv2
				})
			else
				gameContext:Go("/battlefailed", {
					stageData = uv0,
					starMissionData = uv1,
					battleResult = uv2
				})
			end

			manager.story:RemovePlayer()
			EndBattleLogic(uv3)
		end)
	end
end

function GotoRaceTrail(slot0, slot1, slot2, slot3)
	if uv0 == true then
		slot0 = 3
	end

	slot4, slot5 = uv1()

	getRewardData(slot4)

	if isSuccess(slot0) then
		function BattleCallLuaCallBack()
			slot3 = ActivityTools.GetActivityTheme(uv0:GetActivityID())

			gameContext:Go("/battleScorResult", {
				stageData = uv0,
				rewardList = uv1,
				score = RaceTrailData:GetBattleResultGoal(uv0:GetStageId()),
				battleResult = uv2
			})
			EndBattleLogic(uv3)
		end
	else
		GotoBattleFaild(slot0, slot1, slot2, slot3)
	end
end

function GotoScoreStage(slot0, slot1, slot2, slot3)
	slot4, slot5 = uv0()

	getRewardData(slot4)

	function slot6()
		manager.story:RemovePlayer()
		gameContext:Go("/battleScorResult", {
			stageData = uv0,
			rewardList = uv1,
			battleResult = uv2
		})
		EndBattleLogic(uv3)
	end

	if isSuccess(slot0) then
		function BattleCallLuaCallBack()
			manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.WIN, uv1)
		end
	else
		function BattleCallLuaCallBack()
			gameContext:Go("/battlefailedBossChallenge", {
				stageData = uv0,
				starMissionData = uv1,
				battleResult = uv2
			})
		end
	end
end

function GotoBossNormalChallenge(slot0, slot1, slot2, slot3)
	function BattleCallLuaCallBack()
		if isSuccess(uv0) then
			JumpTools.OpenPageByJump("/battleBossChallengeResult", {
				result = uv0,
				rewardList = {},
				stageData = uv1,
				starMissionData = uv2,
				battleResult = uv3
			})
		else
			gameContext:Go("/battlefailedBossChallenge", {
				stageData = uv1,
				battleResult = uv3
			})
		end

		EndBattleLogic(uv0)
	end
end

function GotoBossAdvanceChallenge(slot0, slot1, slot2, slot3)
	slot4, slot5 = uv0()

	getRewardData(slot4)

	function BattleCallLuaCallBack()
		if isSuccess(uv0) then
			gameContext:Go("/battleScorResult", {
				stageData = uv1,
				rewardList = uv2,
				battleResult = uv3
			})
		else
			gameContext:Go("/battlefailedBossChallenge", {
				stageData = uv1,
				battleResult = uv3
			})
		end

		EndBattleLogic(uv0)
	end
end

function GotoSlayerResult(slot0, slot1, slot2, slot3)
	function BattleCallLuaCallBack()
		gameContext:Go("/battleSlayerResult", {
			stageData = uv0,
			rewardList = {},
			battleResult = uv1
		})
		EndBattleLogic(uv2)
	end
end

function GotoSkadiResult(slot0, slot1, slot2, slot3)
	if isSuccess(slot0) then
		function BattleCallLuaCallBack()
			gameContext:Go("/battleLittleGameResultView", {
				stageData = uv0,
				rewardList = {},
				battleResult = uv1
			})
			EndBattleLogic(uv2)
		end
	else
		GotoBattleFaild(slot0, slot1, slot2, slot3)
	end
end

function GotoActivityMatrixResult(slot0, slot1, slot2, slot3)
	slot4, slot5 = uv0()
	slot7 = ActivityTools.GetActivityType(slot1.GetActivityID(slot1))

	for slot11, slot12 in ipairs(slot4) do
		if slot12[1] == 26 then
			if slot7 == ActivityTemplateConst.SUB_SINGLE_MATRIX then
				slot12[1] = ActivityMatrixTools.GetCoinItem(slot6)
			elseif slot7 == ActivityTemplateConst.STRATEGY_MATRIX then
				slot12[1] = StrategyMatrixTools.GetCoinItem(slot6)
			end
		end

		if slot12[2] == 0 then
			slot4[slot11] = nil
		end
	end

	if isSuccess(slot0) then
		function BattleCallLuaCallBack()
			if uv0 == ActivityTemplateConst.STRATEGY_MATRIX then
				if (StrategyMatrixTierTemplateCfg[uv1.tier or 0].level == 10 and StrategyMatrixCfg[uv2].tier_story_list[slot2.tier] or nil) and not manager.story:IsStoryPlayed(slot3) then
					PlayerAction.ChangeStoryList(slot3)

					slot4 = manager.story

					slot4:StartStoryById(slot3, function (slot0)
						gameContext:Go("/battleActivityMatrixResult", {
							multiple = 1,
							stageData = uv0,
							rewardList = uv1,
							battleResult = uv2
						})
					end)
				else
					gameContext:Go("/battleActivityMatrixResult", {
						multiple = 1,
						stageData = uv1,
						rewardList = uv3,
						battleResult = uv4
					})
				end
			else
				gameContext:Go("/battleActivityMatrixResult", {
					multiple = 1,
					stageData = uv1,
					rewardList = uv3,
					battleResult = uv4
				})
			end

			EndBattleLogic(uv5)
		end
	else
		GotoBattleFaild(slot0, slot1, slot2, slot3)
	end
end

function GoToActivityRaceResult(slot0, slot1, slot2, slot3)
	slot4, slot5 = uv0()

	getRewardData(slot4)

	slot8 = ActivityRaceCfg[slot1:GetActivityID()].stage_list

	if not (slot1:GetStageId() == slot8[#slot8]) then
		if isSuccess(slot0) or not uv1 and slot3.challengedNumber >= 1 then
			function BattleCallLuaCallBack()
				ActivityRaceData:SetCompleteStage(uv0, uv1)
				gameContext:Go("/battleActivityRaceResult", {
					stageData = uv2,
					rewardList = uv3,
					affixList = ActivityRaceData:GetDropAffixes(),
					battleResult = uv4
				})
				EndBattleLogic(uv5)
			end
		else
			GotoBattleFaild(slot0, slot1, slot2, slot3)
		end
	elseif slot0 + 1 ~= BattleConst.BATTLE_RESULT.QUIT then
		function BattleCallLuaCallBack()
			slot1 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
			slot2, slot3, slot4 = BattleTools.GetBattleStatisticsData()
			slot5 = slot3.damage
			slot6 = ActivityRaceCfg[uv0].boss_hp[1]
			slot7 = GameSetting.race_boss_point_cal.value
			slot8 = 0

			if isSuccess(uv1) then
				slot8 = math.max(slot7[2] - slot1 * slot7[3], 0)
			end

			slot9 = math.floor(math.min(tonumber(tostring(slot5)) / slot6, 1) * slot7[1] + slot8)

			ActivityRaceData:SetScore(uv0, slot9)
			ActivityRaceData:SetCompleteStage(uv0, uv2)
			gameContext:Go("/battleScorResult", {
				stageData = uv3,
				battleResult = uv4,
				score = slot9
			})
			EndBattleLogic(uv1)
		end
	else
		GotoBattleFaild(slot0, slot1, slot2, slot3)
	end
end

function GotoEquipBreakThrough(slot0, slot1, slot2, slot3)
	if isSuccess(slot0) then
		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("/equipBreakThroughResult", {
				result = uv0,
				rewardList = list,
				stageData = uv1,
				starMissionData = uv2,
				battleResult = uv3
			})
			EndBattleLogic(uv0)
		end
	else
		GotoBattleFaild(slot0, slot1, slot2, slot3)
	end
end

function GotoMythicFinalStage(slot0, slot1, slot2, slot3)
	if isSuccess(slot0) and not uv0 then
		function BattleCallLuaCallBack()
			manager.story:RemovePlayer()
			gameContext:Go("/battleMythicFinalResultView", {
				multiple = 1,
				stageData = uv0,
				battleResult = uv1
			})
			EndBattleLogic(uv2)
		end
	else
		function BattleCallLuaCallBack()
			gameContext:Go("/battleMythicFinalFailedView", {
				stageData = uv0,
				battleResult = uv1
			})
			EndBattleLogic(uv2)
		end
	end
end

function GotoGuildActivity(slot0, slot1, slot2, slot3)
	if uv0 then
		GotoBattleFaild(slot0, slot1, slot2, slot3)

		return
	end

	if ActivityClubCfg[slot1.GetNodeId(slot1)].type == 1 then
		if isSuccess(slot0) then
			function BattleCallLuaCallBack()
				manager.story:RemovePlayer()
				gameContext:Go("/guildActivityNodeResult", {
					isSuccess = true,
					multiple = 1,
					stageData = uv0,
					battleResult = uv1,
					nodeId = uv0:GetNodeId()
				})
				EndBattleLogic(uv2)
			end
		else
			GotoBattleFaild(slot0, slot1, slot2, slot3)
		end
	elseif slot4.type == 2 then
		if not GuildActivityData:GetSelfNodeData(slot1:GetNodeId()) then
			GotoBattleFaild(slot0, slot1, slot2, slot3)
		else
			function BattleCallLuaCallBack()
				manager.story:RemovePlayer()
				gameContext:Go("/guildActivityNodeResult", {
					multiple = 1,
					stageData = uv0,
					battleResult = uv1,
					isSuccess = isSuccess(uv2),
					nodeId = uv0:GetNodeId()
				})
				EndBattleLogic(uv2)
			end
		end
	elseif slot4.type == 3 then
		function BattleCallLuaCallBack()
			manager.story:RemovePlayer()

			slot0, slot1 = uv0()
			slot3 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
			slot4, slot5, slot6 = BattleTools.GetBattleStatisticsData()
			slot7 = slot5.damage
			slot8 = GameSetting.activity_club_point_cal.value
			slot9 = slot8[1]
			slot10 = slot8[2]
			slot11 = slot8[3]
			slot12 = uv1.boss_stage_hp
			slot13 = 0

			if isSuccess(uv2) then
				slot13 = math.max(slot10 - slot3 * slot11, 0)
			end

			slot14 = GuildActivityData:GetUnLockAffixList()
			slot16 = 0

			for slot20, slot21 in pairs(GuildActivityData:GetTempEffectiveAffixList()) do
				for slot25, slot26 in ipairs(TalentTreeCfg[slot20].formula_condition) do
					if slot26[1] == 1 then
						slot16 = slot16 + slot14[slot20].level * slot26[2] * slot21
					end
				end
			end

			slot18 = math.floor(math.min(math.floor(tonumber(tostring(slot7) * 100) / (100 - slot16)) / slot12, 1) * slot9 + slot13)
			slot19 = "choose"

			if isSuccess(uv2) then
				slot19 = "score"
			elseif ActivityClubCfg.all[#ActivityClubCfg.all] == uv3:GetNodeId() and GuildActivityData:GetNodeData(uv3:GetNodeId()) and slot20.health <= 0 then
				slot19 = "score"
			end

			gameContext:Go("/battleScorResult", {
				resultType = slot19,
				okHandler = function ()
					GuildActivityAction.SaveEliteCombatResult(1)
				end,
				giveUpHandler = function ()
					GuildActivityAction.SaveEliteCombatResult(0)
				end,
				stageData = uv3,
				rewardList = slot1,
				score = slot18,
				battleResult = uv4,
				isSuccess = isSuccess(uv2),
				nodeId = uv3:GetNodeId()
			})
			EndBattleLogic(uv2)
		end
	end
end

function GotoSequentialBattleResult(slot0, slot1, slot2, slot3)
	function BattleCallLuaCallBack()
		if isSuccess(uv0) then
			slot0 = uv1:GetActivityID()
			slot4 = SequentialBattleData:GetChapterData(slot0).team[table.indexof(SequentialBattleChapterCfg[slot0].stage_id, uv1:GetStageId())].enabledBuff or {}
			slot5 = "["

			for slot9, slot10 in ipairs(slot4) do
				slot5 = slot5 .. slot10

				if slot9 ~= #slot4 then
					slot5 = slot5 .. ","
				end
			end

			SDKTools.SendMessageToSDK("combat_over", {
				activity_cb_buff_list = slot5 .. "]"
			})
			SequentialBattleData:ClearStage(uv1:GetActivityID())
			gameContext:Go("/sequentialBattleResult", {
				stageData = uv1,
				rewardList = {},
				battleResult = uv2
			})
		else
			gameContext:Go("/sequentialBattleFailed", {
				stageData = uv1,
				battleResult = uv2
			})
		end

		EndBattleLogic(uv0)
	end
end

function GotoMardukSpecial(slot0, slot1, slot2, slot3)
	if uv0 then
		GotoBattleFaild(slot0, slot1, slot2, slot3)

		return
	end

	function BattleCallLuaCallBack()
		manager.story:RemovePlayer()

		slot0 = 1
		slot1 = math.floor(GameSetting.activity_quick_training_point_calculate_time.value[1] / 1000)
		slot3 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
		slot4 = GameSetting.quick_training_time_param.value[1]
		slot5 = 0

		if isSuccess(uv0) then
			slot5 = (slot1 - slot3) / slot1 * slot4
		end

		slot6 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas
		slot7 = 0

		for slot13, slot14 in ipairs(ActivityQuickTrainingCfg[uv1:GetActivityID()].monster_id_list) do
			slot16 = 0

			if slot6.TryGetValue(slot6, slot14[1], nil) then
				slot16 = slot6[slot14[1]] or 0
			end

			slot7 = slot7 + slot16 * (slot14[2] or 0)
		end

		gameContext:Go("/battleScorResult", {
			stageData = uv1,
			battleResult = uv2,
			score = math.floor(slot7 + slot5)
		})
		EndBattleLogic(uv0)
	end
end

function GotoSoloSurvive(slot0, slot1, slot2, slot3)
	function BattleCallLuaCallBack()
		slot0 = uv0:GetStageId()
		slot2 = ActivityTools.GetActivityTheme(uv0:GetActivityID())

		gameContext:Go("/battleScorResult", {
			stageData = uv0,
			battleResult = uv1,
			title = GetTips("ACTIVITY_SOLO_SLAYER_FINISH")
		})
		EndBattleLogic(uv2)
	end
end

function GotoActivityWorldBoss(slot0, slot1, slot2, slot3)
	slot4, slot5 = uv0()

	getRewardData(slot4)

	slot7 = ActivityWorldBossCfg[slot1:GetActivityID()]

	for slot11, slot12 in ipairs(slot4) do
		if slot7 and slot7.coin_id == slot12[1] then
			ActivityWorldBossData:UpdateCoinCount(slot6, slot12[2])
		end
	end

	if not uv1 then
		function BattleCallLuaCallBack()
			slot1 = uv1.end_story_id

			if ActivityWorldBossData:GetLeftHealthPoint(uv0:GetActivityID()) == 0 and not manager.story:IsStoryPlayed(slot1) then
				slot2 = manager.story

				slot2:StartStoryById(slot1, function (slot0)
					gameContext:Go("/battleActivityWorldBossResult", {
						stageData = uv0,
						rewardList = uv1,
						battleResult = uv2
					})
				end)
			else
				gameContext:Go("/battleActivityWorldBossResult", {
					stageData = uv0,
					rewardList = uv2,
					battleResult = uv3
				})
			end

			EndBattleLogic(uv4)
		end
	else
		GotoBattleFaild(slot0, slot1, slot2, slot3)
	end
end

function GotoAbyssSuccess(slot0, slot1, slot2, slot3, slot4, slot5)
	if uv0 == true then
		slot1 = 3
	end

	slot6, slot7 = uv1()

	getRewardData(slot6)

	if isSuccess(slot1) then
		function BattleCallLuaCallBack()
			gameContext:Go("/abyssBattleResult", {
				stageData = uv0,
				rewardList = uv1,
				score = uv2,
				battleResult = uv3
			})
			EndBattleLogic(uv4)
		end
	end
end

function GotoAbyssBossFailed(slot0, slot1, slot2, slot3, slot4)
	if uv0 == true then
		slot2 = 3
	end

	function BattleCallLuaCallBack()
		gameContext:Go("/abyssBattleResult", {
			resultType = "choose",
			scoreType = "hp",
			stageData = uv0,
			hp = uv1,
			totalHp = uv2,
			battleResult = uv3,
			title = GetTips("ABYSS_BATTLE_FAIL_TIP"),
			okHandler = function ()
				AbyssAction.ClearTeamCache(uv0:GetStageId())
				AbyssAction.SaveProgress(uv0:GetStageId(), true)
			end,
			giveUpHandler = function ()
				AbyssAction.SaveProgress(uv0:GetStageId(), false)
			end
		})
		EndBattleLogic(uv4)
	end
end

function GotoBossFailed(slot0, slot1, slot2, slot3, slot4)
	if uv0 == true then
		slot2 = 3
	end

	function BattleCallLuaCallBack()
		gameContext:Go("/battleScorResult", {
			scoreType = "hp",
			stageData = uv0,
			hp = uv1,
			totalHp = uv2,
			battleResult = uv3
		})
		EndBattleLogic(uv4)
	end
end

function GotoScoreResult(slot0, slot1, slot2, slot3, slot4, slot5)
	if uv0 == true then
		slot1 = 3
	end

	slot6, slot7 = uv1()

	getRewardData(slot6)

	if isSuccess(slot1) then
		function BattleCallLuaCallBack()
			gameContext:Go("/battleScorResult", {
				stageData = uv0,
				rewardList = uv1,
				score = uv2,
				battleResult = uv3
			})
			EndBattleLogic(uv4)
		end
	else
		function BattleCallLuaCallBack()
			slot0 = uv0
			slot1 = manager.story

			slot1:CheckBattleStory(slot0:GetStageId(), manager.story.LOSE, function ()
				if uv0 then
					gameContext:Go("/battlefailedBossChallenge", {
						stageData = uv1,
						starMissionData = uv2,
						battleResult = uv3
					})
				else
					gameContext:Go("/battlefailed", {
						stageData = uv1,
						starMissionData = uv2,
						battleResult = uv3
					})
				end

				manager.story:RemovePlayer()
				EndBattleLogic(uv4)
			end)
		end
	end
end

function GotoSoloChallenge(slot0, slot1, slot2, slot3)
	slot4, slot5 = uv0()

	getRewardData(slot4, false)

	if isSuccess(slot0) then
		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("/settlement", {
				result = uv0,
				rewardList = uv1,
				stageData = uv2,
				starMissionData = uv3,
				battleResult = uv4
			})
			EndBattleLogic(uv0)
		end
	else
		function BattleCallLuaCallBack()
			gameContext:Go("/battleMatrixFailed", {
				stageData = uv0,
				starMissionData = uv1,
				battleResult = uv2
			})
			manager.story:RemovePlayer()
			EndBattleLogic(uv3)
		end
	end
end

function GotoActivityPt2ChallengeStage(slot0, slot1, slot2, slot3)
	if uv0 == true then
		slot0 = 3
	end

	slot4, slot5 = uv1()

	getRewardData(slot4)

	if isSuccess(slot0) or not uv0 and slot3.challengedNumber >= 1 then
		slot6 = slot1.GetType(slot1)

		function BattleCallLuaCallBack()
			if ActivityData:GetActivityData(uv0:GetActivityID()) and slot1.IsActivitying(slot1) and ActivityPt2Cfg[uv0:GetDest()].cost[1][1] then
				CurrencyAction.CurrencyModify(slot3.cost[1][1], -1 * uv0:GetMultiple() * slot3.cost[1][2])
			end

			gameContext:Go("/battleMultipleResult", {
				result = uv1,
				stageData = uv0,
				rewardList = uv2,
				multiple = uv3.challengedNumber,
				battleResult = uv3
			})
			EndBattleLogic(uv1)
		end
	else
		GotoBattleFaild(slot0, slot1, slot2, slot3)
	end
end

function GotoPolyhedron(slot0, slot1, slot2, slot3)
	slot4, slot5 = uv0()

	getRewardData(slot4)

	if isSuccess(slot0) then
		if PolyhedronConst.STATE_TYPE.STARTED == PolyhedronData:GetPolyhedronInfo():GetState() then
			DoPolyhedronNextTrigger()
		elseif PolyhedronConst.STATE_TYPE.SETTLEMENT == slot7 then
			DestroyLua()
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronOver", {})
		else
			DestroyLua()
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
		end
	else
		function BattleCallLuaCallBack()
			gameContext:Go("/battlePolyhedronFailed", {
				stageData = uv0,
				starMissionData = uv1,
				battleResult = uv2
			})
			manager.story:RemovePlayer()
			EndBattleLogic(uv3)
		end
	end
end

function EndBattleLogic(slot0)
	manager.guide:OnBattleFinish(slot0)
	manager.achievementTips:FliteAchievementType({})
end

function GetAbyssBossPhase()
	return AbyssData:GetCurrentBossPhase()
end

function OnQuitBattleSuccess()
	manager.notify:Invoke(BULLETIN_QUITBATTLE)
end
