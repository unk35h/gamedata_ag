slot0 = class("BattleResultBaseView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BattleResult/BattleSettlementUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.ChangeCameraToEmpty(slot0)
	manager.ui.mainCamera.transform.localPosition = Vector3(0, -180, 0)
	manager.ui.mainCamera.transform.localEulerAngles = Vector3(0, 180, 0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListener()
end

function slot0.OnEnter(slot0)
	slot0.tweens_ = {}
	slot0.stageData = slot0.params_.stageData
	slot0.stageId = slot0.stageData:GetStageId()
	slot0.stageType = slot0.stageData:GetType()
	slot0.heroExp_ = {}

	BattleInstance.hideBattlePanel()
	slot0:CaculateReward()
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

function slot0.NeedOnceMore(slot0)
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == slot0.stageData:GetType() then
		slot1 = slot0.stageData:GetStageId()

		if slot3[(table.indexof(ChapterCfg[getChapterIDByStageID(slot1)].section_id_list, slot1) or 0) + 1] ~= nil then
			return true, GetTips("CHALLENGE_NEXT_LEVEL")
		end
	end

	return false
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
	slot0:RemoveTween()
	slot0:RemoveTweens()

	for slot4, slot5 in ipairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = nil

	for slot4, slot5 in ipairs(slot0.rewardItemGos_) do
		Object.Destroy(slot5)
	end

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

	slot0.itemPrefeb = slot0.itemPrefeb or Asset.Load("UI/Common/CommonItem")
	slot0.noInfoGos_ = {}
	slot0.missionGo_ = {}
	slot0.missionNoAchieve_ = {}
	slot0.missionAchieve_ = {}
	slot0.missionText_ = {}

	for slot4 = 1, 3 do
		slot0.noInfoGos_[slot4] = slot0["noInfo" .. slot4]
		slot0.missionGo_[slot4] = slot0["mission" .. slot4]
		slot0.missionNoAchieve_[slot4] = slot0["noachieve" .. slot4]
		slot0.missionAchieve_[slot4] = slot0["achieve" .. slot4]
		slot0.missionText_[slot4] = slot0["missionText" .. slot4]
	end

	slot0.heroGo_ = {}
	slot0.heroLv_ = {}
	slot0.heroImg_ = {}
	slot0.heroAddExp = {}
	slot0.heroProgress_ = {}

	for slot4 = 1, 3 do
		slot0.heroGo_[slot4] = slot0["hero" .. slot4]
		slot0.heroLv_[slot4] = slot0["heroLvText" .. slot4]
		slot0.heroImg_[slot4] = slot0["heroMaskIcon" .. slot4]
		slot0.heroAddExp[slot4] = slot0["heroAddExp" .. slot4]
		slot0.heroProgress_[slot4] = slot0["heroExpProgress" .. slot4]
	end

	slot0.rewardItems_ = {}
	slot0.rewardItemGos_ = {}

	LeanTween.alphaCanvas(slot0.mask_, 0, 0.1)
end

function slot0.GetRewardData(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.params_.rewardList) do
		table.insert(slot1, slot6)
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

		if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < uv0.stageData:GetCost() * uv0.stageData:GetMultiple() then
			if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
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
	slot0.btnBattleCount_.onClick:RemoveAllListeners()
end

function slot0.CaculateReward(slot0)
	slot0.rewardHeroExp_ = 0
	slot1 = 0

	if slot0.params_.rewardList then
		for slot5, slot6 in ipairs(slot0.params_.rewardList) do
			if ItemCfg[slot6[1]].type == ItemConst.ITEM_TYPE.CURRENCY and slot6[1] == CurrencyConst.CURRENCY_TYPE_HERO_EXP then
				slot1 = slot5
			end
		end
	end

	if slot1 ~= 0 then
		slot0.rewardHeroExp_ = slot0.params_.rewardList[slot1][2]

		table.remove(slot0.params_.rewardList, slot1)
	end
end

function slot0.RefreshUI(slot0)
	slot0:SetLevelTitle()
	slot0:RefreshRewardItemS()
	slot0:RefreshMyExpS()
	slot0:RefreshHeroS()
	slot0:RefreshMissionS()
	slot0:RefreshCommonUI()
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

	slot0:RefreshTitleImmediate()
end

function slot0.RefreshRewardItemS(slot0)
	for slot4, slot5 in ipairs(slot0.rewardItems_) do
		slot5:Show(false)
	end

	slot1 = {}

	if slot0.params_.rewardList then
		for slot5, slot6 in pairs(slot0.params_.rewardList) do
			table.insert(slot1, slot6)
		end

		slot1 = sortReward(mergeReward(slot1))
	end

	for slot5 = 1, #slot1 do
		if not slot0.rewardItems_[slot5] then
			slot6 = Object.Instantiate(slot0.itemPrefeb, slot0.rewardList_)
			slot0.rewardItems_[slot5] = CommonItem.New(slot6)

			slot0.rewardItems_[slot5]:RegistCallBack(function (slot0)
				ShowPopItem(POP_OTHER_ITEM, {
					slot0.id,
					slot0.number
				})
			end)

			slot0.rewardItemGos_[slot5] = slot6

			slot0.rewardItems_[slot5]:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
			slot0.rewardItems_[slot5]:SetBottomTextColor(Color.white)
		else
			slot0.rewardItems_[slot5]:Show(true)
		end

		if ItemCfg[formatReward(slot1[slot5]).id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[slot6.id].type then
			slot6.race = EquipCfg[slot6.id] and EquipCfg[slot6.id].race
		end

		slot0.rewardItems_[slot5]:RefreshData(slot6)
	end
end

function slot0.RefreshHeroS(slot0)
	slot1, slot2 = slot0.stageData:GetHeroTeam()
	slot3 = slot0.stageData:GetSystemHeroTeam()
	slot0.addExpData_ = {}

	if slot1[2] == 0 then
		table.remove(slot1, 2)
		table.remove(slot2, 2)
		table.insert(slot1, 0)
		table.insert(slot2, 0)
	end

	for slot7 = 1, 3 do
		if not slot1[slot7] or slot1[slot7] == 0 then
			SetActive(slot0.heroGo_[slot7], false)
		else
			SetActive(slot0.heroGo_[slot7], true)

			slot9 = SkinCfg[slot0.stageData:GetHeroDataByPos(slot7).skin_id]

			if slot0.heroImg_[slot7] ~= nil then
				slot0.heroImg_[slot7].sprite = getSpriteViaConfig("HeroIcon", slot9.picture_id)
			end

			if not slot3[slot7] and slot2[slot7] == 0 and slot0:NeedAddExp() then
				slot11 = slot8.exp - LvTools.LevelToExp(slot8.level, "hero_level_exp1")

				if LvTools.GetMaxTotalExp("hero_level_exp1") - slot8.exp < 0 then
					slot13 = 0
				end

				slot15 = slot0.stageData:GetAddHeroExp() * slot0.stageData:GetMultiple()
				slot16 = slot0.stageData:GetActivityID()
				slot17 = ActivityData:GetActivityData(slot16)

				if slot16 ~= 0 and (not slot17 or not slot17:IsActivitying()) then
					slot15 = 0
				end

				slot18 = math.min(slot15, slot13)
				slot20, slot21, slot22, slot23, slot24 = LvTools.CheckHeroExp(slot10, slot8.exp + slot18, HeroTools.GetHeroCurrentMaxLevel(slot8))
				slot18 = slot18 - slot24

				table.insert(slot0.addExpData_, {
					id = slot8.id,
					newLv = slot20,
					newExp = slot8.exp + slot18
				})

				slot0.heroAddExp[slot7].text = string.format("+%d", slot18)
				slot27 = math.min(math.floor(slot21 / GameLevelSetting[slot20].hero_level_exp1 * 1000) / 1000, 0.9999)

				slot0:RemoveTweenAt(slot7)

				slot0.heroExp_[slot7] = slot20 + slot27
				slot29 = LeanTween.value(slot0.heroProgress_[slot7].gameObject, slot10 + math.min(math.floor(slot11 / GameLevelSetting[slot10].hero_level_exp1 * 1000) / 1000, 0.9999), slot20 + slot27, 2)
				slot29 = slot29:setEase(LeanTweenType.easeOutCubic)
				slot29 = slot29:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0:UpdateHeroData(uv1, slot0)
				end))
				slot0.tweens_[slot7] = slot29:setOnComplete(LuaHelper.VoidAction(function ()
					uv0:RemoveTweenAt(uv1)
				end))
			else
				slot0.heroAddExp[slot7].text = "+0"
				slot0.heroLv_[slot7].text = slot8.level
				slot0.heroProgress_[slot7].value = 1
			end
		end
	end

	if slot0.addExpData_ then
		for slot7, slot8 in ipairs(slot0.addExpData_) do
			HeroAction.AddHeroExpSuccess(slot8.id, slot8.newLv, slot8.newExp)
		end

		slot0.addExpData_ = nil
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

function slot0.NeedAddExp(slot0)
	return true
end

function slot0.RefreshMyExpS(slot0)
	slot1 = slot0:GetPlayerInfo()
	slot2 = slot1.userLevel
	slot3 = slot1.remain_exp
	slot4 = slot0.stageData:GetAddUserExp() * slot0.stageData:GetMultiple()
	slot5 = slot0.stageData:GetActivityID()
	slot6 = ActivityData:GetActivityData(slot5)

	if slot5 ~= 0 and (not slot6 or not slot6:IsActivitying()) or not slot0:NeedAddExp() then
		slot4 = 0
	end

	if math.min(slot4, LvTools.GetMaxTotalExp("user_level_exp") - slot1.total_exp) < 0 then
		slot8 = 0
	end

	slot9, slot10 = LvTools.CheckExp(slot2, slot3 + slot8, "user_level_exp")

	if slot2 > 30 and slot9 - slot2 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(slot3), tostring(slot8), tostring(slot2), tostring(slot9)))
	end

	slot0.newPlayerExp_ = slot8
	slot0.addExp_.text = string.format("+%d", slot8)
	slot12 = math.floor(slot10 / GameLevelSetting[slot9].user_level_exp * 1000) / 1000

	if math.floor(slot3 / GameLevelSetting[slot2].user_level_exp * 1000) / 1000 > 0.99 then
		slot11 = 0.99
	end

	if slot12 > 0.99 then
		slot12 = 0.99
	end

	slot0:RemoveTween()

	slot0.userExp_ = slot9 + slot12

	if slot4 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	slot13 = -1
	slot14 = LeanTween.value(slot0.progress_.gameObject, slot2 + slot11, slot9 + slot12, 2)
	slot14 = slot14:setEase(LeanTweenType.easeOutCubic)
	slot14 = slot14:setOnUpdate(LuaHelper.FloatAction(function (slot0)
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
	slot0.tween_ = slot14:setOnComplete(LuaHelper.VoidAction(function ()
		uv0:CheckLevelUp()

		uv0.mask_.blocksRaycasts = false

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

function slot0.UpdateHeroData(slot0, slot1, slot2)
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

	for slot4, slot5 in ipairs(slot0.heroExp_) do
		slot0:UpdateHeroData(slot4, slot5)
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

function slot0.RefreshMissionS(slot0)
	SetActive(slot0.missionTipGo_, true)

	slot1 = slot0.params_.starMissionData
	slot2 = {}

	for slot6 = 1, 3 do
		if slot1 ~= nil and slot1[slot6] ~= nil then
			SetActive(slot0.noInfoGos_[slot6], false)
			SetActive(slot0.missionGo_[slot6], true)

			slot7 = ThreeStarConditionCfg[slot1[slot6].id]
			slot0.missionText_[slot6].text = BattleInstance.GetStarMissionText(slot1[slot6].id, slot1[slot6].xData, slot1[slot6].yData)
			slot8 = nil

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot0.stageType then
				slot8 = BattleStageData:GetStageData()[slot0.stageId]
			elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == slot0.stageType then
				slot8 = BattleBossChallengeNormalData:GetStarList(slot0.stageId)
			end

			slot9 = false

			if slot8 and slot8.stars and slot8.stars[slot6] == 1 then
				slot9 = true
			end

			slot10 = slot1[slot6].isComplete or slot9

			SetActive(slot0.missionNoAchieve_[slot6], not slot10)
			SetActive(slot0.missionAchieve_[slot6], slot10)

			if slot10 then
				slot0.missionText_[slot6].color = Color.New(0.9102, 0.9351, 0.9408, 1)
			else
				slot0.missionText_[slot6].color = Color.New(0.6768, 0.6853, 0.6882, 1)
			end

			slot2[slot6] = slot10 and 1 or 0
		else
			SetActive(slot0.missionGo_[slot6], false)
			SetActive(slot0.noInfoGos_[slot6], true)
		end
	end

	BattleInstance.RecordThreeStar(slot0.stageType, slot0.stageId, slot2)
end

function slot0.RefreshCommonUI(slot0)
	slot1 = true

	SetActive(slot0.btnBattleCount_.gameObject, BattleStageTools.GetStageCfg(slot0.stageType, slot0.stageId).tag ~= BattleConst.BATTLE_TAG.STORY)
	slot0:RefreshBottomBtn()
end

function slot0.RefreshBottomBtn(slot0)
	slot1, slot2 = slot0:NeedOnceMore()

	if slot2 then
		slot0.onceMoreLab_.text = slot2
	else
		slot0.onceMoreLab_.text = GetTips("CHALLENGE_ONCE_MORE")
	end

	SetActive(slot0.onceMoreGo_, slot1)
	SetActive(slot0.closeBtnGo_, slot1)
	SetActive(slot0.closePanel_, not slot1)
end

function slot0.RefreshBattleTime(slot0)
	SetActive(slot0.battleTimeGo_, BattleStageTools.GetStageCfg(slot0.stageType, slot0.stageId).tag ~= BattleConst.BATTLE_TAG.STORY)

	if slot1.tag == BattleConst.BATTLE_TAG.STORY then
		return
	end

	slot0.battleTimeText_.text = slot0:GetBattleTime()
end

function slot0.GetPlayerInfo(slot0)
	return PlayerData:GetPlayerInfo()
end

function slot0.GetBattleTime(slot0)
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function slot0.GetLevelUpInfoList(slot0)
	return PlayerData:GetlevelUpInfos()
end

function slot0.RefreshTitleImmediate(slot0)
	if slot0.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.titleTransform_)
	end
end

function slot0.OnWinStoryEnd(slot0)
	slot0:RefreshTitleImmediate()
end

return slot0
