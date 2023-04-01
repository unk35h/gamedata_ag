slot0 = singletonClass("BattleTeachData")

function slot0.Ctor(slot0)
end

function slot0.Init(slot0)
	slot0.switchType_ = getData("BattleTeach", "switchType_new") or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING
	slot0.stageList_ = {}
	slot0.baseStageList_ = {}
	slot0.heroStageList_ = {}
	slot0.cacheSelectHeroID_ = nil
	slot0.baseScrollViewHorizontal_ = getData("BattleTeach", "base_scroll_horizontal") or 0
	slot0.heroScrollViewHorizontal_ = getData("BattleTeach", "hero_scroll_horizontal") or 0
end

function slot0.ModifyBaseTeach(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.base_stage_list) do
		slot0.baseStageList_[slot6.id] = slot6.clear_times
		slot0.stageList_[slot6.id] = slot6.clear_times
	end
end

function slot0.ModifyHeroTeach(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.hero_teaching_list) do
		slot0.heroStageList_[slot7] = slot0.heroStageList_[slot6.hero_id] or {}

		for slot11, slot12 in ipairs(slot6.stage_list) do
			slot0.heroStageList_[slot7][slot12.id] = slot12.clear_times
			slot0.stageList_[slot12.id] = slot12.clear_times
		end
	end
end

function slot0.SetSwitchType(slot0, slot1)
	slot0.switchType_ = slot1

	saveData("BattleTeach", "switchType_new", slot1)
end

function slot0.GetSwitchType(slot0)
	return slot0.switchType_
end

function slot0.GetStageData(slot0)
	return slot0.stageList_
end

function slot0.GetBaseTeachList(slot0)
	return slot0.baseStageList_
end

function slot0.GetHeroTeachInfo(slot0, slot1, slot2)
	if not slot0.heroStageList_[slot1] then
		return 0
	end

	return slot0.heroStageList_[slot1][slot2]
end

function slot0.SetCacheTeachHeroID(slot0, slot1)
	slot0.cacheSelectHeroID_ = slot1
end

function slot0.GetCacheTeachHeroID(slot0)
	return slot0.cacheSelectHeroID_
end

function slot0.SetBaseScrollViewHorizontal(slot0, slot1)
	slot0.baseScrollViewHorizontal_ = slot1

	saveData("BattleTeach", "base_scroll_horizontal", slot1)
end

function slot0.GetBaseScrollViewHorizontal(slot0)
	return slot0.baseScrollViewHorizontal_
end

function slot0.SetHeroScrollViewHorizontal(slot0, slot1)
	slot0.heroScrollViewHorizontal_ = slot1

	saveData("BattleTeach", "hero_scroll_horizontal", slot1)
end

function slot0.GetHeroScrollViewHorizontal(slot0)
	return slot0.heroScrollViewHorizontal_
end

return slot0
