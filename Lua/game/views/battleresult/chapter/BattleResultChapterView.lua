BattleResultBaseView = import("game.views.battleResult.BattleResultBaseView")
slot0 = class("BattleResultChapterView", BattleResultBaseView)

function slot0.NeedAddExp(slot0)
	if BattleStageData:GetStageData()[slot0.stageData:GetStageId()].clear_times <= 1 then
		return true
	else
		return false
	end
end

function slot0.RefreshBottomBtn(slot0)
	slot1 = slot0.stageData:GetStageId()
	slot4 = StageTools.GetChapterNextStageID(getChapterIDByStageID(slot1), slot1) ~= nil
	slot5 = BattleStageData:GetStageData()[slot1]

	if manager.guide:IsPlaying() and table.keyof(GameSetting.guide_use_old_result_stage.value, slot1) and slot5 and slot5.clear_times == 1 then
		slot4 = false
	end

	SetActive(slot0.nextStageGo_, slot4)
	SetActive(slot0.closeBtnGo_, slot4)
	SetActive(slot0.closePanel_, not slot4)
	SetActive(slot0.vitalityPanel_, slot4)

	if slot3 then
		if BattleStageData:GetStageData()[slot3].clear_times <= 0 then
			slot0.vitalityCostText_.text = BattleStageTools.GetStageCfg(slot0.stageData:GetType(), slot3).cost
		else
			slot0.vitalityCostText_.text = 0
		end
	end
end

function slot0.AddListener(slot0)
	uv0.super.AddListener(slot0)
	slot0:AddBtnListener(slot0.nextStageBtn_, nil, function ()
		slot0 = uv0.stageData:GetStageId()
		slot2 = StageTools.GetChapterNextStageID(getChapterIDByStageID(slot0), slot0)
		slot4 = BattleStageTools.GetStageCfg(uv0.stageData:GetType(), slot2)
		slot6 = 0

		if BattleStageData:GetStageData()[slot2].clear_times <= 0 then
			slot6 = slot4.cost
		end

		if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < slot6 then
			if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
				JumpTools.OpenPopUp("currencyBuyFatigue", uv0.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
			end

			return
		end

		if BattleConst.BATTLE_TAG.STORY == slot4.tag then
			uv0:Back()
			BattleController.GetInstance():LaunchStoryBattle(slot3, slot2)
		else
			BattleInstance.GotoBattleReadyPage(slot1, slot2, slot3)
		end
	end)
end

return slot0
