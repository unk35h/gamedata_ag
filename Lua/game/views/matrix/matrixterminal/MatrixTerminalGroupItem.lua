slot0 = class("MartixTerminalGroupItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.countController_ = ControllerUtil.GetController(slot0.transform_, "count")
	slot4 = "row"
	slot0.rowController_ = ControllerUtil.GetController(slot0.transform_, slot4)
	slot0.items = {}

	for slot4 = 1, 3 do
		table.insert(slot0.items, MatrixTerminalTalentItem.New(slot0["m_item" .. slot4]))
	end
end

function slot0.Refresh(slot0, slot1, slot2, slot3, slot4, slot5)
	slot8 = slot2.row
	slot9 = math.min(#slot2.list, 3)

	if slot2.type == 1 then
		slot0.stateController_:SetSelectedIndex(0)
		slot0.rowController_:SetSelectedIndex(0)
	else
		slot0.stateController_:SetSelectedIndex(1)
		slot0.rowController_:SetSelectedIndex(slot8 and 1 or 0)
	end

	slot13 = slot9

	slot0.countController_:SetSelectedIndex(slot13)

	for slot13, slot14 in pairs(slot7) do
		if slot0.items[slot13] then
			slot0.items[slot13]:Refresh(slot14, slot3, slot4, slot5)
		end
	end

	slot0:SetItemScrollMask(false)
end

function slot0.SetChoice(slot0, slot1)
	for slot5, slot6 in pairs(slot0.items) do
		slot6:SetChoice(slot1)
	end
end

function slot0.RefreshData(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0.items) do
		slot7:RefreshData(slot1, slot2)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	for slot5, slot6 in pairs(slot0.items) do
		slot6:RegistCallBack(slot1)
	end
end

function slot0.SetItemScrollMask(slot0, slot1)
	for slot5, slot6 in pairs(slot0.items) do
		slot6:SetScrollEnable(slot1)
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.items) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
