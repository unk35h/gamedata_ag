slot0 = class("BattleMultipleResultView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BattleResult/MultipletUI"
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
	slot0.rewardList_ = LuaList.New(handler(slot0, slot0.RewardRenderer), slot0.uiList_, BattleMultipleResultReward)
end

function slot0.OnEnter(slot0)
	slot0.stageData = slot0.params_.stageData
	slot0.stageId = slot0.stageData:GetStageId()
	slot0.stageType = slot0.stageData:GetType()

	BattleInstance.hideBattlePanel()
	slot0:RefreshUI()
	slot0.rewardList_:StartScroll(#slot0.params_.rewardList, 1)

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

function slot0.SetBtnOnceMore(slot0)
	if slot0.stageType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT then
		SetActive(slot0.btnOnceMore_.gameObject, false)
	else
		SetActive(slot0.btnOnceMore_.gameObject, true)
	end
end

function slot0.NeedOnceMore(slot0)
	return true
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
	if slot0.rewardList_ then
		slot0.rewardList_:Dispose()

		slot0.rewardList_ = nil
	end

	for slot4, slot5 in ipairs(slot0.heroItemView_) do
		slot5:Dispose()
	end

	slot0.heroItemView_ = nil

	slot0:RemoveTween()
	slot0:RemoveTweens()

	slot0.rewardItemGos_ = nil
	slot0.heroLv_ = nil
	slot0.heroGo_ = nil
	slot0.heroImg_ = nil
	slot0.missionGo_ = nil
	slot0.missionAchieve_ = nil
	slot0.heroAddExp = nil
	slot0.missionNoAchieve_ = nil
	slot0.heroProgress_ = nil
	slot0.missionText_ = nil
	slot0.rewardList_ = nil
	slot0.addExp_ = nil
	slot0.stareText_ = nil
	slot0.lvText_ = nil
	slot0.bg_screen_ = nil
	slot0.rewardListTrs_ = nil
	slot0.mask_ = nil
	slot0.playerLv_ = nil
	slot0.btnBack_ = nil
	slot0.btnBattleCount_ = nil
	slot0.missionTipGo_ = nil
	slot0.progress_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	LeanTween.alphaCanvas(slot0.mask_, 0, 0.1)
end

function slot0.GetRewardData(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.params_.rewardList) do
		for slot10, slot11 in ipairs(slot6) do
			table.insert(slot1, reward)
		end
	end

	return slot1
end

function slot0.ShowVitalityBox(slot0, slot1)
	if needShowVitalityFullBox(slot0:GetRewardData()) then
		showVitalitySendMail(slot1)
	else
		slot1()
	end
end

function slot0.ShowEquipBox(slot0, slot1)
	if needShowBagFullBox(slot0:GetRewardData()) then
		showEquipSendMail(slot1)
	else
		slot1()
	end
end

function slot0.CloseFunc(slot0)
	OperationRecorder.Record(slot0.class.__cname, "closeCombat")
	slot0:ShowVitalityBox(function ()
		slot0 = uv0

		slot0:ShowEquipBox(function ()
			BattleInstance.QuitBattle(uv0.stageData)
		end)
	end)
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
	slot0:AddBtnListener(slot0.btnOnceMore_, nil, function ()
		slot0 = uv0.params_.destID
		slot1 = uv0.params_.stageID
		slot2 = uv0.stageData:GetCost()
		slot3 = uv0.stageData:GetMultiple()
		slot4 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		slot5 = CurrencyConst.CURRENCY_TYPE_VITALITY

		if uv0.stageType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE then
			slot7 = ActivityPt2Cfg[uv0.stageData:GetDest()]
			slot2 = slot7.cost[1][2]
			slot4 = ItemTools.getItemNum(slot7.cost[1][1])
		end

		if slot4 < slot2 * slot3 then
			if slot5 ~= CurrencyConst.CURRENCY_TYPE_VITALITY then
				ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemCfg[slot5].name))
			elseif CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
				JumpTools.OpenPopUp("currencyBuyFatigue", {}, ViewConst.SYSTEM_ID.BUY_FATIGUE)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
			end
		else
			BattleInstance.OnceMoreBattle(uv0.stageData)
		end
	end)
	slot0:AddBtnListener(slot0.btnBattleCount_, nil, function ()
		uv0.toStat_ = true

		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = uv0.stageData,
			battleTime = uv0:GetBattleTime()
		})
	end)
end

function slot0.RemoveListener(slot0)
	slot0.btnBack_.onClick:RemoveAllListeners()
	slot0.btnClose_.onClick:RemoveAllListeners()
	slot0.btnOnceMore_.onClick:RemoveAllListeners()
	slot0.btnBattleCount_.onClick:RemoveAllListeners()
end

function slot0.RefreshUI(slot0)
	slot0:SetLevelTitle()
	slot0:RefreshMyExpS()
	slot0:RefreshHeroS()
	slot0:RefreshCommonUI()
	slot0:SetBtnOnceMore()
	slot0:RefreshBattleTime()
end

function slot0.SetLevelTitle(slot0)
	slot1, slot2 = BattleStageTools.GetChapterSectionIndex(slot0.stageType, slot0.stageId)

	if slot1 ~= "" then
		slot0.stareText_.text = string.format("%s-%s", GetI18NText(slot1), slot2)
	else
		slot0.stareText_.text = ""
	end

	slot0.lvText_.text = BattleStageTools.GetStageName(slot0.stageType, slot0.stageId)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.titleTransform_)
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

function slot0.CheckLevelUp(slot0)
	if #slot0:GetLevelUpInfoList() > 0 then
		PlayerAction.LevelUpFinish()
		slot0:Go("levelUp", {
			levelUpInfoList = slot1
		})
	end
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

function slot0.HeroAnimator(slot0, slot1, slot2)
	slot3, slot4 = math.modf(slot2)
	slot0.heroLv_[slot1].text = string.format("%d", slot3)

	if LvTools.GetIsMaxLv(slot3, "hero") then
		slot0.heroProgress_[slot1].value = 1
	else
		slot0.heroProgress_[slot1].value = slot4
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

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.tween_.id)

		slot0.tween_ = nil
	end
end

function slot0.RemoveTweenAt(slot0, slot1)
	if slot0.tweens_[slot1] then
		slot2:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot2.id)
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

function slot0.RefreshCommonUI(slot0)
	slot1 = true

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot0.stageType and BattleConst.BATTLE_TAG.STORY == BattleChapterStageCfg[slot0.stageId].tag then
		slot1 = false
	end

	SetActive(slot0.btnBattleCount_.gameObject, slot1)

	slot2 = slot0:NeedOnceMore() or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == slot0.stageType

	SetActive(slot0.onceMoreGo_, slot2)
	SetActive(slot0.closeBtnGo_, slot2)
	SetActive(slot0.closePanel_, not slot2)
end

function slot0.RefreshBattleTime(slot0)
	slot0.battleTimeText_.text = slot0:GetBattleTime()
end

function slot0.GetBattleTime(slot0)
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function slot0.RewardRenderer(slot0, slot1, slot2)
	slot2:SetRewardList(slot1, clone(slot0.params_.rewardList[slot1]))
end

function slot0.GetPlayerInfo(slot0)
	return PlayerData:GetPlayerInfo()
end

function slot0.GetLevelUpInfoList(slot0)
	return PlayerData:GetlevelUpInfos()
end

return slot0
