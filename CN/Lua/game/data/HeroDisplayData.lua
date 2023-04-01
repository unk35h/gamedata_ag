slot0 = singletonClass("HeroDisplayData")
slot1 = require("cjson")

function slot0.Init(slot0)
	if getData("HeroDisplay", "settingProfile") == nil then
		slot0.settingProfile_ = {
			cardShowUID = true,
			cardShowLv = true,
			logoPos = 0,
			cardPos = 1,
			cardShow = true
		}
	else
		slot0.settingProfile_ = slot1
	end

	slot0.heroExpressionParams_ = {}
	slot0.heroCustomExpression_ = {}
	slot0.heroPoseList_ = {}
end

function slot0.SaveSetting(slot0, slot1)
	slot0.settingProfile_.logoPos = slot1.logoPos
	slot0.settingProfile_.cardPos = slot1.cardPos
	slot0.settingProfile_.cardShow = slot1.cardShow
	slot0.settingProfile_.cardShowLv = slot1.cardShowLv
	slot0.settingProfile_.cardShowUID = slot1.cardShowUID

	saveData("HeroDisplay", "settingProfile", slot0.settingProfile_)
end

function slot0.GetSetting(slot0)
	return slot0.settingProfile_
end

function slot0.GetCustomExpressionParams(slot0, slot1)
	if slot0.heroCustomExpression_[slot1] == nil then
		if getData("HeroDisplay", "expressionParams" .. slot1) then
			slot0.heroCustomExpression_[slot1] = slot2
		else
			slot0.heroCustomExpression_[slot1] = {}
		end
	end

	return slot0.heroCustomExpression_[slot1]
end

function slot0.AddCustomExpressionParams(slot0, slot1, slot2)
	table.insert(slot0.heroCustomExpression_[slot1], slot2)
	saveData("HeroDisplay", "expressionParams" .. slot1, slot0.heroCustomExpression_[slot1])
end

function slot0.ReplaceCustomExpressionParams(slot0, slot1, slot2, slot3)
	slot0.heroCustomExpression_[slot1][slot2] = slot3

	saveData("HeroDisplay", "expressionParams" .. slot1, slot0.heroCustomExpression_[slot1])
end

function slot0.DeleteCustomExpressionParams(slot0, slot1, slot2)
	table.remove(slot0.heroCustomExpression_[slot1], slot2)
	saveData("HeroDisplay", "expressionParams" .. slot1, slot0.heroCustomExpression_[slot1])
end

function slot0.InitPreset(slot0, slot1, slot2)
	slot0.heroExpressionParams_[slot1] = {}
	slot7 = "DEFAULT_PRESET"
	slot0.heroExpressionParams_[slot1][1] = {
		preset = true,
		effectID = 0,
		name = GetTips(slot7),
		values = slot2
	}
	slot3 = {}

	for slot7, slot8 in ipairs(slot2) do
		slot3[slot7] = 0
	end

	slot8 = "INIT_PRESET"
	slot0.heroExpressionParams_[slot1][2] = {
		preset = true,
		effectID = 0,
		name = GetTips(slot8),
		values = slot3
	}

	for slot8, slot9 in ipairs(HeroDisplayCfg[slot1].skinMeshPresetName) do
		table.insert(slot0.heroExpressionParams_[slot1], {
			preset = true,
			name = slot9,
			values = slot4.skinMeshPresetValue[slot8],
			effectID = slot4.skinMeshPresetEffect[slot8] or 0
		})
	end

	for slot9, slot10 in ipairs(slot0:GetCustomExpressionParams(slot1)) do
		table.insert(slot0.heroExpressionParams_[slot1], slot10)
	end
end

function slot0.GetHeroExpressionParams(slot0, slot1)
	return slot0.heroExpressionParams_[slot1]
end

function slot0.ReplaceHeroExpressionParams(slot0, slot1, slot2, slot3)
	slot0.heroExpressionParams_[slot1][slot2] = slot3

	slot0:ReplaceCustomExpressionParams(slot1, slot2 - slot0:GetCustomStartIndex(slot1), slot3)
end

function slot0.SaveHeroExpressionParams(slot0, slot1, slot2)
	table.insert(slot0.heroExpressionParams_[slot1], slot2)
	slot0:AddCustomExpressionParams(slot1, slot2)
end

function slot0.DeleteHeroExpressionParams(slot0, slot1, slot2)
	table.remove(slot0.heroExpressionParams_[slot1], slot2)
	slot0:DeleteCustomExpressionParams(slot1, slot2 - slot0:GetCustomStartIndex(slot1))
end

function slot0.GetCustomStartIndex(slot0, slot1)
	return #HeroDisplayCfg[slot1].skinMeshPresetName + 2
end

function slot0.InitCacheExpressionParams(slot0, slot1)
	slot0.cacheExpressionParams_ = {
		values = clone(slot0.heroExpressionParams_[slot1][1].values),
		effectID = slot0.heroExpressionParams_[slot1][1].effectID
	}
end

function slot0.SetCacheExpressionParams(slot0, slot1, slot2)
	slot0.cacheExpressionParams_.values[slot1] = slot2
end

function slot0.SetCacheExpressionEffect(slot0, slot1)
	slot0.cacheExpressionParams_.effectID = slot1
end

function slot0.GetCacheExpressionParams(slot0)
	return slot0.cacheExpressionParams_
end

function slot0.InitHeroPose(slot0, slot1)
	if slot0.heroPoseList_[slot1] then
		return
	end

	slot0.heroPoseList_[slot1] = {}

	for slot6, slot7 in ipairs(HeroDisplayCfg[slot1].poseList) do
		table.insert(slot0.heroPoseList_[slot1], {
			id = slot7[1],
			hasWeapon = slot7[2] == 1 and true or false
		})
	end
end

function slot0.GetHeroPoseList(slot0, slot1)
	return slot0.heroPoseList_[slot1]
end

return slot0
