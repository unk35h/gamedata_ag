slot0 = class("BossAdvanceSwitchView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BossChallenge/BossAdvanceSwitchUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.bossItemList_ = {}
	slot0.challengeUpdateHandler_ = handler(slot0, slot0.UpdateBossChallenge)
	slot0.challengeInitHandler_ = handler(slot0, slot0.RefreshUI)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_ADVANCE_DESC")
	BossTools.CheckTimeout()
	slot0:RefreshUI()
	manager.redPoint:bindUIandKey(slot0.transformStar_, RedPointConst.BOSS_CHALLENGE_ADVANCE)
	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, slot0.challengeUpdateHandler_)

	slot4 = BOSS_CHALLENGE_UPDATE
	slot5 = slot0.challengeInitHandler_

	manager.notify:RegistListener(slot4, slot5)
	slot0:CheckMail()

	for slot4, slot5 in ipairs(slot0.bossItemList_) do
		slot5:OnEnter()
	end
end

function slot0.OnUpdate(slot0)
	slot0:RefreshResetBtn()

	for slot4, slot5 in pairs(slot0.bossItemList_) do
		slot5:RefreshResetBtn()
	end
end

function slot0.CheckMail(slot0)
	if PlayerData:GetUnclaimed(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.BOSS) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function ()
				PlayerAction.ReadUnclaimedMessage(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.BOSS)
			end
		})
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveUpdateTimer()
	manager.redPoint:unbindUIandKey(slot0.transformStar_, RedPointConst.BOSS_CHALLENGE_ADVANCE)
	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, slot0.challengeUpdateHandler_)

	slot4 = BOSS_CHALLENGE_UPDATE
	slot5 = slot0.challengeInitHandler_

	manager.notify:RemoveListener(slot4, slot5)

	for slot4, slot5 in ipairs(slot0.bossItemList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.challengeUpdateHandler_ = nil
	slot0.challengeInitHandler_ = nil

	for slot4, slot5 in pairs(slot0.bossItemList_) do
		slot5:Dispose()
	end

	slot0.bossItemList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonShop_, nil, function ()
		JumpTools.GoToSystem("/shop", {
			shopId = 17,
			showShops = {
				17
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.buttonExchange_, nil, function ()
		JumpTools.OpenPageByJump("bossAdvanceReward")
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_CHALLENGE_RESET_MODE"),
			OkCallback = function ()
				BattleBossChallengeAction.ResetHardMode(function (slot0)
					if isSuccess(slot0.result) then
						gameContext:OverrideUrl("/bossSwitch", "/bossMode")
						gameContext:OverrideUrl("/bossAdvanceSwitch", "/bossMode")
						gameContext:Go("/bossMode")
					else
						ShowTips(slot0.result)
					end
				end)
			end
		})
	end)
end

function slot0.RefreshUI(slot0)
	slot0.nameText_.text = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].name2

	slot0:RefreshBossBtnList()
	slot0:AddUpdateTimer()
	slot0:ClacuteScrollWidth()
	slot0:RefreshResetBtn()
end

function slot0.RefreshResetBtn(slot0)
	SetActive(slot0.resetGo_, #BattleBossChallengeAdvanceData:GetReceiveRewardList() <= 0)
end

function slot0.UpdateBossChallenge(slot0)
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

function slot0.RefreshBossBtnList(slot0)
	for slot5, slot6 in ipairs(BattleBossChallengeAdvanceData:GetBossList()) do
		if slot0.bossItemList_[slot5] then
			slot0.bossItemList_[slot5]:RefreshUI()
		else
			slot0.bossItemList_[slot5] = BossAdvanceSwitchItem.New(slot0.goItem_, slot0.itemParent_, slot5)
		end
	end

	for slot5 = #slot0.bossItemList_, #slot1 + 1, -1 do
		slot0.bossItemList_[slot5]:OnExit()
		slot0.bossItemList_[slot5]:Dispose()

		slot0.bossItemList_[slot5] = nil
	end
end

function slot0.AddUpdateTimer(slot0)
	slot0:RemoveUpdateTimer()

	slot0.textTime_.text = string.format(GetTips("REFRESH_LOST_TIME_WITH_COLOR"), manager.time:GetLostTimeStr(BattleBossChallengeData:GetNextRefreshTime()))
	slot0.updateTimer_ = Timer.New(function ()
		if BattleBossChallengeData:GetNextRefreshTime() ~= uv0 then
			uv1:RemoveUpdateTimer()
		end

		uv1.textTime_.text = string.format(GetTips("REFRESH_LOST_TIME_WITH_COLOR"), manager.time:GetLostTimeStr(slot0))
	end, 1, -1)

	slot0.updateTimer_:Start()
end

function slot0.RemoveUpdateTimer(slot0)
	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end
end

function slot0.ClacuteScrollWidth(slot0)
	slot0.parentRect_.sizeDelta = Vector2(BossChallengeAdvancePosCfg[#BattleBossChallengeAdvanceData:GetBossList()].position[1] - slot0.viewportRect_.rect.width + slot0.viewportRect_.rect.width / 4, 707)
end

return slot0
