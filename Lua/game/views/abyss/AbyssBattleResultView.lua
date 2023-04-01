BattleScoreResultView = import("game.views.battleResult.score.BattleScoreResultView")
slot0 = class("AbyssBattleResultView", BattleScoreResultView)

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)
	SetActive(slot0.onceMoreGo_, false)
	SetActive(slot0.closeBtnGo_, false)
end

return slot0
