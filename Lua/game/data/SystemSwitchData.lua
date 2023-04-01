slot0 = singletonClass("SystemSwitchData")

function slot0.Init(slot0)
	slot0.switchIDList_ = {}
end

function slot0.SetData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.close_switch) do
		table.insert(slot0.switchIDList_, slot6)
	end
end

function slot0.UpdateData(slot0, slot1)
	if slot1.type == 1 then
		for slot5, slot6 in ipairs(slot1.close_switch) do
			table.insert(slot0.switchIDList_, slot6)
		end
	else
		for slot5, slot6 in ipairs(slot1.close_switch) do
			if table.indexof(slot0.switchIDList_, slot6) then
				slot0.switchIDList_[slot7] = nil
			end
		end
	end
end

function slot0.GetSwitchIDIsOpen(slot0, slot1)
	if table.indexof(slot0.switchIDList_, slot1) then
		return true
	else
		return false
	end
end

return slot0
