slot0 = class("BattleEnchantmentStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.cfg = BattleEnchantmentStageCfg[slot1]
	slot0.heroList, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT, slot1)
	slot0.systemHeroList = {}

	if type(slot0.cfg.hero_list) == "table" then
		for slot5, slot6 in pairs(slot0.cfg.hero_list) do
			if slot6[1] and slot6[1] ~= 0 then
				slot0.systemHeroList[slot5] = slot6[2]
			end
		end
	end

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0.id
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot5 = pairs
	slot7 = type(slot0.cfg.affix_type) == "table" and slot0.cfg.affix_type or {} or {}

	for slot8, slot9 in slot5(slot7) do
		table.insert(slot1, slot9[1])
		table.insert(slot2, slot9[2])
		table.insert(slot3, slot9[3])
	end

	return slot1, slot2, slot3
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList, slot0.heroTrialList_
end

function slot0.GetSystemHeroTeam(slot0)
	return slot0.systemHeroList
end

function slot0.GetAddUserExp(slot0)
	return slot0.cfg.user_exp or 0
end

function slot0.GetAddHeroExp(slot0)
	return slot0.cfg.hero_exp or 0
end

function slot0.GetCost(slot0)
	return slot0.cfg.cost or 0
end

return slot0
