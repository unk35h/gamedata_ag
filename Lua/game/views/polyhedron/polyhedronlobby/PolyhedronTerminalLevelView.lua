slot0 = class("PolyhedronTerminalLevelView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Polyhedron/Terminal/PolyhedronTerminalpupUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, PolyhedronTerminalLevelItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot1 = PolyhedronData:GetTerminalLevel()
	slot2 = PolyhedronData:GetTerminalExp()
	slot0.m_levelLab.text = "" .. slot1

	if slot1 == #PolyhedronTerminalLevelCfg.all then
		slot0.m_expSlider.value = 1
		slot3 = PolyhedronTerminalLevelCfg[slot1].exp - PolyhedronTerminalLevelCfg[slot1 - 1].exp
		slot0.m_expLab.text = string.format("<color=#FF9500>%d</color>/%d", slot3, slot3)
	else
		slot3 = PolyhedronTerminalLevelCfg[slot1 + 1].exp - PolyhedronTerminalLevelCfg[slot1].exp
		slot0.m_expSlider.value = slot2 / slot3
		slot0.m_expLab.text = string.format("<color=#FF9500>%d</color>/%d", slot2, slot3)
	end

	slot0.list:StartScroll(#PolyhedronTerminalLevelCfg.all, table.indexof(PolyhedronTerminalLevelCfg.all, slot1), false)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(PolyhedronTerminalLevelCfg.all[slot1])
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
