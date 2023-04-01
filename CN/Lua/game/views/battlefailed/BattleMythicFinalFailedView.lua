slot0 = class("BattleMythicFinalFailedView", BattleFailedView)

function slot0.UIName(slot0)
	return "UI/BattleResult/BattleMythicFailed"
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	SetActive(slot0.tipsGo_, false)

	slot0.stageData = slot0.params_.stageData
end

function slot0.OnEnter(slot0)
	BattleInstance.hideBattlePanel()
	slot0:RecordThreeStar()

	slot0.startTime = Time.realtimeSinceStartup
	slot0.isEnd = false

	slot0:RemoveTimer()

	slot0.battleTimeText_.text = slot0:GetBattleTime()

	slot0.animator_:Play("battleFailed")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_backBtn, nil, function ()
		if uv0.isEnd then
			return
		end

		if Time.realtimeSinceStartup - uv0.startTime < 2 then
			return
		end

		uv0:Quit()
	end)
	slot0:AddBtnListener(slot0.m_againBtn, nil, function ()
		if uv0.isEnd then
			return
		end

		if uv0.stageData then
			uv0:OnceMoreBattle()
		else
			uv0:Quit()
		end
	end)
	slot0:AddBtnListener(slot0.btnBattleCount_, nil, function ()
		if uv0.isEnd then
			return
		end

		uv0:RemoveTimer()
		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = uv0.stageData,
			battleTime = uv0:GetBattleTime()
		})
	end)
end

function slot0.Quit(slot0)
	BattleInstance.QuitBattle(slot0.params_.stageData)
end

function slot0.OnceMoreBattle(slot0)
	slot0.isEnd = true

	slot0:RemoveTimer()

	slot0.timer_ = Timer.New(function ()
		BattleInstance.OnceMoreBattle(uv0.stageData)
	end, 1, 1)

	slot0.timer_:Start()
	slot0.animator_:Play("battleFailed_out")
end

return slot0
