slot1 = class("BattleStatisticsActivityMatrixOverView", import("game.views.battleResult.statistics.matrix.over.BattleStatisticsMatrixOverView"))

function slot1.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	uv0.super.OnEnter(slot0)
end

function slot1.GetGameState(slot0)
	return ActivityMatrixData:GetGameState(slot0.matrix_activity_id)
end

function slot1.GetCurrentClearTime(slot0)
	return ActivityMatrixData:GetCurrentClearTime(slot0.matrix_activity_id)
end

function slot1.GetMatrixHeroTeam(slot0)
	return ActivityMatrixData:GetMatrixHeroTeam(slot0.matrix_activity_id)
end

function slot1.GetHeroData(slot0, slot1)
	return ActivityMatrixData:GetHeroData(slot0.matrix_activity_id, slot1)
end

function slot1.GetHeroSkin(slot0, slot1)
	return ActivityMatrixData:GetHeroSkin(slot0.matrix_activity_id, slot1)
end

return slot1
