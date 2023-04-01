slot0 = class("BattleGuildActivityStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleClubActivityCfg[slot1]
	slot0.heroList, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY, slot1, slot2)

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.SetNodeId(slot0, slot1)
	slot0.nodeId_ = slot1
end

function slot0.GetNodeId(slot0)
	return slot0.nodeId_
end

function slot0.GetDest(slot0)
	return slot0.nodeId_
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level or 0
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level or 0
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList, slot0.heroTrialList_
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

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in pairs(slot0.roleDataInLua) do
		if SkinCfg[slot10.ID].hero ~= 0 then
			slot5[slot12] = slot5[HeroCfg[slot11].race] or 0
			slot5[slot12] = slot5[slot12] + 1
		end
	end

	for slot10, slot11 in pairs(GuildActivityData:GetUnLockAffixList()) do
		if slot5[TalentTreeCfg[slot10].race] ~= nil then
			slot1[slot10] = slot5[slot12]

			table.insert(slot2, TalentTreeCfg[slot10].affix_id)
			table.insert(slot3, slot11.level)
			table.insert(slot4, TalentTreeCfg[slot10].affix_user)
		end
	end

	GuildActivityData:SetTempEffectiveAffixList(slot1)

	return slot2, slot3, slot4
end

function slot0.SetPathList(slot0, slot1)
	slot0.pathList_ = slot1
end

function slot0.GetPathList(slot0)
	return slot0.pathList_ or {}
end

function slot0.GetAttributeFactor(slot0)
	if ActivityClubCfg[slot0.nodeId_].attribute_factor and slot1.attribute_factor[3] then
		slot2 = slot1.attribute_factor[1] / 1000
		slot3 = slot1.attribute_factor[2] / 1000
		slot4 = slot1.attribute_factor[3] / 1000
		slot5 = 1
		slot6 = 1

		if 10 - GuildActivityData:GetNodeData(slot0.nodeId_).history_occupied_num < 1 then
			slot8 = 1
		end

		slot6 = slot6 * slot8 / 10
		slot5 = slot5 * slot8 / 10

		if GuildActivityData:GetSelfNodeData(slot0.nodeId_) then
			if slot9.elite_health_rate == 0 then
				slot10 = 100
			end

			slot5 = slot5 * slot10 / 100
		end

		return Vector3.New(slot2 * slot6, slot3 * slot6, slot4 * slot5)
	end

	return Vector3.New(1, 1, 1)
end

return slot0
