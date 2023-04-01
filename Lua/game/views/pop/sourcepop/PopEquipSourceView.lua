slot0 = class("PopEquipSourceView", import("game.views.pop.PopItemView"))

function slot0.OnEnter(slot0)
	slot0.equipInfo_ = slot0.params_.equip_info or {}

	uv0.super.OnEnter(slot0)

	slot0.itemList_ = {}

	slot0:RefreshItem()

	if slot0.params_.suitID then
		slot0:CustomizeForSuit(slot0.params_.suitID)
	end
end

function slot0.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil

	uv0.super.OnExit(slot0)
end

function slot0.CustomInitUI(slot0)
	SetActive(slot0.operatePanel_, false)
	SetActive(slot0.infoPanel_, false)
	SetActive(slot0.sourcePanel_, true)
	SetActive(slot0.sourceDesGo_, false)
	SetActive(slot0.infoBtn_.gameObject, false)
	SetActive(slot0.mergeBtn_.gameObject, false)
	SetActive(slot0.cntPanel_, false)
end

function slot0.RefreshCommonItem(slot0)
	if not slot0.commonItemView_ then
		slot0.commonItemView_ = CommonItem.New(slot0.commonItem_)
	end

	slot0.commonItemView_:RefreshData({
		id = slot0.itemInfo_[1],
		equip_info = slot0.equipInfo_
	})
	slot0.commonItemView_:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
	SetActive(slot0.commonItemView_.num_.gameObject, false)
	slot0.commonItemView_:HideNum()
end

function slot0.CustomizeForSuit(slot0, slot1)
	slot0.nameText_.text = EquipSuitCfg[slot1].name

	SetActive(slot0.cntPanel_, false)
end

function slot0.RefreshItem(slot0)
	if #ItemCfg[slot0.itemInfo_[1]].source > 0 then
		for slot5, slot6 in ipairs(slot1) do
			if slot6[1] == 0 then
				slot0.itemList_[slot5] = PopSourceDisplayItemView.New(slot0.displayItem_, slot0.sourceParent_, slot6)
			elseif SystemLinkCfg[slot6[1]].text_invalid ~= 0 then
				slot0.itemList_[slot5] = PopSourceInvalidItemView.New(slot0.lockItem_, slot0.sourceParent_, slot6)
			else
				sourceData = deepClone(slot6)
				sourceData.equipId = slot0.itemInfo_[1]
				slot0.itemList_[slot5] = PopSourceUnlockItemView.New(slot0.unlockItem_, slot0.sourceParent_, sourceData)

				slot0.itemList_[slot5]:SetJumpCallback(handler(slot0, slot0.OnJumpCallback))
			end
		end
	end
end

function slot0.OnJumpCallback(slot0)
	OperationRecorder.Record(slot0.lastRecord_, "jump")
end

return slot0
