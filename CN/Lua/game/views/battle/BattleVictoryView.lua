slot0 = class("BattleVictoryView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BattleVictory"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.InitUI(slot0)
	slot0.bg_screen_ = slot0:FindCom(typeof(Image), "bg_screen")
	slot0.bg_screen_.enabled = false
	slot0.mask_ = slot0:FindCom(typeof(Button), "bg")
	slot0.timer_ = Timer.New(function ()
		uv0.timer_:Stop()
		uv0:Back()
		manager.newPlayerGuide:FinishStep()
	end, 1.5, 1)

	slot0.timer_:Start()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.mask_, nil, function ()
		uv0.timer_:Stop()
		uv0:Back()
		manager.newPlayerGuide:FinishStep()
	end)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
