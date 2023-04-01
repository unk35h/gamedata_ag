slot1 = {
	__index = slot1
}
slot2 = 0
slot3 = 1
slot4 = 2
slot5 = 3
slot6 = 4

function slot7(slot0)
	if type(slot0) == "table" then
		return getmetatable(slot0) ~= nil and type(slot1.__call) == "function"
	end

	return type(slot0) == "function"
end

function slot8(slot0, slot1)
	slot1 = slot1 or uv0

	for slot5, slot6 in ipairs(slot0.queue) do
		if slot1 == uv1 then
			slot6:resolve(slot0.value)
		else
			slot6:reject(slot0.value)
		end
	end

	slot0.state = slot1
end

function slot9(slot0, slot1, slot2, slot3, slot4)
	if type(slot0) == "table" and type(slot0.value) == "table" and uv0(slot1) then
		slot5 = false
		slot6, slot7 = pcall(slot1, slot0.value, function (slot0)
			if uv0 then
				return
			end

			uv0 = true
			uv1.value = slot0

			uv2()
		end, function (slot0)
			if uv0 then
				return
			end

			uv0 = true
			uv1.value = slot0

			uv2()
		end)

		if not slot6 and not slot5 then
			if slot5 then
				return
			end

			slot5 = true
			slot0.value = slot7

			slot3()
		end

		return
	end

	slot4()
end

function slot10(slot0)
	slot1 = nil

	if type(slot0.value) == "table" then
		slot2, slot3 = pcall(function ()
			uv0 = uv1.value.next
		end)

		if not slot2 then
			function slot1()
				return uv0
			end
		end
	end

	uv0(slot0, slot1, function ()
		uv0.state = uv1

		uv2(uv0)
	end, function ()
		uv0.state = uv1

		uv2(uv0)
	end, function ()
		slot0, slot1 = nil

		if uv0.state == uv1 and uv2(uv0.success) then
			slot0, slot1 = pcall(uv0.success, uv0.value)
		elseif uv0.state == uv3 and uv2(uv0.failure) then
			slot2, slot1 = pcall(uv0.failure, uv0.value)

			if slot2 then
				uv0.state = uv1
			end
		end

		if slot0 ~= nil then
			if slot0 then
				uv0.value = slot1
			else
				uv0.value = slot1

				Debug.LogError(uv0.value)

				return uv4(uv0)
			end
		end

		if uv0.value == uv0 then
			slot2 = nil
			slot2, uv0.value = pcall(error, "TypeError : resolving promise with itself")

			return uv4(uv0)
		else
			uv5(uv0, uv6, function ()
				uv0(uv1, uv2)
			end, function (slot0)
				uv0(uv1, slot0)
			end, function ()
				uv0(uv1, uv1.state == uv2 and uv3)
			end)
		end
	end)
end

function slot11(slot0, slot1, slot2)
	if slot0.state == uv0 then
		slot0.value = slot2
		slot0.state = slot1
		slot3, slot4 = pcall(uv1, slot0)

		if not slot3 then
			slot0.value = slot4
			slot0.state = uv2

			uv1(slot0)
		end
	end

	return slot0
end

function slot1.resolve(slot0, slot1)
	if uv0.async then
		uv0.async(function ()
			if type(uv0) == "table" and uv0.is_promise then
				if uv0.state == uv1 then
					uv2:resolve(uv0.value)
				elseif uv0.state == uv3 then
					uv2:reject(uv0.value)
				else
					table.insert(uv0.queue, uv2)
				end

				return
			end

			uv4(uv2, uv5, uv0)
		end)
	else
		uv3(slot0, uv4, slot1)
	end

	return slot0
end

function slot1.reject(slot0, slot1)
	if uv0.async then
		uv0.async(function ()
			uv0(uv1, uv2, uv3)
		end)
	else
		uv1(slot0, uv2, slot1)
	end

	return slot0
end

return {
	__version = "1.0.0-beta",
	new = function (slot0)
		if uv0(slot0) then
			slot2 = uv1.async
			uv1.async = nil
			slot3, slot4 = pcall(slot0, uv1.new())

			if not slot3 then
				slot1:reject(slot4)
			end

			uv1.async = slot2

			return slot1
		end

		slot0 = slot0 or {}
		slot1 = nil
		slot1 = setmetatable({
			is_promise = true,
			state = 0,
			next = function (slot0, slot1, slot2)
				slot3 = uv0.new({
					success = slot1,
					failure = slot2,
					extend = uv1.extend
				})

				if uv2.state == uv3 then
					slot3:resolve(uv2.value)
				elseif uv2.state == uv4 then
					slot3:reject(uv2.value)
				else
					table.insert(uv2.queue, slot3)
				end

				return slot3
			end,
			queue = {},
			success = slot0.success,
			failure = slot0.failure
		}, uv4)

		if uv0(slot0.extend) then
			slot0.extend(slot1)
		end

		return slot1
	end,
	all = function (slot0)
		slot1 = uv0.new()

		if slot0 == nil or #slot0 == 0 then
			return slot1:resolve({})
		end

		slot2 = "resolve"
		slot4 = {}

		function slot5(slot0, slot1)
			return function (slot0)
				uv0[uv1] = slot0

				if not uv2 then
					uv3 = "reject"
				end

				uv4 = uv4 - 1

				if uv4 == 0 then
					uv5[uv3](uv5, uv0)
				end

				return slot0
			end
		end

		for slot9 = 1, #slot0 do
			slot0[slot9]:next(slot5(slot9, true), slot5(slot9, false))
		end

		return slot1
	end,
	map = function (slot0, slot1)
		slot3 = {}

		(function (slot0)
			if slot0 > #uv0 then
				uv1:resolve(uv2)
			else
				slot1 = uv3(uv0[slot0])

				slot1:next(function (slot0)
					table.insert(uv0, slot0)
					uv1(uv2 + 1)
				end, function (slot0)
					uv0:reject(slot0)
				end)
			end
		end)(1)

		return uv0.new()
	end,
	first = function (slot0)
		slot1 = uv0.new()

		for slot5, slot6 in ipairs(slot0) do
			slot6:next(function (slot0)
				uv0:resolve(slot0)
			end, function (slot0)
				uv0:reject(slot0)
			end)
		end

		return slot1
	end,
	promisify = function (slot0)
		return function (...)
			slot0 = uv0.new()
			slot1 = {
				...
			}

			table.insert(slot1, function (slot0, ...)
				if slot0 == nil or slot0 == "" then
					if #{
						...
					} <= 1 then
						uv0:resolve(...)
					else
						uv0:resolve(slot1)
					end
				else
					uv0:reject(slot0)
				end
			end)

			slot2, slot3 = pcall(uv1, unpack(slot1))

			if not slot2 then
				slot0:reject(slot3)
			end

			return slot0
		end
	end
}
