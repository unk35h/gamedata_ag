slot0 = class("BattleLeviathanLittleGameTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id_ = slot1
	slot0.activityID_ = slot2
	slot0.stageID_ = ActivityBubblesCfg[slot1].stage_id
	slot0.cfg = BattleLeviathanGamesCfg[slot0.stageID_]
	slot0.heroList_, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(slot0:GetType(), slot0.stageID_, slot2)

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0.id_
end

function slot0.GetStageId(slot0)
	return slot0.stageID_
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.LEVIATHAN_GAME
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level
end

function slot0.GetStageAffix(slot0)
	return {}, {}, {}
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
end

function slot0.GetActivityID(slot0)
	return slot0.activityID_
end

function slot0.SetMaxRaceData(slot0)
	slot1 = {}
	slot2 = 0
	slot3 = false

	for slot7, slot8 in pairs(slot0.roleDataInLua) do
		if slot8.ID ~= 0 then
			slot1[slot10] = (slot1[HeroCfg[slot9].race] or 0) + 1

			if slot1[slot10] == 2 then
				slot2 = slot10
			elseif slot1[slot10] == 3 then
				slot3 = true
			end
		end
	end

	slot0.maxRaceID_ = slot2
	slot0.maxRacePlayerCount_ = slot1[slot2] or 1
end

return slot0
