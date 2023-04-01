slot0 = class("ActivityMatrixProcessAstrolabeRewardItem", MatrixProcessAstrolabeRewardItem)

function slot0.SetMatrixActivityId(slot0, slot1)
	slot0.matrix_activity_id = slot1
end

function slot0.GetHeroData(slot0, slot1)
	return ActivityMatrixData:GetHeroData(slot0.matrix_activity_id, slot1)
end

function slot0.GetHeroSkin(slot0, slot1)
	return ActivityMatrixData:GetHeroSkin(slot0.matrix_activity_id, slot1)
end

function slot0.GetItemDes(slot0, slot1)
	return MatrixTools.GetMatrixItemDes(slot1, nil, slot0.matrix_activity_id)
end

return slot0
