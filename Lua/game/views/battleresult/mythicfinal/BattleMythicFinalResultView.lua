slot1 = class("BattleMythicFinalResultView", import("game.views.battleResult.BattleResultBaseView"))

function slot1.UIName(slot0)
	return "UI/BattleResult/MythicBattleSettlementUI"
end

function slot1.RefreshUI(slot0)
	slot0:SetLevelTitle()
	slot0:RefreshMyExpS()
	slot0:RefreshHeroS()
	slot0:RefreshMythicFinalUI()
	slot0:RefreshBattleTime()
end

function slot1.OnEnter(slot0)
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
				BattleInstance.TryNextBattle(uv0.stageData)
			end
		})
	end

	if slot0.stageData:GetDest() >= #MythicData:GetCurLevelIdList() then
		if not MythicData:GetIsNew() then
			MythicAction.QueryCurRank()
			MythicAction.UpdateMythicFinalRedPoint()
		end

		SetActive(slot0.gogiveup_, false)
		SetActive(slot0.pointgo_, true)

		slot0.pointtext_.text = MythicData:GetCurPoint()
	else
		SetActive(slot0.gogiveup_, true)
		SetActive(slot0.pointgo_, false)
	end
end

function slot1.RefreshMythicFinalUI(slot0)
	slot0.teamindextext_.text = string.format(slot0.stageData:GetDest() .. "/" .. #MythicData:GetCurLevelIdList())
	slot0.teamtext_.text = GetTips("TEAM_" .. slot0.stageData:GetDest())
end

function slot1.SetLevelTitle(slot0)
	slot0.lvText_.text = string.format(GetTips("MYTHIC_FINAL_LEVEL"), MythicData:GetCurHotLevelId())

	slot0:RefreshTitleImmediate()
end

function slot1.RefreshBattleTime(slot0)
	if BattleStageTools.GetStageCfg(slot0.stageType, slot0.stageId).tag == BattleConst.BATTLE_TAG.STORY then
		return
	end

	slot0.battleTimeText_.text = slot0:GetBattleTime()
	slot0.teamTimeText_.text = slot0:GetBattleTime()
	slot2 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
	slot0.remainTimeText_.text = manager.time:DescCdTime2(MythicData:GetBattlingTime())
end

function slot1.AddListener(slot0)
	slot0:AddBtnListener(slot0.btnClose_, nil, function ()
		BattleInstance.TryNextBattle(uv0.stageData)
	end)
	slot0:AddBtnListener(slot0.buttonMask_, nil, function ()
		uv0:EndAnimator()
	end)
	slot0:AddBtnListener(slot0.btnOnceMore_, nil, function ()
		ShowMessageBox({
			content = GetTips("MYTHIC_FINAL_LEVEL_RETRY"),
			OkCallback = function ()
				BattleInstance.OnceMoreBattle(uv0.stageData)
			end
		})
	end)
	slot0:AddBtnListener(slot0.btnBattleCount_, nil, function ()
		uv0.toStat_ = true

		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = uv0.stageData,
			battleTime = uv0:GetBattleTime()
		})
	end)
	slot0:AddBtnListener(slot0.btngiveup_, nil, function ()
		BattleInstance.QuitBattle(uv0.stageData)
	end)
end

return slot1
