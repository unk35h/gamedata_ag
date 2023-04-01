slot0 = class("StrategyMatrixProcessWeaponReplaceView", MatrixProcessWeaponReplaceView)

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.item_l = StrategyMatrixProcessRewardItem.New(slot0.m_item_l)
	slot0.item_r = StrategyMatrixProcessRewardItem.New(slot0.m_item_r)
end

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	slot0.item_l:SetMatrixActivityId(slot0.matrix_activity_id)
	slot0.item_r:SetMatrixActivityId(slot0.matrix_activity_id)
	uv0.super.OnEnter(slot0)
end

function slot0.GetHeroData(slot0, slot1)
	return StrategyMatrixData:GetHeroData(slot0.matrix_activity_id, slot1)
end

return slot0
