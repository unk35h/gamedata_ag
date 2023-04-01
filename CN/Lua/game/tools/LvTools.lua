return {
	LevelToExp = function (slot0, slot1)
		if slot1 == nil then
			return 0
		end

		if uv0.levelToExp == nil then
			uv0.levelToExp = {}
		end

		if uv0.levelToExp[slot1] == nil then
			uv0.levelToExp[slot1] = {}
			slot2 = 0

			for slot6, slot7 in ipairs(GameLevelSetting) do
				uv0.levelToExp[slot1][slot6] = slot2
				slot2 = slot2 + slot7[slot1]
			end
		end

		return uv0.levelToExp[slot1][slot0]
	end,
	CheckExp = function (slot0, slot1, slot2)
		if slot2 == nil then
			return 1, 0, 0
		elseif slot2 == "user_level_exp" then
			return uv0.CheckUserExp(slot0, slot1)
		end
	end,
	CheckHeroExp = function (slot0, slot1, slot2)
		slot3 = 0
		slot4 = slot1
		slot5 = 0
		slot6 = slot0
		slot7 = 0
		slot11 = GameLevelSetting[#GameLevelSetting.all].id

		for slot11 = 1, math.min(slot11, slot2) do
			slot13 = GameLevelSetting[slot11].hero_level_exp1

			if slot11 < slot0 then
				slot3 = slot3 + slot13
				slot4 = slot4 - slot13
			elseif slot13 <= slot4 then
				slot4 = slot4 - slot13
				slot5 = slot13

				if slot6 < slot2 then
					slot3 = slot3 + slot13
					slot6 = slot6 + 1
				else
					slot7 = slot4 + slot13
					slot5 = 0

					break
				end
			else
				if slot2 <= slot6 then
					slot7 = slot4
					slot5 = 0

					break
				end

				slot3 = slot3 + slot4
				slot5 = slot4

				break
			end
		end

		return slot6, slot5, slot4, slot3, slot7
	end,
	CheckUserExp = function (slot0, slot1)
		slot2 = "user_level_exp"
		slot4 = GameLevelSetting[slot0 + 1]

		if GameLevelSetting[slot0] == nil or slot4 == nil or slot4[slot2] == 0 or uv0.GetIsCurrentMaxLv(slot0, slot2) then
			return slot0, slot1, 0
		end

		if slot3[slot2] <= slot1 then
			return uv0.CheckUserExp(slot0 + 1, slot1 - slot5)
		else
			return slot0, slot1, 0
		end
	end,
	GetIsCurrentMaxLv = function (slot0, slot1)
		if slot1 == "hero_level_exp1" then
			return PlayerData:GetPlayerInfo().userLevel <= slot0
		end

		return GameLevelSetting[slot0 + 1] == nil
	end,
	GetIsMaxLv = function (slot0, slot1)
		if not GameSetting[slot1 .. "_level_max"] then
			print("GameSetting存在未知的记录:", slot1 .. "_level_max")

			return true
		end

		return slot2.value[1] <= slot0
	end,
	GetMaxTotalExp = function (slot0, slot1)
		slot2 = 1

		if slot0 == "hero_level_exp1" then
			slot2 = GameSetting.hero_level_max.value[1]
		elseif slot0 == "user_level_exp" then
			slot2 = GameSetting.user_level_max.value[1]
		end

		return uv0.LevelToExp(slot2, slot0)
	end,
	LoveExpToLevel = function (slot0)
		slot1 = 0

		for slot5 = 1, HeroConst.HERO_LOVE_LV_MAX + 1 do
			slot6 = GameLevelSetting[slot5].hero_love_exp
			slot1 = slot1 + slot6

			if slot6 == 0 then
				return slot5, 0, slot1
			end

			if slot0 > slot6 - 1 then
				slot0 = slot0 - slot6
			else
				return slot5, slot0, slot1
			end
		end
	end,
	checkLoveExp = function (slot0, slot1)
		slot3, slot4 = uv0.LevelToExp(slot0 + slot1)

		return slot3, slot4
	end
}
