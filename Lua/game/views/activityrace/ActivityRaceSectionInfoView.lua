slot1 = class("ActivityRaceSectionInfoView", import("game.views.sectionInfo.SectionInfoMultipleBaseView"))
slot2 = #GameSetting.challenge_multiple_count_unlock_level.value

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)
end

function slot1.OnClickBtn(slot0)
	slot0:Go("/activityRaceSectionSelectHero", {
		section = slot0.stageID_,
		multiple = slot0.multiple_,
		sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE,
		activityID = slot0.params_.activityID,
		race = ActivityRaceCfg[slot0.params_.activityID].race_id
	})
end

function slot1.RefreshData(slot0)
	slot1 = BattleActivityRaceStageCfg[slot0.stageID_]
	slot0.lock_ = false
	slot0.cost = slot1.cost
	slot0.drop_lib_id = slot1.drop_lib_id
	slot0.isFirstClear_ = ActivityRaceData:GetStateList()[slot0.params_.activityID].completedStageList[slot0.stageID_] == nil

	uv0.super.RefreshData(slot0)
end

function slot1.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)
	SetActive(slot0.stageTitleGo_, false)

	slot1 = ActivityRaceCfg[slot0.params_.activityID].stage_list

	if not (slot0.stageID_ == slot1[#slot1]) then
		SetActive(slot0.rewardPanel_, true)
		SetActive(slot0.multiplePanel_, true)
	else
		SetActive(slot0.rewardPanel_, false)
		SetActive(slot0.multiplePanel_, false)
	end
end

function slot1.RefreshRewardPanel(slot0, slot1)
	slot2 = getRewardFromDropCfg(slot1, true)

	if slot0.isFirstClear_ and DropCfg[slot1] and #DropCfg[slot1].base_drop >= 1 then
		slot0.rewardTitleText_.text = GetTips("FIRST_DROP")
	else
		slot0.rewardTitleText_.text = GetTips("MAYBE_DROP")
	end

	for slot6, slot7 in pairs(slot2) do
		if slot0.rewardItems_[slot6] then
			slot0.rewardItems_[slot6]:SetData(slot7, true)
		else
			slot0.rewardGos_[slot6] = slot0.rewardGos_[slot6] or Object.Instantiate(slot0.rewardItem_, slot0.rewardParent_.transform)
			slot0.rewardItems_[slot6] = RewardPoolItem.New(slot0.rewardGos_[slot6], slot7, true)
		end

		SetActive(slot0.rewardGos_[slot6], true)

		if not slot0.isFirstClear_ or #DropCfg[slot1].base_drop < 1 then
			slot0.rewardItems_[slot6]:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
			slot0.rewardItems_[slot6]:HideNum()
		else
			slot0.rewardItems_[slot6]:ShowFloor(ItemConst.ITEM_FLOOR.LONG)
		end
	end

	for slot6 = #slot2 + 1, #slot0.rewardItems_ do
		SetActive(slot0.rewardGos_[slot6], false)
	end
end

function slot1.RefreshStageInfo(slot0)
	if slot0.oldCfgID_ ~= BattleActivityRaceStageCfg[slot0.stageID_].id then
		slot0.sectionName_.text = slot1.name
		slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot1.background_1))
		slot0.tipsText_.text = slot1.tips

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.tipsTextContentTrans_)

		slot0.oldCfgID_ = slot1.id
	end
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)

	slot0.multiple_ = 1
end

function slot1.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function slot1.RefreshMultiple(slot0)
	slot0.multipleText_.text = "x" .. slot0.multiple_

	if slot0.isFirstClear_ == true then
		slot0.maxMultipleBtn_.interactable = false
		slot0.maxMultipleBtnCanvas_.alpha = 0.5
	elseif slot0.maxMultiple_ <= slot0.multiple_ or slot0.challengeCnt_ <= slot0.multiple_ then
		slot0.maxMultipleBtn_.interactable = false
		slot0.maxMultipleBtnCanvas_.alpha = 0.5
		slot0.minMultipleBtn_.interactable = true
		slot0.minMultipleCanvas_.alpha = 1
		slot0.subBtn_.interactable = true
		slot0.subBtnCanvas_.alpha = 1
	elseif slot0.multiple_ <= 1 then
		slot0.maxMultipleBtn_.interactable = true
		slot0.maxMultipleBtnCanvas_.alpha = 1
		slot0.minMultipleBtn_.interactable = false
		slot0.minMultipleCanvas_.alpha = 0.5
		slot0.subBtn_.interactable = false
		slot0.subBtnCanvas_.alpha = 0.5
	else
		slot0.maxMultipleBtn_.interactable = true
		slot0.maxMultipleBtnCanvas_.alpha = 1
		slot0.minMultipleBtn_.interactable = true
		slot0.minMultipleCanvas_.alpha = 1
		slot0.subBtn_.interactable = true
		slot0.subBtnCanvas_.alpha = 1
	end

	if slot0.multiple_ == uv0 then
		slot0.addBtn_.interactable = false
		slot0.addBtnCanvas_.alpha = 0.5
	else
		slot0.addBtn_.interactable = true
		slot0.addBtnCanvas_.alpha = 1
	end

	if slot0.multiple_ <= 1 then
		slot0.minMultipleBtn_.interactable = false
		slot0.minMultipleCanvas_.alpha = 0.5
		slot0.subBtn_.interactable = false
		slot0.subBtnCanvas_.alpha = 0.5
	end
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		slot0 = uv0.stageID_
		slot1 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY)

		if uv0.lock_ then
			ShowTips(uv0.lockTips_)
		elseif slot1 < uv0.cost * uv0.multiple_ then
			if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
				JumpTools.OpenPopUp("currencyBuyFatigue", uv0.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
			end
		else
			uv0:OnClickBtn()
		end
	end)
	slot0:AddBtnListener(slot0.minMultipleBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "challenge_multiple")

		uv0.multiple_ = 1

		uv0:ChangeMultiple()
	end)
	slot0:AddBtnListener(slot0.subBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "single")

		uv0.multiple_ = uv0.multiple_ - 1

		uv0:ChangeMultiple()
	end)
	slot0:AddBtnListener(slot0.addBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "single")

		if uv0.isFirstClear_ == true then
			ShowTips("ACTIVITY_PT_REPEAT_MULTIPLE_UNLOCK")

			return
		end

		if uv0.challengeCnt_ <= uv0.multiple_ then
			ShowTips(uv0:GetChallengeCntMaxTip())

			return
		end

		uv0.multiple_ = uv0.multiple_ + 1

		uv0:ChangeMultiple()
	end)
	slot0:AddBtnListener(slot0.maxMultipleBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "challenge_multiple")

		slot0 = uv0.maxMultiple_

		if uv0.challengeCnt_ < uv0.maxMultiple_ then
			slot0 = uv0.challengeCnt_
		end

		uv0.multiple_ = slot0

		uv0:ChangeMultiple()
	end)
end

return slot1
