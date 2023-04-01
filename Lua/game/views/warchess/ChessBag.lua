slot0 = class("ChessBag", ReduxView)

function slot0.UIName(slot0)
	return "UI/WarChess/WarChessBag"
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.itempanelGo_, ChessBagItem)
	slot0.scrollHelperKey_ = LuaList.New(handler(slot0, slot0.indexItemKey), slot0.itempanel_keyGo_, CommonItem)
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot1, slot0.itemList_[slot1])
end

function slot0.indexItemKey(slot0, slot1, slot2)
	slot2:RefreshData(slot0.itemList_[slot1])
end

function slot0.UpdateData(slot0, slot1)
	slot0.itemList_ = {}

	if slot1 == 1 then
		for slot6, slot7 in pairs(WarChessData:GetItemData()) do
			if WarchessObjectCfg[slot6].type ~= ChessConst.OBJECT_TYPE.ENERGY then
				slot0.itemList_[#slot0.itemList_ + 1] = {
					star = 0,
					id = slot6,
					number = slot7,
					iconPath = "Textures/WarchessItem/WarchessHexIcon/" .. slot8.icon
				}
			end
		end
	elseif slot1 == 2 then
		for slot6, slot7 in pairs(WarChessData:GetArtifactData()) do
			if not (WarchessItemCfg[slot6].identify_buff == 1) then
				table.insert(slot0.itemList_, {
					id = slot6,
					num = slot7
				})
			end
		end
	elseif slot1 == 3 then
		for slot6, slot7 in pairs(WarChessData:GetArtifactData()) do
			if WarchessItemCfg[slot6].identify_buff == 1 then
				table.insert(slot0.itemList_, {
					id = slot6,
					num = slot7
				})
			end
		end
	end

	if slot0.type_ ~= slot1 then
		slot0:RecordStay(slot1)
	end

	slot0.type_ = slot1
end

function slot0.AddUIListener(slot0)
	slot0:AddToggleListener(slot0.toggle1Tgl_, function (slot0)
		if slot0 then
			uv0.emptyText1_.text = GetTips("PAGE_NO_USE")
			uv0.emptyText2_.text = GetTips("NO_ITEM")

			uv0:UpdateData(1)
			uv0.scrollHelperKey_:StartScroll(#uv0.itemList_)
			uv0.controller_:SetSelectedState("key")
			OperationRecorder.Record("chess", "key")
		end
	end)
	slot0:AddToggleListener(slot0.toggle2Tgl_, function (slot0)
		if slot0 then
			uv0.emptyText1_.text = GetTips("NO_FIX_ITEM")
			uv0.emptyText2_.text = GetTips("ALL_NULL")

			uv0:UpdateData(2)
			uv0.scrollHelper_:StartScroll(#uv0.itemList_)
			uv0.controller_:SetSelectedState("artifact")
			OperationRecorder.Record("chess", "artifact")
		end
	end)
	slot0:AddToggleListener(slot0.toggle3Tgl_, function (slot0)
		if slot0 then
			uv0.emptyText1_.text = GetTips("NO_ERROR_PARAMS")
			uv0.emptyText2_.text = GetTips("ALL_NULL")

			uv0:UpdateData(3)
			uv0.scrollHelper_:StartScroll(#uv0.itemList_)
			uv0.controller_:SetSelectedState("artifact")
			OperationRecorder.Record("chess", "artifact")
		end
	end)
end

function slot0.OnEnter(slot0)
	if slot0.toggle1Tgl_.isOn then
		slot0:UpdateData(1)
		slot0.scrollHelperKey_:StartScroll(#slot0.itemList_)
		slot0.controller_:SetSelectedState("key")
	else
		slot0.toggle1Tgl_.isOn = true
	end

	slot0.state = slot0.params_.state

	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RecordStay(slot0.type_)
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	slot0.scrollHelperKey_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.RecordStay(slot0, slot1)
	if slot0:GetStayTime() == 0 then
		return
	end

	slot3 = 0

	if slot1 == 1 then
		slot3 = 30205
	elseif slot1 == 2 then
		slot3 = 30204
	end

	OperationRecorder.RecordStayView("STAY_VIEW_CHESS_BAG", slot2, slot3)
	slot0:UpdateLastOpenTime()
end

return slot0
