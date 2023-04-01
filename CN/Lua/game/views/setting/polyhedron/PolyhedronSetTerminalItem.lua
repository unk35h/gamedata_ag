slot0 = class("PolyhedronSetTerminalItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.frameController = ControllerUtil.GetController(slot0.transform_, "frame")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if uv0.clickFunc then
			slot0 = PolyhedronTerminalCfg[uv0.id]

			uv0.clickFunc(slot0.name, slot0.desc, uv0.transform_.position)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.id = slot1
	slot4 = (PolyhedronTerminalCfg[slot1].classify or 1) - 1

	if slot2.hinge == 0 then
		slot0.frameController:SetSelectedIndex(slot4)
	else
		slot0.frameController:SetSelectedIndex(slot4 + 3)
	end

	slot0.m_icon.sprite = getSpriteWithoutAtlas(PolyhedronConst.TERMINAL_ICON_PATH .. slot2.icon)
	slot0.m_name.text = slot2.name
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

return slot0
