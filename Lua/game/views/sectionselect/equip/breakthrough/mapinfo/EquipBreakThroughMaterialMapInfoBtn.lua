slot0 = class("EquipBreakThroughMaterialMapInfoBtn", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.toggleType_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "toggle")
	slot0.selectToggleHandler_ = handler(slot0, slot0.RefreshToggle)
end

function slot0.OnEnter(slot0, slot1)
	slot0:RefreshToggle(slot1)
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_SELECT_TOGGLE, slot0.selectToggleHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_SELECT_TOGGLE, slot0.selectToggleHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.selectToggleHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		manager.notify:Invoke(EQUIP_BREAK_THROUGH_SELECT_TOGGLE, uv0.toggleType_)
	end)
end

function slot0.RefreshToggle(slot0, slot1)
	if slot0.toggleType_ == slot1 then
		slot0.controller_:SetSelectedState("on")
	else
		slot0.controller_:SetSelectedState("off")
	end
end

return slot0
