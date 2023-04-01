slot0 = class("PolyhedronTerminalLine", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.id_list = {}

	for slot7, slot8 in pairs(string.split(slot2, "_")) do
		table.insert(slot0.id_list, tonumber(slot8))
	end

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.SetData(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.id_list) do
		if slot6 ~= 0 and not table.indexof(slot1, slot6) then
			slot0.stateController:SetSelectedIndex(0)

			return
		end
	end

	slot0.stateController:SetSelectedIndex(1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
