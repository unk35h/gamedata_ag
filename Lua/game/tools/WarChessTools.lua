slot0 = {}
slot1, slot2 = pcall(require, "bit")

if not slot1 then
	slot1, slot2 = pcall(require, "bit32")
end

slot3 = 32
slot4 = 1

function slot0.DecodeFogInfo(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0) do
		slot7 = uv0.tobit(slot6)

		for slot11 = uv1 - 1, 0, -1 do
			table.insert(slot1, uv0.band(uv0.rshift(slot7, slot11), uv2) == 1)
		end
	end

	return slot1
end

slot5 = {
	GUIDER_1094 = 1
}

function slot0.GetGuiderAssetPath(slot0)
	if WarchessLevelCfg[slot0] then
		for slot5 = 1, #slot1.extra_gameplay do
			if slot1.extra_gameplay[slot5] == uv0.GUIDER_1094 then
				return "Char/6070_tpose"
			end
		end
	end
end

return slot0
