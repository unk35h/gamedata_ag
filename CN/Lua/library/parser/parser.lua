slot0 = require("lpeg")
slot1 = slot0.S
slot2 = slot0.R
slot3 = slot0.P
slot4 = slot0.Ct
slot5 = slot0.C
slot6 = slot0.Cc
slot7 = slot0.V
slot8 = slot1(" \t\n")^0
slot9 = slot2("09")
slot11 = slot2("AZ", "az")
slot12 = "(" * slot8
slot13 = ")" * slot8
slot14 = "[" * slot8
slot15 = "]" * slot8
slot17 = slot5(slot3("true")) * slot8
slot18 = slot5(slot3("false")) * slot8
slot26 = slot7("AddSub")
slot27 = slot7("MulDiv")
slot28 = slot7("Exponent")
slot29 = slot7("Operand")
slot30 = slot7("Ref")
slot32 = slot7("VarList")
slot33 = slot7("Val")
slot43 = slot8 * slot3({
	slot33,
	Val = slot7("Array") + slot7("Bool") + slot26,
	Bool = slot4(slot6("bool") * (slot17 + slot18 + slot26 * slot5(slot3("<=") + slot3(">=") + slot3("!=") + slot3("==") + slot1("<>")) * slot8 * slot26)),
	AddSub = slot4(slot6("addsub") * slot27 * (slot5(slot1("+-")) * slot8 * slot27)^0),
	MulDiv = slot4(slot6("muldiv") * slot28 * (slot5(slot1("*/")) * slot8 * slot28)^0),
	Exponent = slot4(slot6("expo") * slot29 * (slot5(slot1("^")) * slot8 * slot29)^0),
	Operand = slot5(("-" + slot9) * slot9^0 * ("." * slot9^0)^-1) / tonumber * slot8 + slot12 * slot26 * slot13 + slot7("Call") + slot30,
	Ref = slot4(slot6("ref") * (slot5("#" * slot9 * slot9^0) * slot8 + slot5(slot11 * (slot9 + slot11 + "_")^0) * slot8 - (slot17 + slot18) * slot8) * (slot14 * slot26 * slot15)^0),
	Call = slot4(slot6("call") * slot30 * slot8 * slot12 * slot32 * slot13),
	VarList = slot4((slot33 * ("," * slot8)^-1)^0),
	Array = slot4(slot6("array") * slot14 * slot32 * slot15)
}) * -1

function simplify(slot0)
	if type(slot0) ~= "table" then
		return slot0
	elseif slot0[1] == uv0 or slot0[1] == uv1 or slot0[1] == uv2 then
		if #slot0 == 2 then
			slot0 = simplify(slot0[2])
		else
			for slot5 = 2, slot1 do
				slot0[slot5] = simplify(slot0[slot5])
			end
		end
	elseif slot0[1] == uv3 then
		for slot4 = 2, #slot0 do
			slot0[slot4] = simplify(slot0[slot4])
		end
	elseif slot0[1] == uv4 then
		for slot4 = 3, #slot0 do
			slot0[slot4] = simplify(slot0[slot4])
		end
	elseif slot0[1] == uv5 then
		for slot5 = 1, #slot0[2] do
			slot1[slot5] = simplify(slot1[slot5])
		end
	elseif slot0[1] == uv6 then
		for slot5, slot6 in ipairs(slot0[3]) do
			slot1[slot5] = simplify(slot1[slot5])
		end
	end

	return slot0
end

function eval_expr_lr(slot0, slot1, slot2)
	if type(slot0) ~= "table" or slot0[1] ~= uv0 and slot0[1] ~= uv1 then
		return nil, "invalid expr(left to right)"
	end

	slot3, slot4, slot5 = nil
	slot6, slot5 = eval(slot0[2], slot1, slot2)

	if slot6 == nil then
		return nil, slot5
	end

	for slot9 = 3, #slot0, 2 do
		slot10 = slot0[slot9]
		slot4, slot12 = eval(slot0[slot9 + 1], slot1, slot2)

		if slot12 ~= nil then
			return nil, slot5
		end

		if slot10 == "+" then
			slot3 = slot3 + slot4
		elseif slot10 == "-" then
			slot3 = slot3 - slot4
		elseif slot10 == "*" then
			slot3 = slot3 * slot4
		elseif slot10 == "/" then
			slot3 = slot3 / slot4
		else
			return nil, slot10 .. " operator is not supported"
		end
	end

	return slot3
end

function eval_expr_rl(slot0, slot1, slot2)
	if type(slot0) ~= "table" or slot0[1] ~= uv0 then
		return nil, "invalid expr(right to left)"
	end

	slot3, slot4, slot5 = nil
	slot7, slot5 = eval(slot0[#slot0], slot1, slot2)

	if slot7 == nil then
		return nil, slot5
	end

	for slot10 = slot6 - 1, 3, -2 do
		slot11 = slot0[slot10]
		slot3, slot13 = eval(slot0[slot10 - 1], slot1, slot2)

		if slot13 ~= nil then
			return nil, slot5
		end

		if slot11 == "^" then
			slot4 = slot3^slot4
		else
			return nil, slot11 .. " operator is not supported"
		end
	end

	return slot4
end

function eval_bool(slot0, slot1, slot2)
	if type(slot0) ~= "table" or slot0[1] ~= uv0 then
		return nil, "invalid bool"
	end

	if slot0[2] == "true" then
		return true
	elseif slot0[2] == "false" then
		return false
	end

	slot3, slot4, slot5 = nil
	slot3, slot5 = eval(slot0[2], slot1, slot2)
	slot4, slot5 = eval(slot0[4], slot1, slot2)

	if slot0[3] == "<" then
		return slot3 < slot4
	elseif slot6 == "==" then
		return slot3 == slot4
	elseif slot6 == ">" then
		return slot4 < slot3
	elseif slot6 == "<=" then
		return slot3 <= slot4
	elseif slot6 == ">=" then
		return slot4 <= slot3
	elseif slot6 == "!=" then
		return slot3 ~= slot4
	end

	return nil, "invalid bool operator"
end

function eval_array(slot0, slot1, slot2)
	if type(slot0) ~= "table" or slot0[1] ~= uv0 or type(slot0[2]) ~= "table" then
		return nil, "invalid array"
	end

	slot3 = {}

	for slot7 = 1, #slot0[2] do
		slot8, slot9 = eval(slot0[2][slot7], slot1, slot2)

		if slot9 ~= nil then
			return nil, slot9
		end

		table.insert(slot3, slot8)
	end

	log(uv0, slot3)

	return slot3
end

function eval_call(slot0, slot1, slot2)
	if type(slot0) ~= "table" or slot0[1] ~= uv0 then
		return nil, "invalid call"
	end

	if type(eval(slot0[2], slot1, slot2)) ~= "function" then
		return nil, slot0[2][2] .. " is not a function"
	end

	slot4 = {}

	for slot8, slot9 in ipairs(slot0[3]) do
		slot10 = nil
		slot4[slot8], slot12 = eval(slot9, slot1, slot2)

		if slot12 ~= nil then
			return nil, slot10
		end
	end

	return slot3(unpack(slot4))
end

function lookup(slot0, slot1, slot2)
	if type(slot0) ~= "table" or slot0[1] ~= uv0 then
		return nil, "invalid ref"
	end

	if slot2[slot0[2]] ~= nil then
		for slot7 = 3, #slot0 do
			slot8, slot9 = eval(slot0[slot7], slot1, slot2)

			if slot9 ~= nil then
				return nil, slot9
			end

			log("array", slot3)

			if type(slot3) ~= "table" then
				return nil, "index of non-table"
			end

			slot3 = slot3[slot8]
		end

		return slot3
	end

	return slot1[slot0[2]]
end

function eval(slot0, slot1, slot2)
	if type(slot0) == "number" then
		return slot0
	elseif type(slot0) ~= "table" then
		return nil, "invalid ast"
	elseif slot0[1] == uv0 or slot0[1] == uv1 then
		return eval_expr_lr(slot0, slot1, slot2)
	elseif slot0[1] == uv2 then
		return eval_expr_rl(slot0, slot1, slot2)
	elseif slot0[1] == uv3 then
		return lookup(slot0, slot1, slot2)
	elseif slot0[1] == uv4 then
		return eval_bool(slot0, slot1, slot2)
	elseif slot0[1] == uv5 then
		return eval_array(slot0, slot1, slot2)
	elseif slot0[1] == uv6 then
		return eval_call(slot0, slot1, slot2)
	end
end

return {
	parse = function (slot0)
		return simplify(uv0:match(slot0))
	end,
	eval = eval
}
