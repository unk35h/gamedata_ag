slot0 = singletonClass("HeroTrialData")

function slot0.Init(slot0)
	slot0.heroTrialStateList_ = {}
	slot0.selectActiviteHeroIDList_ = {}
	slot0.stageIDToHeroTrialID_ = {}
end

function slot0.InitData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.activity_info) do
		slot0.heroTrialStateList_[slot6.id] = slot6.challenge_state
		slot7 = ActivityHeroTrialCfg[slot6.id]

		if slot6.challenge_state <= 1 then
			if ActivityData:GetActivityIsOpen(slot7.activity_id) then
				manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, slot7.activity_id, slot7.id), 1)
			end
		elseif slot6.challenge_state > 1 then
			manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, slot7.activity_id, slot7.id), 0)
		end
	end
end

function slot0.ReceiveReward(slot0, slot1)
	slot0.heroTrialStateList_[slot1] = 2
	slot2 = ActivityHeroTrialCfg[slot1]

	manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, slot2.activity_id, slot2.id), 0)
end

function slot0.GetHeroTrialStateList(slot0)
	return slot0.heroTrialStateList_
end

function slot0.SetSelectActiviteHeroID(slot0, slot1, slot2)
	slot0.selectActiviteHeroIDList_[slot1] = slot2

	if slot0.heroTrialStateList_[slot2] ~= 1 then
		slot3 = ActivityHeroTrialCfg[slot2]

		manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, slot3.activity_id, slot3.id), 0)
	end

	saveData("HeroTrial", "activiteID_" .. tostring(slot1), slot2)
end

function slot0.GetSelectActiviteHeroID(slot0, slot1)
	if slot0.selectActiviteHeroIDList_[slot1] == nil then
		slot0.selectActiviteHeroIDList_[slot1] = getData("HeroTrial", "activiteID_" .. tostring(slot1))
	end

	return slot0.selectActiviteHeroIDList_[slot1]
end

function slot0.SaveStageID(slot0, slot1)
	slot0.stageIDToHeroTrialID_[ActivityHeroTrialCfg[slot1].stage_id] = slot1
end

function slot0.GetHeroTrialID(slot0, slot1)
	return slot0.stageIDToHeroTrialID_[slot1]
end

return slot0
