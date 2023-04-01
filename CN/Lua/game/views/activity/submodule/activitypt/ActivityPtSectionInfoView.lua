SectionBaseView = import("game.views.sectionInfo.SectionInfoMultipleBaseView")
slot0 = class("ActivityPtSectionInfoView", SectionBaseView)

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

function slot0.UpdateBar(slot0)
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
end

function slot0.RefreshData(slot0)
	slot0.cfg_ = BattleStageTools.GetStageCfg(slot0.params_.sectionType, slot0.params_.section)
	slot0.cost = slot0.cfg_.cost or 0

	uv0.super.RefreshData(slot0)

	slot0.lock_ = false
	slot0.lockTips_ = ""
	slot0.isFirstClear_ = SummerActivityPtData:GetLevelChallengeCount(slot0.params_.repeat_id) == 0
	slot0.drop_lib_id = slot0.cfg_.drop_lib_id
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
	if SummerActivityPtData:GetLevelChallengeCount(slot0.params_.repeat_id) > 0 then
		return uv0.super.GetUnlockChallengeCnt(slot0)
	end

	return SummerActivityPtData:GetLevelChallengeCount(slot0.params_.repeat_id)
end

function slot0.GetChallengeCntMaxTip(slot0)
	if SummerActivityPtData:GetLevelChallengeCount(slot0.params_.repeat_id) > 0 then
		return uv0.super.GetChallengeCntMaxTip(slot0)
	end

	return GetTips("ACTIVITY_PT_REPEAT_MULTIPLE_UNLOCK")
end

function slot0.Dispose(slot0)
	slot0.affixGoList_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
