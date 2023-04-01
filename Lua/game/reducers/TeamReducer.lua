slot0 = import(".TeamMemberReducer")

return function (slot0, slot1)
	if slot0 == nil then
		slot0 = {
			access = 1,
			available = 1,
			room_id = 0,
			dest = 0,
			level = 1
		}
	end

	if ({
		[ACTIONS.TEAM_INIT] = function (slot0)
			slot0.room_id = uv0.data.room_id
			slot0.dest = uv0.data.dest
			slot0.available = uv0.data.available
			slot0.access = uv0.data.access
			slot0.level = uv0.data.level

			for slot4 = 1, 3 do
				slot0[slot4] = uv1(slot0[slot4], {
					type = uv0.type,
					data = uv0.data.player_list[slot4] or {
						is_master = 0,
						is_ready = 0,
						player_id = "",
						channel = 1,
						server = 1,
						hero_list = {}
					}
				})
			end
		end,
		[ACTIONS.TEAM_ROOM_CHANGE] = function (slot0)
			slot0.room_id = uv0.data.room_id
			slot0.dest = uv0.data.dest
			slot0.available = uv0.data.available
			slot0.access = uv0.data.access
			slot0.level = uv0.data.level

			for slot4 = 1, 3 do
				slot0[slot4] = uv1(slot0[slot4], {
					type = uv0.type,
					data = uv0.data.player_list[slot4] or {
						is_master = 0,
						is_ready = 0,
						player_id = "",
						channel = 1,
						server = 1,
						hero_list = {}
					}
				})
			end
		end
	})[slot1.type] then
		return immer.produce(slot0, function (slot0)
			uv0[uv1.type](slot0)
		end)
	else
		return slot0
	end
end
