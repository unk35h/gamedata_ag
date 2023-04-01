function slot1(slot0, slot1)
	return slot0 < slot1
end

function slot2(slot0)
	return slot0
end

return {
	UniversalSort = function (slot0, slot1, ...)
		slot2 = {
			...
		}

		return table.sort(slot0, function (slot0, slot1)
			for slot5, slot6 in ipairs(uv0) do
				if slot0[slot6] ~= slot1[slot6] then
					if uv1 then
						return slot0[slot6] < slot1[slot6]
					else
						return slot1[slot6] < slot0[slot6]
					end
				end
			end
		end)
	end,
	UniversalSortEx = function (slot0, ...)
		slot1 = {
			...
		}

		return table.sort(slot0, function (slot0, slot1)
			for slot5, slot6 in pairs(uv0) do
				slot7 = slot6.map or uv1
				slot10 = slot6.ascend
				slot11 = slot6.lessOp or uv2

				if slot7(slot0) ~= slot7(slot1) then
					if slot10 then
						return slot11(slot8, slot9)
					else
						return slot11(slot9, slot8)
					end
				end
			end

			return false
		end)
	end,
	Convert2SamePosition = function (slot0, slot1)
		slot0.position = slot1.position
	end
}
