slot0 = require("library/immer/utils")
slot1 = {}

return {
	produceImpl = function (slot0, slot1)
		slot2 = uv0
		uv0 = {}

		uv2.each(uv0, function (slot0, slot1)
			for slot5, slot6 in pairs(slot1.proxy) do
				if slot5 ~= uv0.PROXY_STATE then
					error("Do not use table.insert or rawset directly on draft properties.")
				end
			end

			slot1.finalizing = true
		end)

		slot5 = nil

		if slot1(uv1.createProxy(nil, slot0)) ~= nil and slot4 ~= slot3 then
			if slot3[uv2.PROXY_STATE].modified then
				error("An immer producer returned a new value *and* modified its draft. Either return a new value *or* modify the draft.")
			end

			slot5 = uv1.finalize(slot4)
		else
			uv1.markChangedSweep()

			slot5 = uv1.finalize(slot3)
		end

		uv2.each(uv0, function (slot0, slot1)
			slot1.finished = true
		end)

		uv0 = slot2

		return slot5
	end,
	createProxy = function (slot0, slot1)
		slot2 = {}
		slot3 = uv0.createState(slot0, slot2, slot1)
		slot2[uv1.PROXY_STATE] = slot3

		setmetatable(slot2, {
			__index = function (slot0, slot1)
				return uv0.get(uv1, slot1)
			end,
			__newindex = function (slot0, slot1, slot2)
				uv0.set(uv1, slot1, slot2)
			end
		})
		table.insert(uv2, slot3)

		return slot2
	end,
	createState = function (slot0, slot1, slot2)
		return {
			finalized = false,
			finished = false,
			hasCopy = false,
			modified = false,
			finalizing = false,
			assigned = {},
			parent = slot0,
			base = slot2,
			proxy = slot1
		}
	end,
	get = function (slot0, slot1)
		uv0.assertUnfinished(slot0)

		slot2 = uv0.source(slot0)[slot1]

		if not slot0.finalizing and slot2 == slot0.base[slot1] and uv1.isProxyable(slot2) then
			uv0.prepareCopy(slot0)

			slot0.copy[slot1] = uv0.createProxy(slot0, slot2)

			return slot0.copy[slot1]
		end

		return slot2
	end,
	set = function (slot0, slot1, slot2)
		uv0.assertUnfinished(slot0)

		slot0.assigned[slot1] = true

		if not slot0.modified then
			if uv0.source(slot0)[slot1] == slot2 then
				return
			end

			uv0.markChanged(slot0)
			uv0.prepareCopy(slot0)
		end

		slot0.copy[slot1] = slot2
	end,
	source = function (slot0)
		if slot0.hasCopy then
			return slot0.copy
		else
			return slot0.base
		end
	end,
	assertUnfinished = function (slot0)
		if slot0.finished then
			error("Cannot use a proxy that has been revoke. Did you pass an object from inside an immer function to an async process?")
		end
	end,
	assertProxy = function (slot0)
		if not uv0.isProxy(slot0) then
			error("base should be a proxy object")
		end
	end,
	prepareModified = function (slot0)
		if not slot0.modified then
			uv0.markChanged(slot0)
			uv0.prepareCopy(slot0)
		end
	end,
	prepareCopy = function (slot0)
		if slot0.hasCopy then
			return
		end

		slot0.hasCopy = true
		slot0.copy = uv0.shallowCopy(slot0.base)
	end,
	insert = function (slot0, ...)
		if uv0.isProxy(slot0) then
			slot1 = slot0[uv0.PROXY_STATE]

			uv1.prepareModified(slot1)

			return table.insert(slot1.copy, ...)
		else
			return table.insert(slot0, ...)
		end
	end,
	remove = function (slot0, ...)
		if uv0.isProxy(slot0) then
			slot1 = slot0[uv0.PROXY_STATE]

			uv1.prepareModified(slot1)

			return table.remove(slot1.copy, ...)
		else
			return table.remove(slot0, ...)
		end
	end,
	getn = function (slot0, ...)
		if uv0.isProxy(slot0) then
			return table.getn(uv1.source(slot0[uv0.PROXY_STATE]), ...)
		else
			return table.getn(slot0, ...)
		end
	end,
	ipairs = function (slot0)
		if uv0.isProxy(slot0) then
			return function (slot0, slot1)
				if slot0[slot1 + 1] then
					return slot1, uv0.get(uv1, slot1)
				end
			end, uv1.source(slot0[uv0.PROXY_STATE]), 0
		else
			return ipairs(slot0)
		end
	end,
	pairs = function (slot0)
		if uv0.isProxy(slot0) then
			return function (slot0, slot1)
				slot2, slot3 = next(slot0, slot1)

				if slot3 then
					return slot2, uv0.get(uv1, slot2)
				end
			end, uv1.source(slot0[uv0.PROXY_STATE]), nil
		else
			return pairs(slot0)
		end
	end,
	markChanged = function (slot0)
		if not slot0.modified then
			slot0.modified = true

			if slot0.parent then
				uv0.markChanged(slot0.parent)
			end
		end
	end,
	markChangedSweep = function ()
		for slot3 = #uv0, 1, -1 do
			if not uv0[slot3].modified and uv1.hasTableChanges(slot4) then
				uv1.markChanged(slot4)
			end
		end
	end,
	hasTableChanges = function (slot0)
		slot1 = slot0.base
		slot3 = 0
		slot4 = 0

		for slot8, slot9 in pairs(uv0.source(slot0)) do
			if slot1[slot8] == nil then
				return true
			end

			slot4 = slot4 + 1
		end

		for slot8, slot9 in pairs(slot1) do
			slot3 = slot3 + 1
		end

		return slot3 ~= slot4
	end,
	finalize = function (slot0)
		if uv0.isProxy(slot0) then
			if slot0[uv0.PROXY_STATE].modified then
				if slot1.finalized then
					return slot1.copy
				end

				slot1.finalized = true

				return uv1.finalizeTable(slot1.copy, slot1)
			else
				return slot1.base
			end
		end

		uv1.finalizeNonProxiedTable(slot0)

		return slot0
	end,
	finalizeTable = function (slot0, slot1)
		slot2 = slot1.base

		uv0.each(slot0, function (slot0, slot1)
			if slot1 ~= uv0[slot0] then
				uv1[slot0] = uv2.finalize(slot1)
			end
		end)

		return slot0
	end,
	finalizeNonProxiedTable = function (slot0)
		if not uv0.isProxyable(slot0) then
			return
		end

		uv0.each(slot0, function (slot0, slot1)
			if uv0.isProxy(slot1) then
				uv1[slot0] = uv2.finalize(slot1)
			else
				uv2.finalizeNonProxiedTable(slot1)
			end
		end)
	end
}
