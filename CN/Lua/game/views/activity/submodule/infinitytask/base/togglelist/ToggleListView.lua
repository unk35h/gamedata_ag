slot0 = class("ToggleListView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.parentItemList_ = {}

	for slot6, slot7 in ipairs(slot2) do
		slot0.parentItemList_[slot6] = ToggleParentView.New(slot0[string.format("toggleParent%s_", slot6)], slot6, slot7)
	end

	slot0.childrenHandler_ = handler(slot0, slot0.ChildrenUpdate)
end

function slot0.OnEnter(slot0)
	for slot4, slot5 in pairs(slot0.parentItemList_) do
		slot5:OnEnter()
	end

	manager.notify:RegistListener(TOGGLE_LIST_CHILDREN_UPDATE, slot0.childrenHandler_)
end

function slot0.OnExit(slot0)
	for slot4, slot5 in pairs(slot0.parentItemList_) do
		slot5:OnExit()
	end

	manager.notify:RemoveListener(TOGGLE_LIST_CHILDREN_UPDATE, slot0.childrenHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.parentItemList_) do
		slot5:Dispose()
	end

	slot0.parentItemList_ = nil
	slot0.childrenHandler_ = nil
end

function slot0.SetSelectOn(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0.parentItemList_) do
		slot7:SetSelectOn(slot1, slot2)
	end

	manager.notify:Invoke(TOGGLE_LIST_UPDATE, slot1, slot2)
end

function slot0.ChildrenUpdate(slot0, slot1, slot2)
	slot0:SetSelectOn(slot1, slot2)
end

return slot0
