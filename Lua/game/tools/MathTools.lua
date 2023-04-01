return {
	GetDistance = function (slot0, slot1)
		return math.sqrt((slot0.x - slot1.x) * (slot0.x - slot1.x) + (slot0.y - slot1.y) * (slot0.y - slot1.y))
	end,
	GetMidpoint = function (slot0, slot1)
		return (slot0 + slot1) / 2
	end,
	GetAngle = function (slot0, slot1)
		slot2 = uv0.GetDistance(slot0, slot1)

		if slot0.x - slot1.x < 0 then
			return math.asin((slot0.y - slot1.y) / slot2) / math.pi * -180
		else
			return math.asin((slot0.y - slot1.y) / slot2) / math.pi * 180 + 180
		end
	end
}
