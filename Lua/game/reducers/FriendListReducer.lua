slot0 = import(".FriendReducer")

return function (slot0, slot1)
	if slot0 == nil then
		slot0 = {
			recommendTime = 0,
			friend = {},
			recommendData = {}
		}
	end

	if ({
		[ACTIONS.FRIEND_INIT] = function (slot0)
			for slot4, slot5 in ipairs(uv0.data.friend_list) do
				slot0.friend[slot5.user_id] = uv1(slot0.friend[slot5.user_id], {
					type = uv0.type,
					data = {
						playerInfo = slot5,
						fType = FriendConst.FRIEND_TYPE.FRIEND,
						isBlackList = slot0.friend[slot5.user_id] and slot0.friend[slot5.user_id].isBlackList or false
					}
				})

				for slot10, slot11 in immer.pairs(slot0.recommendData) do
					if slot11 == slot5.user_id then
						immer.remove(slot0.recommendData, slot10)

						break
					end
				end
			end

			for slot4, slot5 in ipairs(uv0.data.black_list) do
				slot0.friend[slot5.user_id] = uv1(slot0.friend[slot5.user_id], {
					type = uv0.type,
					data = {
						playerInfo = slot5,
						isBlackList = slot0.friend[slot5.user_id] and slot0.friend[slot5.user_id].isBlackList or true
					}
				})
			end
		end,
		[ACTIONS.FRIEND_APPLY] = function (slot0)
			if uv0.data.is_del == 1 then
				for slot4, slot5 in ipairs(uv0.data.list) do
					if slot0.friend[slot5.user_id] and slot0.friend[slot5.user_id].fType == FriendConst.FRIEND_TYPE.APPLYED then
						slot0.friend[slot5.user_id] = nil
					end
				end
			else
				for slot4, slot5 in ipairs(uv0.data.list) do
					slot0.friend[slot5.user_id] = uv1(slot0.friend[slot5.user_id], {
						type = uv0.type,
						data = {
							requestIndex = slot4,
							playerInfo = slot5,
							fType = FriendConst.FRIEND_TYPE.APPLYED,
							isBlackList = slot0.friend[slot5.user_id] and slot0.friend[slot5.user_id].isBlackList or false
						}
					})

					for slot10, slot11 in immer.ipairs(slot0.recommendData) do
						if slot11 == slot5.user_id then
							immer.remove(slot0.recommendData, slot10)

							break
						end
					end
				end
			end
		end,
		[ACTIONS.FRIEND_SEARCH] = function (slot0)
			for slot4, slot5 in pairs(uv0.data) do
				slot0.friend[slot5.user_id] = uv1(slot0.friend[slot5.user_id], {
					type = uv0.type,
					data = {
						playerInfo = slot5,
						fType = FriendConst.FRIEND_TYPE.SEARCH,
						isBlackList = slot0.friend[slot5.user_id] and slot0.friend[slot5.user_id].isBlackList or false
					}
				})
			end
		end,
		[ACTIONS.FRIEND_DELETE] = function (slot0)
			for slot4, slot5 in ipairs(uv0.data.friend_list) do
				slot0.friend[slot5.user_id] = nil
			end

			for slot4, slot5 in ipairs(uv0.data.black_list) do
				slot0.friend[slot5.user_id] = nil
			end
		end,
		[ACTIONS.FRIEND_RECOMMEND] = function (slot0)
			for slot4, slot5 in ipairs(uv0.data) do
				slot6 = {
					type = uv0.type,
					data = {
						playerInfo = slot5,
						fType = FriendConst.FRIEND_TYPE.RECOMMEND,
						isBlackList = slot0.friend[slot5.user_id] and slot0.friend[slot5.user_id].isBlackList or false
					}
				}

				if not slot0.friend[slot5.user_id] or FriendConst.FRIEND_TYPE.RECOMMEND >= slot0.friend[slot5.user_id].fType then
					slot0.friend[slot5.user_id] = uv1(slot0.friend[slot5.user_id], slot6)

					immer.insert(slot0.recommendData, slot5.user_id)
				end
			end
		end,
		[ACTIONS.FRIEND_RECOMMEND_REFRESH] = function (slot0)
			slot1 = {}

			for slot5, slot6 in immer.pairs(slot0.recommendData) do
				if table.keyof(uv0.data, slot6) then
					slot0.recommendData[slot5] = nil

					table.insert(slot1, slot5)
				end
			end

			slot2 = 1

			for slot6, slot7 in immer.pairs(slot0.recommendData) do
				if FriendConst.RECOMMEND_COUNT < slot6 then
					if slot1[slot2] == nil then
						break
					end

					slot0.recommendData[slot8] = slot7
					slot0.recommendData[slot6] = nil
					slot2 = slot2 + 1
				end
			end
		end,
		[ACTIONS.FRIEND_REMAKE] = function (slot0)
			slot1 = uv0.data
			slot0.friend[slot1.friendID] = uv1(slot0.friend[slot1.friendID], {
				type = uv0.type,
				data = {
					playerInfo = slot0.friend[slot1.friendID],
					fType = slot0.friend[slot1.friendID].fType,
					isBlackList = slot0.friend[slot1.friendID].isBlackList,
					remake = slot1.remake
				}
			})
		end,
		[ACTIONS.FRIEND_APPLY_SEND] = function (slot0)
			for slot4, slot5 in ipairs(uv0.data) do
				slot9 = uv0

				uv1(slot0.friend[slot5], slot9)

				for slot9, slot10 in immer.ipairs(slot0.recommendData) do
					if slot10 == slot5 then
						immer.remove(slot0.recommendData, slot9)

						break
					end
				end
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
