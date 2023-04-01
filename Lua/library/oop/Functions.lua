slot0 = "Assets/Scripts/LuaScripts/"

function slot1(slot0)
	if not string.find(slot0, ".") then
		slot0 = slot0 .. ".lua"
	end

	return uv0 .. slot0
end

function dump_stack(slot0)
	return string.format("%s%s%s", string.format("<a href=\"%s\" line=\"%d\">", uv0(slot0.short_src), slot0.currentline), string.format("[%s:%s:%d]", slot0.short_src, slot0.name or "?", slot0.currentline), "</a>")
end

function dump_msg(slot0, slot1)
	return string.format("%s: %s", dump_stack(slot0), slot1)
end

function nullable(slot0, ...)
	slot1 = {
		...
	}
	slot5 = "#"

	for slot5 = 1, select(slot5, ...) do
		slot6 = slot1[slot5]

		if slot0 == nil or slot6 == nil then
			return nil
		end

		slot0 = slot0[slot6]
	end

	return slot0
end

if nullable(debugger, "enabled") then
	function slot2(slot0, slot1, slot2)
		slot0 = slot0 .. "\nstack traceback:"

		for slot6 = 1, slot2 do
			if debug.getinfo(slot1 + slot6 + 1) == nil then
				break
			end

			slot0 = slot0 .. "\n\t" .. dump_stack(slot7)
		end

		if debug.getinfo(slot1 + slot2 + 2) then
			slot0 = slot0 .. "\n\t..."
		end

		return slot0
	end

	slot3 = 3

	function print(slot0, ...)
		slot2 = slot0

		for slot6 = 1, #{
			...
		} do
			slot2 = slot2 .. "    " .. tostring(slot1[slot6])
		end

		slot3 = 2

		Debug.Log(uv0(dump_msg(debug.getinfo(slot3), slot2), slot3, uv1))
	end

	function printf(slot0, ...)
		slot1 = 2

		Debug.Log(uv0(dump_msg(debug.getinfo(slot1), string.format(slot0, ...)), slot1, uv1))
	end
else
	function printf(slot0, ...)
		print(string.format(slot0, ...))
	end
end

function AssureTable(slot0)
	if type(slot0) ~= "table" then
		slot0 = {}
	end

	return slot0
end

function checknumber(slot0, slot1)
	return tonumber(slot0, slot1) or 0
end

function math.round(slot0)
	return math.floor(checknumber(slot0) + 0.5)
end

function checkint(slot0)
	return math.round(checknumber(slot0))
end

function checkbool(slot0)
	return slot0 ~= nil and slot0 ~= false
end

function checktable(slot0)
	if type(slot0) ~= "table" then
		slot0 = {}
	end

	return slot0
end

function table.nums(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0) do
		slot1 = slot1 + 1
	end

	return slot1
end

function table.keys(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0) do
		slot1[#slot1 + 1] = slot5
	end

	return slot1
end

function table.indexof(slot0, slot1, slot2)
	slot3 = slot2 or 1

	for slot6 = slot3, #slot0 do
		if slot0[slot6] == slot1 then
			return slot6
		end
	end

	return false
end

function table.keyof(slot0, slot1)
	if type(slot0) ~= "table" then
		return nil
	end

	for slot5, slot6 in pairs(slot0) do
		if slot6 == slot1 then
			return slot5
		end
	end

	return nil
end

function table.removebyvalue(slot0, slot1, slot2)
	slot3 = 0
	slot4 = 1
	slot5 = #slot0

	while slot4 <= slot5 do
		if slot0[slot4] == slot1 then
			table.remove(slot0, slot4)

			slot3 = slot3 + 1
			slot4 = slot4 - 1
			slot5 = slot5 - 1

			if not slot2 then
				break
			end
		end

		slot4 = slot4 + 1
	end

	return slot3
end

function table.clean(slot0)
	for slot4 = #slot0, 1, -1 do
		table.remove(slot0, slot4)
	end
end

function table.insertto(slot0, slot1, slot2)
	if checkint(slot2) <= 0 then
		slot2 = #slot0 + 1
	end

	for slot7 = 0, #slot1 - 1 do
		slot0[slot7 + slot2] = slot1[slot7 + 1]
	end
end

function table.merge(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		slot0[slot5] = slot6
	end
end

function table.length(slot0)
	slot1 = 0
	slot2 = pairs
	slot4 = slot0 or {}

	for slot5, slot6 in slot2(slot4) do
		slot1 = slot1 + 1
	end

	return slot1
end

function table.mergeinsert(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if not table.keyof(slot0, slot6) then
			table.insert(slot0, table.nums(slot0) + 1, slot6)
		end
	end

	return slot0
end

function table.deepMerge(slot0, slot1)
	if type(slot1) == "table" then
		for slot5, slot6 in pairs(slot1) do
			if slot0[slot5] then
				table.deepMerge(slot0[slot5], slot6)
			else
				slot0[slot5] = slot6
			end
		end
	end
end

function table.equal(slot0, slot1, slot2)
	if slot0 == nil or slot1 == nil or table.length(slot0) ~= table.length(slot1) or type(slot0) ~= type(slot1) then
		return false
	end

	for slot6, slot7 in pairs(slot0) do
		if type(slot7) == "table" then
			if slot2 == "all" or table.indexof(slot2, slot6) then
				if not table.equal(slot7, slot1[slot6], "all") then
					return false
				end
			elseif not table.equal(slot7, slot1[slot6], slot2) then
				return false
			end
		elseif (slot2 == "all" or table.indexof(slot2, slot6)) and slot7 ~= slot1[slot6] then
			return false
		end
	end

	return true
end

function string.split(slot0, slot1)
	slot0 = tostring(slot0)

	if tostring(slot1) == "" then
		return false
	end

	slot2 = 0
	slot3 = {}

	for slot7, slot8 in function ()
		return string.find(uv0, uv1, uv2, true)
	end, nil,  do
		table.insert(slot3, string.sub(slot0, slot2, slot7 - 1))

		slot2 = slot8 + 1
	end

	table.insert(slot3, string.sub(slot0, slot2))

	return slot3
end

function string.ltrim(slot0)
	return string.gsub(slot0, "^[ \t\n\r]+", "")
end

function string.rtrim(slot0)
	return string.gsub(slot0, "[ \t\n\r]+$", "")
end

function string.trim(slot0)
	return string.gsub(string.gsub(slot0, "^[ \t\n\r]+", ""), "[ \t\n\r]+$", "")
end

function string.ucfirst(slot0)
	return string.upper(string.sub(slot0, 1, 1)) .. string.sub(slot0, 2)
end

function slot2(slot0)
	return "%" .. string.format("%02X", string.byte(slot0))
end

function handler(slot0, slot1)
	return function (...)
		return uv0(uv1, ...)
	end
end

function handlerArg(slot0, slot1, slot2)
	return function (...)
		return uv0(uv1, unpack(uv2), ...)
	end
end

function handlerArg1(slot0, slot1, slot2)
	return function (...)
		return uv0(uv1, uv2, ...)
	end
end

function handler1layer(slot0, slot1)
	return function (slot0, ...)
		return uv0(uv1, ...)
	end
end

function handler2layer(slot0, slot1, slot2)
	return function (slot0, ...)
		if uv0(uv1) then
			return slot1[uv2](slot1, ...)
		end
	end
end

function handler2layerArg1(slot0, slot1, slot2)
	return function (slot0, ...)
		if uv0(uv1, table.remove({
			...
		}, 1)) then
			return slot3[uv2](slot3, unpack(slot1))
		end
	end
end

function config2dev(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0) do
		slot1[slot5 .. "_"] = slot6
	end

	return slot1
end

slot3 = print
slot4 = table.concat
slot5 = table.insert
slot6 = string.rep
slot7 = type
slot8 = pairs
slot9 = tostring
slot10 = next

function print_r(slot0)
	if uv0(slot0) ~= "table" then
		return
	end

	slot1 = {
		[slot0] = "."
	}

	uv7((function (slot0, slot1, slot2)
		slot3 = {}

		for slot7, slot8 in uv0(slot0) do
			slot9 = uv1(slot7)

			if uv2[slot8] then
				uv3(slot3, "+" .. slot9 .. " {" .. uv2[slot8] .. "}")
			elseif uv4(slot8) == "table" then
				uv2[slot8] = slot2 .. "." .. slot9

				uv3(slot3, "+" .. slot9 .. uv5(slot8, slot1 .. (uv6(slot0, slot7) and "|" or " ") .. uv7(" ", #slot9), slot10))
			else
				uv3(slot3, "+" .. slot9 .. " [" .. uv1(slot8) .. "]")
			end
		end

		return uv8(slot3, "\n" .. slot1)
	end)(slot0, "", ""))
end

function string.firstToUpper(slot0)
	return string.upper(string.sub(slot0, 1, 1)) .. string.sub(slot0, 2)
end

function table.GetFirstElem(slot0)
	for slot4, slot5 in uv0(slot0) do
		return slot5
	end
end

function table.GetElemByIndex(slot0, slot1)
	if uv0(slot0) == "table" then
		slot2 = 1

		for slot6, slot7 in uv1(slot0) do
			if slot2 == slot1 then
				return slot7
			end

			slot2 = slot2 + 1
		end
	end

	return nil
end

function table.isEmpty(slot0)
	if uv0(slot0) == "table" then
		for slot4, slot5 in uv1(slot0) do
			return false
		end
	end

	return true
end

function table.dup(slot0)
	if uv0(slot0) ~= "table" then
		return {}
	end

	slot1 = {}

	table.merge(slot1, slot0)

	return slot1
end

function table.toString(slot0)
	if uv0(slot0) ~= "table" then
		return "{}"
	end

	return "{" .. (function (slot0)
		slot1 = ""

		for slot5, slot6 in uv0(slot0) do
			slot1 = uv1(slot6) == "table" and slot1 .. uv2(slot5) .. "=" .. "{" .. uv3(slot6) .. "}," or uv1(slot6) == "string" and slot1 .. uv2(slot5) .. "=" .. "{" .. uv3(slot6) .. "}," .. uv2(slot5) .. "=" .. "\"" .. uv2(slot6) .. "\"," or slot1 .. uv2(slot6) .. ","
		end

		return slot1
	end)(slot0) .. "}"
end

function table.toStringLimitDepth(slot0, slot1)
	if uv0(slot0) ~= "table" then
		return "{}"
	end

	slot2 = 0

	return "{" .. (function (slot0)
		uv0 = uv0 + 1

		if uv1 < uv0 then
			return "\"表格深度大于" .. uv1 .. "\","
		end

		slot1 = ""

		for slot5, slot6 in uv2(slot0) do
			slot1 = uv3(slot6) == "table" and slot1 .. uv4(slot5) .. "=" .. "{" .. uv5(slot6) .. "}," or uv3(slot6) == "string" and slot1 .. uv4(slot5) .. "=" .. "{" .. uv5(slot6) .. "}," .. uv4(slot5) .. "=" .. "\"" .. uv4(slot6) .. "\"," or slot1 .. uv4(slot6) .. ","
		end

		return slot1
	end)(slot0) .. "}"
end

function slot11(slot0, slot1)
	if slot0[slot1 - 1] then
		return slot1, slot2
	end
end

function r_ipairs(slot0)
	return uv0, slot0, #slot0 + 1
end
