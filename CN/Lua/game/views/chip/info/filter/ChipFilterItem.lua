slot0 = class("ChipFilterItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.clickFilterItemHandler_ = handler(slot0, slot0.OnClickFilterItem)

	manager.notify:RegistListener(ON_CLICK_CHIP_FILTER, slot0.clickFilterItemHandler_)

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		manager.notify:Invoke(ON_CLICK_CHIP_FILTER, uv0.spectID_)
	end)
end

function slot0.OnClickFilterItem(slot0, slot1)
	slot0.controller_:SetSelectedState(slot1 == slot0.spectID_ and "on" or "off")
end

function slot0.SetSpectID(slot0, slot1, slot2, slot3)
	slot0.spectID_ = slot1
	slot4 = nil
	slot0.name_.text = (slot1 ~= -1 or GetTips("ALL")) and (slot1 ~= 0 or GetTips("NORMAL")) and HeroCfg[slot1].name
	slot0.cnt_.text = slot2

	slot0:OnClickFilterItem(slot3)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(ON_CLICK_CHIP_FILTER, slot0.clickFilterItemHandler_)
end

return slot0
