slot0 = class("LeviathanSectionInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Stage/ChapterSectionInfoUI"
end

function slot0.RefreshData(slot0)
	slot0.lock_ = false
	slot0.lockTips_ = ""
	slot0.cost = 0
	slot0.isFirstClear_ = false
	slot0.drop_lib_id = 0
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.multiple_ = 1
end

function slot0.OnEnter(slot0)
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

	slot0.activityID_ = slot0.params_.activityID
	slot0.chapterID_ = slot0.params_.chapterID
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
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	SetActive(slot0.multiplePanel_, false)
	SetActive(slot0.tipsPanel_, false)
	SetActive(slot0.targetPanel_, false)

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")

	slot0.controller_:SetSelectedState("leviathan")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		BattleController.GetInstance():LaunchBattle(BattleLeviathanLittleGameTemplate.New(uv0.chapterID_, uv0.activityID_))
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.battleBtn_.onClick:RemoveAllListeners()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshStageInfo()
	slot0:RefreshCost()
	SetActive(slot0.unlockGo_, slot0.lock_)
	SetActive(slot0.battleBtnGo_, not slot0.lock_)

	slot0.lockText_.text = slot0.lockTips_
	slot0.rewardView_.horizontalNormalizedPosition = 0
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

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	uv0.super.Dispose(slot0)
end

return slot0
