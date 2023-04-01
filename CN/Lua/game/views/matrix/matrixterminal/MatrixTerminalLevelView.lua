slot0 = class("MatrixTerminalLevelView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Matrix/Terminal/MatrixTerminalLevelUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, MatrixTerminalLevelItem)
	slot0.desController_ = ControllerUtil.GetController(slot0.transform_, "des")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.curLevel = MatrixData:GetTerminalLevel()
	slot0.selectLevel = slot0.curLevel
	slot0.data = slot0:ReverseTable(MatrixTerminalLevelCfg.all)

	slot0.list_:StartScroll(#slot0.data)
	slot0.list_:ScrollToIndex(table.indexof(slot0.data, slot0.curLevel), true, false)
	slot0:RefreshInfo()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.data[slot1], slot0.curLevel)
	slot2:SetChoice(slot0.selectLevel)
	slot2:RegistCallBack(handler(slot0, slot0.OnItemClick))
end

function slot0.OnItemClick(slot0, slot1)
	slot0.selectLevel = slot1

	for slot6, slot7 in pairs(slot0.list_:GetItemList()) do
		slot7:SetChoice(slot0.selectLevel)
	end

	slot0:RefreshInfo()
end

function slot0.RefreshInfo(slot0)
	slot0.m_levelLab.text = "" .. slot0.selectLevel
	slot1 = MatrixTerminalLevelCfg[slot0.selectLevel]
	slot0.m_giftLab.text = "+" .. slot1.point - (MatrixTerminalLevelCfg[slot0.selectLevel - 1] and MatrixTerminalLevelCfg[slot2].point or 0)

	if slot1.desc and slot1.desc ~= "" then
		slot0.desController_:SetSelectedIndex(1)

		slot0.m_desLab.text = slot1.desc
	else
		slot0.desController_:SetSelectedIndex(0)
	end
end

function slot0.ReverseTable(slot0, slot1)
	slot2 = {}

	for slot6 = 1, #slot1 do
		slot2[slot6] = slot1[#slot1 + 1 - slot6]
	end

	return slot2
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
