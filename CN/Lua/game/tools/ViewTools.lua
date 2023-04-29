slot1 = import("game.const.ViewConst")
slot2 = {
	"blank",
	"settlement",
	"battlefailed",
	"battleBossChallengeResult",
	"battleMultipleResult",
	"battleChapterResult"
}

return {
	PreDealWithAsset = function (slot0, slot1, slot2, slot3)
		slot4 = {}

		if #slot1 > 0 then
			for slot9 = slot5, slot2 + 1, -1 do
				if slot3 and ViewCfg[slot1[slot9]] and not uv0.IGNORE_UNLOAD[slot1[slot9]] then
					table.insert(slot4, slot1[slot9])
				end
			end

			uv1.PreUnLoadAsset(slot4)
		end

		slot6 = {}

		for slot10 = slot2 + 1, #slot0 do
			if slot3 and ViewCfg[slot0[slot10]] then
				table.insert(slot6, slot0[slot10])
			end
		end

		uv1.PreLoadAsset(slot6)
	end,
	isLoading = false,
	GetIsLoadied = function ()
		return not uv0.isLoading
	end,
	PreLoadAsset = function (slot0)
		slot1 = {}
		slot2 = false

		for slot6 = 1, #slot0 do
			for slot11 = 1, #ViewCfg[slot0[slot6]].need_atlas do
				slot1[slot7.need_atlas[slot11]] = 20
				slot2 = true
			end
		end

		if slot2 then
			uv0.isLoading = true

			PreLoadAsset(slot1, 0, function ()
				for slot3, slot4 in pairs(uv0) do
					LuaForUtil.PreLoadAtlas(slot3)
				end

				uv1.isLoading = false
			end, true)
		end
	end,
	PreUnLoadAsset = function (slot0)
		slot1 = {}

		for slot5 = 1, #slot0 do
			for slot10 = 1, #ViewCfg[slot0[slot5]].need_atlas do
				if not table.keyof(slot1, slot6.need_atlas[slot10]) then
					table.insert(slot1, slot6.need_atlas[slot10])
				end
			end
		end

		for slot5 = 1, #slot1 do
			Asset.Unload(slot1[slot5])
		end
	end,
	GetIsSkipRecord = function (slot0)
		for slot4, slot5 in ipairs(uv0) do
			if table.indexof(slot0, slot5) then
				return true
			end
		end

		return false
	end
}
