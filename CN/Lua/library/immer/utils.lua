return {
	PROXY_STATE = "__$immer_state",
	NOTHING = {
		["__$immer-nothing"] = true
	},
	isProxy = function (slot0)
		return type(slot0) == "table" and slot0[uv0.PROXY_STATE]
	end,
	isProxyable = function (slot0)
		return type(slot0) == "table"
	end,
	original = function (slot0)
		if slot0 and slot0[uv0.PROXY_STATE] then
			return slot0[uv0.PROXY_STATE].base
		end
	end,
	each = function (slot0, slot1)
		for slot5, slot6 in pairs(slot0) do
			slot1(slot5, slot6)
		end
	end,
	shallowCopy = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			slot1[slot5] = slot6
		end

		return slot1
	end
}
