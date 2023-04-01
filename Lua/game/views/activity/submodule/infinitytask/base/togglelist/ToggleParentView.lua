slot0 = class("ToggleParentView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index_ = slot2
	slot0.childrenCnt_ = slot3

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.childrenItemList_ = {}

	for slot7 = 1, slot3 do
		slot0.childrenItemList_[slot7] = ToggleChildrenView.New(slot0[string.format("toggleChildren%s_", slot7)], slot2, slot7)
	end

	slot0.controller_ = ControllerUtil.GetController(slot0.toggle_.transform, "toggle")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.toggle_, nil, function ()
		manager.notify:Invoke(TOGGLE_LIST_CHILDREN_UPDATE, uv0.index_, uv0.childrenIndex_)
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.childrenItemList_) do
		slot5:Dispose()
	end

	slot0.childrenItemList_ = nil
end

function slot0.SetSelectOn(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0.childrenItemList_) do
		slot7:SetSelectOn(slot2)
	end

	if slot0.index_ == slot1 then
		slot0.controller_:SetSelectedState("on")

		slot0.childrenIndex_ = slot2
	else
		slot0.controller_:SetSelectedState("off")
	end

	SetActive(slot0.goChildren_, slot3)
end

return slot0
