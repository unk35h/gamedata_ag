slot0 = class("PolyhedronTerminalItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.id = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.frameController = ControllerUtil.GetController(slot0.transform_, "frame")
	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot3 = (PolyhedronTerminalCfg[slot0.id].classify or 1) - 1

	if slot1.hinge == 0 then
		slot0.frameController:SetSelectedIndex(slot3)
	else
		slot0.frameController:SetSelectedIndex(slot3 + 3)
	end

	slot0.m_icon.sprite = getSpriteWithoutAtlas(PolyhedronConst.TERMINAL_ICON_PATH .. slot1.icon)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.id, uv0)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.stateController:SetSelectedIndex(slot2)
end

function slot0.SetChoice(slot0, slot1)
	slot0.selectController:SetSelectedIndex(slot1 and 1 or 0)
end

function slot0.GetId(slot0)
	return slot0.id
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
