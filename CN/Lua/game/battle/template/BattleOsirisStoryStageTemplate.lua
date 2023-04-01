slot0 = class("BattleOsirisStoryStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleActivityStoryStageCfg[slot1]

	if BattleConst.BATTLE_TAG.STORY == slot0.cfg.tag then
		slot0.heroList = {}
		slot0.systemHeroList = {}
	else
		slot0.heroList, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY, slot1, slot2)
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
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY
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

function slot0.GetRevive(slot0)
	if type(slot0.cfg.is_revive) ~= "table" or BattleConst.BATTLE_TAG.STORY == slot0.cfg.tag then
		return false, 0, 0, 0
	end

	return slot0.cfg.is_revive[1] and true or false, slot1[1] or 0, slot1[1] and ItemTools.getItemNum(slot1[1]) or 0, slot1[2] or 0
end

function slot0.GetClearTime(slot0)
	if StoryStageActivityData:GetHistoryChapter(slot0.activityID_) == nil then
		return 0
	end

	if StoryStageActivityData:GetStageData(slot2)[slot0.id] and slot3.clear_times then
		return slot3.clear_times
	else
		return 0
	end
end

return slot0
