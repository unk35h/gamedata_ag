slot0 = class("ActivityMatrixTreasureMiniView", MatrixTreasureMiniView)

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	uv0.super.OnEnter(slot0)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, slot0.matrix_activity_id)
end

function slot0.GetArtifactList(slot0)
	return ActivityMatrixData:GetArtifactList(slot0.matrix_activity_id)
end

return slot0
