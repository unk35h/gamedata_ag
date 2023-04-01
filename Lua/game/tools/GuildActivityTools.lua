return {
	IsConditionAchieved = function (slot0, slot1)
		if ConditionCfg[slot0] == nil then
			return true, 0, 0
		end

		slot3 = false
		slot4 = 0
		slot5 = slot2.params[1]

		if slot2.type == 9001 then
			slot4 = HistoryData:GetHistoryData(slot2.id) or 0

			return slot2.params[1] <= slot4, slot4, slot2.params[1]
		elseif slot2.type == 9002 then
			slot4 = HistoryData:GetHistoryData(slot2.id) or 0

			return slot2.params[1] <= slot4, slot4, slot2.params[1]
		elseif slot2.type == 9003 then
			slot4 = HistoryData:GetHistoryData(slot2.id) or 0

			return slot2.params[1] <= slot4, slot4, slot2.params[1]
		elseif slot2.type == 9004 then
			slot4 = HistoryData:GetHistoryData(slot2.id) or 0

			return slot4 >= 1, slot4, 1
		elseif slot2.type == 9005 then
			slot4 = HistoryData:GetHistoryData(slot2.id) or 0

			return slot4 >= 1, slot4, 1
		end

		return slot3, slot4, slot5
	end
}
