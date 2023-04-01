slot1 = class("StrategyMatrixIncidentView", import("game.views.matrixStrategy.matrixProcess.StrategyMatrixProcessView"))

function slot1.UIBackCount(slot0)
	return 1
end

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)
	SetActive(slot0.m_infoBtn.gameObject, false)
end

return slot1
