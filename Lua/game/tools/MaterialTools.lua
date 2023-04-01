return {
	Sort = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			table.insert(slot1, slot6)
		end

		table.sort(slot1, function (slot0, slot1)
			return slot0.id < slot1.id
		end)

		return slot1
	end,
	materialGiveBack = function (slot0, slot1)
		slot2 = ItemCfg.get_id_list_by_sub_type[slot1]

		if slot0 <= 0 then
			return {}
		end

		slot3 = {}

		for slot7 = #slot2, 1, -1 do
			slot8 = ItemCfg[slot2[slot7]].param[1]
			slot3[slot7] = math.modf(slot0 / slot8)
			slot0 = slot0 - slot3[slot7] * slot8
		end

		slot4 = {}

		for slot8 = 1, 3 do
			if slot3[slot8] ~= 0 then
				slot4[#slot4 + 1] = {
					slot2[slot8],
					slot3[slot8]
				}
			end
		end

		return slot4
	end
}
