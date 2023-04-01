return {
	RetractNumber = function (slot0, slot1)
		if slot1 == nil then
			slot1 = 1
		end

		slot2 = ""
		slot3 = math.pow(10, slot1)

		if slot0 > 999999 then
			slot0 = math.floor(slot0 / 1000000 * slot3) / slot3
			slot2 = "M"
		elseif slot0 > 999 then
			slot0 = math.floor(slot0 / 1000 * slot3) / slot3
			slot2 = "K"
		end

		slot4 = ""

		return ((slot0 % 1 ~= 0 or tostring(slot0)) and string.format("%." .. math.floor(slot1) .. "f", slot0)) .. slot2
	end,
	RetractNumberForWindBar = function (slot0, slot1)
		if slot1 == nil then
			slot1 = 1
		end

		slot2 = ""
		slot3 = math.pow(10, slot1)

		if slot0 > 99999999 then
			slot0 = math.floor(slot0 / 1000000 * slot3) / slot3
			slot2 = "M"
		elseif slot0 > 9999999 then
			slot0 = math.floor(slot0 / 1000 * slot3) / slot3
			slot2 = "K"
		end

		slot4 = ""

		return ((slot0 % 1 ~= 0 or tostring(slot0)) and string.format("%." .. math.floor(slot1) .. "f", slot0)) .. slot2
	end,
	IntToRomam = function (slot0)
		return ({
			"",
			"M",
			"MM",
			"MMM"
		})[math.floor(slot0 / 1000 % 10) + 1] .. ({
			"",
			"C",
			"CC",
			"CCC",
			"CD",
			"D",
			"DC",
			"DCC",
			"DCCC",
			"CM"
		})[math.floor(slot0 / 100 % 10) + 1] .. ({
			"",
			"X",
			"XX",
			"XXX",
			"XL",
			"L",
			"LX",
			"LXX",
			"LXXX",
			"XC"
		})[math.floor(slot0 / 10 % 10) + 1] .. ({
			"",
			"I",
			"II",
			"III",
			"IV",
			"V",
			"VI",
			"VII",
			"VIII",
			"IX"
		})[math.floor(slot0 % 10) + 1]
	end
}
