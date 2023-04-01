slot0 = class("BattleFailedWithButtonView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BattleResult/BattleFailed"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "failedType")

	slot0.controller_:SetSelectedState("keep")
end

function slot0.OnEnter(slot0)
	BattleInstance.hideBattlePanel()

	slot0.startTime_ = Time.realtimeSinceStartup
	slot0.isEnd_ = false
	slot0.battleTimeText_.text = slot0:GetBattleTime()

	slot0.animator_:Play("battleFailed")
end

function slot0.OnExit(slot0)
	slot0:RemoveTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.keepBtn_, nil, function ()
		uv0:OnClickKeep()
	end)
	slot0:AddBtnListener(slot0.giveupBtn_, nil, function ()
		uv0:OnClickBack()
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

function slot0.GetBattleTime(slot0)
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function slot0.OnClickKeep(slot0)
	slot0:Quit()
end

function slot0.OnClickBack(slot0)
	slot0:Quit()
end

function slot0.Quit(slot0)
	slot0.isEnd_ = true

	slot0:RemoveTimer()

	slot0.timer_ = Timer.New(function ()
		BattleInstance.QuitBattle(uv0.params_.stageData, true, true)
	end, 1, 1)

	slot0.timer_:Start()
	slot0.animator_:Play("battleFailed_out")
end

function slot0.RemoveTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
