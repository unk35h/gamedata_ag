slot0 = class("EquipBreakThroughMaterialTeamInfoView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.itemList_ = {}
end

function slot0.OnEnter(slot0)
	for slot4 = 1, 3 do
		if slot0.itemList_[slot4] == nil then
			slot0.itemList_[slot4] = EquipBreakThroughMaterialTeamInfoItem.New(slot0.itemGo_, slot0.itemParent_, slot4)
		end

		slot0.itemList_[slot4]:OnEnter()
	end
end

function slot0.OnEixt(slot0)
	for slot4, slot5 in ipiars(itemList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil
end

return slot0
