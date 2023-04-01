slot0 = class("EquipBreakThroughResultHeroView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.heroItemList_ = {}

	for slot5 = 1, 3 do
		slot0.heroItemList_[slot5] = EquipBreakThroughResultHeroItem.New(slot0[string.format("heroGo%s_", slot5)], slot5)
	end
end

function slot0.SetData(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.heroItemList_) do
		slot6:SetData(slot1)
	end
end

function slot0.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.heroItemList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.heroItemList_) do
		slot5:Dispose()
	end

	slot0.heroItemList_ = nil
end

return slot0
