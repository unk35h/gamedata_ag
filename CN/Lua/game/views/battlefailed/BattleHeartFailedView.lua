slot0 = class("BattleHeartFailedView", ReduxView)
slot1 = import("game.tools.BattleInstance")

function slot0.UIName(slot0)
	return "UI/BattleResult/BattleFailed"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stayTime = 20
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.restartBtn_, nil, function ()
		uv0:OnClickRestart()
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Quit()
	end)
end

function slot0.OnClickRestart(slot0)
	BattleController.GetInstance():LaunchBattle(slot0.params_.stageData)
end

function slot0.Quit(slot0)
	slot0.isEnd = true

	slot0:SetButtonActiveStage(false)
	slot0:RemoveTimer()

	slot0.timer_ = Timer.New(function ()
		uv0.QuitBattle(uv1.params_.stageData, true, true)
	end, 1, 1)

	slot0.timer_:Start()
	slot0.animator_:Play("battleFailed_out")
end

function slot0.SetButtonActiveStage(slot0, slot1)
	SetActive(slot0.restartBtn_.gameObject, slot1)
	SetActive(slot0.backBtn_.gameObject, slot1)
	SetActive(slot0.tipsGo_, not slot1)
end

function slot0.OnEnter(slot0)
	uv0.hideBattlePanel()
	slot0:SetButtonActiveStage(true)

	slot0.startTime = Time.realtimeSinceStartup
	slot0.isEnd = false

	slot0:RemoveTimer()

	slot0.timer_ = Timer.New(function ()
		uv0:Quit()
	end, slot0.stayTime, 1)

	slot0.timer_:Start()
	slot0.animator_:Play("battleFailed")
end

function slot0.OnExit(slot0)
	slot0:RemoveTimer()
end

function slot0.RemoveTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
