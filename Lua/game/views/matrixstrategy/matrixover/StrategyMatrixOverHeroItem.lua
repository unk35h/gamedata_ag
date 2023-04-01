slot1 = class("StrategyMatrixOverHeroItem", import("game.views.matrixOver.MatrixOverHeroItem"))

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.servantView_ = StrategyMatrixOverHeroServantItem.New(slot0.servantItem_)
	slot0.equipItemView_ = {}

	for slot4 = 1, 5 do
		table.insert(slot0.equipItemView_, MatrixOverHeroEquipItem.New(slot0[string.format("equipGo%s_", slot4)]))
	end

	slot0.astrolabeItemView_ = {}

	for slot4 = 1, 6 do
		table.insert(slot0.astrolabeItemView_, StrategyMatrixOverHeroAstrolabeItem.New(slot0[string.format("astrolabeGo%s_", slot4)]))
	end
end

function slot1.SetMatrixActivityId(slot0, slot1)
	slot5 = slot1

	slot0.servantView_:SetMatrixActivityId(slot5)

	for slot5, slot6 in ipairs(slot0.astrolabeItemView_) do
		slot6:SetMatrixActivityId(slot1)
	end

	slot0.matrix_activity_id = slot1
end

function slot1.GetHeroData(slot0, slot1)
	return StrategyMatrixData:GetHeroData(slot0.matrix_activity_id, slot1)
end

function slot1.GetHeroSkin(slot0, slot1)
	return StrategyMatrixData:GetHeroSkin(slot0.matrix_activity_id, slot1)
end

return slot1
