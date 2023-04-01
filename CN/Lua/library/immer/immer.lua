slot1 = require("library/immer/proxy")

return {
	NOTHING = require("library/immer/utils").NOTHING,
	insert = slot1.insert,
	remove = slot1.remove,
	getn = slot1.getn,
	ipairs = slot1.ipairs,
	pairs = slot1.pairs,
	produce = function (slot0, slot1)
		if not uv0.isProxyable(slot0) or uv0.isProxy(slot0) then
			if slot1(slot0) == nil then
				return slot0
			else
				return uv1.normalizeResult(slot2)
			end
		end

		return uv1.normalizeResult(uv2.produceImpl(slot0, slot1))
	end,
	normalizeResult = function (slot0)
		if slot0 == uv0.NOTHING then
			return nil
		else
			return slot0
		end
	end
}
