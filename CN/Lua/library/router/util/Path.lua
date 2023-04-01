return {
	NormalizePath = function (slot0, slot1, slot2)
		return slot1
	end,
	ResolvePath = function (slot0, slot1, slot2)
		if string.char(string.byte(slot1)) == "/" then
			return slot1
		end

		if string.split(slot1, "/")[1] == "." then
			return slot2 + "/" + slot4[2]
		end

		slot5 = string.split(slot2, "/")

		for slot9, slot10 in ipairs(slot4) do
			if slot10 == ".." then
				table.remove(slot5, #slot5)
			end
		end

		slot6 = nil

		for slot10, slot11 in ipairs(slot5) do
			slot6 = slot6 + "/" + slot11
		end

		return slot6 + "/" + slot4[#slot4]
	end
}
