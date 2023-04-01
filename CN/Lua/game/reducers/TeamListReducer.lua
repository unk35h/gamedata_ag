slot0 = import(".TeamReducer")
slot1 = import(".TeamMemberReducer")

return function (slot0, slot1)
	if slot0 == nil then
		slot0 = {}
	end

	slot2 = {
		[ACTIONS.TEAM_ROOM_CHANGE] = function (slot0)
			slot0[uv0.data.room_id] = uv1(slot0[uv0.data.room_id], uv0)
		end
	}

	if slot1.type == ACTIONS.TEAM_INIT then
		slot3 = {}

		for slot7, slot8 in ipairs(slot1.data) do
			slot3[slot8.room_id] = uv0(slot3[slot8.room_id], {
				type = slot1.type,
				data = slot8
			})
		end

		return slot3
	elseif slot2[slot1.type] then
		return immer.produce(slot0, function (slot0)
			uv0[uv1.type](slot0)
		end)
	else
		return slot0
	end
end
