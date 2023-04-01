slot0 = class("ActivityMatrixProcessAstrolabeReplaceView", MatrixProcessAstrolabeReplaceView)

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.item_ = ActivityMatrixProcessRewardItem.New(slot0.m_item)
	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, ActivityMatrixProcessAstrolabeRewardItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetMatrixActivityId(slot0.matrix_activity_id)
	uv0.super.indexItem(slot0, slot1, slot2)
end

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	slot0.item_:SetMatrixActivityId(slot0.matrix_activity_id)
	uv0.super.OnEnter(slot0)
end

function slot0.GetHeroData(slot0, slot1)
	return ActivityMatrixData:GetHeroData(slot0.matrix_activity_id, slot1)
end

return slot0
