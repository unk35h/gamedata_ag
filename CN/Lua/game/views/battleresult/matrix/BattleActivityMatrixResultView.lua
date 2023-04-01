BattleMatrixResultView = import("game.views.battleResult.matrix.BattleMatrixResultView")
slot0 = class("BattleMatrixResultView", BattleMatrixResultView)

function slot0.SetLevelTitle(slot0)
	if ActivityTools.GetActivityType(slot0.stageData:GetActivityID()) == ActivityTemplateConst.SUB_SINGLE_MATRIX then
		slot4 = ActivityMatrixTierTemplateCfg[ActivityMatrixData:GetTierID(slot1)]
		slot0.stareText_.text = string.format("%s-%s", slot4.tier, slot4.level)
		slot0.lvText_.text = BattleActivityMatrixCfg[slot0.stageData:GetStageId()].name
		slot0.difficultText_.text = ""
		slot0.affixData = ActivityMatrixData:GetAffixList(slot1)

		slot0.affixList:StartScroll(math.max(#slot0.affixData, 3))
	elseif slot2 == ActivityTemplateConst.STRATEGY_MATRIX then
		slot4 = StrategyMatrixTierTemplateCfg[StrategyMatrixData:GetTierID(slot1)]
		slot0.stareText_.text = string.format("%s-%s", slot4.tier, slot4.level)
		slot0.lvText_.text = BattleStrategyMatrixCfg[slot0.stageData:GetStageId()].name
		slot0.difficultText_.text = ""
		slot0.affixData = StrategyMatrixData:GetAffixList(slot1)

		slot0.affixList:StartScroll(math.max(#slot0.affixData, 3))
	end

	slot0.timeText_.text = manager.time:DescCTime(BattleFieldData:GetBattleResultData().useSecond, "%M:%S")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.titleTransform_)
end

function slot0.RefreshHeroS(slot0)
	slot1 = slot0.stageData:GetHeroTeam()

	if ActivityTools.GetActivityType(slot0.stageData:GetActivityID()) == ActivityTemplateConst.SUB_SINGLE_MATRIX then
		for slot7 = 1, 3 do
			if not slot1[slot7] or slot1[slot7] == 0 then
				SetActive(slot0.heroGo_[slot7], false)
			else
				SetActive(slot0.heroGo_[slot7], true)

				slot0.heroImg_[slot7].sprite = getSpriteViaConfig("HeroIcon", SkinCfg[ActivityMatrixData:GetHeroSkin(slot2, slot1[slot7])].picture_id)
				slot9 = ActivityMatrixData:GetHeroData(slot2, slot1[slot7])
				slot10 = slot9:GetHeroHP()
				slot11 = slot9:GetHeroMaxHP()
				slot0.hpText_[slot7].text = string.format("<color=#FF9500>%s</color>/%s", slot10, slot11)
				slot0[string.format("hpSlider%s_", slot7)].value = slot10 / slot11
			end
		end
	elseif slot3 == ActivityTemplateConst.STRATEGY_MATRIX then
		for slot7 = 1, 3 do
			if not slot1[slot7] or slot1[slot7] == 0 then
				SetActive(slot0.heroGo_[slot7], false)
			else
				SetActive(slot0.heroGo_[slot7], true)

				slot0.heroImg_[slot7].sprite = getSpriteViaConfig("HeroIcon", SkinCfg[StrategyMatrixData:GetHeroSkin(slot2, slot1[slot7])].picture_id)
				slot9 = StrategyMatrixData:GetHeroData(slot2, slot1[slot7])
				slot10 = slot9:GetHeroHP()
				slot11 = slot9:GetHeroMaxHP()
				slot0.hpText_[slot7].text = string.format("<color=#FF9500>%s</color>/%s", slot10, slot11)
				slot0[string.format("hpSlider%s_", slot7)].value = slot10 / slot11
			end
		end
	end
end

return slot0
