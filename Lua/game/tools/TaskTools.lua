return {
	GetTaskList = function (slot0, slot1, slot2)
		slot3 = {}

		for slot7, slot8 in pairs(slot0) do
			if AssignmentCfg[slot8.id] == nil then
				print("没有对应的任务ID:", slot8.id)

				break
			end

			if AssignmentCfg[slot8.id].type == slot1 then
				if slot2 then
					if AssignmentCfg[slot8.id].phase == slot2 then
						table.insert(slot3, slot8.id)
					end
				else
					table.insert(slot3, slot8.id)
				end
			end
		end

		table.sort(slot3)

		return slot3
	end,
	ActivityPtCanReceive = function (slot0, slot1)
		return ActivityPtCfg[slot0].target[slot1] <= ActivityPtData:GetCurrentActivityPt(slot0)
	end,
	ActivityPtIsReceived = function (slot0, slot1)
		if ActivityPtData:GetDailyGetRewardList()[slot0][ActivityPtCfg[slot0].target[slot1]] then
			return true
		end

		return false
	end
}
