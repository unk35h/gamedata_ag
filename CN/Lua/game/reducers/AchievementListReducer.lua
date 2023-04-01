slot0 = import(".AchievementReducer")

return function (slot0, slot1)
	if slot0 == nil then
		slot0 = {
			point = 0,
			rewardList = {}
		}
	end

	slot2 = {
		[ACTIONS.ACHIEVEMENT_SUBMIT] = function (slot0)
			immer.insert(slot0.rewardList, uv0.data.id)

			slot0.point = slot0.point + uv0.data.point
			slot0[1] = uv1(slot0[1], uv0)
		end,
		[ACTIONS.ACHIEVEMENT_MODIFY] = function (slot0)
			slot1 = uv0.data
			slot0[slot1.id] = uv1(slot0[slot1.id], uv0)
		end,
		[ACTIONS.ACHIEVEMENT_CHANGE] = function (slot0)
			slot1 = uv0.data
			slot0[slot1.id] = uv1(slot0[slot1.id], uv0)
		end,
		[ACTIONS.CURRENCY_MODIFY] = function (slot0)
			if uv0.data.vary < 0 then
				slot2 = nil

				if slot1.currencyType == 1 then
					slot2 = 6
				elseif slot1.currencyType == 2 then
					slot2 = 5
				elseif slot1.currencyType == 4 then
					slot2 = 4
				end

				if slot2 then
					slot0[slot2] = uv1(slot0[slot2], {
						type = ACTIONS.ACHIEVEMENT_MODIFY,
						data = {
							vary = -slot1.vary
						}
					})
				end
			end
		end,
		[ACTIONS.SIGN] = function (slot0)
			slot0[7] = uv0(slot0[7], {
				type = ACTIONS.ACHIEVEMENT_MODIFY,
				data = {
					vary = 1
				}
			})
		end,
		[ACTIONS.HERO_UNLOCK_TALENT_SUCCESS] = function (slot0)
			slot0[8] = uv0(slot0[8], {
				type = ACTIONS.ACHIEVEMENT_MODIFY,
				data = {
					vary = 1
				}
			})
		end,
		[ACTIONS.HERO_UNLOCK_SUCCESS] = function (slot0)
			slot0[17] = uv0(slot0[17], {
				type = ACTIONS.ACHIEVEMENT_MODIFY,
				data = {
					vary = 1
				}
			})

			if HeroCfg[uv1.data.id].unlock_star >= 3 then
				slot0[18] = uv0(slot0[18], slot1)
			end
		end
	}

	if slot1.type == ACTIONS.ACHIEVEMENT_INIT then
		slot3 = {
			point = slot1.data.point,
			rewardList = {}
		}

		for slot7, slot8 in ipairs(slot1.data.rewardList) do
			table.insert(slot3.rewardList, slot8)
		end

		for slot7, slot8 in ipairs(AchievementTypeCfg) do
			slot9 = 0

			for slot13, slot14 in ipairs(slot1.data.list) do
				if slot7 == slot14.type_id then
					slot9 = slot14.count

					break
				end
			end

			slot3[slot7] = {
				typeId = slot7,
				count = slot9
			}
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
