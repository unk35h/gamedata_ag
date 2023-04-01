slot0 = class("ChipFilterView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.RefreshFilterItem), slot0.uiList_, ChipFilterItem)
	slot0.chipTypeList_ = ChipTools.GetChipTypeList(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP])
	slot0.chipTypeCntList_ = ChipTools.GetChipTypeCntList(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP])
	slot2 = slot0.itemTransform_.sizeDelta.y

	if #slot0.chipTypeList_ <= 12 then
		slot0.uiListTransform_.sizeDelta = Vector2(slot0.uiListTransform_.sizeDelta.x, #slot0.chipTypeList_ * slot2)
	else
		slot0.uiListTransform_.sizeDelta = Vector2(slot0.uiListTransform_.sizeDelta.x, #slot0.chipTypeList_ * 12)
	end
end

function slot0.OnEnter(slot0)
	slot0.filterID_ = -1

	slot0:RefreshUI()
	slot0.uiList_:StartScroll(#slot0.chipTypeList_, 1)
end

function slot0.OnExit(slot0)
	SetActive(slot0.filterPanel_, false)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.mask_, nil, function ()
		SetActive(uv0.filterPanel_, false)
	end)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		SetActive(uv0.filterPanel_, true)
	end)
end

function slot0.RefreshFilterItem(slot0, slot1, slot2)
	slot3 = slot0.chipTypeList_[slot1]

	slot2:SetSpectID(slot3, #slot0.chipTypeCntList_[slot3], slot0.filterID_)
end

function slot0.OnClickFilterItem(slot0, slot1)
	slot0.filterID_ = slot1

	SetActive(slot0.filterPanel_, false)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot2 = nil
	slot0.label_.text = (slot0.filterID_ ~= -1 or GetTips("ALL")) and (slot1 ~= 0 or GetTips("NORMAL")) and HeroCfg[slot1].name
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end
end

return slot0
