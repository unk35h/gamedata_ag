lk = {
	math2d = import("support.math2d"),
	BattleMath = import("support.BattleMath"),
	FLOAT_PRECISION = 1.0000000000000006e-05
}

function lk.FloatEqual(slot0, slot1)
	if math.abs(slot0 - slot1) <= lk.FLOAT_PRECISION then
		return true
	else
		return false
	end
end
