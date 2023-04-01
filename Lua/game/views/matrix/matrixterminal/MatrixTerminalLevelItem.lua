slot0 = class("MatrixLevelItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
	slot0:AddUIListener()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_clickBtn, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.level)
		end
	end)
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0.level = slot1
	slot0.m_levelLab.text = "" .. slot1
	slot0.m_selectLab.text = "" .. slot1

	if slot1 <= slot2 then
		slot0.typeController_:SetSelectedIndex(0)
	else
		slot0.typeController_:SetSelectedIndex(1)
	end
end

function slot0.SetChoice(slot0, slot1)
	slot0.selectController_:SetSelectedIndex(slot0.level == slot1 and 1 or 0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
