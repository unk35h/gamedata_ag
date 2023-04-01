slot0 = class("SectionInfoBaseView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Stage/ChapterSectionInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.rewardItems_ = {}
	slot0.rewardGos_ = {}

	slot0:InitUI()
	slot0:AddListeners()

	slot0.multiple_ = 1
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.chapterID_ = slot0.params_.chapterID

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)

	slot0.stageID_ = slot0.params_.section
	slot0.stageType_ = slot0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.OnUpdate(slot0)
	if slot0.stageID_ == slot0.params_.section then
		return
	end

	slot0.stageID_ = slot0.params_.section

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot4 = {
		BACK_BAR,
		slot5
	}
	slot5 = HOME_BAR

	manager.windowBar:SwitchBar(slot4)

	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	SetActive(slot0.multiplePanel_, false)
	SetActive(slot0.tipsPanel_, false)
	SetActive(slot0.targetPanel_, false)
	SetActive(slot0.targetPanel_, true)

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
	slot4 = "skadi"

	slot0.controller_:SetSelectedState(slot4)

	slot0.sectionTargets_ = {}

	for slot4 = 1, 3 do
		slot0.sectionTargets_[slot4] = SectionTargetItem.New(slot0[string.format("targetItem%s_", slot4)], slot4)
	end
end

function slot0.AddListeners(slot0)
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
			BattleController.GetInstance():LaunchBattle(BattleSkadiLittleGameTemplate.New(uv0.chapterID_, uv0.activityID_))
		end
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.battleBtn_.onClick:RemoveAllListeners()
end

function slot0.RefreshData(slot0)
	slot0.lock_ = false
	slot0.lockTips_ = ""
	slot0.cost = 0
	slot0.isFirstClear_ = false
	slot0.drop_lib_id = 0
	slot0.lock_ = false
	slot0.lockTips_ = ""
	slot0.cost = BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).cost or 0
	slot0.drop_lib_id = slot1.drop_lib_id
	slot0.isFirstClear_ = false
end

function slot0.RefreshUI(slot0)
	slot0:RefreshStageInfo()
	slot0:RefreshReward()
	slot0:RefreshCost()
	SetActive(slot0.unlockGo_, slot0.lock_)

	slot4 = not slot0.lock_

	SetActive(slot0.battleBtnGo_, slot4)

	slot0.lockText_.text = slot0.lockTips_
	slot0.rewardView_.horizontalNormalizedPosition = 0

	for slot4, slot5 in pairs(slot0.sectionTargets_) do
		slot6, slot7 = slot0:GetThreeStar(slot4)

		slot5:Refresh(slot6, slot7)
	end
end

function slot0.RefreshCost(slot0)
	slot0.battleResourceText_.text = slot0.cost
end

function slot0.RefreshStageInfo(slot0)
	if slot0.oldCfgID_ ~= BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).id then
		slot0.sectionName_.text = slot1.name
		slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot1.background_1))
		slot0.textStory_.text = slot1.tips
		slot0.oldCfgID_ = slot1.id
	end
end

function slot0.RefreshReward(slot0)
	slot0:RefreshRewardPanel(slot0.drop_lib_id)
end

function slot0.RefreshRewardPanel(slot0, slot1)
	slot2 = getRewardFromDropCfg(slot1, slot0.isFirstClear_)

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

function slot0.GetThreeStar(slot0, slot1)
	return table.indexof(SummerLittleGameData:GetSkadiStars(slot0.chapterID_), slot1), BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).three_star_need[slot1]
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.sectionTargets_) do
		slot5:Dispose()
	end

	slot0.sectionTargets_ = {}

	slot0:RemoveListeners()

	for slot4, slot5 in pairs(slot0.rewardGos_) do
		Object.Destroy(slot5)
	end

	slot0.rewardGos_ = nil

	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
