slot0 = class("PolyhedronTerminalLevelItem", ReduxView)

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

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1)
	slot2 = PolyhedronTerminalLevelCfg[slot1]

	if slot1 <= PolyhedronData:GetTerminalLevel() then
		slot0.stateController:SetSelectedIndex(1)
	else
		slot0.stateController:SetSelectedIndex(0)
	end

	slot0.m_levelLab.text = slot1
	slot0.m_des.text = slot2.des
	slot7 = nil

	if slot2.point - (PolyhedronTerminalLevelCfg[slot1 - 1] and PolyhedronTerminalLevelCfg[slot4].point or 0) ~= 0 then
		slot7 = string.format(GetTips("POLYHEDRON_TERMINAL_LEVEL_POINT"), slot6)
	end

	if slot2.des and slot2.des ~= "" then
		if slot7 ~= nil then
			slot7 = slot7 .. " ;"
		end

		slot7 = slot7 .. slot2.des
	end

	slot0.m_des.text = slot7
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
