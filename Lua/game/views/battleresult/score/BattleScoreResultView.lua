slot0 = class("BattleScoreResultView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BattleResult/OsirisMultipletUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0.tweens_ = {}
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListener()

	slot0.heroItemView_ = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.resultTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "resultType")
	slot0.scoreTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "scoreType")

	LeanTween.alphaCanvas(slot0.mask_, 0, 0.1)
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.btnBack_, nil, function ()
		uv0:CloseFunc()
	end)
	slot0:AddBtnListener(slot0.btnClose_, nil, function ()
		uv0:CloseFunc()
	end)
	slot0:AddBtnListener(slot0.buttonMask_, nil, function ()
		uv0:EndAnimator()
	end)
	slot0:AddBtnListener(slot0.btnBattleCount_, nil, function ()
		uv0.toStat_ = true

		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = uv0.stageData,
			battleTime = uv0:GetBattleTime()
		})
	end)
	slot0:AddBtnListener(slot0.btnOk_, nil, function ()
		if uv0.params_.okHandler then
			uv0.params_.okHandler()
		end

		uv0:CloseFunc()
	end)
	slot0:AddBtnListener(slot0.btnGiveUp_, nil, function ()
		if uv0.params_.giveUpHandler then
			uv0.params_.giveUpHandler()
		end

		uv0:CloseFunc()
	end)
	slot0:AddBtnListener(slot0.btnOnceMore_, nil, function ()
		uv0:OnClickRestart()
	end)
end

function slot0.OnEnter(slot0)
	slot0.stageData = slot0.params_.stageData
	slot0.stageId = slot0.stageData:GetStageId()
	slot0.stageType = slot0.stageData:GetType()

	BattleInstance.hideBattlePanel()
	slot0:RefreshUI()

	if slot0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function ()
				uv0:CloseFunc()
			end
		})
	end
end

function slot0.CloseFunc(slot0)
	OperationRecorder.Record(slot0.class.__cname, "closeCombat")
	BattleInstance.QuitBattle(slot0.stageData)
end

function slot0.ShowVitalityBox(slot0, slot1)
	if needShowVitalityFullBox(slot0:GetRewardData()) then
		showVitalitySendMail(slot1)
	else
		slot1()
	end
end

function slot0.RefreshUI(slot0)
	if slot0.params_.resultType == "choose" then
		slot0.resultTypeController_:SetSelectedState("choose")
	else
		slot0.resultTypeController_:SetSelectedState("score")
	end

	slot0:SetLevelTitle()
	slot0:RefreshMyExpS()
	slot0:RefreshHeroS()
	slot0:RefreshCommonUI()

	if slot0.params_.scoreType == "hp" then
		slot0.scoreTypeController_:SetSelectedState("hp")
		slot0:RefreshHp()
	else
		slot0.scoreTypeController_:SetSelectedState("score")
		slot0:RefreshScore()
	end

	slot0:RefreshBattleTime()
end

function slot0.SetLevelTitle(slot0)
	slot1, slot2 = BattleStageTools.GetChapterSectionIndex(slot0.stageType, slot0.stageId)

	if slot1 ~= "" then
		slot0.stareText_.text = string.format("%s-%s", slot1, slot2)
	else
		slot0.stareText_.text = ""
	end

	slot0.lvText_.text = BattleStageTools.GetStageName(slot0.stageType, slot0.stageId)

	if slot0.params_.scoreType == "hp" then
		if slot0.params_.title ~= nil and slot0.params_.title ~= "" then
			slot0.hpTitleText_.text = slot0.params_.title
		end
	elseif slot0.params_.title ~= nil and slot0.params_.title ~= "" then
		slot0.titleText_.text = slot0.params_.title
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.titleTransform_)
end

function slot0.RefreshMyExpS(slot0)
	slot1 = slot0:GetPlayerInfo()
	slot2 = slot1.userLevel
	slot3 = slot1.remain_exp

	if math.min(slot0.stageData:GetAddUserExp() * slot0.stageData:GetMultiple(), LvTools.GetMaxTotalExp("user_level_exp") - slot1.total_exp) < 0 then
		slot6 = 0
	end

	slot7, slot8 = LvTools.CheckExp(slot2, slot3 + slot6, "user_level_exp")

	if slot2 > 30 and slot7 - slot2 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(slot3), tostring(slot6), tostring(slot2), tostring(slot7)))
	end

	slot0.newPlayerExp_ = slot6
	slot0.addExp_.text = string.format("+%d", slot6)
	slot10 = math.floor(slot8 / GameLevelSetting[slot7].user_level_exp * 1000) / 1000

	if math.floor(slot3 / GameLevelSetting[slot2].user_level_exp * 1000) / 1000 > 0.99 then
		slot9 = 0.99
	end

	if slot10 > 0.99 then
		slot10 = 0.99
	end

	slot0:RemoveTween()

	slot0.userExp_ = slot7 + slot10

	if slot4 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	slot11 = -1
	slot12 = LeanTween.value(slot0.progress_.gameObject, slot2 + slot9, slot7 + slot10, 2)
	slot12 = slot12:setEase(LeanTweenType.easeOutCubic)
	slot12 = slot12:setOnUpdate(LuaHelper.FloatAction(function (slot0)
		slot1 = math.modf(slot0)

		if uv0 == -1 then
			uv0 = slot1
		end

		if slot1 ~= uv0 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			uv0 = slot1
		end

		uv1:UpdateUserData(slot0)
	end))
	slot0.tween_ = slot12:setOnComplete(LuaHelper.VoidAction(function ()
		uv0.mask_.blocksRaycasts = false

		uv0:CheckLevelUp()
		uv0:RemoveTween()
	end))

	if slot0.newPlayerExp_ then
		PlayerAction.EXPChange(slot0.newPlayerExp_)

		slot0.newPlayerExp_ = nil
	end
end

function slot0.GetPlayerInfo(slot0)
	return PlayerData:GetPlayerInfo()
end

function slot0.UpdateUserData(slot0, slot1)
	slot2, slot3 = math.modf(slot1)
	slot4 = GameLevelSetting[slot2].user_level_exp
	slot0.playerLv_.text = string.format("%d", slot2)

	if LvTools.GetIsMaxLv(slot2, "user") then
		slot0.progress_.value = 1
	else
		slot0.progress_.value = slot3
	end
end

function slot0.CheckLevelUp(slot0)
	if #slot0:GetLevelUpInfoList() > 0 then
		PlayerAction.LevelUpFinish()
		slot0:Go("levelUp", {
			levelUpInfoList = slot1
		})
	end
end

function slot0.GetLevelUpInfoList(slot0)
	return PlayerData:GetlevelUpInfos()
end

function slot0.RefreshHeroS(slot0)
	slot1, slot2 = slot0.stageData:GetHeroTeam()
	slot3 = slot0.stageData:GetSystemHeroTeam()

	for slot7 = 1, 3 do
		slot8 = slot0[string.format("hero%s_", slot7)]

		if not slot1[slot7] or slot1[slot7] == 0 then
			SetActive(slot8, false)
		else
			SetActive(slot8, true)

			slot9 = slot0.stageData:GetHeroDataByPos(slot7)
			slot10 = slot3[slot7] or slot2[slot7] ~= 0

			table.insert(slot0.heroItemView_, BattleMultipleResultHeroItem.New(slot8, slot9, slot0.stageData, slot10))
		end
	end
end

function slot0.RefreshCommonUI(slot0)
	slot1 = true

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot0.stageType and BattleConst.BATTLE_TAG.STORY == BattleChapterStageCfg[slot0.stageId].tag then
		slot1 = false
	end

	SetActive(slot0.btnBattleCount_.gameObject, slot1)
end

function slot0.RefreshHp(slot0)
	slot1 = 100

	if slot0.params_.hp and slot0.params_.totalHp then
		slot1 = math.ceil(100 * slot0.params_.hp / slot0.params_.totalHp)
	end

	slot0.hpProgressBar_.fillAmount = slot1 / 100
	slot0.hpValueText_.text = slot1 .. "%"
end

function slot0.RefreshScore(slot0)
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE == slot0.stageType then
		slot0:RefreshBossAdvanceScore()

		return
	end

	if slot0.params_.score then
		slot0.scoreText_.text = slot0.params_.score
	elseif ActivityTools.GetActivityTheme(slot0.stageData:GetActivityID()) == ActivityConst.THEME.SUMMER or slot1 == ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION then
		slot3 = 0
		slot5 = GameSetting.limit_calculation_time_score_args.value
		slot6 = slot5[1]
		slot7 = slot5[2]
		slot9 = slot5[4]
		slot3 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime) < slot5[3] and slot6 * slot8 + slot7 or slot4 < slot9 and slot6 * slot4 + slot7 or slot6 * slot9 + slot7
		slot10 = 0
		slot11 = 0
		slot12, slot13, slot14 = BattleTools.GetBattleStatisticsData()
		slot15 = GameSetting.limit_calculation_injured_score_args.value

		if slot15[#slot15][1] <= tonumber(tostring(slot12[1].hurt)) then
			slot11 = slot15[#slot15][1]
		end

		for slot19, slot20 in ipairs(slot15) do
			if slot11 <= slot20[1] then
				slot10 = slot20[2]

				break
			end
		end

		slot0.scoreText_.text = math.ceil(math.floor((slot3 + slot10) * ActivityLimitCalculationCfg[slot0.stageData:GetDest()].reward_point / 100))
	elseif slot2 == ActivityConst.THEME.FACTORY or ActivityConst.THEME.TYR then
		slot0.scoreText_.text = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime) .. "s"
	end
end

function slot0.RefreshBossAdvanceScore(slot0)
	slot1 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
	slot3 = BattleBossChallengeAdvanceData:GetBossList()[slot0.stageData:GetBossIndex()]
	slot4 = slot3.multipleIndex
	slot6 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].difficult_point[slot3.multipleIndex]
	slot7 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua
	slot11 = BossConst.TYPE_STAGE

	for slot11, slot12 in pairs(slot3.condition[slot11]) do
		if BattleInstance.CaculateStar(slot0.stageData, StageChallengeConditionPoolCfg[slot12].condition, slot7).isComplete then
			slot6 = slot6 + StageChallengeConditionPoolCfg[slot12].point
		end
	end

	slot11 = BossConst.TYPE_BOSS_AI

	for slot11, slot12 in pairs(slot3.condition[slot11]) do
		slot6 = slot6 + BossAIPoolCfg[slot12].point
	end

	slot11 = BossConst.TYPE_AFFIX

	for slot11, slot12 in pairs(slot3.condition[slot11]) do
		slot6 = slot6 + ActivityAffixPoolCfg[slot12].point
	end

	slot0.scoreText_.text = slot6
end

function slot0.RefreshBattleTime(slot0)
	slot0.battleTimeText_.text = slot0:GetBattleTime()

	SetActive(slot0.battleTimeText_.gameObject, ActivityTools.GetActivityTheme(slot0.stageData:GetActivityID()) ~= ActivityConst.THEME.FACTORY)
end

function slot0.GetBattleTime(slot0)
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function slot0.HeroAnimator(slot0, slot1, slot2)
	slot3, slot4 = math.modf(slot2)
	slot0.heroLv_[slot1].text = string.format("%d", slot3)

	if LvTools.GetIsMaxLv(slot3, "hero") then
		slot0.heroProgress_[slot1].value = 1
	else
		slot0.heroProgress_[slot1].value = slot4
	end
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.tween_.id)

		slot0.tween_ = nil
	end
end

function slot0.RemoveTweens(slot0)
	if slot0.tweens_ then
		for slot4, slot5 in pairs(slot0.tweens_) do
			slot0:RemoveTweenAt(slot4)
		end

		slot0.tweens_ = nil
	end
end

function slot0.RemoveTweenAt(slot0, slot1)
	if slot0.tweens_[slot1] then
		slot2:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot2.id)
	end
end

function slot0.EndAnimator(slot0)
	slot0:RemoveTween()
	slot0:RemoveTweens()
	manager.audio:StopEffect()

	if slot0.stageData:GetAddUserExp() > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add_skip", "")
	end

	slot4 = slot0.userExp_

	slot0:UpdateUserData(slot4)
	slot0:CheckLevelUp()

	for slot4, slot5 in ipairs(slot0.heroItemView_) do
		slot5:EndAnimator()
	end

	slot0.mask_.blocksRaycasts = false
end

function slot0.OnClickRestart(slot0)
	BattleController.GetInstance():LaunchBattle(slot0.params_.stageData)
end

function slot0.OnTop(slot0)
	SetActive(slot0.gameObject_, true)

	slot0.toStat_ = false
end

function slot0.OnBehind(slot0)
	if slot0.toStat_ then
		SetActive(slot0.gameObject_, false)
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.heroItemView_) do
		slot5:Dispose()
	end

	slot0.heroItemView_ = nil

	slot0:RemoveTween()
	slot0:RemoveTweens()
	uv0.super.Dispose(slot0)
end

return slot0
