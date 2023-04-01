slot1 = class("BattleSequentialBattleResultView", import("game.views.battleResult.BattleResultBaseView"))

function slot1.UIName(slot0)
	return "UI/MardukUI/continuousBattle/MardukContinuousBattleSettlementUI"
end

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.finishController_ = ControllerUtil.GetController(slot0.transform_, "finish")
	slot0.bossController_ = ControllerUtil.GetController(slot0.bossTf_, "name")
	slot0.buffItemList_ = {}
end

function slot1.RefreshUI(slot0)
	slot0:SetLevelTitle()
	slot0:RefreshMyExpS()
	slot0:RefreshHeroS()
	slot0:RefreshBattleTime()
	slot0:RefreshFinishState()
	slot0:RefreshLeftPanel()
	slot0:RefreshBuffPanel()
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
				uv0:OnClickClose()
			end
		})
	end
end

function slot1.SetLevelTitle(slot0)
	slot0.stareText_.text = BattleSequentialBattleStageCfg[slot0.stageId].name

	slot0:RefreshTitleImmediate()
end

function slot1.RefreshBattleTime(slot0)
	SetActive(slot0.battleTimeGo_, BattleStageTools.GetStageCfg(slot0.stageType, slot0.stageId).tag ~= BattleConst.BATTLE_TAG.STORY)

	if slot1.tag == BattleConst.BATTLE_TAG.STORY then
		return
	end

	slot0.battleTimeText_.text = slot0:GetBattleTime()
end

function slot1.RefreshLeftPanel(slot0)
	slot1 = slot0.params_.stageData:GetActivityID()
	slot2 = SequentialBattleData:GetCurrentFinishStageIndex(slot1)
	slot0.finishText_.text = string.format("%s/%s", slot2, #SequentialBattleChapterCfg[slot1].stage_id)

	if SequentialBattleChapterCfg[slot1].boss_list[slot2] ~= 0 then
		slot0.bossController_:SetSelectedState("true")

		slot0.portraitImage_.sprite = getSpriteWithoutAtlas(string.format("Textures/MardukUI/boss/icon/%s", slot3.boss_list[slot2]))
	else
		slot0.bossController_:SetSelectedState("false")
	end
end

function slot1.RefreshBuffPanel(slot0)
	for slot5 = #slot0.params_.stageData:GetStageAffix() + 1, #slot0.buffItemList_ do
		slot0.buffItemList_[slot5]:Show(false)
	end

	for slot5 = 1, #slot1 do
		slot0.buffItemList_[slot5] = slot0.buffItemList_[slot5] or SequentialBattleFactoryTeamBuff.New(slot0.buffItem_, slot0.buffParent_)

		slot0.buffItemList_[slot5]:SetData(slot1[slot5])
	end
end

function slot1.RefreshFinishState(slot0)
	slot1 = slot0.params_.stageData:GetActivityID()

	if SequentialBattleData:GetCurrentFinishStageIndex(slot1) + 1 > #SequentialBattleChapterCfg[slot1].stage_id then
		slot0.finishController_:SetSelectedState("true")
	else
		slot0.finishController_:SetSelectedState("false")
	end
end

function slot1.AddListener(slot0)
	slot0:AddBtnListener(slot0.buttonMask_, nil, function ()
		uv0:EndAnimator()
	end)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		BattleInstance.QuitBattle(uv0.params_.stageData)
	end)
	slot0:AddBtnListener(slot0.btnOnceMore_, nil, function ()
		uv0:OnClickNextStage()
	end)
	slot0:AddBtnListener(slot0.btnBattleCount_, nil, function ()
		uv0.toStat_ = true

		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = uv0.stageData,
			battleTime = uv0:GetBattleTime()
		})
	end)
	slot0:AddBtnListener(slot0.giveUpBtn_, nil, function ()
		uv0:OnClickClose()
	end)
end

function slot1.OnClickClose(slot0)
	slot1 = slot0.params_.stageData
	slot1 = slot1:GetActivityID()

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("SEQUENTIAL_BATTLE_RESET_STAGE"),
		OkCallback = function ()
			SequentialBattleAction.ResetTeam(uv0, function (slot0)
				if isSuccess(slot0.result) then
					SequentialBattleData:ResetChapterTeamData(uv0)
					BattleInstance.QuitBattle(uv1.params_.stageData, nil, true)
				else
					ShowTips(slot0.result)
				end
			end)
		end
	})
end

function slot1.OnClickNextStage(slot0)
	slot1 = slot0.params_.stageData:GetActivityID()

	BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE, SequentialBattleChapterCfg[slot1].stage_id[SequentialBattleData:GetCurrentFinishStageIndex(slot1) + 1], slot1))
end

function slot1.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.buffItemList_) do
		slot5:Dispose()
	end

	slot0.buffItemList_ = nil

	uv0.super.Dispose(slot0)
end

return slot1
