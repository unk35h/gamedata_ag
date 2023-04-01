SectionBaseView = import("game.views.sectionInfo.SectionInfoMultipleBaseView")
slot0 = class("ActivityPt2SectionInfoView", SectionBaseView)

function slot0.UIName(slot0)
	return "UI/Stage/PTSectionInfoUI"
end

function slot0.Init(slot0)
	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.affixGoList_ = {}

	for slot5 = 1, slot0.affixContentTrans_.childCount do
		slot0.affixGoList_[slot5] = slot0.affixContentTrans_:GetChild(slot5 - 1).gameObject
	end
end

function slot0.AddListeners(slot0)
	uv0.super.AddListeners(slot0)
	slot0:RemoveBtnListener(nil, slot0.battleBtn_.transform)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		if uv0.lock_ then
			ShowTips(uv0.lockTips_)
		elseif uv0.costId ~= 0 and CurrencyData:GetCurrencyNum(uv0.costId) < uv0.cost * uv0.multiple_ then
			if uv0.costId == CurrencyConst.CURRENCY_TYPE_VITALITY then
				if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
					JumpTools.OpenPopUp("currencyBuyFatigue", uv0.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
				end
			else
				ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemCfg[uv0.costId].name))
			end
		else
			uv0:OnClickBtn()
		end
	end)
end

function slot0.UpdateBar(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		slot0.costId == 0 and CurrencyConst.CURRENCY_TYPE_VITALITY or slot0.costId,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:RegistBackCallBack(function ()
		if uv0.params_.backCall then
			uv0.params_.backCall()
		end

		uv0:Back()
	end)
end

function slot0.RefreshData(slot0)
	slot0.cfg_ = BattleStageTools.GetStageCfg(slot0.params_.sectionType, slot0.params_.section)

	slot0:RefreshCostInfo()

	slot1 = 1

	for slot5 = #GameSetting.challenge_multiple_count_unlock_level.value, 1, -1 do
		if CurrencyData:GetCurrencyNum(slot0.costId) >= slot0.cost * slot5 then
			slot1 = slot5

			break
		end
	end

	slot0.maxMultiple_ = slot1
	slot0.multiple_ = slot0.multiple_ or 1
	slot0.challengeCnt_ = slot0:GetUnlockChallengeCnt()
	slot2 = 0
	slot3 = ActivityCfg[slot0.params_.mainActivityId].sub_activity_list
	slot0.lock_ = false
	slot0.lockTips_ = ""
	slot0.isFirstClear_ = (slot0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL and (ActivityPt2Data:GetNormalData(slot3[1], slot0.params_.repeat_id) and slot4.clear_time or 0) or slot0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE and (ActivityPt2Data:GetChallengeData(slot3[2], slot0.params_.repeat_id) and slot4.clear_time or 0) or ActivityPt2Data:GetHardData(slot3[3]) and slot4.clear_time or 0) == 0
	slot0.drop_lib_id = slot0.cfg_.drop_lib_id
end

function slot0.RefreshCostInfo(slot0)
	if ActivityPt2Cfg[slot0.params_.repeat_id].cost[1][1] then
		slot0.costId = ActivityPt2Cfg[slot0.params_.repeat_id].cost[1][1]
		slot0.cost = ActivityPt2Cfg[slot0.params_.repeat_id].cost[1][2]
		slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(slot0.costId)

		SetActive(slot0.resourcePanel_, true)
		SetActive(slot0.multiplePanel_, true)
		SetActive(slot0.rewardPanel_, true)
	else
		slot0.costId = 0
		slot0.cost = 0

		SetActive(slot0.resourcePanel_, false)
		SetActive(slot0.multiplePanel_, false)
		SetActive(slot0.rewardPanel_, false)
	end
end

function slot0.RefreshStageInfo(slot0)
	slot0.cfg_ = BattleStageTools.GetStageCfg(slot0.params_.sectionType, slot0.params_.section)

	if slot0.oldCfgID_ ~= slot0.cfg_.id then
		slot0.sectionName_.text = slot0.cfg_.name
		slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot0.cfg_.background_1))
		slot0.textStory_.text = slot0.cfg_.tips
		slot0.oldCfgID_ = slot0.cfg_.id
		slot0.tipsText_.text = slot0.cfg_.tips
		slot0.titleCanvasGroup_.alpha = 0
		slot0.multiple_ = 1

		slot0:RefreshAffix()
	end
end

function slot0.RefreshAffix(slot0)
	if type(slot0.cfg_.affix_type) ~= "table" then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot0["affixName_" .. slot5].text = getAffixName(slot6)
		slot0["affixDesc_" .. slot5].text = getAffixDesc(slot6)
		slot0["affixIcon_" .. slot5].sprite = getAffixSprite(slot6)

		if slot0.affixGoList_[slot5] then
			SetActive(slot0.affixGoList_[slot5], true)
		end
	end

	for slot5 = #slot1 + 1, #slot0.affixGoList_ do
		if slot0.affixGoList_[slot5] then
			SetActive(slot0.affixGoList_[slot5], false)
		end
	end
end

function slot0.OnClickBtn(slot0)
	slot0:Go("/sectionSelectHero", {
		section = slot0.params_.section,
		sectionType = slot0.params_.sectionType,
		activityID = slot0.params_.activityId,
		multiple = slot0.multiple_
	})
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.GetUnlockChallengeCnt(slot0)
	slot1 = 0
	slot2 = ActivityCfg[slot0.params_.mainActivityId].sub_activity_list

	if (slot0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL and (ActivityPt2Data:GetNormalData(slot2[1], slot0.params_.repeat_id) and slot3.clear_time or 0) or slot0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE and (ActivityPt2Data:GetChallengeData(slot2[2], slot0.params_.repeat_id) and slot3.clear_time or 0) or ActivityPt2Data:GetHardData(slot2[3]) and slot3.clear_time or 0) > 0 then
		return uv0.super.GetUnlockChallengeCnt(slot0)
	end

	return slot1
end

function slot0.GetChallengeCntMaxTip(slot0)
	slot1 = 0
	slot2 = ActivityCfg[slot0.params_.mainActivityId].sub_activity_list

	if (slot0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL and (ActivityPt2Data:GetNormalData(slot2[1], slot0.params_.repeat_id) and slot3.clear_time or 0) or slot0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE and (ActivityPt2Data:GetChallengeData(slot2[2], slot0.params_.repeat_id) and slot3.clear_time or 0) or ActivityPt2Data:GetHardData(slot2[3]) and slot3.clear_time or 0) > 0 then
		return uv0.super.GetChallengeCntMaxTip(slot0)
	end

	return GetTips("ACTIVITY_PT_REPEAT_MULTIPLE_UNLOCK")
end

function slot0.Dispose(slot0)
	slot0.affixGoList_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
