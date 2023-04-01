slot0 = class("ToggleChildrenView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.parentIndex_ = slot2
	slot0.index_ = slot3

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "toggle")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.toggle_, nil, function ()
		manager.notify:Invoke(TOGGLE_LIST_CHILDREN_UPDATE, uv0.parentIndex_, uv0.index_)
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.SetSelectOn(slot0, slot1)
	if slot0.index_ == slot1 then
		slot0.controller_:SetSelectedState("on")
	else
		slot0.controller_:SetSelectedState("off")
	end
end

return slot0
