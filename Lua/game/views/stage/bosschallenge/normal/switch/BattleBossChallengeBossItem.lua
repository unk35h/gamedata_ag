slot0 = class("BattleBossChallengeBossItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)

	slot0.bossIndex_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "bossItem")
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
	slot0:AddTimer()
	slot0:AddDelayTimer()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0:StopDelayTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:RemoveListeners()

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.isLock_ then
			ShowTips(string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(BattleBossChallengeNormalData:GetBossUnlockTime(uv0.bossIndex_))))
		else
			uv0:Go("/bossChallenge", {
				bossIndex = uv0.bossIndex_
			})
		end
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_CHALLENGE_NORMAL_RESET"),
			OkCallback = function ()
				BattleBossChallengeAction.ResetNormalModeBoss(uv0.bossIndex_, function (slot0)
					if isSuccess(slot0.result) then
						uv0:RefreshUI()
					else
						ShowTips(slot0.result)
					end
				end)
			end
		})
	end)
end

function slot0.RemoveListeners(slot0)
end

function slot0.RefreshUI(slot0)
	slot2 = BossChallengeUICfg[StageGroupCfg[BattleBossChallengeNormalData:GetBossList()[slot0.bossIndex_]].boss_id]
	slot0.icon_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossLittlePaint.path, slot2.icon))
	slot0.textName_.text = slot2.main_name
	slot0.textLv_.text = GetTips("BOSS_LEVEL_" .. StageTools.GetBossChallengeNextIndex(slot0.bossIndex_))

	slot0:RefreshResetBtn()
end

function slot0.RefreshResetBtn(slot0)
	if table.length(BattleBossChallengeNormalData:GetReceiveStarList()) > 0 then
		SetActive(slot0.resetGo_, false)

		return
	end

	if table.length(BattleBossChallengeNormalData:GetLockHero()[slot0.bossIndex_]) > 0 then
		SetActive(slot0.resetGo_, true)
	else
		SetActive(slot0.resetGo_, false)
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.RefreshLock(slot0, slot1)
	if slot1 then
		slot0.controller_:SetSelectedState("lock")
	else
		slot0.controller_:SetSelectedState("false")
	end
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot2 = manager.time:GetServerTime() < BattleBossChallengeNormalData:GetBossUnlockTime(slot0.bossIndex_)

	slot0:RefreshLock(slot2)

	slot0.isLock_ = slot2

	if slot2 then
		slot0.timeText_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(slot1))
		slot0.timer_ = Timer.New(function ()
			uv0.timeText_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(uv1))

			if uv1 <= manager.time:GetServerTime() then
				uv0:StopTimer()

				uv0.isLock_ = false

				uv0:RefreshLock(false)
			end
		end, 1, -1)

		slot0.timer_:Start()
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.AddDelayTimer(slot0)
	slot0:StopDelayTimer()
	slot0:Show(false)

	slot0.delayTimer_ = Timer.New(function ()
		uv0:Show(true)
	end, 0.1 * (slot0.bossIndex_ - 1), 1)

	slot0.delayTimer_:Start()
end

function slot0.StopDelayTimer(slot0)
	if slot0.delayTimer_ then
		slot0.delayTimer_:Stop()

		slot0.delayTimer_ = nil
	end
end

return slot0
