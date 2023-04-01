slot1 = import("game.const.SettingConst")

return {
	GetDefaultScreenSize = function ()
		slot1 = _G.SCREEN_HEIGHT / uv0.DESIGN_HEIGHT

		if _G.SCREEN_WIDTH / uv0.DESIGN_WIDTH > 1 or slot1 > 1 then
			slot2 = math.max(slot0, slot1)

			return math.floor(_G.SCREEN_WIDTH / slot2), math.floor(_G.SCREEN_HEIGHT / slot2)
		else
			return _G.SCREEN_WIDTH, _G.SCREEN_HEIGHT
		end
	end,
	GetSettingScreenSize = function (slot0)
		slot1 = _G.SCREEN_WIDTH
		slot2 = _G.SCREEN_HEIGHT

		if GameToSDK.PLATFORM_ID == 0 then
			slot1 = math.floor(math.min(slot2, 1080) * slot1 / slot2)
		end

		slot3 = 1

		if slot0 == 1 then
			slot3 = 0.5
		elseif slot0 == 2 then
			slot3 = 0.75
		end

		if GameToSDK.PLATFORM_ID == 1 then
			slot3 = slot3 == 0.5 and 0.75 or 1
		end

		return slot1 * slot3, slot2 * slot3
	end
}
