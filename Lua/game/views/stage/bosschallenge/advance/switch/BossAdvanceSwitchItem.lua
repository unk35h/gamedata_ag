slot0 = class("BossAdvanceSwitchItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.bossIndex_ = slot3

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
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.isLock_ then
			ShowTips(string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(BattleBossChallengeAdvanceData:GetBossList()[uv0.bossIndex_].timestamp)))
		else
			uv0:Go("/bossAdvanceInfo", {
				bossIndex = uv0.bossIndex_
			})
		end
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_CHALLENGE_RESET"),
			OkCallback = function ()
				BattleBossChallengeAction.ResetHardModeBoss(uv0.bossIndex_, function (slot0)
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
	slot2 = BattleBossChallengeAdvanceData:GetBossList()[slot0.bossIndex_]
	slot3 = BossChallengeUICfg[slot2.templateID]
	slot0.icon_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossLittlePaint.path, slot3.icon))
	slot0.nameText_.text = slot3.main_name
	slot0.weaknessText_.text = slot3.weakness
	slot0.numText_.text = string.format("NO.%02d", slot0.bossIndex_)
	slot0.pointText_.text = slot2.maxPoint
	slot4 = BossChallengeAdvancePosCfg[slot0.bossIndex_].position
	slot0.transform_.localPosition = Vector3(slot4[1], slot4[2], 0)

	slot0:RefreshResetBtn()
	slot0:Show(true)
end

function slot0.RefreshResetBtn(slot0)
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

	slot3 = manager.time:GetServerTime() < BattleBossChallengeAdvanceData:GetBossList()[slot0.bossIndex_].timestamp

	slot0:RefreshLock(slot3)

	slot0.isLock_ = slot3

	if slot3 then
		slot0.timeText_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(slot2))
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
