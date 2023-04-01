slot1 = manager.net

slot1:Bind(60101, function (slot0)
	PuzzleData:InitData(slot0)
end)

return {
	OPERATION_TYPE = {
		receive = 4,
		complete = 5,
		help = 2,
		reset = 3,
		move = 1
	},
	Operate = function (slot0, slot1, slot2, slot3)
		slot4 = {
			activity_id = slot0,
			operate_type = slot1
		}

		if slot3 ~= nil then
			slot4.puzzle_id = slot3
		end

		slot5 = manager.net

		slot5:SendWithLoadingNew(60102, slot4, 60103, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 ~= nil then
					if uv1 == uv2.OPERATION_TYPE.help then
						uv0(true)
					elseif uv1 == uv2.OPERATION_TYPE.complete then
						uv0(false)
					else
						uv0(uv3)
					end
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	InitRedPointKey = function (slot0)
		slot2 = {}
		slot3 = nil

		for slot7, slot8 in pairs(ActivityData:GetActivityData(slot0).subActivityIdList) do
			slot9 = {
				[#slot9 + 1] = string.format("%s_%s_%s_normal", RedPointConst.ACTIVITY_PUZZLE, slot0, slot8),
				[#slot9 + 1] = string.format("%s_%s_%s_video", RedPointConst.ACTIVITY_PUZZLE, slot0, slot8)
			}
			slot3 = string.format("%s_%s_%s", RedPointConst.ACTIVITY_PUZZLE, slot0, slot8)

			manager.redPoint:addGroup(slot3, slot9)

			slot2[#slot2 + 1] = slot3
		end

		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_PUZZLE, slot0), slot2)
	end
}
