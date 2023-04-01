slot1 = math.sqrt
slot2 = math.atan2
slot3 = math.cos
slot4 = math.sin
slot5 = math.pi
slot6 = slot5 / 180
slot7 = 180 / slot5

return {
	dist = function (slot0, slot1, slot2, slot3)
		slot4 = slot2 - slot0
		slot5 = slot3 - slot1

		return uv0(slot4 * slot4 + slot5 * slot5)
	end,
	radians4point = function (slot0, slot1, slot2, slot3)
		return uv0(slot1 - slot3, slot2 - slot0)
	end,
	pointAtCircle = function (slot0, slot1, slot2, slot3)
		return slot0 + uv0(slot2) * slot3, slot1 - uv1(slot2) * slot3
	end,
	pointAtLineToPoint = function (slot0, slot1, slot2, slot3, slot4, slot5)
		slot6 = slot4 - slot2
		slot7 = slot5 - slot3

		if ((slot0 - slot2) * slot6 + (slot1 - slot3) * slot7) / (slot6 * slot6 + slot7 * slot7) > 1 then
			slot9 = 1
		elseif slot9 < 0 then
			slot9 = 0
		end

		return slot2 + slot9 * slot6, slot3 + slot9 * slot7
	end,
	degrees2radians = function (slot0)
		return slot0 * uv0
	end,
	radians2degrees = function (slot0)
		return slot0 * uv0
	end,
	rotateCoord = function (slot0, slot1, slot2)
		slot3 = math.cos(slot2)
		slot4 = math.sin(slot2)

		return slot3 * slot0 + slot4 * slot1, -1 * slot4 * slot0 + slot3 * slot1
	end,
	rotateZCoord = function (slot0, slot1, slot2)
		slot3 = math.cos(slot2)
		slot4 = math.sin(slot2)

		return slot3 * slot0 - slot4 * slot1, slot4 * slot0 + slot3 * slot1
	end,
	rotatePoint = function (slot0, slot1, slot2, slot3, slot4)
		slot5 = math.cos(slot4)
		slot6 = math.sin(slot4)

		return slot5 * (slot0 - slot2) + slot6 * (slot1 - slot3) + slot2, slot6 + (slot0 - slot2) * -1 + slot5 * (slot1 - slot3) + slot3
	end,
	twoCircleIntersect = function (slot0, slot1, slot2, slot3, slot4, slot5)
		slot6, slot7, slot8 = nil
		slot9 = 0
		slot10 = 0
		slot11 = 0
		slot12 = 0
		slot13 = -1

		if not lk.FloatEqual(slot1, slot4) then
			slot14 = (slot0 * slot0 - slot3 * slot3 + slot1 * slot1 - slot4 * slot4 + slot5 * slot5 - slot2 * slot2) / (2 * (slot1 - slot4))
			slot15 = (slot0 - slot3) / (slot1 - slot4)
			slot7 = -2 * (slot0 + (slot14 - slot1) * slot15)

			if slot7 * slot7 - 4 * (1 + slot15 * slot15) * (slot0 * slot0 + (slot14 - slot1) * (slot14 - slot1) - slot2 * slot2) > 0 then
				slot11 = slot14 - slot15 * (-slot7 + uv0(slot7 * slot7 - 4 * slot6 * slot8)) / (2 * slot6)
				slot12 = slot14 - slot15 * (-slot7 - uv0(slot7 * slot7 - 4 * slot6 * slot8)) / (2 * slot6)
			elseif slot13 == 0 then
				slot9 = -slot7 / (2 * slot6)
				slot10 = slot9
				slot12 = slot14 - slot15 * slot9
			else
				return {}
			end
		elseif not lk.FloatEqual(slot0, slot3) then
			slot9 = (slot0 * slot0 - slot3 * slot3 + slot5 * slot5 - slot2 * slot2) / (2 * (slot0 - slot3))
			slot10 = slot9
			slot7 = -2 * slot1

			if slot7 * slot7 - 4 * 1 * (slot1 * slot1 - slot2 * slot2 + (slot9 - slot0) * (slot9 - slot0)) > 0 then
				slot11 = (-slot7 + uv0(slot7 * slot7 - 4 * slot6 * slot8)) / (2 * slot6)
				slot12 = (-slot7 - uv0(slot7 * slot7 - 4 * slot6 * slot8)) / (2 * slot6)
			elseif slot13 == 0 then
				slot12 = -slot7 / (2 * slot6)
			else
				return {}
			end
		else
			return {}
		end

		return {
			{
				slot9,
				slot11
			},
			{
				slot10,
				slot12
			}
		}
	end,
	LineAndCircleIntersect = function (slot0, slot1, slot2, slot3, slot4)
		slot5, slot6, slot7, slot8 = nil
		slot11 = 2 * slot2 - 2 * slot0 * (slot1 - slot3)

		if slot11 * slot11 - 4 * (1 + slot0 * slot0) * (slot2 * slot2 + (slot1 - slot3) * (slot1 - slot3) - slot4 * slot4) < 0 then
			return {}
		end

		slot13 = math.sqrt(slot12)
		slot5 = (slot11 + slot13) / (2 * slot10)
		slot7 = (slot11 - slot13) / (2 * slot10)

		return {
			{
				slot5,
				slot0 * slot5 + slot1
			},
			{
				slot7,
				slot0 * slot7 + slot1
			}
		}
	end,
	point2lineDist = function (slot0, slot1, slot2, slot3)
		return math.abs((slot2 * slot0 - slot1 + slot3) / math.sqrt(slot2 * 2 + 1))
	end
}
