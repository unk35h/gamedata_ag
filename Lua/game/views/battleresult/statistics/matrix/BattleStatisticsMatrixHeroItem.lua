slot1 = class("BattleStatisticsMatrixHeroItem", import("..BattleStatisticsHeroItem"))

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)
	SetActive(slot0.LVGo_, false)
end

return slot1
