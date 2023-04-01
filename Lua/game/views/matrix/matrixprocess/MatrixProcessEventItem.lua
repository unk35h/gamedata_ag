slot0 = class("MatrixProcessEventItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index = slot2

	slot0:initUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_clickBtn, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.index)
		end
	end)
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.selectedController_ = ControllerUtil.GetController(slot0.m_controller, "selected")
	slot0.typeController_ = ControllerUtil.GetController(slot0.m_controller, "type")
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.index = slot2

	if slot0.id and MatrixEventCfg[slot0.id] or nil then
		slot0.typeController_:SetSelectedIndex(slot3.event_type - 1)

		slot0.m_name.text = slot3.name
		slot0.m_subName.text = slot3.sub_name
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.GetTypeName(slot0, slot1)
	return GetTips("MATRIX_TYPE_NOTE_" .. slot1)
end

function slot0.SetSelected(slot0, slot1)
	slot0.selectedController_:SetSelectedIndex(slot1 and 1 or 0)
end

function slot0.GetIndex(slot0)
	return slot0.index
end

return slot0
