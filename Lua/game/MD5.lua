slot0 = {
	_LICENSE = [[


    MIT LICENSE






    Copyright (c) 2013 Enrique García Cota + Adam Baldwin + hanzao + Equi 4 Software






    Permission is hereby granted, free of charge, to any person obtaining a


    copy of this software and associated documentation files (the


    "Software"), to deal in the Software without restriction, including


    without limitation the rights to use, copy, modify, merge, publish,


    distribute, sublicense, and/or sell copies of the Software, and to


    permit persons to whom the Software is furnished to do so, subject to


    the following conditions:






    The above copyright notice and this permission notice shall be included


    in all copies or substantial portions of the Software.






    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS


    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF


    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.


    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY


    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,


    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE


    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


  ]]
}
slot1 = string.char
slot2 = string.byte
slot3 = string.format
slot4 = string.rep
slot5 = string.sub
slot6, slot7, slot8, slot9, slot10, slot11 = nil
slot12, slot13 = pcall(require, "bit")

if slot12 then
	slot11 = slot13.lshift
	slot10 = slot13.rshift
	slot9 = slot13.bxor
	slot8 = slot13.bnot
	slot7 = slot13.band
	slot6 = slot13.bor
else
	slot14, slot13 = pcall(require, "bit32")

	if slot14 then
		slot8 = slot13.bnot

		function slot14(slot0)
			return slot0 <= 2147483647 and slot0 or -(uv0(slot0) + 1)
		end

		function slot15(slot0)
			return function (slot0, slot1)
				return uv0(uv1(uv0(slot0), uv0(slot1)))
			end
		end

		slot9 = slot15(slot13.bxor)
		slot7 = slot15(slot13.band)
		slot6 = slot15(slot13.bor)
		slot11 = slot15(slot13.lshift)
		slot10 = slot15(slot13.rshift)
	else
		function slot14(slot0)
			slot1 = 0
			slot2 = 1

			for slot6 = 1, #slot0 do
				slot1 = slot1 + slot0[slot6] * slot2
				slot2 = slot2 * 2
			end

			return slot1
		end

		function slot15(slot0, slot1)
			if #slot0 < #slot1 then
				slot3 = slot2
				slot2 = slot3
			end

			for slot7 = #slot3 + 1, #slot2 do
				slot3[slot7] = 0
			end
		end

		slot16 = nil

		function slot8(slot0)
			for slot6 = 1, math.max(#uv0(slot0), 32) do
				if slot1[slot6] == 1 then
					slot1[slot6] = 0
				else
					slot1[slot6] = 1
				end
			end

			return uv1(slot1)
		end

		function slot16(slot0)
			if slot0 < 0 then
				return uv0(uv1(math.abs(slot0)) + 1)
			end

			slot1 = {}
			slot2 = 1
			slot3 = nil

			while slot0 > 0 do
				slot3 = slot0 % 2
				slot1[slot2] = slot3
				slot0 = (slot0 - slot3) / 2
				slot2 = slot2 + 1
			end

			return slot1
		end

		function slot6(slot0, slot1)
			slot2 = uv0(slot0)

			uv1(slot2, uv0(slot1))

			slot4 = {}

			for slot8 = 1, #slot2 do
				if slot2[slot8] == 0 and slot3[slot8] == 0 then
					slot4[slot8] = 0
				else
					slot4[slot8] = 1
				end
			end

			return uv2(slot4)
		end

		function slot7(slot0, slot1)
			slot2 = uv0(slot0)

			uv1(slot2, uv0(slot1))

			slot4 = {}

			for slot8 = 1, #slot2 do
				if slot2[slot8] == 0 or slot3[slot8] == 0 then
					slot4[slot8] = 0
				else
					slot4[slot8] = 1
				end
			end

			return uv2(slot4)
		end

		function slot9(slot0, slot1)
			slot2 = uv0(slot0)

			uv1(slot2, uv0(slot1))

			slot4 = {}

			for slot8 = 1, #slot2 do
				if slot2[slot8] ~= slot3[slot8] then
					slot4[slot8] = 1
				else
					slot4[slot8] = 0
				end
			end

			return uv2(slot4)
		end

		function slot10(slot0, slot1)
			slot2 = 0

			if slot0 < 0 then
				slot0 = uv0(math.abs(slot0)) + 1
				slot2 = 2147483648.0
			end

			slot3 = math.floor

			for slot7 = 1, slot1 do
				slot0 = uv1(slot3(slot0 / 2), slot2)
			end

			return slot3(slot0)
		end

		function slot11(slot0, slot1)
			if slot0 < 0 then
				slot0 = uv0(math.abs(slot0)) + 1
			end

			for slot5 = 1, slot1 do
				slot0 = slot0 * 2
			end

			return uv1(slot0, 4294967295.0)
		end
	end
end

function slot14(slot0)
	function slot1(slot0)
		return uv0(uv1(uv2(uv3, slot0), 255))
	end

	return slot1(0) .. slot1(8) .. slot1(16) .. slot1(24)
end

function slot15(slot0)
	slot1 = 0

	for slot5 = 1, #slot0 do
		slot1 = slot1 * 256 + uv0(slot0, slot5)
	end

	return slot1
end

function slot16(slot0)
	slot1 = 0

	for slot5 = #slot0, 1, -1 do
		slot1 = slot1 * 256 + uv0(slot0, slot5)
	end

	return slot1
end

function slot17(slot0, ...)
	slot1 = 1
	slot2 = {}

	for slot7 = 1, #{
		...
	} do
		table.insert(slot2, uv0(uv1(slot0, slot1, slot1 + slot3[slot7] - 1)))

		slot1 = slot1 + slot3[slot7]
	end

	return slot2
end

function slot18(slot0)
	return uv0(uv1(slot0))
end

slot19 = {
	3614090360.0,
	3905402710.0,
	606105819,
	3250441966.0,
	4118548399.0,
	1200080426,
	2821735955.0,
	4249261313.0,
	1770035416,
	2336552879.0,
	4294925233.0,
	2304563134.0,
	1804603682,
	4254626195.0,
	2792965006.0,
	1236535329,
	4129170786.0,
	3225465664.0,
	643717713,
	3921069994.0,
	3593408605.0,
	38016083,
	3634488961.0,
	3889429448.0,
	568446438,
	3275163606.0,
	4107603335.0,
	1163531501,
	2850285829.0,
	4243563512.0,
	1735328473,
	2368359562.0,
	4294588738.0,
	2272392833.0,
	1839030562,
	4259657740.0,
	2763975236.0,
	1272893353,
	4139469664.0,
	3200236656.0,
	681279174,
	3936430074.0,
	3572445317.0,
	76029189,
	3654602809.0,
	3873151461.0,
	530742520,
	3299628645.0,
	4096336452.0,
	1126891415,
	2878612391.0,
	4237533241.0,
	1700485571,
	2399980690.0,
	4293915773.0,
	2240044497.0,
	1873313359,
	4264355552.0,
	2734768916.0,
	1309151649,
	4149444226.0,
	3174756917.0,
	718787259,
	3951481745.0,
	1732584193,
	4023233417.0,
	2562383102.0,
	271733878
}

function slot20(slot0, slot1, slot2)
	return uv0(uv1(slot0, slot1), uv1(-slot0 - 1, slot2))
end

function slot21(slot0, slot1, slot2)
	return uv0(uv1(slot0, slot2), uv1(slot1, -slot2 - 1))
end

function slot22(slot0, slot1, slot2)
	return uv0(slot0, uv0(slot1, slot2))
end

function slot23(slot0, slot1, slot2)
	return uv0(slot1, uv1(slot0, -slot2 - 1))
end

function slot24(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot1 = uv0(slot1 + slot0(slot2, slot3, slot4) + slot5 + slot7, 4294967295.0)

	return uv1(uv2(uv0(slot1, uv3(4294967295.0, slot6)), slot6), uv3(slot1, 32 - slot6)) + slot2
end

function slot25(slot0, slot1, slot2, slot3, slot4)
	slot6 = slot1
	slot7 = slot2
	slot8 = slot3
	slot9 = uv0
	slot5 = uv1(uv2, slot0, slot6, slot7, slot8, slot4[0], 7, slot9[1])
	slot8 = uv1(uv2, slot8, slot5, slot6, slot7, slot4[1], 12, slot9[2])
	slot7 = uv1(uv2, slot7, slot8, slot5, slot6, slot4[2], 17, slot9[3])
	slot6 = uv1(uv2, slot6, slot7, slot8, slot5, slot4[3], 22, slot9[4])
	slot5 = uv1(uv2, slot5, slot6, slot7, slot8, slot4[4], 7, slot9[5])
	slot8 = uv1(uv2, slot8, slot5, slot6, slot7, slot4[5], 12, slot9[6])
	slot7 = uv1(uv2, slot7, slot8, slot5, slot6, slot4[6], 17, slot9[7])
	slot6 = uv1(uv2, slot6, slot7, slot8, slot5, slot4[7], 22, slot9[8])
	slot5 = uv1(uv2, slot5, slot6, slot7, slot8, slot4[8], 7, slot9[9])
	slot8 = uv1(uv2, slot8, slot5, slot6, slot7, slot4[9], 12, slot9[10])
	slot7 = uv1(uv2, slot7, slot8, slot5, slot6, slot4[10], 17, slot9[11])
	slot6 = uv1(uv2, slot6, slot7, slot8, slot5, slot4[11], 22, slot9[12])
	slot5 = uv1(uv2, slot5, slot6, slot7, slot8, slot4[12], 7, slot9[13])
	slot8 = uv1(uv2, slot8, slot5, slot6, slot7, slot4[13], 12, slot9[14])
	slot7 = uv1(uv2, slot7, slot8, slot5, slot6, slot4[14], 17, slot9[15])
	slot6 = uv1(uv2, slot6, slot7, slot8, slot5, slot4[15], 22, slot9[16])
	slot5 = uv1(uv3, slot5, slot6, slot7, slot8, slot4[1], 5, slot9[17])
	slot8 = uv1(uv3, slot8, slot5, slot6, slot7, slot4[6], 9, slot9[18])
	slot7 = uv1(uv3, slot7, slot8, slot5, slot6, slot4[11], 14, slot9[19])
	slot6 = uv1(uv3, slot6, slot7, slot8, slot5, slot4[0], 20, slot9[20])
	slot5 = uv1(uv3, slot5, slot6, slot7, slot8, slot4[5], 5, slot9[21])
	slot8 = uv1(uv3, slot8, slot5, slot6, slot7, slot4[10], 9, slot9[22])
	slot7 = uv1(uv3, slot7, slot8, slot5, slot6, slot4[15], 14, slot9[23])
	slot6 = uv1(uv3, slot6, slot7, slot8, slot5, slot4[4], 20, slot9[24])
	slot5 = uv1(uv3, slot5, slot6, slot7, slot8, slot4[9], 5, slot9[25])
	slot8 = uv1(uv3, slot8, slot5, slot6, slot7, slot4[14], 9, slot9[26])
	slot7 = uv1(uv3, slot7, slot8, slot5, slot6, slot4[3], 14, slot9[27])
	slot6 = uv1(uv3, slot6, slot7, slot8, slot5, slot4[8], 20, slot9[28])
	slot5 = uv1(uv3, slot5, slot6, slot7, slot8, slot4[13], 5, slot9[29])
	slot8 = uv1(uv3, slot8, slot5, slot6, slot7, slot4[2], 9, slot9[30])
	slot7 = uv1(uv3, slot7, slot8, slot5, slot6, slot4[7], 14, slot9[31])
	slot6 = uv1(uv3, slot6, slot7, slot8, slot5, slot4[12], 20, slot9[32])
	slot5 = uv1(uv4, slot5, slot6, slot7, slot8, slot4[5], 4, slot9[33])
	slot8 = uv1(uv4, slot8, slot5, slot6, slot7, slot4[8], 11, slot9[34])
	slot7 = uv1(uv4, slot7, slot8, slot5, slot6, slot4[11], 16, slot9[35])
	slot6 = uv1(uv4, slot6, slot7, slot8, slot5, slot4[14], 23, slot9[36])
	slot5 = uv1(uv4, slot5, slot6, slot7, slot8, slot4[1], 4, slot9[37])
	slot8 = uv1(uv4, slot8, slot5, slot6, slot7, slot4[4], 11, slot9[38])
	slot7 = uv1(uv4, slot7, slot8, slot5, slot6, slot4[7], 16, slot9[39])
	slot6 = uv1(uv4, slot6, slot7, slot8, slot5, slot4[10], 23, slot9[40])
	slot5 = uv1(uv4, slot5, slot6, slot7, slot8, slot4[13], 4, slot9[41])
	slot8 = uv1(uv4, slot8, slot5, slot6, slot7, slot4[0], 11, slot9[42])
	slot7 = uv1(uv4, slot7, slot8, slot5, slot6, slot4[3], 16, slot9[43])
	slot6 = uv1(uv4, slot6, slot7, slot8, slot5, slot4[6], 23, slot9[44])
	slot5 = uv1(uv4, slot5, slot6, slot7, slot8, slot4[9], 4, slot9[45])
	slot8 = uv1(uv4, slot8, slot5, slot6, slot7, slot4[12], 11, slot9[46])
	slot7 = uv1(uv4, slot7, slot8, slot5, slot6, slot4[15], 16, slot9[47])
	slot6 = uv1(uv4, slot6, slot7, slot8, slot5, slot4[2], 23, slot9[48])
	slot5 = uv1(uv5, slot5, slot6, slot7, slot8, slot4[0], 6, slot9[49])
	slot8 = uv1(uv5, slot8, slot5, slot6, slot7, slot4[7], 10, slot9[50])
	slot7 = uv1(uv5, slot7, slot8, slot5, slot6, slot4[14], 15, slot9[51])
	slot6 = uv1(uv5, slot6, slot7, slot8, slot5, slot4[5], 21, slot9[52])
	slot5 = uv1(uv5, slot5, slot6, slot7, slot8, slot4[12], 6, slot9[53])
	slot8 = uv1(uv5, slot8, slot5, slot6, slot7, slot4[3], 10, slot9[54])
	slot7 = uv1(uv5, slot7, slot8, slot5, slot6, slot4[10], 15, slot9[55])
	slot6 = uv1(uv5, slot6, slot7, slot8, slot5, slot4[1], 21, slot9[56])
	slot5 = uv1(uv5, slot5, slot6, slot7, slot8, slot4[8], 6, slot9[57])
	slot8 = uv1(uv5, slot8, slot5, slot6, slot7, slot4[15], 10, slot9[58])
	slot7 = uv1(uv5, slot7, slot8, slot5, slot6, slot4[6], 15, slot9[59])
	slot6 = uv1(uv5, slot6, slot7, slot8, slot5, slot4[13], 21, slot9[60])
	slot5 = uv1(uv5, slot5, slot6, slot7, slot8, slot4[4], 6, slot9[61])
	slot8 = uv1(uv5, slot8, slot5, slot6, slot7, slot4[11], 10, slot9[62])
	slot7 = uv1(uv5, slot7, slot8, slot5, slot6, slot4[2], 15, slot9[63])

	return uv6(slot0 + slot5, 4294967295.0), uv6(slot1 + uv1(uv5, slot6, slot7, slot8, slot5, slot4[9], 21, slot9[64]), 4294967295.0), uv6(slot2 + slot7, 4294967295.0), uv6(slot3 + slot8, 4294967295.0)
end

function slot26(slot0, slot1)
	slot0.pos = slot0.pos + #slot1

	for slot5 = 1, #(slot0.buf .. slot1) - 63, 64 do
		slot6 = uv0(uv1(slot1, slot5, slot5 + 63), 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4)
		slot6[0] = table.remove(slot6, 1)
		slot0.a, slot0.b, slot0.c, slot0.d = uv2(slot0.a, slot0.b, slot0.c, slot0.d, slot6)
	end

	slot0.buf = uv1(slot1, math.floor(#slot1 / 64) * 64 + 1, #slot1)

	return slot0
end

function slot27(slot0)
	slot1 = slot0.pos
	slot2 = 56 - slot1 % 64

	if slot1 % 64 > 56 then
		slot2 = slot2 + 64
	end

	if slot2 == 0 then
		slot2 = 64
	end

	uv4(slot0, uv0(128) .. uv1(uv0(0), slot2 - 1) .. uv2(uv3(8 * slot1, 4294967295.0)) .. uv2(math.floor(slot1 / 536870912)))

	return uv2(slot0.a) .. uv2(slot0.b) .. uv2(slot0.c) .. uv2(slot0.d)
end

function slot0.new()
	return {
		buf = "",
		pos = 0,
		a = uv0[65],
		b = uv0[66],
		c = uv0[67],
		d = uv0[68],
		update = uv1,
		finish = uv2
	}
end

function slot0.tohex(slot0)
	return uv0("%08x%08x%08x%08x", uv1(uv2(slot0, 1, 4)), uv1(uv2(slot0, 5, 8)), uv1(uv2(slot0, 9, 12)), uv1(uv2(slot0, 13, 16)))
end

function slot0.sum(slot0)
	return uv0.new():update(slot0):finish()
end

function slot0.sumhexa(slot0)
	return uv0.tohex(uv0.sum(slot0))
end

return slot0
