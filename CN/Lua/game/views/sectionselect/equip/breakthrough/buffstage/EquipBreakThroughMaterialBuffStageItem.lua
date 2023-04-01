slot0 = class("EquipBreakThroughMaterialBuffStageItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectHandler_ = handler(slot0, slot0.SelectItem)

	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_SELECT_BUFF, slot0.selectHandler_)

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		manager.notify:Invoke(EQUIP_BREAK_THROUGH_SELECT_BUFF, uv0.index_)
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_SELECT_BUFF, slot0.selectHandler_)

	slot0.selectHandler_ = nil
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.mapStageID_ = slot2

	slot0:RefreshUI()
	slot0:SelectItem(slot3)
end

function slot0.RefreshUI(slot0)
	slot3 = EquipBreakThroughMaterialItemCfg[EquipBreakThroughMaterialData:GetStageData()[slot0.mapStageID_].buffList[slot0.index_]]
	slot0.nameText_.text = slot3.name
	slot0.descText_.text = getAffixDesc(slot3.params)
	slot0.icon_.sprite = getSprite("Atlas/EquipBreakThroughMaterialIcon", slot3.icon)
end

function slot0.SelectItem(slot0, slot1)
	if slot0.index_ == slot1 then
		slot0.controller_:SetSelectedState("1")
	else
		slot0.controller_:SetSelectedState("0")
	end
end

return slot0
