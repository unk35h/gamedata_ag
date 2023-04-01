slot0 = class("MatrixProcessIncidentItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

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
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.index = slot2
	slot0.m_tipLab.text = slot2
	slot0.m_desLab.text = MatrixDescCfg[slot1] and slot3.desc or ""
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.SetSelected(slot0, slot1)
	slot0.selectedController_:SetSelectedIndex(slot1 and 1 or 0)
end

function slot0.GetIndex(slot0)
	return slot0.index
end

return slot0
