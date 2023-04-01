slot0 = class("PopItemMergeView", PopItemSourceView)

function slot0.AddListeners(slot0)
	uv0.super.AddListeners(slot0)
	slot0:AddBtnListener(slot0.mergeBtn_, nil, function ()
		JumpTools.OpenPageByJump("synthesise", {
			id = uv0.itemInfo_[1]
		})
	end)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.equipInfo_ = slot0.params_.equip_info or {}
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
end

function slot0.CustomInitUI(slot0)
	uv0.super.CustomInitUI(slot0)
	SetActive(slot0.operatePanel_, false)
	SetActive(slot0.infoPanel_, true)
	SetActive(slot0.sourceDesGo_, false)
	SetActive(slot0.cntPanel_, true)
	SetActive(slot0.mergeBtn_.gameObject, true)
end

function slot0.RefreshCommonItem(slot0)
	if not slot0.commonItemView_ then
		slot0.commonItemView_ = CommonItem.New(slot0.commonItem_)
	end

	slot0.commonItemView_:RefreshData({
		id = slot0.itemInfo_[1],
		equip_info = slot0.equipInfo_
	})
	slot0.commonItemView_:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	SetActive(slot0.commonItemView_.num_.gameObject, false)
	slot0.commonItemView_:HideNum()
end

function slot0.RefreshItem(slot0)
	uv0.super.RefreshItem(slot0)

	slot2 = 0

	if MaterialData:GetMaterial(slot0.itemInfo_[1]) then
		slot2 = slot1.num
	end

	slot0.cntText_.text = string.format("x%d", slot2)
end

return slot0
