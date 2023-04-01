slot0 = class("StrategyMatrixHeroAstrolabePage", MatrixHeroAstrolabePage)

function slot0.SetMatirxHeroInfo(slot0, slot1, slot2)
	slot0.matrix_activity_id = slot1

	uv0.super.SetMatirxHeroInfo(slot0, slot2)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.adjustBtn_, nil, function ()
		JumpTools.OpenPageByJump("/strategyMatrixAstrolabeAdjust", {
			heroId = uv0.heroInfo_.id,
			selectPos = {
				0
			},
			matrix_activity_id = uv0.matrix_activity_id
		})
	end)
end

function slot0.SelectItem(slot0, slot1)
	slot2 = slot1:GetItemInfo()

	JumpTools.OpenPageByJump("/strategyMatrixAstrolabeAdjust", {
		heroId = slot0.heroInfo_.id,
		selectPos = {
			slot2.posX,
			slot2.posY
		},
		matrix_activity_id = slot0.matrix_activity_id
	})
end

function slot0.GetHeroData(slot0, slot1)
	return StrategyMatrixData:GetHeroData(slot0.matrix_activity_id, slot1)
end

function slot0.GetAstrolabeMaxCount(slot0)
	return StrategyMatrixData:GetAstrolabeMaxCount(slot0.matrix_activity_id)
end

return slot0
