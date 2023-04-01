slot0 = class("PolyhedronBeaconView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Polyhedron/Beacon/PolyhedronBeaconUI"
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

	slot0.beaconList_ = LuaList.New(handler(slot0, slot0.IndexBeaconItem), slot0.m_list, PolyhedronBeaconItem)
	slot0.nextController = ControllerUtil.GetController(slot0.transform_, "next")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_backBtn, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.m_okBtn, nil, function ()
		PolyhedronAction.QueryStartPolyhedron({
			PolyhedronData:GetCacheSelectHero()
		}, uv0.selectBeaconList, PolyhedronData:GetCacheSelectDifficulty())
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.selectBeaconList = PolyhedronData:GetCacheBeaconList()
	slot0.maxBeaconSelect = 3
	slot0.maxBeaconSelect = PolyhedronData:GetBeaconMaxBeaconSelect()
	slot0.beaconData = PolyhedronData:GetUnlockBeaconList()

	slot0.beaconList_:StartScroll(#slot0.beaconData)

	slot0.m_numLab.text = #slot0.selectBeaconList .. "/" .. slot0.maxBeaconSelect
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	PolyhedronData:SetCacheBeaconList(slot0.selectBeaconList)
end

function slot0.IndexBeaconItem(slot0, slot1, slot2)
	slot3 = slot0.beaconData[slot1]
	slot4 = not not table.indexof(slot0.selectBeaconList, slot3)

	slot2:SetData(slot3)
	slot2:SetChoice(slot4)
	slot2:SetMask(not slot4 and slot0.maxBeaconSelect <= #slot0.selectBeaconList)
	slot2:RegistCallBack(handler(slot0, slot0.OnBeaconItemClick))
end

function slot0.OnBeaconItemClick(slot0, slot1, slot2)
	if table.indexof(slot0.selectBeaconList, slot1) then
		slot0:UnSelectBeacon(slot1)
	else
		if slot0.maxBeaconSelect == 0 then
			ShowTips("POLYHEDRON_SELECT_BEACON_EMPTY")

			return
		end

		if slot0.maxBeaconSelect <= #slot0.selectBeaconList then
			ShowTips("POLYHEDRON_SELECT_BEACON_MAX")

			return
		end

		slot5 = {}
		slot6 = PolyhedronData:GetTerminalGift() or {}
		slot7 = ipairs
		slot9 = PolyhedronBeaconCfg[slot1].require_terminal_list or {}

		for slot10, slot11 in slot7(slot9) do
			if table.indexof(slot6, slot11) then
				table.insert(slot5, slot11)
			end
		end

		if #slot5 > 0 then
			slot7 = ""

			for slot11, slot12 in ipairs(slot5) do
				slot13 = PolyhedronTerminalCfg[slot12]
				slot7 = (slot11 ~= 1 or slot13.name) and slot13.name .. "," .. slot13.name
			end

			ShowMessageBox({
				content = string.format(GetTips("ERROR_MATRIX_NOT_EFFECTIVE"), slot4.name, slot7),
				OkCallback = function ()
					uv0:SelectBeacon(uv1)
				end
			})

			return
		end

		slot0:SelectBeacon(slot1)
	end
end

function slot0.SelectBeacon(slot0, slot1)
	table.insert(slot0.selectBeaconList, slot1)

	slot0.m_numLab.text = #slot0.selectBeaconList .. "/" .. slot0.maxBeaconSelect

	slot0.beaconList_:Refresh()
end

function slot0.UnSelectBeacon(slot0, slot1)
	table.remove(slot0.selectBeaconList, table.indexof(slot0.selectBeaconList, slot1))

	slot0.m_numLab.text = #slot0.selectBeaconList .. "/" .. slot0.maxBeaconSelect

	slot0.beaconList_:Refresh()
end

function slot0.Dispose(slot0)
	slot0.beaconList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
