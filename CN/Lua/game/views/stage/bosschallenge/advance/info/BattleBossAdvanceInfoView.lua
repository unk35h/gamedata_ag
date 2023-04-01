slot1 = class("BattleBossAdvanceInfoView", import("game.views.stage.bossChallenge.BattleBossInfoBaseView"))

function slot1.UIName(slot0)
	return "UI/BossChallenge/BossAdvanceInformationUI"
end

function slot1.OnEnterExtend(slot0)
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_ADVANCE_DESC")

	slot0.bossIndex_ = slot0.params_.bossIndex or BattleBossChallengeData:GetCacheSelectBossIndex()

	BattleBossChallengeData:SaveCacheSelectBossIndex(slot0.bossIndex_)
	manager.redPoint:bindUIandKey(slot0.transformStar_, RedPointConst.BOSS_CHALLENGE_ADVANCE)
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transformStar_, RedPointConst.BOSS_CHALLENGE_ADVANCE)
end

function slot1.OnUpdate(slot0)
	uv0.super.OnUpdate(slot0)
	slot0:RefreshResetBtn()
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.startBattleBtn_, nil, function ()
		uv0:Go("/bossAdvanceTarget", {
			bossIndex = uv0.bossIndex_
		})
	end)
	slot0:AddBtnListener(slot0.buttonExchange_, nil, function ()
		JumpTools.OpenPageByJump("bossAdvanceReward")
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_CHALLENGE_RESET"),
			OkCallback = function ()
				BattleBossChallengeAction.ResetHardModeBoss(uv0.bossIndex_, function (slot0)
					if isSuccess(slot0.result) then
						uv0:RefreshData()
						uv0:RefreshUI()
					else
						ShowTips(slot0.result)
					end
				end)
			end
		})
	end)
end

function slot1.RefreshData(slot0)
	slot0.templateID_ = BattleBossChallengeAdvanceData:GetBossList()[slot0.bossIndex_].templateID
	slot0.lockHeroGroup_ = BossTools.GetLockHero()
end

function slot1.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)

	slot0.pointText_.text = BattleBossChallengeAdvanceData:GetMaxPoint(slot0.bossIndex_)

	slot0:RefreshResetBtn()
end

function slot1.RefreshResetBtn(slot0)
	if #BattleBossChallengeAdvanceData:GetReceiveRewardList() > 0 then
		SetActive(slot0.resetGo_, false)

		return
	end

	if BattleBossChallengeAdvanceData:GetBossList()[slot0.bossIndex_].maxPoint > 0 then
		SetActive(slot0.resetGo_, true)
	else
		SetActive(slot0.resetGo_, false)
	end
end

return slot1
