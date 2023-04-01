slot0 = class("ActivityMatrixAstrolabeAdjustView", MatrixAstrolabeAdjustView)

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	uv0.super.OnEnter(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.overviewBtn_, nil, function ()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixMiniHero")
	end)
end

function slot0.OnTop(slot0)
end

function slot0.GetHeroData(slot0, slot1)
	return ActivityMatrixData:GetHeroData(slot0.matrix_activity_id, slot1)
end

return slot0
