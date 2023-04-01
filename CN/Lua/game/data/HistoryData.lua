slot0 = singletonClass("HistoryData")

function slot0.Init(slot0)
	slot0.historyData_ = {}
end

function slot0.InitData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.data_list) do
		slot0.historyData_[slot6.id] = slot6.data
	end
end

function slot0.GetHistoryData(slot0, slot1)
	return slot0.historyData_[slot1]
end

return slot0
