slot0 = class("SurviveSoloSectionInfoView", SectionInfoBaseView)

function slot0.InitUI(slot0)
	slot0.super.InitUI(slot0)

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")

	slot0.controller_:SetSelectedState("surviveSolo")
end

function slot0.UpdateBar(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})

	slot1 = manager.windowBar

	slot1:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)

	slot1 = manager.windowBar

	slot1:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)

	slot1 = manager.windowBar

	slot1:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		if uv0.params_.backFunc then
			uv0.params_.backFunc()
		end

		uv0:Back()
	end)
end

function slot0.RefreshData(slot0)
	slot0.cfg_ = BattleStageTools.GetStageCfg(slot0.params_.sectionType, slot0.params_.section)
	slot0.cost_ = slot0.cfg_.cost or 0

	uv0.super.RefreshData(slot0)

	slot0.isFirstClear_ = false
	slot0.drop_lib_id = 0
	slot0.lockTips_ = ""
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
	end
end

function slot0.OnClickBtn(slot0)
	slot2 = {}
	slot3 = {}
	slot4 = {}

	if ActivitySoloSlayerCfg[slot0.params_.activityID].limit_type[1] == 1 then
		table.insert(slot2, slot1.limit_type[2])
	elseif slot5 == 2 then
		table.insert(slot3, slot1.limit_type[2])
	elseif slot5 == 3 then
		table.insert(slot4, slot1.limit_type[2])
	end

	HeroData:SaveSortValue(false, 0, slot4, slot3, slot2)
	slot0:Go("/sectionSelectHero", {
		isSorted = true,
		isHideEffect = true,
		section = slot0.params_.section,
		sectionType = slot0.params_.sectionType,
		activityID = slot0.params_.activityID
	})
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
